package com.zzwtec.iceTicketProject.ice;

import com.zzwtec.iceTicketProject.util.IceClientUtil;
import com.zzwtec.ticket.ticket.Order;
import com.zzwtec.ticket.ticket.TicketServicePrx;

public class TestIce {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		testCall();
	}
	
	public static void testCall(){
		TicketServicePrx ticketServicePrx = (TicketServicePrx)IceClientUtil.getServicePrx(TicketServicePrx.class);
		Order[] orders = ticketServicePrx.queryMyOrders("13631276694");
		System.out.println("orders.length:"+orders.length);
	}
}
