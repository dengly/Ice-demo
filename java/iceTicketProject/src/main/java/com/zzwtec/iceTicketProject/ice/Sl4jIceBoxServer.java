package com.zzwtec.iceTicketProject.ice;

import IceBox.Server;

import com.zzwtec.iceTicketProject.ice.util.Sl4jLoggerI;

public class Sl4jIceBoxServer {
	public static void main(String[] args){
		Ice.InitializationData initData = new Ice.InitializationData();
		initData.properties = Ice.Util.createProperties();
		initData.properties.setProperty("Ice.Admin.DelayCreation", "1");
		initData.logger = new Sl4jLoggerI("system");
		
		Server server = new Server();
		System.exit(server.main("IceBox.Server", args, initData));
	}
}
