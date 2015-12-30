package com.zzwtec.iceTicketProject.db;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 订单对象
 * @author 邓燎燕
 *
 */
@Entity
@Table(name = "TB_ORDER")
public class TBOrder {
	private long id;
	private String phone;
	private String orderNum;
	private int orderDate;
	private int ticketType;
	private double amount;
	private int orderStatus;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public long getId() {
		return id;
	}
	
	@Column(name = "PHONE",length = 16)
	public String getPhone() {
		return phone;
	}

	@Column(name = "ORDER_NUM",length = 32)
	public String getOrderNum() {
		return orderNum;
	}
	
	@Column(name = "ORDER_DATE")
	public int getOrderDate() {
		return orderDate;
	}
	
	@Column(name = "TICKET_TYPE")
	public int getTicketType() {
		return ticketType;
	}
	
	@Column(name = "AMOUNT")
	public double getAmount() {
		return amount;
	}
	
	@Column(name = "ORDER_STATUS")
	public int getOrderStatus() {
		return orderStatus;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public void setOrderDate(int orderDate) {
		this.orderDate = orderDate;
	}
	public void setTicketType(int ticketType) {
		this.ticketType = ticketType;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}
}
