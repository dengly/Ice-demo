package com.zzwtec.iceTicketProject.ice.interceptor;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import Ice.DispatchInterceptor;
import Ice.DispatchStatus;
import Ice.Identity;
import Ice.Request;

/**
 * 分发拦截器，本拦截器用于日志记录
 * @author 邓燎燕
 *
 */
@SuppressWarnings("serial")
public class PerfDispatchInterceptor extends DispatchInterceptor {
	private static Logger logger = LoggerFactory.getLogger(PerfDispatchInterceptor.class);
	
	//用来存放我们需要拦截的Ice服务对象，Key为服务ID，value为对应的Servant
	private static final Map<Ice.Identity, Ice.Object> id2ObjectMap = new ConcurrentHashMap<Ice.Identity, Ice.Object>();
	
	//单例模式
	private static final PerfDispatchInterceptor self = new PerfDispatchInterceptor();

	public static PerfDispatchInterceptor getInstance(){
		return self;
	}
	
	//添加我们要拦截的服务Servant
	public static DispatchInterceptor addIceObject(Ice.Identity id, Ice.Object iceObj){
		id2ObjectMap.put(id, iceObj);
		return self;
	}
	
	/**
	 * 此方法可以做任何拦截，类似AOP
	 */
	@Override
	public DispatchStatus dispatch(Request request) {
		Identity theId = request.getCurrent().id;
		//request.getCurrent().con 会打印出来local address=localhost:50907
		//(回车换行)remote address=localhost:51147这样的信息
		/*其中local address为被访问的服务地址端口，remote address为客户端的地址端口*/
		String inf = "dispach req,method: "+request.getCurrent().operation
				+" service:"+theId.name
				+" server address:"+request.getCurrent().con;
		logger.info(inf+" begin");
		try{
			DispatchStatus reslt = id2ObjectMap.get(request.getCurrent().id).ice_dispatch(request);
			logger.info(inf+" success");
			return reslt;
		}catch(Exception e){
			logger.info(inf+" error "+e);
			throw e;
			
		}
	}
	
	public static void removeIceObject(Identity id){
		logger.info("remove ice object "+id);
		id2ObjectMap.remove(id);
	}

}
