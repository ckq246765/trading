package com.gage.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gage.beans.City;
import com.gage.beans.LoginSysOrUser;
import com.gage.beans.ParObjectType;
import com.gage.beans.Province;
import com.gage.beans.TradingObject;
import com.gage.beans.TradingType;
import com.gage.beans.User;
import com.gage.service.LoginSysOrUserService;
import com.gage.service.SysCityService;
import com.gage.service.SysParObjectTypeService;
import com.gage.utils.ImageUtils;

@Controller
public class LoginSysOrUserController {

	@Autowired
	private LoginSysOrUserService loginSysOrUserService;
	@Autowired
	private SysCityService sysCityService;
	@Autowired
	private SysParObjectTypeService sysParObjectTypeService;
	
	@RequestMapping(value="login.do",method=RequestMethod.POST)
	@ResponseBody
	public String loginSysOrUser(HttpSession session,LoginSysOrUser loginSysOrUser) {
		if("1".equals(loginSysOrUser.getCheckUser())) {
			if(loginSysOrUserService.loginSysFind(loginSysOrUser)==1) {
				session.setAttribute("loginSys", loginSysOrUser.getUserName());
				return "sys/sys";
			}
		}else if("0".equals(loginSysOrUser.getCheckUser())) {
			if(loginSysOrUserService.loginUserFind(loginSysOrUser)==1 && "1".equals(loginSysOrUserService.getLoginUserStatus(loginSysOrUser))) {
				session.setAttribute("loginUser", loginSysOrUser.getUserName());
				return loginSysOrUser.getUserName();
			}else if(loginSysOrUserService.loginUserFind(loginSysOrUser)==1&&"0".equals(loginSysOrUserService.getLoginUserStatus(loginSysOrUser))){
				return "noLogin";
			}
		}
		return "show";
	}			
	
	@RequestMapping(value="sys/changeUserPwd.do",method=RequestMethod.POST,params= {"userName","oldPwd","newPwd"},produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String changeUserPwd(@RequestParam("userName")String userName,
			@RequestParam("oldPwd")String oldPwd,
			@RequestParam("newPwd")String newPwd) {
		if(loginSysOrUserService.checkUserPwd(userName, oldPwd)) {
			if(loginSysOrUserService.changeUserPwd(userName, newPwd)) {
				return "密码修改成功";
			}else {
				return "密码修改失败,请重试";
			}
		}else {
			return "原密码不正确,请重新输入";
		}
	}
	
	@RequestMapping(value="user/getProvinceAndCity.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")	
	@ResponseBody
	public Map<String,Object> getAllProinceAndCity(@RequestParam("userName")String userName){
		Map<String, Object> map = new HashMap<>();
		List<Province> pList = sysCityService.getAllProvince();
		if (pList == null) {
			pList = new ArrayList<Province>();
		}
		map.put("pList", pList);
		List<City> cList = sysCityService.getAllCityForRegister();
		if (cList == null) {
			cList = new ArrayList<City>();
		}
		map.put("cList", cList);
		User user = loginSysOrUserService.getUserByUserName(userName);
		if(user == null) {
			user = new User();
		}
		map.put("user", user);
		return map;
	}
	
	@RequestMapping(value="user/cahngeUserMsg.do",method=RequestMethod.POST,params= {"user_code"})
	@ResponseBody
	public String changeUserMsg(User user) {
		return loginSysOrUserService.changeUserMsg(user);
	}
	
	@RequestMapping(value="user/objectShow.do",method=RequestMethod.POST,params= {"userName"},produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> returnOjectShow(@RequestParam("userName")String userName){
		Map<String, Object> map = new HashMap<>();
		User user = loginSysOrUserService.getUserByUserName(userName);
		if(user == null) {
			user = new User();
		}
		map.put("user", user);
		
		List<TradingType> tList = loginSysOrUserService.getAllTradingType();
		if(tList == null) {
			tList = new ArrayList<TradingType>();
		}
		map.put("tList", tList);
		
		List<ParObjectType> pList = sysParObjectTypeService.getAllParObject();
		if(pList == null) {
			pList = new ArrayList<ParObjectType>();
		}
		map.put("pList", pList);
		
		List<City> cList = sysCityService.getAllCityForRegister();
		if (cList == null) {
			cList = new ArrayList<City>();
		}
		map.put("cList", cList);
		
		return map;
	}
	
	@RequestMapping(value = "user/savecreateObjModal.do", method = RequestMethod.POST,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String saveUserObj(TradingObject tradingObject, HttpServletRequest request,
			@RequestParam("salePrice1")String salePrice,
			@RequestParam("originalPrince1")String originalPrince,
			@RequestParam("postage1")String postage,
			@RequestParam("objectUserName")String objectUserName,
			@RequestParam(value="pictureFile",required=false)MultipartFile pictureFile) {
		if(salePrice!=null&&!"".equals(salePrice)) {
			tradingObject.setSalePrice(Float.parseFloat(salePrice.trim()));
		}
		if(originalPrince!=null&&!"".equals(originalPrince)) {
			tradingObject.setOriginalPrince(Float.parseFloat(originalPrince.trim()));
		}
		if(postage!=null&&!"".equals(postage)) {
			tradingObject.setPostage(Float.parseFloat(postage.trim()));
		}
		String imgPath;
		try {
			imgPath = ImageUtils.upload(request, pictureFile);
			if (imgPath != null) {
				tradingObject.setPictureDescri(imgPath);
				System.out.println("-----------------图片上传成功！");
			}
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("-----------------图片上传shibai");
		}
		return loginSysOrUserService.saveUserObj(tradingObject,objectUserName);
	}
	
}
