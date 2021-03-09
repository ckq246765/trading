package com.gage.controllers;

import java.sql.ClientInfoStatus;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.alipay.api.domain.PublicAuditStatus;
import com.gage.beans.City;
import com.gage.beans.ObjectType;
import com.gage.beans.Order;
import com.gage.beans.ParObjectType;
import com.gage.beans.Province;
import com.gage.beans.TradingObject;
import com.gage.service.SysCityService;
import com.gage.service.SysObjectService;
import com.gage.service.SysParObjectTypeService;
import com.gage.service.SysProvinceService;
import com.gage.service.UserDoService;

/**
 * 跳转到
 * @author 陈克齐
 *
 */
@Controller
@RequestMapping(value="jump")
public class JumpToJsp {

	@Autowired
	private SysParObjectTypeService sysParObjectTypeService;
	@Autowired
	private SysObjectService sysObjectService;
	@Autowired
	private SysCityService sysCityService; 
	@Autowired
	private UserDoService userDoService;
	
	@RequestMapping("/tojsp.do")
	public String toJsp(String target) {
		if("show".equals(target)) {
			return "redirect:show.do";
		}
		if("sys/user/index".equals(target)) {
			return "redirect:sys/user/index.do";
		}
		return target;
	}
	
	@RequestMapping("show")
	public String toShow(Model model) {
		List<ObjectType> oList = sysParObjectTypeService.getAllObjectType();
		model.addAttribute("oList",oList);
		List<ParObjectType> pList = sysParObjectTypeService.getAllParObject();
		model.addAttribute("pList",pList);
		
		//图片
		List<TradingObject> tList = sysParObjectTypeService.getAllTradingObject(0,20);
		if(tList == null) {
			tList = new ArrayList<TradingObject>();
		}
		model.addAttribute("tList",tList);
		return "show";
	}
	
	@RequestMapping(value="/toObject.do",params= {"objectCode"})
	public ModelAndView toObjectShow(@RequestParam("objectCode")String objectCode) {
		ModelAndView mv = new ModelAndView();
		TradingObject tObject = sysParObjectTypeService.toObjectShowByObjectCode(objectCode);
		if(tObject == null) {
			tObject = new TradingObject();
		}
		mv.addObject("tObject", tObject);
		
		List<TradingObject> tList = sysParObjectTypeService.toParObjectShowByObjectCode(objectCode);
		if(tList == null) {
			tList = new ArrayList<TradingObject>();
		}
		mv.addObject("tList",tList);
		mv.setViewName("object/index");
		return mv;
	}
	
	/**
	 * 返回物品查询集合
	 * @param objectCode
	 * @param parObjectTypeName
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value="/toObjectList.do")
	public ModelAndView toObjectListByObjectCode(
			@RequestParam(value="objectCode",required=false)String objectCode,
			@RequestParam(value="parObjectTypeCode",required=false)String parObjectTypeCode) {
		ModelAndView mv = new ModelAndView();
		//ObjectType
		//parObjectType
		if(objectCode != null&&!"".equals(objectCode)) {
			ObjectType objectType = sysObjectService.getobjectByCode(objectCode);
			mv.addObject("objectType", objectType);
			List<ParObjectType> pList = sysParObjectTypeService.getAllParObjectTypeByObjectCode(objectCode);
			mv.addObject("pList", pList);
			mv.addObject("currentCode", objectCode);
		}else if(parObjectTypeCode != null&&!"".equals(parObjectTypeCode)) {
			ObjectType objectType = sysObjectService.getobjectByCode(sysParObjectTypeService.getObjectCodeByParObjectTypeCode(parObjectTypeCode));
			mv.addObject("objectType", objectType);
			List<ParObjectType> pList = sysParObjectTypeService.getAllParObjectTypeByObjectCode(sysParObjectTypeService.getObjectCodeByParObjectTypeCode(parObjectTypeCode));
			mv.addObject("pList", pList);
			mv.addObject("currentCode", parObjectTypeCode);
		}
		//allObject
		//allParObject
		List<ObjectType> allObjectTypeList = sysParObjectTypeService.getAllObjectType();
		if(allObjectTypeList == null) {
			allObjectTypeList = new ArrayList<ObjectType>();
		}
		mv.addObject("allObjectTypeList",allObjectTypeList);
		
		List<ParObjectType> parObjectTypeList = sysParObjectTypeService.getAllParObject();
		if(parObjectTypeList == null) {
			parObjectTypeList = new ArrayList<ParObjectType>();
		}
		mv.addObject("parObjectTypeList", parObjectTypeList);
		mv.setViewName("release/show");
		return mv;
	}
	
	@RequestMapping("sys/user/index")
	public String toSysUserIndex(Model model) {
		List<Province> pList = sysCityService.getAllProvince();
		if(pList == null) {
			pList = new ArrayList<Province>();
		}
		model.addAttribute("pList", pList);
		List<City> cList =  sysCityService.getAllCityForRegister();
		if(cList == null) {
			cList = new ArrayList<City>();
		}
		model.addAttribute("cList", cList);
		return "sys/user/index";
	}
	@RequestMapping(value="/toAlipay.do")
	public ModelAndView toAlipay(@RequestParam("userName")String userName,@RequestParam("objectCode")String objectCode) {
		ModelAndView mv = new ModelAndView();
		
		Order order = userDoService.getOrderByUserAndObject(userName,objectCode);
		if(order == null) {
			order = new Order();
		}
		mv.addObject("order", order);
		System.out.println(order.getObjectCode());
		System.out.println(order.getObjectDescribe()+" "+ order.getOrderCode()+" "+order.getOrderDate()+" "+order.getOrderAccount());
		
		mv.setViewName("wappay/pay");
		
		return mv;
	}
	
	@RequestMapping(value="/user/saveOrder.do")
	public void saveOrder(Order order) {
		userDoService.saveOrder(order);
	}
	
	@RequestMapping(value="user/addOrderMsg.do")
	public ModelAndView toRecordForUser(@RequestParam("orderCode")String orderCode,@RequestParam("tradeNo")String tradeNo,@RequestParam("tradeStatus")String tradeStatus) {
		Order order = new Order();
		System.out.println(orderCode+" "+ tradeNo+" "+ tradeStatus);
		order.setOrderCode(orderCode);
		order.setTradeNo(tradeNo);
		order.setTradeStatus(tradeStatus);
		userDoService.toRecordForUser(order);
		ModelAndView mv = new ModelAndView();
		mv.addObject("userCode",userDoService.getUserCodeByOrderCode(order.getOrderCode()));
		mv.setViewName("order/index");
		return mv;
	}
	
	
	
	@RequestMapping(value="/toOrderByUserName.do")
	public ModelAndView toOrderByUserName(@RequestParam("userName")String userName,@RequestParam("backURL")String backURL) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("userCode", userDoService.getUserCode(userName));
		mv.addObject("backURL", backURL);
		mv.setViewName("order/index");
		
		/*
		 *查找用户发布的被购买后生成的订单
		 */
		List<Order> oList = userDoService.getTradingObjectByUserCode(userDoService.getUserCode(userName));
		if(oList == null) {
			oList = new ArrayList<>();
		}
		mv.addObject("oList",oList);
		
		return mv;
	}
	
	@RequestMapping(value="/toOrder.do")
	public ModelAndView toOrder(@RequestParam("target")String target,@RequestParam("userCode")String userCode) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("userCode", userCode);
		mv.setViewName(target);
		return mv;
	}
	@RequestMapping(value="/toCommentByUserName.do")
	public ModelAndView toComment(@RequestParam("userName")String userName,@RequestParam("backURL")String backURL) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("userCode", userDoService.getUserCode(userName));
		mv.addObject("backURL", backURL);
		mv.setViewName("comment/index");
		return mv;
	}
	
	@RequestMapping("/toIndex.do")
	public String toIndex(Model model,HttpServletRequest request) {
		
		request.getSession().removeAttribute("loginUser");
		
		List<ObjectType> oList = sysParObjectTypeService.getAllObjectType();
		model.addAttribute("oList",oList);
		List<ParObjectType> pList = sysParObjectTypeService.getAllParObject();
		model.addAttribute("pList",pList);
		
		//图片
		List<TradingObject> tList = sysParObjectTypeService.getAllTradingObject(0,20);
		if(tList == null) {
			tList = new ArrayList<TradingObject>();
		}
		model.addAttribute("tList",tList);
		return "show";
	}
	
	@RequestMapping(value="/object/toIndex.do")
	public String toObjectIndex() {
		return "object/index";
	}
	
}
