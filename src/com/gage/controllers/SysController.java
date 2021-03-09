package com.gage.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gage.beans.Order;
import com.gage.beans.Page;
import com.gage.beans.SearchUser;
import com.gage.beans.Sys;
import com.gage.beans.TradingObject;
import com.gage.beans.User;
import com.gage.beans.sysOrder;
import com.gage.service.SysParObjectTypeService;
import com.gage.service.SysService;

@Controller
public class SysController {

	@Autowired
	private SysService sysService;
	
	@RequestMapping(value="showMySource.do",method=RequestMethod.POST)
	@ResponseBody
	public Sys showMySource(String userName) {
		Sys sys = sysService.findCurrSys(userName);
		if(sys == null) {
			sys = new Sys();
		}
		return sys;
	}
	
	@RequestMapping(value="sys/changePwd.do",method=RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String changeSysPwd(String userName,String oldPwd,String newPwd) {
		if(sysService.checkPwd(userName, oldPwd)) {
			if(sysService.changeSysPwd(userName, newPwd)) {
				return "密码修改成功";
			}else {
				return "密码修改失败,请重试";
			}
		}else {
			return "原密码不正确,请重新输入";
		}
	}
	
	@RequestMapping(value="sys/tradingobject/getAllUserTradingObject.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String,Object> getAllUserTradingObjectForSys(Page page){
		Map<String,Object> map = new HashMap<>();
		Page pg =  sysService.getTradingObjectPageForSys(page);
		if(pg == null) {
			pg = new Page();
		}
		map.put("page", pg);
		
		List<TradingObject> tList = sysService.getAllUserTradingObjectForSys((page.getPageNo()-1)*page.getPageSize(),page.getPageSize());
		if(tList == null) {
			tList = new ArrayList<TradingObject>();
		}
		map.put("tList", tList);
		
		return map;
	}
	
	@RequestMapping(value="sys/tradingobject/deleteObject.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteObjectByObjectCode(@RequestParam("objectCode")String objectCode) {
		return sysService.deleteObjectByObjectCode(objectCode);
	}
	
	@RequestMapping(value="sys/tradingobject/toTradingObjectMsg.do")
	public ModelAndView toTradingObjectMsgByObjectCode(@RequestParam("objectCode")String objectCode) {
		ModelAndView mv = new ModelAndView();
		TradingObject tradingObject = sysService.toObjectShowByObjectCode(objectCode);
		if(tradingObject == null) {
			tradingObject = new TradingObject();
		}
		mv.addObject("tObject",tradingObject);
		mv.setViewName("sys/tradingobject/tradingObjectMsg");
		
		return mv;
	}
	
	@RequestMapping(value="sys/user/getAllUser.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String,Object> getUser(SearchUser searchUser){
		Map<String,Object> map = new HashMap<>();
		
		System.out.println(searchUser.getUserName());
		
		Page pg =  sysService.getUserPageForSys(searchUser);
		if(pg == null) {
			pg = new Page();
		}
		map.put("page", pg);
		
		searchUser.setPageNo((pg.getPageNo()-1)*pg.getPageSize());
		searchUser.setPageSize(pg.getPageSize());
		
		List<User> uList = sysService.getAllUserForSys(searchUser);
		if(uList == null) {
			uList = new ArrayList<User>();
		}
		map.put("uList", uList);
		
		for (User user : uList) {
			System.out.println(user.getUserName());
		}
		
		return map;
	}
	
	@RequestMapping(value="sys/user/toUserMsg.do",params={"userCode"})
	public ModelAndView toUserMsg(@RequestParam(value="userCode",required=true)String userCode) {
		ModelAndView mv = new ModelAndView();
		User user = sysService.getUserByUserCode(userCode);
		if(user == null) {
			user = new User();
		}
		mv.addObject("user", user);
		mv.setViewName("sys/user/toUserMsg");
		return mv;
	}
	
	@RequestMapping(value="sys/user/changeState.do",method=RequestMethod.POST,params= {"userCode","state"})
	@ResponseBody
	public String changeState(@RequestParam(value="userCode",required=true)String userCode,@RequestParam(value="state",required=true)String state) {
		return sysService.changeState(userCode,state);
	}
	
	
	@RequestMapping(value="sys/order/getAllOrderBySys.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getAllUserObjectOrderByUser(@RequestParam("pageNo")String pageNo,@RequestParam("pageSize")String pageSize){
		Map<String, Object> map = new HashMap<>();
		Page page = sysService.getAllOrderBySysPage(Integer.valueOf(pageNo),Integer.valueOf(pageSize));
		if(page == null) {
			page = new Page();
		}
		map.put("page", page);
		
		List<sysOrder> oList = sysService.getAllOrderBySys((page.getPageNo()-1)*page.getPageSize(),page.getPageSize());
		if(oList == null) {
			oList = new ArrayList<>();
		}
		map.put("oList", oList);
		
		return map;
	}
}
