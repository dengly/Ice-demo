package com.zzwtec.iceclient2;

import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import Ice.ObjectPrx;

/**
 * Created by dengliaoyan on 2017/5/2.
 */

public class IceUtil {
    private static boolean isInit = false;
    // 移动端BKS证书流
    private static InputStream certStream;
    // Android系统版本
    private static int androidSDKVersion = 0;

    private static String iceRouter;
    private static String iceSSLPsw;

    private static boolean useSecure = false;
    private static boolean doDisConnect = false;

    private static String userName;
    private static String userPsw;

    private static Map<String, String> properties = null;

    private static Ice.Dispatcher iceDispatcher = null;

    // 代理缓存
    protected static Map<String, Ice.ObjectPrx> prxMap;

    private static Ice.Communicator communicator;
    private static Glacier2.RouterPrx router = null;
    private static Glacier2.SessionPrx session = null;

    /**
     * 设置属性
     * @param properties
     */
    public static void setProperties(Map<String, String> properties){
        IceUtil.properties = properties;
    }

    public static void setIceDispatcher(Ice.Dispatcher iceDispatcher){
        IceUtil.iceDispatcher = iceDispatcher;
    }

    public static String getIceRouter() {
        return iceRouter;
    }

    public static String getIceSSLPsw() {
        return iceSSLPsw;
    }

    public static boolean isUseSecure() {
        return useSecure;
    }

    public static String getUserName() {
        return userName;
    }

    public static String getUserPsw() {
        return userPsw;
    }

    /**
     * 初始化 使用SSL的方式通信 证书是BKS类型
     *
     * @param androidSDKVersion Android系统版本
     * @param certStream BKS证书流
     * @param iceSSLPsw JKS证书密码
     * @param iceRouter ice的router配置
     */
    public static void init(int androidSDKVersion, InputStream certStream, String iceSSLPsw, String iceRouter) {
        if (certStream == null) {
            throw new java.lang.IllegalArgumentException("certStream can not be null");
        }
        if (iceRouter.indexOf("ssl") < 0) {
            throw new java.lang.IllegalArgumentException("iceRouter must be ssl");
        }
        if (iceRouter.indexOf("tcp") > 0) {
            throw new java.lang.IllegalArgumentException("iceRouter can not be tcp");
        }
        IceUtil.androidSDKVersion = androidSDKVersion;
        IceUtil.certStream = certStream;
        IceUtil.iceSSLPsw = iceSSLPsw;
        IceUtil.iceRouter = iceRouter;
        IceUtil.useSecure = true;
        isInit = true;
    }

    /**
     * 初始化 使用TCP的方式通信 通过账号认证
     *
     * @param userName 账号名称
     * @param userPsw 账号密码
     * @param iceRouter ice的router配置
     */
    public static void init(String userName, String userPsw, String iceRouter) {
        if (iceRouter.indexOf("tcp") < 0) {
            throw new java.lang.IllegalArgumentException("iceRouter must be tcp");
        }
        if (iceRouter.indexOf("ssl") > 0) {
            throw new java.lang.IllegalArgumentException("iceRouter can not be ssl");
        }
        IceUtil.userName = userName;
        IceUtil.userPsw = userPsw;
        IceUtil.iceRouter = iceRouter;
        IceUtil.useSecure = false;
        isInit = true;
    }

    /**
     * 获取代理
     *
     * @param clazz
     *            代理类型
     * @return 代理
     */
    @SuppressWarnings("unchecked")
    public static <T> T getObjectPrx(Class<T> clazz) {
        if (doDisConnect || !isConnect()) {
            return null;
        }
        String serviceName = clazz.getSimpleName();
        int pos = serviceName.lastIndexOf("Prx");
        if (pos <= 0) {
            throw new java.lang.IllegalArgumentException("Invalid ObjectPrx class ,class name must end with Prx");
        }
        String realSvName = serviceName.substring(0, pos);
        if("MSG".equals(realSvName)){
            realSvName = "Msg";
        }
        if(!"SessionOpt".equals(realSvName)){
            realSvName = realSvName+"Action";
        }
        Ice.ObjectPrx objectPrx = prxMap.get(realSvName);
        if (objectPrx == null) {
            try {
                String clsName = clazz.getName();
                Ice.ObjectPrx base = communicator.stringToProxy(realSvName);
                if (base == null) {
                    throw new java.lang.Exception("base is null");
                }
                objectPrx = (ObjectPrx) Class.forName(clsName + "Helper").newInstance();
                if (objectPrx == null || objectPrx.getClass() == null) {
                    throw new java.lang.Exception(clsName + "Helper get instance fail");
                }
                Method m1 = objectPrx.getClass().getDeclaredMethod("uncheckedCast", ObjectPrx.class);
                if (m1 == null) {
                    throw new java.lang.Exception("not uncheckedCast Method");
                }
                objectPrx = (ObjectPrx) m1.invoke(objectPrx, base);
                prxMap.put(realSvName, objectPrx);
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
        return (T) objectPrx;
    }

    /**
     * 是否与服务器连接
     *
     * @return
     */
    public static boolean isConnect() {
        if (session == null || !session.ice_isConnectionCached()) {
            if (prxMap != null) {
                prxMap.clear();
                prxMap = null;
            }
            return false;
        }
        return true;
    }

    /**
     * 断开连接
     */
    public static void disConnect() {
        doDisConnect = true;
        if (prxMap != null) {
            prxMap.clear();
            prxMap = null;
        }
        if (session != null && session.ice_isConnectionCached()) {
            session.destroy();
            session = null;
            router = null;
            communicator = null;
        }
    }

    /**
     * 连接服务器
     *
     * @return
     */
    public synchronized static boolean connect() {
        if (!isInit) {
            throw new java.lang.IllegalArgumentException("You must first call the \"init\" method");
        }
        if(!doDisConnect && isConnect()){
            return true;
        }
        doDisConnect = false;
        if (prxMap == null) {
            prxMap = new ConcurrentHashMap<String, Ice.ObjectPrx>();
        } else {
            prxMap.clear();
        }
        Ice.InitializationData initData = new Ice.InitializationData();
        if(iceDispatcher!=null){
            initData.dispatcher = iceDispatcher;
        }
        initData.properties = Ice.Util.createProperties();
        initData.properties.setProperty("Ice.Default.Router", iceRouter);
        initData.properties.setProperty("Ice.RetryIntervals", "-1");
        initData.properties.setProperty("Ice.Trace.Network", "0");
        initData.properties.setProperty("Ice.IPv6", "1");
        if (useSecure) {
            initData.properties.setProperty("Ice.Plugin.IceSSL", "IceSSL.PluginFactory");
            initData.properties.setProperty("IceSSL.VerifyPeer", "2");
            initData.properties.setProperty("IceSSL.Trace.Security", "0");

            initData.properties.setProperty("IceSSL.KeystoreType","BKS");
            initData.properties.setProperty("IceSSL.TruststoreType", "BKS");
            initData.properties.setProperty("IceSSL.Password", iceSSLPsw);
            initData.properties.setProperty("IceSSL.Alias", "client");
            initData.properties.setProperty("IceSSL.CheckCertName", "0");
            initData.properties.setProperty("Ice.InitPlugins", "0");
            initData.properties.setProperty("IceSSL.UsePlatformCAs","0");
            if (androidSDKVersion < 21) {
                initData.properties.setProperty("IceSSL.Protocols", "tls1_0");
            }
        }
        if(properties!=null){
            Set<String> keys = properties.keySet();
            Iterator<String> iterator = keys.iterator();
            while(iterator.hasNext()){
                String key = iterator.next();
                initData.properties.setProperty(key, properties.get(key));
            }
        }
        try {
            communicator = Ice.Util.initialize(initData);
            if (useSecure) {
                IceSSL.Plugin plugin = (IceSSL.Plugin) communicator.getPluginManager().getPlugin("IceSSL");
                plugin.setKeystoreStream(certStream);
                plugin.setTruststoreStream(certStream);
                communicator.getPluginManager().initializePlugins();
            }
            router = Glacier2.RouterPrxHelper.checkedCast(communicator.getDefaultRouter());

            if (useSecure) {
                session = router.createSessionFromSecureConnection();
            } else {
                session = router.createSession(userName, userPsw);
            }
            if (session != null) {
                int acmTimeout = router.getACMTimeout();
                if (acmTimeout > 0) {
                    Ice.Connection conn = router.ice_getCachedConnection();
                    conn.setACM(Ice.Optional.O(acmTimeout - 2), Ice.Optional.O(Ice.ACMClose.CloseOff),
                            Ice.Optional.O(Ice.ACMHeartbeat.HeartbeatAlways));
                    conn.setCallback(new Ice.ConnectionCallback() {
                        @Override
                        public void heartbeat(Ice.Connection con) {}

                        @Override
                        public void closed(Ice.Connection con) {
                            disConnect();
                        }
                    });
                }
                return session.ice_isConnectionCached();
            }
            return false;
        }  catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

