package com.gage.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gage.beans.City;
import com.gage.beans.Province;
import com.gage.beans.User;
import com.gage.service.RegisterService;
import com.gage.service.SysCityService;

@Controller
public class RegisterController {

	@Autowired
	private SysCityService sysCityService;
	@Autowired
	private RegisterService registerService;
	
	@RequestMapping("jump/toRegister.do")
	public ModelAndView getProvinceAndCity() {
		ModelAndView mv = new ModelAndView();
		List<Province> pList = sysCityService.getAllProvince();
		if(pList == null) {
			pList = new ArrayList<Province>();
		}
		mv.addObject("pList",pList);
		List<City> cList = sysCityService.getAllCityForRegister();
		if(cList == null) {
			cList = new ArrayList<City>();
		}
		mv.addObject("cList",cList);
		mv.setViewName("register/register");
		return mv;
	}
	
	@RequestMapping(value="user/getCityByProvince.do",method=RequestMethod.POST,produces="application/json;changset=UTF-8")
	@ResponseBody
	public List<City> getAllCityByProvinceCode(@RequestParam("provinceCode")String provinceCode){
		return sysCityService.getAllCityByProvinceCode(provinceCode);
	}
	
	
	@RequestMapping(value="user/checkUserName.do",method=RequestMethod.POST)
	@ResponseBody
	public String checkUser(@RequestParam("userName")String userName) {
		return registerService.checkUser(userName);
	}
	
	@RequestMapping(value="user/regist.do",method=RequestMethod.POST)
	@ResponseBody
	public String saveUser(User user) {
		return registerService.saveUser(user);
	}
	
}