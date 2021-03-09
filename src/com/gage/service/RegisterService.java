package com.gage.service;

import com.gage.beans.User;

public interface RegisterService {

	String saveUser(User user);

	String checkUser(String userName);

}
