package com.zzwtec.iceclient;

import com.zzwtec.iceclient.R;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class TicketOrdersListAdapter extends ArrayAdapter<String>{
	private final Activity context;
	private final String[] tickOrderNames;
	private final Integer[] imageId;
	
	public TicketOrdersListAdapter(Activity context,String[] tickOrderNames,Integer[] imageId){
		super(context, R.layout.list_single, tickOrderNames);
		this.context = context;
		this.tickOrderNames = tickOrderNames;
		this.imageId = imageId;
	}

	@SuppressLint("ViewHolder")
	@Override
	public View getView(int postion, View view, ViewGroup parent){
		LayoutInflater inflater = context.getLayoutInflater();
		View rowView = inflater.inflate(R.layout.list_single, null,true);
		TextView txtTile = (TextView)rowView.findViewById(R.id.txt);
		ImageView imageView = (ImageView)rowView.findViewById(R.id.imageView1);
		txtTile.setText(tickOrderNames[postion]);
		imageView.setImageResource(imageId[postion]);
		return rowView;
	}
}
