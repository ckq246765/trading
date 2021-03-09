package com.gage.dao;

import java.util.List;

import com.gage.beans.LoginSysOrUser;
import com.gage.beans.TradingObject;
import com.gage.beans.TradingType;
import com.gage.beans.User;

public interface LoginSysOrUserDao {
	//管理员源表
	int selectFromSys(LoginSysOrUser loginSysOrUser);
	//用户源表
	int loginUserFind(LoginSysOrUser loginSysOrUser);
	
	int changeUserPwd(String userName, String newPwd);
	
	int checkUserPwd(String userName, String oldPwd);
	
	User getUserByUserName(String userName);
	
	int changeUserMsg(User user);
	
	List<TradingType> getAllTradingType();
	
	String getObjectUserCodeByUserName(String objectUserName);
	
	int saveUserObj(TradingObject tradingObject);
	
	String getProvinceCodeByCityCode(String citycode);
	
	/**
	 * 获取登录状态
	 * @param loginSysOrUser
	 * @return
	 */
	String getLoginUserStatus(LoginSysOrUser loginSysOrUser);
}
