package com.zzwtec.iceTicketProject.util;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import Ice.ObjectPrx;

/**
 * Ice客户端封装类
 * @author 邓燎燕
 *
 */
public class IceClientUtil {
	/*
	 * volatile用在多线程，同步变量
	 * 用来确保将变量的更新操作通知到其他线程,保证了新值能立即同步到主内存,
	 * 以及每次使用前立即从主内存刷新. 当把变量声明为volatile类型后,
	 * 编译器与运行时都会注意到这个变量是共享的
	 */
	private static volatile Ice.Communicator ic = null;
	
	@SuppressWarnings("rawtypes")
	private static Map<Class,ObjectPrx>cls2PrxMap = new HashMap<Class,ObjectPrx>();
	
	//上次访问时间
	private static volatile long lastAccessTimestamp;
	
	//检测线程
	private static volatile MonitorThread monitorThread;
	
	//空闲超时时间 单位秒
	private static long idleTimeOutSeconds = 0;
	
	private static String iceLocator = null;
	
	/**
	 * 延时加载Communicator
	 * @return Ice.Communicator
	 */
	public static Ice.Communicator getIceCommunicator(){
		if(ic == null){
			synchronized (IceClientUtil.class) {
				if(ic == null){
					ResourceBundle rb = ResourceBundle.getBundle("iceclient", Locale.ENGLISH);
					if(rb!=null){
						iceLocator = rb.getString("--Ice.Default.Locator");
						idleTimeOutSeconds = Integer.parseInt(rb.getString("idleTimeOutSeconds"));
						System.out.println("Ice client`s locator is "+iceLocator+" proxy cache time out seconds :"+idleTimeOutSeconds);
						String[] initParams = new String[]{"--Ice.Default.Locator="+iceLocator,
								"--Ice.Plugin.IceSSL=IceSSL.PluginFactory",
								"--IceSSL.DefaultDir="+rb.getString("--IceSSL.DefaultDir"),
								"--IceSSL.Keystore="+rb.getString("--IceSSL.Keystore"),
								"--IceSSL.Truststore="+rb.getString("--IceSSL.Truststore"),
								"--IceSSL.TruststorePassword="+rb.getString("--IceSSL.TruststorePassword"),
								"--IceSSL.Password="+rb.getString("--IceSSL.Password"),
								"--Ice.Default.PreferSecure=1"};
						ic = Ice.Util.initialize(initParams);
						//创建守护线程
						createMonitorThread();
					}
				}
			}
		}
		lastAccessTimestamp = System.currentTimeMillis();
		return ic;
	}
	
	 /**
	  * 创建守护线程
	  */
	private static void createMonitorThread(){
		monitorThread = new MonitorThread();
		monitorThread.setDaemon(true);
		monitorThread.start();
	}
	
	/**
	 * 关闭Ice.Communicator，释放资源 
	 */
	public static void closeCommunicator(boolean removeServiceCache){
		synchronized (IceClientUtil.class) {
			if(ic != null){
				safeShutdown();
				monitorThread.interrupt();
				if(removeServiceCache && !cls2PrxMap.isEmpty()){
					try{
						cls2PrxMap.clear();
					}catch(Exception e){
						//ignore
					}
				}
			}
		}
	}
	
	private static void safeShutdown(){
		try{
			ic.shutdown();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ic.destroy();
			ic = null;
		}
	}
	
	/**
	 * 用发射方式创建Object Proxy
	 * @param communicator
	 * @param serviceCls
	 * @return ObjectPrx
	 */
	@SuppressWarnings("rawtypes")
	private static ObjectPrx createIceProxy(Ice.Communicator communicator,Class serviceCls){
		ObjectPrx proxy = null;
		String clsName = serviceCls.getName();
		System.out.println("clsName:"+clsName);
		String serviceName = serviceCls.getSimpleName();
		int pos = serviceName.lastIndexOf("Prx");
		if(pos <= 0){
			throw new java.lang.IllegalArgumentException("Invalid ObjectPrx class ,class name must end with Prx");
		}
		String realSvName = serviceName.substring(0,pos);
		try{
			Ice.ObjectPrx base = communicator.stringToProxy(realSvName);
			System.out.println("realSvName:"+realSvName);
			proxy = (ObjectPrx) Class.forName(clsName+"Helper").newInstance();
			Method m1 = proxy.getClass().getDeclaredMethod("uncheckedCast", ObjectPrx.class);
			proxy = (ObjectPrx)m1.invoke(proxy, base);
			return proxy;
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 用于客户端API获取Ice服务实例的场景
	 * @param serviceCls
	 * @return ObjectPrx
	 */
	@SuppressWarnings("rawtypes")
	public static ObjectPrx getServicePrx(Class serviceCls){
		ObjectPrx proxy = cls2PrxMap.get(serviceCls);
		if(proxy != null){
			lastAccessTimestamp = System.currentTimeMillis();
			return proxy;
		}
		proxy = createIceProxy(getIceCommunicator(), serviceCls);
		cls2PrxMap.put(serviceCls, proxy);
		lastAccessTimestamp = System.currentTimeMillis();
		return proxy;
	}
	
	static class MonitorThread extends Thread {
		public void run(){
			while(!Thread.currentThread().isInterrupted()){
				try{
					Thread.sleep(5000L);
					if(lastAccessTimestamp + idleTimeOutSeconds * 1000L < System.currentTimeMillis()){
						closeCommunicator(true);
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
	}
}
