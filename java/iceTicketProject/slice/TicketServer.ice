[["java:package:com.zzwtec.ticket"]]

#include <Glacier2/Session.ice>
/**
 * 票模块
 */
module ticket{
	/**
	 * 订单模型
	 */
	struct Order{
		long orderId;
		string phone;
		string orderNum;
		int orderDate;
		int ticketType;
		double amount;
		int orderStatus;
	};
	/**
	 * 订单
	 */
	sequence<Order> OrderSeq;
	/**
	 * 票务服务接口
	 */
	interface TicketService{
		/**
	 	 * 下单
	 	 */
		bool createOrder(Order myOrder);
		/**
	 	 * 查询订单
	 	 */
		OrderSeq queryMyOrders(string phone);
		/**
	 	 * 取消订单
	 	 */
		bool cancleOrder(long orderId);
	};
};