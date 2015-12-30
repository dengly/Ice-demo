package com.zzwtec.iceTicketProject.util.ice.glacier2;

import java.lang.reflect.Method;

import com.zzwtec.iceclient.R;

import Glacier2.SessionHelper;
import Glacier2.SessionNotExistException;
import Ice.ObjectPrx;
import android.content.Context;
import android.os.Handler;

public class MySessionCallback implements Glacier2.SessionCallback {

	@SuppressWarnings("rawtypes")
	private Class serviceCls;
	private Handler mHandler;
	public static final int GET_PROXY = 1000;
	public ObjectPrx proxy;
	private Context context;
	
	@SuppressWarnings("rawtypes")
	public MySessionCallback(Context context,Class serviceCls, Handler handler){
		this.context = context;
		this.serviceCls = serviceCls;
		this.mHandler = handler;
	}

	@Override
	public void connectFailed(SessionHelper sessionHelper, Throwable throwable) {
		// TODO Auto-generated method stub
		System.out.println("sessionHelper connectFailed");
		throwable.printStackTrace();
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
			Ice.ObjectPrx base = sessionHelper.communicator().stringToProxy(realSvName);
			if(base == null){
				throw new java.lang.Exception("base is null");
			}
			proxy = (ObjectPrx) Class.forName(clsName+"Helper").newInstance();
			Method m1 = proxy.getClass().getDeclaredMethod("uncheckedCast", ObjectPrx.class);
			proxy = (ObjectPrx)m1.invoke(proxy, base);
			
			mHandler.sendEmptyMessage(GET_PROXY);
		} catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	@Override
	public void createdCommunicator(SessionHelper sessionHelper) {
		System.out.println("sessionHelper createdCommunicator");
		Ice.Communicator communicator = sessionHelper.communicator();
		if(communicator.getProperties().getPropertyAsIntWithDefault("IceSSL.UsePlatformCAs", 0) == 0) {
			System.out.println("load cert");
			try {
				java.io.InputStream certStream = context.getResources().openRawResource(R.raw.client);
	            IceSSL.Plugin plugin = (IceSSL.Plugin)communicator.getPluginManager().getPlugin("IceSSL");
	            plugin.setKeystoreStream(certStream);
	            communicator.getPluginManager().initializePlugins();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("sessionHelper createdCommunicator end");
	}

	@Override
	public void disconnected(SessionHelper sessionHelper) {
		System.out.println("sessionHelper disconnected");
	}

}
