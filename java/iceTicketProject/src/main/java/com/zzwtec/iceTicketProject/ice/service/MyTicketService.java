package com.zzwtec.iceTicketProject.ice.service;

import Ice.Object;

public class MyTicketService extends AbstractIceBoxService {

	@Override
	public Object createMyIceServiceObj(String[] args) {
		//创建servant并返回
		Ice.Object object = new TicketServiceI();
		return object;
	}

}
