package com.gage.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gage.beans.User;
import com.gage.dao.RegisterDao;
import com.gage.service.RegisterService;
import com.gage.utils.UUIDGenerator;

@Service
public class RegisterServiceImpl implements RegisterService {

	@Autowired
	private RegisterDao  registerDao;
	
	@Override
	public String saveUser(User user) {
		// TODO Auto-generated method stub
		user.setUser_code(user.getUserName()+UUIDGenerator.generator());
		if(registerDao.saveUser(user)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public String checkUser(String userName) {
		// TODO Auto-generated method stub
		if(registerDao.checkUser(userName)!=null) {
			return "true";
		}
		return "false";
	}

}
