package com.gage.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gage.beans.Order;
import com.gage.beans.Page;
import com.gage.beans.SearchUser;
import com.gage.beans.Sys;
import com.gage.beans.TradingObject;
import com.gage.beans.User;
import com.gage.beans.sysOrder;
import com.gage.dao.SysDao;
import com.gage.dao.SysParObjectTypeDao;
import com.gage.service.SysService;

@Service
public class SysServiceImpl implements SysService {

	@Autowired
	private SysDao sysDao; 
	@Autowired
	private SysParObjectTypeDao sysParObjectTypeDao;
	
	/**
	 * 获取当前sys用户的信息
	 */
	@Override
	public Sys findCurrSys(String userName) {
		// TODO Auto-generated method stub
		return sysDao.findSysSource(userName);
	}
	/**
	 * 修改当前用户密码
	 */
	@Override
	public boolean changeSysPwd(String userName, String newPwd) {
		// TODO Auto-generated method stub
		return (sysDao.changeSysPwd(userName, newPwd)>0);
	}
	/**
	 * 校验密码
	 */
	@Override
	public boolean checkPwd(String userName, String oldPwd) {
		// TODO Auto-generated method stub
		return (sysDao.checkPwd(userName, oldPwd)==1);
	}
	
	
	@Override
	public Page getTradingObjectPageForSys(Page page) {
		// TODO Auto-generated method stub
		page.setRecordTotal(sysParObjectTypeDao.getAllTradingObjectAccount());
		page.setPageTotal((int)(Math.ceil((float)page.getRecordTotal()/(float)page.getPageSize())));
		return page;
	}
	@Override
	public List<TradingObject> getAllUserTradingObjectForSys(int no, Integer pageSize) {
		// TODO Auto-generated method stub
		return sysDao.getAllUserTradingObjectForSys(no,pageSize);
	}
	@Override
	public String deleteObjectByObjectCode(String objectCode) {
		// TODO Auto-generated method stub
		if(sysDao.deleteObjectByObjectCode(objectCode)>0) {
			return "true";
		}
		return "false";
	}
	@Override
	public TradingObject toObjectShowByObjectCode(String objectCode) {
		// TODO Auto-generated method stub
		return sysDao.toObjectShowByObjectCode(objectCode);
	}
	@Override
	public Page getUserPageForSys(SearchUser searchUser) {
		// TODO Auto-generated method stub
		Page page = new Page();
		page.setPageNo(searchUser.getPageNo());
		page.setPageSize(searchUser.getPageSize());
		page.setRecordTotal(sysDao.getAllUserAccount(searchUser));
		page.setPageTotal((int)(Math.ceil((float)page.getRecordTotal()/(float)page.getPageSize())));
		return page;
	}
	@Override
	public List<User> getAllUserForSys(SearchUser searchUser) {
		// TODO Auto-generated method stub
		return sysDao.getAllUserForSys(searchUser);
	}
	@Override
	public User getUserByUserCode(String userCode) {
		// TODO Auto-generated method stub
		return sysDao.getUserByUserCode(userCode);
	}
	@Override
	public String changeState(String userCode, String state) {
		// TODO Auto-generated method stub
		String strState = null;
		if("1".equals(state)) {
			strState = "0";
		}else if("0".equals(state)) {
			strState = "1";
		}
		if(sysDao.changeState(userCode,strState)>0) {
			return "1";
		}else {
			return "0";
		}
	}
	@Override
	public Page getAllOrderBySysPage(Integer valueOf, Integer valueOf2) {
		// TODO Auto-generated method stub
		Page page = new Page();
		int recordTotal = sysDao.getAllOrderBySysPage();
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) valueOf2));
		
		page.setPageNo(valueOf);
		page.setPageSize(valueOf2);
		page.setRecordTotal(recordTotal);
		page.setPageTotal(pageTotal);
		
		return page;
	}
	
	@Override
	public List<sysOrder> getAllOrderBySys(int i, Integer pageSize) {
		// TODO Auto-generated method stub
		List<sysOrder> sList = sysDao.getAllOrderBySys(i,pageSize);
		if(sList == null){
			sList = new ArrayList<sysOrder>();
		}
		return sList;
	}
	
}
