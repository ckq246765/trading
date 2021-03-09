package com.gage.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gage.beans.Page;
import com.gage.beans.Province;
import com.gage.service.SysProvinceService;
import com.sun.org.apache.regexp.internal.recompile;

@Controller
public class SysProvinceController {

	@Autowired
	private SysProvinceService sysProvinceService;
	
	@RequestMapping(value="sys/all_province/index.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String,Object>  getAllProvonce(@RequestParam("pageNo")String pageNo,
			@RequestParam("pageSize")String pageSize){
		Page page = sysProvinceService.getAllAccountProvince(Integer.valueOf(pageNo));
		if(page == null) {
			page = new Page();
		}
		Map<String, Object> map = new HashMap<>();
		map.put("page", page);
		List<Province> pList = sysProvinceService.getAllProvince(Integer.valueOf(pageNo), Integer.valueOf(pageSize));
		if(pList == null) {
			pList = new ArrayList<Province>();
		}
		map.put("pList", pList);
		
		return map;
	}
	
	@RequestMapping(value="sys/province/create.do",method=RequestMethod.POST)
	@ResponseBody
	public String getProvinceCode() {
		return sysProvinceService.getProvinCode();
	}
	
	@RequestMapping(value="sys/province/checkprovinceCode.do",method=RequestMethod.POST)
	@ResponseBody
	public String getProvinceCodeByCode(@RequestParam("provinceCode") String provinceCode) {
		return sysProvinceService.getProvinCode(provinceCode);
	}
	
	@RequestMapping(value="sys/province/save.do",method=RequestMethod.POST)
	@ResponseBody
	public String saveProvince(Province province) {
		return sysProvinceService.saveProvince(province);
	}
	
	
	@RequestMapping(value="sys/province/getProvince.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Province getProvinceByCode(@RequestParam("provinceCode") String provinceCode) {
		return sysProvinceService.getProvinceByCode(provinceCode);
	}
	
	@RequestMapping(value="sys/province/change.do",method=RequestMethod.POST)
	@ResponseBody
	public String changeProvince(Province province) {
		return sysProvinceService.changeProvince(province);
	}
	
	@RequestMapping(value="sys/province/delete.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteProvince(@RequestParam("chk_value[]") String[] arrays) {
		return sysProvinceService.deleteProvince(arrays);
	}
}
