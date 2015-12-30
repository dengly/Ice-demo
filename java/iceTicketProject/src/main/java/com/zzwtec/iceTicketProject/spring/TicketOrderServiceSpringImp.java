package com.zzwtec.iceTicketProject.spring;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.zzwtec.iceTicketProject.db.TBOrder;

/**
 * TicketOrderServiceSpring的Spring实现类，主要是数据库事务操作
 * @author 邓燎燕
 *
 */
@Component
@Lazy(true)
public class TicketOrderServiceSpringImp {
	private Logger logger = LoggerFactory.getLogger(TicketOrderServiceSpringImp.class);
	
	@Autowired
	private SessionFactory sessionFact;
	
	@Transactional
	public boolean createOrder(TBOrder theOrder){
		logger.info("create order ..."+theOrder);
		Session curSession = sessionFact.getCurrentSession();
		curSession.save(theOrder);
		logger.info("success created ,id "+theOrder.getId());
		return true;
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<TBOrder> queryMyOrders(String phoneNum){
		Session curSession = sessionFact.getCurrentSession();
		String sql = "from TBOrder WHERE phone=:phone order by orderDate desc";
		Query query = curSession.createQuery(sql);
		query.setParameter("phone", phoneNum);
		return query.list();
	}
	
	@Transactional
	public boolean cancleOrder(long orderId){
		Session curSession = sessionFact.getCurrentSession();
		String sql = "update TBOrder set orderStatus=-1 WHERE id=:id and orderStatus in(0,1)";
		Query query = curSession.createQuery(sql);
		query.setParameter("id", orderId);
		int result = query.executeUpdate();
		return (result == 1);
	}
}
