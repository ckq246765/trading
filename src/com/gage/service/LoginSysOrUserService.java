package com.gage.service;

import java.util.List;

import com.gage.beans.LoginSysOrUser;
import com.gage.beans.TradingObject;
import com.gage.beans.TradingType;
import com.gage.beans.User;

public interface LoginSysOrUserService {

	int loginSysFind(LoginSysOrUser loginSysOrUser);

	int loginUserFind(LoginSysOrUser loginSysOrUser);

	boolean checkUserPwd(String userName, String oldPwd);

	boolean changeUserPwd(String userName, String newPwd);

	User getUserByUserName(String userName);

	String changeUserMsg(User user);

	List<TradingType> getAllTradingType();

	String saveUserObj(TradingObject tradingObject, String objectUserName);

	String getLoginUserStatus(LoginSysOrUser loginSysOrUser);

}
