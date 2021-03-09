package com.gage.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gage.beans.City;
import com.gage.beans.Comment;
import com.gage.beans.Order;
import com.gage.beans.Page;
import com.gage.beans.ParObjectType;
import com.gage.beans.Shopping;
import com.gage.beans.TradingObject;
import com.gage.beans.TradingType;
import com.gage.beans.User;
import com.gage.service.LoginSysOrUserService;
import com.gage.service.SysCityService;
import com.gage.service.SysParObjectTypeService;
import com.gage.service.UserDoService;
import com.gage.utils.CurrentDate;
import com.gage.utils.ImageUtils;
import com.gage.utils.UUIDGenerator;
import com.sun.org.glassfish.gmbal.ParameterNames;

@Controller
@RequestMapping("user/jump")
public class UserDoController {

	@Autowired
	private UserDoService userDoService; 
	@Autowired
	private SysParObjectTypeService sysParObjectTypeService;
	@Autowired
	private LoginSysOrUserService loginSysOrUserService;
	@Autowired
	private SysCityService sysCityService;
	
	@RequestMapping(value="/shopping.do",params= {"userName"})
	public	ModelAndView toShopping(@RequestParam(value="userName",required=true)String userName,
			@RequestParam("backURL")String backURL) {
		ModelAndView mv = new ModelAndView();
		List<TradingObject> tList = new ArrayList<TradingObject>();
		
		if(backURL != null&&!"".equals(backURL)) {
			String [] url = backURL.split("trading");
			mv.addObject("backURL", url[1]);
			System.out.println(url[1]);
		}
		String userCode = userDoService.getUserCode(userName);
		System.out.println(userCode);
		List<Shopping> sList = userDoService.getUserShoppingByUserCode(userCode);
		if(sList==null) {
			sList = new ArrayList<Shopping>();
		}else {
			mv.addObject("sList", sList);
			for (Shopping shopping : sList) {
				TradingObject tradingObject = new TradingObject();
				System.out.println(shopping.getObjectCode().toString());
				tradingObject = userDoService.getTradingObjectByObjectCode(shopping.getObjectCode());
				tList.add(tradingObject);
			}
			mv.addObject("tList", tList);
		}
		
		//推荐随机10个
		List<TradingObject> toList = sysParObjectTypeService.getAllTradingObject(0,10);
		if(toList == null) {
			toList = new ArrayList<TradingObject>();
		}
		mv.addObject("toList", toList);
		
		mv.setViewName("shopping/index");
		return mv;
	}
	
	@RequestMapping(value="/deleteTradingObject.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteTradingObject(@RequestParam("chk_value[]")String[] objectCode,@RequestParam("userCode")String userCode) {
		Map<Object, Object> map = new HashMap<>();
		map.put("objectCode", objectCode);
		map.put("userCode", userCode);
		return userDoService.deleteTradingObject(map);
	}
	
	@RequestMapping(value="toObjectMsg.do",params={"userName"})
	public ModelAndView toObjectMsg(@RequestParam(value="userName",required=true)String userName,
			@RequestParam("backURL")String backURL) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("userName", userName);
		if(backURL != null&&!"".equals(backURL)) {
			String [] url = backURL.split("trading");
			mv.addObject("backURL", url[1]);
		}
		String userCode = userDoService.getUserCode(userName);
		mv.addObject("userCode", "userCode");
		List<TradingObject> tList = sysParObjectTypeService.getTradingObjectByUserCode(userCode);
		if(tList == null) {
			tList = new ArrayList<TradingObject>();
		}
		mv.addObject("tList", tList);
		
		//交易类型
		List<TradingType> tradingTypeList = loginSysOrUserService.getAllTradingType();
		if(tradingTypeList == null) {
			tradingTypeList = new ArrayList<TradingType>();
		}
		mv.addObject("tradingTypeList", tradingTypeList);
		
		//物品详细类型
		List<ParObjectType> parObjectTypeList = sysParObjectTypeService.getAllParObject();
		if(parObjectTypeList == null) {
			parObjectTypeList = new ArrayList<ParObjectType>();
		}
		mv.addObject("parObjectTypeList", parObjectTypeList);
		
		//城市
		List<City> cList = sysCityService.getAllCityForRegister();
		if (cList == null) {
			cList = new ArrayList<City>();
		}
		mv.addObject("cList", cList);
		
		mv.setViewName("objectMsg/show");
		return mv;
	}
	
	@RequestMapping(value="/deleteTradingObjectByUserCode.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteTradingObjectByUserCode(@RequestParam("chk_value[]")String[] objectCode) {
		return userDoService.deleteTradingObjectByUserCode(objectCode);
	}
	@RequestMapping(value="/changeTradingObjectByUserCode.do",method=RequestMethod.POST)
	@ResponseBody
	public String changeTradingObjectByUserCode(TradingObject tradingObject, HttpServletRequest request,
			@RequestParam(value="salePrice1",required=false)Float salePrice,@RequestParam(value="originalPrince1",required=false)Float originalPrince,
			@RequestParam(value="postage1",required=false)Float postage,@RequestParam(value="pictureFile",required=false)MultipartFile pictureFile) {
		if(salePrice!=null&&!"".equals(salePrice)) {
			tradingObject.setSalePrice(salePrice);
		}
		if(originalPrince!=null&&!"".equals(originalPrince)) {
			tradingObject.setOriginalPrince(originalPrince);
		}
		if(postage!=null&&!"".equals(postage)) {
			tradingObject.setPostage(postage);
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
		
		return userDoService.changeTradingObjectByUserCode(tradingObject);
	}
	
	@RequestMapping(value="/addTradingObjectToShop.do",method=RequestMethod.POST)
	@ResponseBody
	public String addTradingObjectToShop(@RequestParam("objectCode")String objectCode, @RequestParam("userName")String userName) {
		return userDoService.addTradingObjectToShop(objectCode,userName);
	}
	
	
	@RequestMapping(value="/order/getAllOrderByUser.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getAllOrderByUser(@RequestParam("pageNo")String pageNo,@RequestParam("pageSize")String pageSize,@RequestParam("userCode")String userCode){
		Map<String, Object> map = new HashMap<>();
		Page page = userDoService.getAllOrderByUserPage(Integer.valueOf(pageNo),Integer.valueOf(pageSize),userCode);
		if(page == null) {
			page = new Page();
		}
		map.put("page", page);
		
		List<Order> oList = userDoService.getAllOrderByUser((page.getPageNo()-1)*page.getPageSize(),page.getPageSize(),userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		map.put("oList", oList);
		
		return map;
	}
	
	@RequestMapping(value="/order/getAllNoPayOrderByUser.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getAllNoPayOrderByUser(@RequestParam("pageNo")String pageNo,@RequestParam("pageSize")String pageSize,@RequestParam("userCode")String userCode){
		Map<String, Object> map = new HashMap<>();
		
		Page page = userDoService.getAllNoPayOrderByUserPage(Integer.valueOf(pageNo),Integer.valueOf(pageSize),userCode);
		if(page == null) {
			page = new Page();
		}
		map.put("page", page);
		
		List<Order> oList = userDoService.getAllNoPayOrderByUser((page.getPageNo()-1)*page.getPageSize(),page.getPageSize(),userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		map.put("oList", oList);
		
		return map;
	}
	
	@RequestMapping(value="/order/getAllNoFhOrderByUser.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getAllNoFhOrderByUser(@RequestParam("pageNo")String pageNo,@RequestParam("pageSize")String pageSize,@RequestParam("userCode")String userCode){
		Map<String, Object> map = new HashMap<>();
		
		Page page = userDoService.getAllNoFhOrderByUserPage(Integer.valueOf(pageNo),Integer.valueOf(pageSize),userCode);
		if(page == null) {
			page = new Page();
		}
		map.put("page", page);
		
		List<Order> oList = userDoService.getAllNoFhOrderByUser((page.getPageNo()-1)*page.getPageSize(),page.getPageSize(),userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		map.put("oList", oList);
		
		return map;
	}
	
	@RequestMapping(value="/order/getAllNoYsOrderByUser.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getAllNoYsOrderByUser(@RequestParam("pageNo")String pageNo,@RequestParam("pageSize")String pageSize,@RequestParam("userCode")String userCode){
		Map<String, Object> map = new HashMap<>();
		
		Page page = userDoService.getAllNoYsOrderByUserPage(Integer.valueOf(pageNo),Integer.valueOf(pageSize),userCode);
		if(page == null) {
			page = new Page();
		}
		map.put("page", page);
		
		List<Order> oList = userDoService.getAllNoYsOrderByUser((page.getPageNo()-1)*page.getPageSize(),page.getPageSize(),userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		map.put("oList", oList);
		
		return map;
	}
	
	@RequestMapping(value="/order/yansuo.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Boolean yanShou(@RequestParam("orderCode")String orderCode,@RequestParam("userCode")String userCode){
		return userDoService.yanShou(orderCode,userCode);
	}
	
	@RequestMapping(value="/order/getAllNoPjOrderByUser.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getAllNoPjOrderByUser(@RequestParam("pageNo")String pageNo,@RequestParam("pageSize")String pageSize,@RequestParam("userCode")String userCode){
		Map<String, Object> map = new HashMap<>();
		
		Page page = userDoService.getAllNoPjOrderByUserPage(Integer.valueOf(pageNo),Integer.valueOf(pageSize),userCode);
		if(page == null) {
			page = new Page();
		}
		map.put("page", page);
		
		List<Order> oList = userDoService.getAllNoPjOrderByUser((page.getPageNo()-1)*page.getPageSize(),page.getPageSize(),userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		map.put("oList", oList);
		
		return map;
	}
	
	@RequestMapping(value="/order/gotopj.do")
	public ModelAndView goToPjByTradeUser(@RequestParam("objectCode")String objectCode,@RequestParam("userCode")String userCode,@RequestParam("backURL")String backURL,@RequestParam("orderCode")String orderCode){
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("orderCode", orderCode);
		mv.addObject("objectCode", objectCode);
		mv.addObject("userCode", userCode);
		mv.addObject("backURL", backURL);
		
		TradingObject tradingObject = userDoService.TradingObjectByObjectCode(objectCode);
		if(tradingObject == null) {
			tradingObject = new TradingObject();
		}
		mv.addObject("tObject", tradingObject);
		
		mv.setViewName("comment/comment");
		return mv;
	}
	@RequestMapping(value="/saveEvaluate.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> saveEvaluate(Comment comment,@RequestParam(value="orderCode",required=false)String orderCode, HttpServletRequest request,@RequestParam(value="pictureFile",required=false)MultipartFile pictureFile) {
		String imgPath;
		try {
			imgPath = ImageUtils.upload(request, pictureFile);
			if (imgPath != null) {
				comment.setEvaluatePicture(imgPath);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<>();
		map.put("success", userDoService.saveEvaluate(comment,orderCode));
		map.put("userCode", comment.getEvaluateUser());
		return map;
	}
	
	@RequestMapping(value="/comment/getAllWriteCommentByUser.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getAllWriteCommentByUser(@RequestParam("pageNo")String pageNo,@RequestParam("pageSize")String pageSize,@RequestParam("userCode")String userCode){
		Map<String, Object> map = new HashMap<>();
		
		Page page = userDoService.getAllWriteCommentByUserPage(Integer.valueOf(pageNo),Integer.valueOf(pageSize),userCode);
		if(page == null) {
			page = new Page();
		}
		map.put("page", page);
		
		List<Comment> cList = userDoService.getAllWriteCommentByUser((page.getPageNo()-1)*page.getPageSize(),page.getPageSize(),userCode);
		if(cList == null) {
			cList = new ArrayList<>();
		}
		map.put("cList", cList);
		
		return map;
	}
	
	@RequestMapping(value="/comment/deleteCommentByUser.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public boolean deleteCommentByUser(@RequestParam("objectCode")String objectCode,@RequestParam("evaluateUser")String evaluateUser,@RequestParam("evaluateCode")String evaluateCode){
		return userDoService.deleteCommentByUser(objectCode,evaluateUser,evaluateCode);
	}
	
	
	@RequestMapping(value="/comment/getAllReceiveCommentByUser.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getAllReceiveCommentByUser(@RequestParam("pageNo")String pageNo,@RequestParam("pageSize")String pageSize,@RequestParam("userCode")String userCode){
		Map<String, Object> map = new HashMap<>();
		
		Page page = userDoService.getAllReceiveCommentByUserPage(Integer.valueOf(pageNo),Integer.valueOf(pageSize),userCode);
		if(page == null) {
			page = new Page();
		}
		map.put("page", page);
		
		List<Comment> cList = userDoService.getAllReceiveCommentByUser((page.getPageNo()-1)*page.getPageSize(),page.getPageSize(),userCode);
		if(cList == null) {
			cList = new ArrayList<>();
		}
		map.put("cList", cList);
		
		return map;
	}
	
	@RequestMapping(value="/order/userObject/getAllUserObjectOrderByUser.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getAllUserObjectOrderByUser(@RequestParam("pageNo")String pageNo,@RequestParam("pageSize")String pageSize,@RequestParam("userCode")String userCode){
		Map<String, Object> map = new HashMap<>();
		
		Page page = userDoService.getAllUserObjectOrderByUserPage(Integer.valueOf(pageNo),Integer.valueOf(pageSize),userCode);
		if(page == null) {
			page = new Page();
		}
		map.put("page", page);
		
		List<Order> oList = userDoService.getAllUserObjectOrderByUser((page.getPageNo()-1)*page.getPageSize(),page.getPageSize(),userCode);
		if(oList == null) {
			oList = new ArrayList<>();
		}
		map.put("oList", oList);
		
		return map;
	}
	
	@RequestMapping(value="/order/userObject/sureFh.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public boolean sureFh(@RequestParam("orderCode")String orderCode){
		return userDoService.sureFh(orderCode);
	}
	
	@RequestMapping(value="/toAlipayByShouDong.do")
	public ModelAndView toAlipayByShouDong(@RequestParam("userName")String userName,@RequestParam("objectCode")String objectCode){
		ModelAndView mv = new ModelAndView();
		String userCode = userDoService.getUserCode(userName);
		
		User user = userDoService.getUserMsg(userCode);
		if(user == null) {
			user = new User();
		}
		mv.addObject("user", user);
		
		TradingObject tradingObject = userDoService.getTradingObject(objectCode);
		if(tradingObject == null) {
			tradingObject = new TradingObject();
		}
		mv.addObject("tObject", tradingObject);
		
		Order order = new Order();
		order.setOrderCode(UUIDGenerator.generator());
		order.setOrderName("赠予物品"+UUIDGenerator.generator());
		/*order.setObjectCode(objectCode);
		order.setOrderAccount(Float.valueOf("0"));
		order.setUserCode(userCode);
		order.setOrderDate(CurrentDate.getCurrentDate());*/
		
		mv.addObject("order", order);
		
		mv.setViewName("order/zengyu/index");
		return mv;
	}
	
	@RequestMapping(value="/order/saveZengYu.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String saveZengYu(Order order) {
		order.setOrderAccount(Float.valueOf("0"));
		order.setOrderDate(CurrentDate.getCurrentDate());
		order.setTradeStatus("1");
		return userDoService.saveZengYu(order);
	}
}
