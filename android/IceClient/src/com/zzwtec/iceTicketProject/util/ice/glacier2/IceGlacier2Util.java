package com.zzwtec.iceTicketProject.util.ice.glacier2;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import android.content.Context;
import android.os.Build;

public class IceGlacier2Util {
	private static Glacier2.SessionFactoryHelper sessionFactoryHelper;
	public static Glacier2.SessionHelper sessionHelper;
	
	public static void connect(Context context,Glacier2.SessionCallback callback){
		Ice.InitializationData initData = new Ice.InitializationData();
		initData.properties = Ice.Util.createProperties();
		
		try {
            InputStream inputStream = context.getResources().getAssets().open("iceclient_glacier2.properties");
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

            // SDK versions < 21 only support TLSv1 with SSLEngine.
            if(Build.VERSION.SDK_INT < 21) {
                initData.properties.setProperty("IceSSL.Protocols", "TLS1_0");
            }

//            if(initData.properties.getPropertyAsIntWithDefault("IceSSL.UsePlatformCAs", 0) == 0) {
//            	initData.properties.setProperty("Ice.InitPlugins", "0");
//            	initData.properties.setProperty("IceSSL.VerifyPeer", "0");
//                initData.properties.setProperty("IceSSL.Trace.Security", "1");
//                initData.properties.setProperty("IceSSL.KeystoreType", "BKS");
//                initData.properties.setProperty("IceSSL.Password", "123456");
//            }
        } catch(IOException ex) {
            ex.printStackTrace();
        }
		
		sessionFactoryHelper = new Glacier2.SessionFactoryHelper(initData, callback);
		sessionHelper = sessionFactoryHelper.connect("dly", "123456");
	}
}
