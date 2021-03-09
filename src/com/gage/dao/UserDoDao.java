package com.gage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.gage.beans.Comment;
import com.gage.beans.Order;
import com.gage.beans.Shopping;
import com.gage.beans.TradingObject;
import com.gage.beans.User;

public interface UserDoDao {

	String getUserCode(String userName);

	List<Shopping> getUserShoppingByUserCode(String userCode);

	int deleteTradingObject(Map<Object, Object> map);

	int deleteTradingObjectByUserCode(String[] objectCode);

	int changeTradingObjectByUserCode(TradingObject tradingObject);

	String getBeforePictureDescri(String objectCode);

	int addTradingObjectToShop(@Param("objectCode")String objectCode, @Param("userCode")String userCode, @Param("currentDate")String currentDate);

	Order getOrderByUserAndObject(String objectCode);

	void saveOrder(Order order);

	void toRecordForUser(Order order);

	String getUserCodeByOrderCode(String orderCode);

	int getAllOrderByUserPageAccount(String userCode);

	List<Order> getAllOrderByUser(@Param("pageNo")Integer pageNo, @Param("pageSize")Integer pageSize, @Param("userCode")String userCode);

	int getAllNoPayOrderByUserPageAccount(String userCode);

	List<Order> getAllNoPayOrderByUser(@Param("pageNo")Integer pageNo, @Param("pageSize")Integer pageSize, @Param("userCode")String userCode);

	int getAllNoFhOrderByUserPageAccount(String userCode);

	List<Order> getAllNoFhOrderByUser(@Param("pageNo")Integer pageNo, @Param("pageSize")Integer pageSize, @Param("userCode")String userCode);

	int getAllNoYsOrderByUserPageAccount(String userCode);

	List<Order> getAllNoYsOrderByUser(@Param("pageNo")Integer pageNo, @Param("pageSize")Integer pageSize, @Param("userCode")String userCode);

	Integer yanShou(@Param("orderCode")String orderCode, @Param("userCode")String userCode);

	String getObjectByOrderCode(@Param("orderCode")String orderCode);

	void updateTradingObjectByTradingUser(@Param("objectCode")String objectCode,@Param("userCode")String userCode,@Param("currentDate")String currentDate);

	int getAllNoPjOrderByUserPageAccount(String userCode);

	List<Order> getAllNoPjOrderByUser(@Param("pageNo")Integer pageNo, @Param("pageSize")Integer pageSize, @Param("userCode")String userCode);

	TradingObject TradingObjectByObjectCode(String objectCode);

	int saveEvaluate(Comment comment);

	void updateOrderPJ(String orderCode);

	int getAllWriteCommentByUserPageAccount(String userCode);

	List<Comment> getAllWriteCommentByUser(@Param("pageNo")Integer pageNo, @Param("pageSize")Integer pageSize, @Param("userCode")String userCode);

	int deleteCommentByUser(@Param("objectCode")String objectCode, @Param("evaluateUser")String evaluateUser, @Param("evaluateCode")String evaluateCode);

	int getAllReceiveCommentByUserPageAccount(String userCode);

	List<Comment> getAllReceiveCommentByUser(@Param("pageNo")Integer pageNo, @Param("pageSize")Integer pageSize, @Param("userCode")String userCode);

	List<Order> getTradingObjectByUserCode(String userCode);

	int getAllUserObjectOrderByUserPage(String userCode);

	List<Order> getAllUserObjectOrderByUser(@Param("pageNo")Integer pageNo, @Param("pageSize")Integer pageSize, @Param("userCode")String userCode);

	int sureFh(String orderCode);

	Order getOrderByForZengYu(@Param("userCode")String userCode, @Param("objectCode")String objectCode);

	User getUserMsg(String userCode);

	TradingObject getTradingObject(String objectCode);

	int saveZengYu(Order order);

}
