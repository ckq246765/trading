package com.gage.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gage.beans.Comment;
import com.gage.beans.Order;
import com.gage.beans.Page;
import com.gage.beans.Shopping;
import com.gage.beans.TradingObject;
import com.gage.beans.User;
import com.gage.dao.LoginSysOrUserDao;
import com.gage.dao.SysParObjectTypeDao;
import com.gage.dao.UserDoDao;
import com.gage.service.LoginSysOrUserService;
import com.gage.service.UserDoService;
import com.gage.utils.CurrentDate;
import com.gage.utils.UUIDGenerator;

@Service
public class UserDoServiceImpl implements UserDoService {

	@Autowired
	private UserDoDao userDoDao;
	@Autowired
	private SysParObjectTypeDao sysParObjectTypeDao;
	@Autowired
	private LoginSysOrUserDao loginSysOrUserDao;
	
	@Override
	public String getUserCode(String userName) {
		// TODO Auto-generated method stub
		return userDoDao.getUserCode(userName);
	}

	@Override
	public List<Shopping> getUserShoppingByUserCode(String userCode) {
		// TODO Auto-generated method stub
		return userDoDao.getUserShoppingByUserCode(userCode);
	}

	@Override
	public TradingObject getTradingObjectByObjectCode(String objectCode) {
		// TODO Auto-generated method stub
		return sysParObjectTypeDao.toObjectShowByObjectCode(objectCode);
	}

	@Override
	public String deleteTradingObject(Map<Object, Object> map) {
		// TODO Auto-generated method stub
		if(userDoDao.deleteTradingObject(map)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public String deleteTradingObjectByUserCode(String[] objectCode) {
		// TODO Auto-generated method stub
		if(userDoDao.deleteTradingObjectByUserCode(objectCode)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public String changeTradingObjectByUserCode(TradingObject tradingObject) {
		// TODO Auto-generated method stub
		tradingObject.setProvincecode(loginSysOrUserDao.getProvinceCodeByCityCode(tradingObject.getCitycode()));
		tradingObject.setObjectTypeCode(sysParObjectTypeDao.getObjectCodeByParObjectTypeCode(tradingObject.getParObjectCode()));
		if(tradingObject.getPictureDescri()==null) {
			tradingObject.setPictureDescri(userDoDao.getBeforePictureDescri(tradingObject.getObjectCode()));
		}
		if(userDoDao.changeTradingObjectByUserCode(tradingObject)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public String addTradingObjectToShop(String objectCode, String userName) {
		// TODO Auto-generated method stub
		String userCode = userDoDao.getUserCode(userName);
		if(userCode == null) {
			return "false";
		}
		if(userDoDao.addTradingObjectToShop(objectCode,userCode,CurrentDate.getCurrentDate())>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public Order getOrderByUserAndObject(String userName, String objectCode) {
		// TODO Auto-generated method stub
		Order order = new Order();
		
		order = userDoDao.getOrderByUserAndObject(objectCode);
		order.setObjectCode(objectCode);
		order.setUserCode(userDoDao.getUserCode(userName));
		
		return order;
	}

	@Override
	public void saveOrder(Order order) {
		// TODO Auto-generated method stub
		userDoDao.saveOrder(order);
	}

	@Override
	public void toRecordForUser(Order order) {
		// TODO Auto-generated method stub
		userDoDao.toRecordForUser(order);
	}

	@Override
	public String getUserCodeByOrderCode(String orderCode) {
		// TODO Auto-generated method stub
		return userDoDao.getUserCodeByOrderCode(orderCode);
	}

	@Override
	public Page getAllOrderByUserPage(Integer pageNo, Integer pageSize, String userCode) {
		// TODO Auto-generated method stub
		Page page = new Page();
		int recordTotal = userDoDao.getAllOrderByUserPageAccount(userCode);
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) pageSize));
		
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page.setRecordTotal(recordTotal);
		page.setPageTotal(pageTotal);
		
		return page;
	}

	@Override
	public List<Order> getAllOrderByUser(Integer pageNo, Integer pageSize, String userCode) {
		// TODO Auto-generated method stub
		List<Order> oList = userDoDao.getAllOrderByUser(pageNo,pageSize,userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		return oList;
	}

	@Override
	public Page getAllNoPayOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode) {
		// TODO Auto-generated method stub
		Page page = new Page();
		int recordTotal = userDoDao.getAllNoPayOrderByUserPageAccount(userCode);
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) valueOf2));
		
		page.setPageNo(valueOf);
		page.setPageSize(valueOf2);
		page.setRecordTotal(recordTotal);
		page.setPageTotal(pageTotal);
		
		return page;
	}

	@Override
	public List<Order> getAllNoPayOrderByUser(int i, Integer pageSize, String userCode) {
		// TODO Auto-generated method stub
		List<Order> oList = userDoDao.getAllNoPayOrderByUser(i,pageSize,userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		return oList;
	}

	@Override
	public Page getAllNoFhOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode) {
		// TODO Auto-generated method stub
		Page page = new Page();
		int recordTotal = userDoDao.getAllNoFhOrderByUserPageAccount(userCode);
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) valueOf2));
		
		page.setPageNo(valueOf);
		page.setPageSize(valueOf2);
		page.setRecordTotal(recordTotal);
		page.setPageTotal(pageTotal);
		
		return page;
	}

	@Override
	public List<Order> getAllNoFhOrderByUser(int i, Integer pageSize, String userCode) {
		// TODO Auto-generated method stub
		List<Order> oList = userDoDao.getAllNoFhOrderByUser(i,pageSize,userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		return oList;
	}

	@Override
	public Page getAllNoYsOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode) {
		// TODO Auto-generated method stub
		Page page = new Page();
		int recordTotal = userDoDao.getAllNoYsOrderByUserPageAccount(userCode);
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) valueOf2));
		
		page.setPageNo(valueOf);
		page.setPageSize(valueOf2);
		page.setRecordTotal(recordTotal);
		page.setPageTotal(pageTotal);
		
		return page;
	}

	@Override
	public List<Order> getAllNoYsOrderByUser(int i, Integer pageSize, String userCode) {
		// TODO Auto-generated method stub
		List<Order> oList = userDoDao.getAllNoYsOrderByUser(i,pageSize,userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		return oList;
	}

	@Override
	public Boolean yanShou(String orderCode, String userCode) {
		// TODO Auto-generated method stub
		String objectCode = userDoDao.getObjectByOrderCode(orderCode);
		userDoDao.updateTradingObjectByTradingUser(objectCode,userCode,CurrentDate.getCurrentDate());
		return userDoDao.yanShou(orderCode,userCode)>0;
	}

	@Override
	public Page getAllNoPjOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode) {
		// TODO Auto-generated method stub
		Page page = new Page();
		int recordTotal = userDoDao.getAllNoPjOrderByUserPageAccount(userCode);
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) valueOf2));
		
		page.setPageNo(valueOf);
		page.setPageSize(valueOf2);
		page.setRecordTotal(recordTotal);
		page.setPageTotal(pageTotal);
		
		return page;
	}

	@Override
	public List<Order> getAllNoPjOrderByUser(int i, Integer pageSize, String userCode) {
		// TODO Auto-generated method stub
		List<Order> oList = userDoDao.getAllNoPjOrderByUser(i,pageSize,userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		return oList;
	}

	@Override
	public TradingObject TradingObjectByObjectCode(String objectCode) {
		// TODO Auto-generated method stub
		return userDoDao.TradingObjectByObjectCode(objectCode);
	}

	@Override
	public String saveEvaluate(Comment comment,String orderCode) {
		// TODO Auto-generated method stub
		String[] str =comment.getEvaluateUser().split(",");
		comment.setEvaluateUser(str[0]);
		comment.setEvaluateDate(CurrentDate.getCurrentDate());
		comment.setEvaluateCode(comment.getEvaluateText().substring(0, 5)+UUIDGenerator.generator());
		if(userDoDao.saveEvaluate(comment) > 0) {
			userDoDao.updateOrderPJ(orderCode);
			return "true";
		}else {
			return "false";
		}
	}

	@Override
	public Page getAllWriteCommentByUserPage(Integer valueOf, Integer valueOf2, String userCode) {
		// TODO Auto-generated method stub
		Page page = new Page();
		int recordTotal = userDoDao.getAllWriteCommentByUserPageAccount(userCode);
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) valueOf2));
		
		page.setPageNo(valueOf);
		page.setPageSize(valueOf2);
		page.setRecordTotal(recordTotal);
		page.setPageTotal(pageTotal);
		
		return page;
	}

	@Override
	public List<Comment> getAllWriteCommentByUser(int i, Integer pageSize, String userCode) {
		// TODO Auto-generated method stub
		List<Comment> cList = userDoDao.getAllWriteCommentByUser(i,pageSize,userCode);
		if(cList == null) {
			cList = new ArrayList<>();
		}
		return cList;
	}

	@Override
	public boolean deleteCommentByUser(String objectCode, String evaluateUser, String evaluateCode) {
		// TODO Auto-generated method stub
		return userDoDao.deleteCommentByUser(objectCode,evaluateUser,evaluateCode)>0;
	}

	@Override
	public Page getAllReceiveCommentByUserPage(Integer valueOf, Integer valueOf2, String userCode) {
		// TODO Auto-generated method stub
		Page page = new Page();
		int recordTotal = userDoDao.getAllReceiveCommentByUserPageAccount(userCode);
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) valueOf2));
		
		page.setPageNo(valueOf);
		page.setPageSize(valueOf2);
		page.setRecordTotal(recordTotal);
		page.setPageTotal(pageTotal);
		
		return page;
	}

	@Override
	public List<Comment> getAllReceiveCommentByUser(int i, Integer pageSize, String userCode) {
		// TODO Auto-generated method stub
		List<Comment> cList = userDoDao.getAllReceiveCommentByUser(i,pageSize,userCode);
		if(cList == null) {
			cList = new ArrayList<>();
		}
		return cList;
	}

	@Override
	public List<Order> getTradingObjectByUserCode(String userCode) {
		// TODO Auto-generated method stub
		List<Order> oList = userDoDao.getTradingObjectByUserCode(userCode);
		
		if(oList == null){
			oList = new ArrayList<Order>();
		}
		
		return oList;
	}

	@Override
	public Page getAllUserObjectOrderByUserPage(Integer valueOf, Integer valueOf2, String userCode) {
		// TODO Auto-generated method stub
		Page page = new Page();
		int recordTotal = userDoDao.getAllUserObjectOrderByUserPage(userCode);
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) valueOf2));
		
		page.setPageNo(valueOf);
		page.setPageSize(valueOf2);
		page.setRecordTotal(recordTotal);
		page.setPageTotal(pageTotal);
		
		return page;
	}

	@Override
	public List<Order> getAllUserObjectOrderByUser(int i, Integer pageSize, String userCode) {
		// TODO Auto-generated method stub
		List<Order> oList = userDoDao.getAllUserObjectOrderByUser(i,pageSize,userCode);
		if(oList == null){
			oList = new ArrayList<Order>();
		}
		return oList;
	}

	@Override
	public boolean sureFh(String orderCode) {
		// TODO Auto-generated method stub
		return userDoDao.sureFh(orderCode)>0;
	}

	@Override
	public User getUserMsg(String userCode) {
		// TODO Auto-generated method stub
		return userDoDao.getUserMsg(userCode);
	}

	@Override
	public TradingObject getTradingObject(String objectCode) {
		// TODO Auto-generated method stub
		return userDoDao.getTradingObject(objectCode);
	}

	@Override
	public String saveZengYu(Order order) {
		// TODO Auto-generated method stub
		if(userDoDao.saveZengYu(order)>0) {
			return "true";
		}else {
			return "false";
		}
	}



}
