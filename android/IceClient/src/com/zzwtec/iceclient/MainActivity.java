package com.zzwtec.iceclient;

import com.zzwtec.iceTicketProject.util.ice.glacier2.IceGlacier2Util;
import com.zzwtec.iceTicketProject.util.ice.glacier2.MySessionCallback;
import com.zzwtec.ticket.ticket.Order;
import com.zzwtec.ticket.ticket.TicketServicePrx;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

public class MainActivity extends Activity {

	@SuppressLint("HandlerLeak")
	private Handler handler = new Handler() {
		@Override
		public void handleMessage(Message msg) {
			switch (msg.what) {
			case MySessionCallback.GET_PROXY:
				TicketServicePrx ticketService = (TicketServicePrx)mySessionCallback.proxy;
				mainActivity.updateList(ticketService.queryMyOrders("13631276694"));
				break;
			}
		}
	};
	
	private MySessionCallback mySessionCallback;
	private MainActivity mainActivity;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		mainActivity = this;

		//Glacier2方式
		mySessionCallback = new MySessionCallback(this,TicketServicePrx.class,handler);
		new Thread(new Runnable() {
			@Override
			public void run() {
				IceGlacier2Util.connect(mainActivity, mySessionCallback);
			}
		}).start();
		
//		//Registry方式
//		new FetchMyTickOrdersAsyncTask(this).execute("13631276694");
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}
	
	public void updateList(Order[] orders) {
		if(orders == null || orders.length==0){
			return;
		}
		final String[] orderTitles = new String[orders.length];
		Integer[] orderImgs = new Integer[orders.length];
		for(int i=0;i<orders.length;i++){
			orderTitles[i] = orders[i].orderId+" "+orders[i].orderDate+" "+orders[i].amount+"¥";
			orderImgs[i] = MainActivity.getTicketTypeImage(orders[i].ticketType);
		}
		TicketOrdersListAdapter adapter = new TicketOrdersListAdapter(this, orderTitles, orderImgs);
		ListView list = (ListView)this.findViewById(R.id.list);
		list.setAdapter(adapter);
		list.setOnItemClickListener(new AdapterView.OnItemClickListener() {
			@Override
			public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
				Toast.makeText(mainActivity, "You Clicked ad "+orderTitles[position], Toast.LENGTH_SHORT).show();
			}
			
		});
	}

	public static Integer getTicketTypeImage(int ticketType) {
		switch (ticketType) {
		case 1:
			return R.drawable.air;
		case 2:
			return R.drawable.book;
		case 3:
			return R.drawable.film;
		case 4:
			return R.drawable.kissvilla;
		default:
			return R.drawable.unkown;
		}
	}
}
