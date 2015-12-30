package com.zzwtec.iceTicketProject.util;

import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringUtil {
	private static ClassPathXmlApplicationContext ctx;
	
	public static synchronized <T>T getBean(Class<T> beanCls){
		if(ctx == null){
			ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
			ctx.registerShutdownHook();
		}
		return ctx.getBean(beanCls);
	}
	
	public static synchronized void shutdown(){
		if(ctx!=null){
			ctx.close();
			ctx = null;
		}
	}
}
