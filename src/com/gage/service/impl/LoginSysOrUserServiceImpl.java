package com.gage.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gage.beans.LoginSysOrUser;
import com.gage.beans.TradingObject;
import com.gage.beans.TradingType;
import com.gage.beans.User;
import com.gage.dao.LoginSysOrUserDao;
import com.gage.dao.SysParObjectTypeDao;
import com.gage.service.LoginSysOrUserService;
import com.gage.utils.UUIDGenerator;

@Service
public class LoginSysOrUserServiceImpl implements LoginSysOrUserService {

	@Autowired
	private LoginSysOrUserDao loginSysOrUserDao;
	@Autowired
	private SysParObjectTypeDao sysParObjectTypeDao;

	@Override
	public int loginSysFind(LoginSysOrUser loginSysOrUser) {
		// TODO Auto-generated method stub
		int row = 0;
		if(loginSysOrUser.getCheckUser().equals("1")) {
			row = loginSysOrUserDao.selectFromSys(loginSysOrUser);
		}
		return row;
	}

	@Override
	public int loginUserFind(LoginSysOrUser loginSysOrUser) {
		// TODO Auto-generated method stub
		if(loginSysOrUserDao.loginUserFind(loginSysOrUser)==1) {
			return 1;
		}
		return 0;
	}

	@Override
	public boolean checkUserPwd(String userName, String oldPwd) {
		// TODO Auto-generated method stub
		return (loginSysOrUserDao.checkUserPwd(userName,oldPwd)>0);
	}

	@Override
	public boolean changeUserPwd(String userName, String newPwd) {
		// TODO Auto-generated method stub
		return (loginSysOrUserDao.changeUserPwd(userName,newPwd)>0);
	}

	@Override
	public User getUserByUserName(String userName) {
		// TODO Auto-generated method stub
		return loginSysOrUserDao.getUserByUserName(userName);
	}

	@Override
	public String changeUserMsg(User user) {
		// TODO Auto-generated method stub
		if(loginSysOrUserDao.changeUserMsg(user)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public List<TradingType> getAllTradingType() {
		// TODO Auto-generated method stub
		return loginSysOrUserDao.getAllTradingType();
	}

	@Override
	public String saveUserObj(TradingObject tradingObject, String objectUserName) {
		// TODO Auto-generated method stub
		tradingObject.setObjectCode(objectUserName+"-OBJ-"+UUIDGenerator.generator());
		tradingObject.setProvincecode(loginSysOrUserDao.getProvinceCodeByCityCode(tradingObject.getCitycode()));
		tradingObject.setObjectTypeCode(sysParObjectTypeDao.getObjectCodeByParObjectTypeCode(tradingObject.getParObjectCode()));
		String userCode = loginSysOrUserDao.getObjectUserCodeByUserName(objectUserName);
		if(userCode == null) {
			return "false";
		}else {
			tradingObject.setObjectUserCode(userCode);
		}
		if(loginSysOrUserDao.saveUserObj(tradingObject)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public String getLoginUserStatus(LoginSysOrUser loginSysOrUser) {
		// TODO Auto-generated method stub
		return loginSysOrUserDao.getLoginUserStatus(loginSysOrUser);
	}

}
