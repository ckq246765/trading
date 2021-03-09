package com.gage.dao;

import com.gage.beans.User;

public interface RegisterDao {

	int saveUser(User user);

	String checkUser(String userName);

}
