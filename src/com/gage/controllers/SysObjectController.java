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
import com.gage.beans.Province;
import com.gage.service.SysObjectService;

@Controller
public class SysObjectController {
	
	@Autowired
	private SysObjectService sysObjectService;
	
	@RequestMapping(value="sys/object_type/index.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String,Object>  getAllObject(@RequestParam("pageNo")String pageNo,
			@RequestParam("pageSize")String pageSize){
		Page page = sysObjectService.getAllAccountObject(Integer.valueOf(pageNo));
		if(page == null) {
			page = new Page();
		}
		Map<String, Object> map = new HashMap<>();
		map.put("page", page);
		List<ObjectType> oList = sysObjectService.getAllObject(Integer.valueOf(pageNo), Integer.valueOf(pageSize));
		if(oList == null) {
			oList = new ArrayList<ObjectType>();
		}
		map.put("oList", oList);
		
		return map;
	}
	
	@RequestMapping(value="sys/object/create.do",method=RequestMethod.POST)
	@ResponseBody
	public String getObjectCode() {
		return sysObjectService.getObjectCode();
	}
	
	@RequestMapping(value="sys/object/checkObjectCode.do",method=RequestMethod.POST)
	@ResponseBody
	public String getObjectCodeByCode(@RequestParam("objectCode") String objectCode) {
		return sysObjectService.getObjectCode(objectCode);
	}
	
	@RequestMapping(value="sys/object/save.do",method=RequestMethod.POST)
	@ResponseBody
	public String saveObject(ObjectType objectType) {
		return sysObjectService.saveObject(objectType);
	}
	
	@RequestMapping(value="sys/object/getobject.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public ObjectType getobjectByCode(@RequestParam("objectCode") String objectCode) {
		return sysObjectService.getobjectByCode(objectCode);
	}
	
	@RequestMapping(value="sys/object/change.do",method=RequestMethod.POST)
	@ResponseBody
	public String changeObject(ObjectType objectType) {
		return sysObjectService.changeObject(objectType);
	}
	
	@RequestMapping(value="sys/object/delete.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteObject(@RequestParam("chk_value[]") String[] arrays) {
		return sysObjectService.deleteObject(arrays);
	}
}
