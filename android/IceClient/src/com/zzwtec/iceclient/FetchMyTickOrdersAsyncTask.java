package com.zzwtec.iceclient;

import com.zzwtec.iceTicketProject.util.ice.IceClientUtil;
import com.zzwtec.ticket.ticket.Order;
import com.zzwtec.ticket.ticket.TicketServicePrx;

import android.os.AsyncTask;

public class FetchMyTickOrdersAsyncTask extends AsyncTask<String, Integer, Order[]> {

	private MainActivity mainActivity;
	
	public FetchMyTickOrdersAsyncTask(MainActivity mainActivity){
		this.mainActivity = mainActivity;
	}
	
	@Override
	protected Order[] doInBackground(String... phone) {
		try{
			TicketServicePrx ticketService = null;
			//Registry方式
			ticketService = (TicketServicePrx)IceClientUtil.getServicePrx(mainActivity,TicketServicePrx.class);
			return ticketService.queryMyOrders(phone[0]);
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	protected void onPostExecute(Order[] orders) {
		mainActivity.updateList(orders);
	}
}
