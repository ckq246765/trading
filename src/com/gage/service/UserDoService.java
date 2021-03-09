package com.gage.service;

import java.util.List;
import java.util.Map;

import com.gage.beans.Comment;
import com.gage.beans.Order;
import com.gage.beans.Page;
import com.gage.beans.Shopping;
import com.gage.beans.TradingObject;
import com.gage.beans.User;

public interface UserDoService {

	String getUserCode(String userName);

	List<Shopping> getUserShoppingByUserCode(String userCode);

	TradingObject getTradingObjectByObjectCode(String objectCode);

	String deleteTradingObject(Map<Object, Object> map);

	String deleteTradingObjectByUserCode(String[] objectCode);

	String changeTradingObjectByUserCode(TradingObject tradingObject);

	String addTradingObjectToShop( String objectCode, String userName);

	Order getOrderByUserAndObject(String userName, String objectCode);

	void saveOrder(Order order);

	void toRecordForUser(Order order);

	String getUserCodeByOrderCode(String orderCode);

	Page getAllOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode);

	List<Order> getAllOrderByUser(Integer pageNo, Integer pageSize, String userCode);

	Page getAllNoPayOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode);

	List<Order> getAllNoPayOrderByUser(int i, Integer pageSize, String userCode);

	Page getAllNoFhOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode);

	List<Order> getAllNoFhOrderByUser(int i, Integer pageSize, String userCode);

	Page getAllNoYsOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode);

	List<Order> getAllNoYsOrderByUser(int i, Integer pageSize, String userCode);

	Boolean yanShou(String orderCode, String userCode);

	Page getAllNoPjOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode);

	List<Order> getAllNoPjOrderByUser(int i, Integer pageSize, String userCode);

	TradingObject TradingObjectByObjectCode(String objectCode);

	String saveEvaluate(Comment comment,String orderCode);

	Page getAllWriteCommentByUserPage(Integer valueOf, Integer valueOf2, String userCode);

	List<Comment> getAllWriteCommentByUser(int i, Integer pageSize, String userCode);

	boolean deleteCommentByUser(String objectCode, String evaluateUser, String evaluateCode);

	Page getAllReceiveCommentByUserPage(Integer valueOf, Integer valueOf2, String userCode);

	List<Comment> getAllReceiveCommentByUser(int i, Integer pageSize, String userCode);

	List<Order> getTradingObjectByUserCode(String userCode);

	Page getAllUserObjectOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode);

	List<Order> getAllUserObjectOrderByUser(int i, Integer pageSize, String userCode);

	boolean sureFh(String orderCode);

	User getUserMsg(String userCode);

	TradingObject getTradingObject(String objectCode);

	String saveZengYu(Order order);


}
