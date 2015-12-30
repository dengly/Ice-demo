package com.zzwtec.iceTicketProject.ice.glacier2;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Properties;

import Glacier2.SessionHelper;
import Glacier2.SessionNotExistException;
import Ice.ObjectPrx;

import com.zzwtec.ticket.ticket.Order;
import com.zzwtec.ticket.ticket.TicketServicePrx;

/**
 * Glacier2客户端测试 <br>
 * 客户端使用SSL通过Glacier2，调用服务。<br>
 * 而服务是使用Grid
 * @author 邓燎燕
 *
 */
public class Glacier2Client {

	private static Glacier2.SessionFactoryHelper sessionFactoryHelper;
	public static Glacier2.SessionHelper _sessionHelper;
	
	@SuppressWarnings("rawtypes")
	public static void connect(final Class serviceCls,final Glacier2Callback callback){
		Ice.InitializationData initData = new Ice.InitializationData();
		initData.properties = Ice.Util.createProperties();
		
		try {
			File file = new File("/Users/dengliaoyan/Documents/Work/Workspaces/Java_workspaces/iceTicketProject/target/classes/iceclient_glacier2.properties");
			FileInputStream inputStream = new FileInputStream(file);
            Properties properties = new Properties();
            properties.load(inputStream);
            for (String name : properties.stringPropertyNames()) {
            	if(name.equals("idleTimeOutSeconds")){
            		continue;
            	}
                String value = properties.getProperty(name);
                initData.properties.setProperty(name, value);
            }

//            initData.properties.setProperty("Ice.RetryIntervals", "-1");
//            initData.properties.setProperty("Ice.Trace.Network", "0");
//            initData.properties.setProperty("Ice.Plugin.IceSSL", "IceSSL.PluginFactory");
//            
//            if(initData.properties.getPropertyAsIntWithDefault("IceSSL.UsePlatformCAs", 0) == 0) {
//                initData.properties.setProperty("Ice.InitPlugins", "0");
//            	initData.properties.setProperty("IceSSL.VerifyPeer", "0");
//                initData.properties.setProperty("IceSSL.Trace.Security", "1");
//                initData.properties.setProperty("IceSSL.KeystoreType", "JKS");
//                initData.properties.setProperty("IceSSL.Password", "123456");
//            }
            
        } catch(IOException ex) {
            ex.printStackTrace();
        }
		
		sessionFactoryHelper = new Glacier2.SessionFactoryHelper(initData, new Glacier2.SessionCallback(){

			@Override
			public void connectFailed(SessionHelper arg0, Throwable ex) {
				System.out.println("sessionHelper connectFailed");
				ex.printStackTrace();
			}

			@Override
			public void connected(SessionHelper sessionHelper) throws SessionNotExistException {
				System.out.println("sessionHelper connected");
				String clsName = serviceCls.getName();
				System.out.println("clsName:"+clsName);
				String serviceName = serviceCls.getSimpleName();
				int pos = serviceName.lastIndexOf("Prx");
				if(pos <= 0){
					throw new java.lang.IllegalArgumentException("Invalid ObjectPrx class ,class name must end with Prx");
				}
				String realSvName = serviceName.substring(0,pos);
				System.out.println("realSvName:"+realSvName);
				try {
					Ice.ObjectPrx base = _sessionHelper.communicator().stringToProxy(realSvName);
					
					ObjectPrx proxy = (ObjectPrx) Class.forName(clsName+"Helper").newInstance();
					Method m1 = proxy.getClass().getDeclaredMethod("uncheckedCast", ObjectPrx.class);
					proxy = (ObjectPrx)m1.invoke(proxy, base);
					
					callback.callback(proxy);
					
					System.out.println("=========================");
					
					_sessionHelper.destroy();
				} catch(Exception e){
					e.printStackTrace();
					throw new RuntimeException(e);
				}
				
			}

			@Override
			public void createdCommunicator(SessionHelper sessionHelper) {
				System.out.println("sessionHelper createdCommunicator");
//				Ice.Communicator communicator = sessionHelper.communicator();
//				if(communicator.getProperties().getPropertyAsIntWithDefault("IceSSL.UsePlatformCAs", 0) == 0) {
//					try {
//						java.io.InputStream certStream = new FileInputStream(new File("/Users/dengliaoyan/Documents/Work/Workspaces/Java_workspaces/iceTicketProject/target/classes/client.jks"));
//						IceSSL.Plugin plugin = (IceSSL.Plugin)communicator.getPluginManager().getPlugin("IceSSL");
//						plugin.setKeystoreStream(certStream);
//                        communicator.getPluginManager().initializePlugins();
//					} catch (Exception e) {
//						e.printStackTrace();
//					}
//				}
			}

			@Override
			public void disconnected(SessionHelper sessionHelper) {
				System.out.println("sessionHelper disconnected");
			}});
		_sessionHelper = sessionFactoryHelper.connect("dly", "123456");
	}
	
	//测试
	public static void main(String[] s) throws InterruptedException{
		Glacier2Callback callback = new Glacier2Callback() {
			@Override
			public void callback(ObjectPrx proxy) {
				TicketServicePrx ticketService = (TicketServicePrx)proxy;
				Order[] orders = ticketService.queryMyOrders("13631276694");
				if(orders!=null){
					System.out.println("orders.length:"+orders.length);
				}else{
					System.out.println("orders is null");
				}
			}
		};
		
		Glacier2Client.connect(TicketServicePrx.class,callback);
		Thread.sleep(2000);
	}
}
