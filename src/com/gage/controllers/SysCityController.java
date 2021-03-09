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

import com.gage.beans.City;
import com.gage.beans.Page;
import com.gage.beans.Province;
import com.gage.service.SysCityService;
import com.gage.service.SysProvinceService;

@Controller
public class SysCityController{

	@Autowired
	private SysCityService sysCityService;
	
	@RequestMapping(value="sys/all_city/index.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getAllCity(@RequestParam("pageNo")String pageNo,
			@RequestParam("pageSize")String pageSize){
		
		Page page = sysCityService.getAccountCity(Integer.valueOf(pageNo));
		if(page == null) {
			page = new Page();
		}
		Map<String, Object> map = new HashMap<>();
		map.put("page", page);
		List<City> cList = sysCityService.getAllCity(Integer.valueOf(pageNo),Integer.valueOf(pageSize));
		if(cList == null) {
			cList = new ArrayList<>();
		}
		map.put("cList", cList);
		
		return map;
	}
	
	@RequestMapping(value="sys/city/getProvince.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<Province> getAllProvince(){
		return sysCityService.getAllProvince();
	}
	
	@RequestMapping(value="sys/city/createCityCode.do",method=RequestMethod.POST)
	@ResponseBody
	public String getCityCode(@RequestParam("provinceCode")String provinceCode) {
		return sysCityService.getCityCode(provinceCode);
	}
	
	@RequestMapping(value="sys/city/checkCityCode.do",method=RequestMethod.POST)
	@ResponseBody
	public String checkCityCode(@RequestParam("cityCode")String cityCode) {
		return sysCityService.checkCityCode(cityCode);
	}
	
	@RequestMapping(value="sys/city/save.do",method=RequestMethod.POST)
	@ResponseBody
	public String saveCity(City city) {
		return sysCityService.saveCity(city);
	}
	@RequestMapping(value="sys/city/getCity.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public City getCityByCityCode(@RequestParam("cityCode") String cityCode) {
		return sysCityService.getCityByCityCode(cityCode);
	}
	@RequestMapping(value="sys/city/change.do",method=RequestMethod.POST)
	@ResponseBody
	public String changeCity(@RequestParam("beforeCityCode")String beforeCityCode,
			@RequestParam("cityCode")String cityCode,
			@RequestParam("cityName")String cityName,
			@RequestParam("provinceCode")String provinceCode) {
		return sysCityService.changeCity(beforeCityCode,cityCode,cityName,provinceCode);
	}
	@RequestMapping(value="sys/city/delete.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteCity(@RequestParam("chk_value[]") String[] chk_value) {
		return sysCityService.deleteCity(chk_value);
	}
}
