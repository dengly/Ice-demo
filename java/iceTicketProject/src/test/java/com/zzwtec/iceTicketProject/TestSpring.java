package com.zzwtec.iceTicketProject;

import java.util.List;

import junit.framework.Assert;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zzwtec.iceTicketProject.db.TBOrder;
import com.zzwtec.iceTicketProject.spring.TicketOrderServiceSpringImp;

public class TestSpring {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		testAll();
	}
	
	public static void testAll(){
		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TicketOrderServiceSpringImp springImp = context.getBean(TicketOrderServiceSpringImp.class);
		TBOrder theOrder = new TBOrder();
		theOrder.setPhone("13631276694");
		theOrder.setAmount(33.33);
		theOrder.setOrderDate(2015120119);
		theOrder.setOrderNum("201512011918001");
		boolean success = springImp.createOrder(theOrder);
		Assert.assertEquals(true, success);
		List<TBOrder> orders = springImp.queryMyOrders("13631276694");
		Assert.assertEquals(true, !orders.isEmpty());
		theOrder = orders.iterator().next();
		success = springImp.cancleOrder(theOrder.getId());
		Assert.assertEquals(true, success);
	}

}
