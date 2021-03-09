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

import com.gage.beans.ObjectType;
import com.gage.beans.Page;
import com.gage.beans.ParObjectType;
import com.gage.service.SysParObjectTypeService;

@Controller
public class SysParObjectTypeController {

	@Autowired
	private SysParObjectTypeService sysParObjectTypeService;
	
	@RequestMapping(value="sys/objectParType/index.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")  
	@ResponseBody
	public Map<String, Object> getAllParObjectType(@RequestParam("pageNo")String pageNo,
			@RequestParam("pageSize")String pageSize){
		Page page = sysParObjectTypeService.getAllAccountParObjectType(Integer.valueOf(pageNo),Integer.valueOf(pageSize));
		if(page == null) {
			page = new Page();
		}
		Map<String, Object> map = new HashMap<>();
		map.put("page", page);
		List<ParObjectType> pList = sysParObjectTypeService.getAllParObjectType(Integer.valueOf(pageNo), Integer.valueOf(pageSize));
		if(pList == null) {
			pList = new ArrayList<ParObjectType>();
		}
		map.put("pList", pList);
		
		return map;
	}
	
	@RequestMapping(value="sys/parObjectType/getParObjectType.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<ObjectType> getAllObjectType(){
		return sysParObjectTypeService.getAllObjectType();
	}
	
	@RequestMapping(value="sys/parObjectType/createparObjectTypeCode.do",method=RequestMethod.POST)
	@ResponseBody
	public String getParObjectTypeCode(@RequestParam("objectCode")String objectCode) {
		return sysParObjectTypeService.getParObjectTypeCode(objectCode);
	}	
	
	@RequestMapping(value="sys/parObjectType/checkparObjectTypeCode.do",method=RequestMethod.POST)
	@ResponseBody
	public String checkParObjectTypeCode(@RequestParam("parObjectTypeCode")String parObjectTypeCode ) {
		return sysParObjectTypeService.checkParObjectTypeCode(parObjectTypeCode);
	}
	
	@RequestMapping(value="sys/parObjectType/save.do",method=RequestMethod.POST)
	@ResponseBody
	public String saveparObjectType(ParObjectType parObjectType) {
		return sysParObjectTypeService.saveparObjectType(parObjectType);
	}
	
	@RequestMapping(value="sys/parObjectType/getParObject.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public ParObjectType getParObjectTypeByParObjectTypeCode(@RequestParam("parObjectTypeCode") String parObjectTypeCode) {
		return sysParObjectTypeService.getParObjectTypeByParObjectTypeCode(parObjectTypeCode);
	}
	
	@RequestMapping(value="sys/parObject/change.do",method=RequestMethod.POST)
	@ResponseBody
	public String changeParObjectType(@RequestParam("beforeObjectTypeCode")String beforeObjectTypeCode,
			@RequestParam("parObjectTypeCode")String parObjectTypeCode,
			@RequestParam("parObjectTypeName")String parObjectTypeName,
			@RequestParam("objectTypeCode")String objectTypeCode) {
		return sysParObjectTypeService.changeParObjectType(beforeObjectTypeCode,parObjectTypeCode,parObjectTypeName,objectTypeCode);
	}
	
	@RequestMapping(value="sys/parObject/delete.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteParObject(@RequestParam("chk_value[]") String[] chk_value) {
		return sysParObjectTypeService.deleteParObject(chk_value);
	}
}
