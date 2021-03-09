package com.gage.service;

import java.util.List;

import com.gage.beans.Page;
import com.gage.beans.SearchUser;
import com.gage.beans.Sys;
import com.gage.beans.TradingObject;
import com.gage.beans.User;
import com.gage.beans.sysOrder;

public interface SysService {
	
	public Sys findCurrSys(String userName);
	
	public boolean checkPwd(String userName, String oldPwd);
	
	public boolean changeSysPwd(String userName, String newPwd);

	public Page getTradingObjectPageForSys(Page page);

	public List<TradingObject> getAllUserTradingObjectForSys(int no, Integer pageSize);

	public String deleteObjectByObjectCode(String objectCode);

	public TradingObject toObjectShowByObjectCode(String objectCode);

	public Page getUserPageForSys(SearchUser searchUser);

	public List<User> getAllUserForSys(SearchUser searchUser);

	public User getUserByUserCode(String userCode);

	public String changeState(String userCode, String state);

	public Page getAllOrderBySysPage(Integer valueOf, Integer valueOf2);

	public List<sysOrder> getAllOrderBySys(int i, Integer pageSize);
}
