package com.gage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gage.beans.SearchUser;
import com.gage.beans.Sys;
import com.gage.beans.TradingObject;
import com.gage.beans.User;
import com.gage.beans.sysOrder;

public interface SysDao {

	/**
	 * 获取当前sys的信息
	 * @param userName
	 * @return
	 */
	public Sys findSysSource(String userName);
	/**
	 * 修改密码
	 * @param userName
	 * @return
	 */
	public int changeSysPwd(String userName, String newPwd);
	/**
	 * 校验密码
	 * @param userName
	 * @param oldPwd
	 * @return
	 */
	public int checkPwd(String userName, String oldPwd);
	
	public List<TradingObject> getAllUserTradingObjectForSys(@Param("no")int no, @Param("pageSize")Integer pageSize);
	
	public int deleteObjectByObjectCode(@Param("objectCode")String objectCode);
	
	public TradingObject toObjectShowByObjectCode(String objectCode);
	
	public Integer getAllUserAccount(@Param("searchUser")SearchUser searchUser);
	
	public List<User> getAllUserForSys(@Param("searchUser")SearchUser searchUser);
	
	public User getUserByUserCode(@Param("userCode")String userCode);
	
	public int changeState(String userCode, String state);
	
	public int getAllOrderBySysPage();
	
	public List<sysOrder> getAllOrderBySys(@Param("pageNo")Integer pageNo, @Param("pageSize")Integer pageSize);
}
