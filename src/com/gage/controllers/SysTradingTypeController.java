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

import com.gage.beans.Page;
import com.gage.beans.TradingObject;
import com.gage.beans.TradingType;
import com.gage.service.SysParObjectTypeService;
import com.gage.service.SysTradingTypeService;

@Controller
public class SysTradingTypeController {

		@Autowired
		private SysTradingTypeService sysTradingTypeService;
		@Autowired
		private SysParObjectTypeService sysParObjectTypeService;
		
		@RequestMapping(value="sys/trading_type/index.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
		@ResponseBody
		public Map<String,Object>  getAllTradingType(@RequestParam("pageNo")String pageNo,
				@RequestParam("pageSize")String pageSize){
			Page page = sysTradingTypeService.getAllAccountTradingType(Integer.valueOf(pageNo));
			if(page == null) {
				page = new Page();
			}
			Map<String, Object> map = new HashMap<>();
			map.put("page", page);
			List<TradingType> tList = sysTradingTypeService.getAllTradingType(Integer.valueOf(pageNo), Integer.valueOf(pageSize));
			if(tList == null) {
				tList = new ArrayList<TradingType>();
			}
			map.put("tList", tList);
			
			return map;
		}
		
		@RequestMapping(value="sys/tradingtype/create.do",method=RequestMethod.POST)
		@ResponseBody
		public String getTradingTypeCode() {
			
			return sysTradingTypeService.getTradingTypeCode();
		}
		
		@RequestMapping(value="sys/tradingtype/checkTradingTypeCode.do",method=RequestMethod.POST)
		@ResponseBody
		public String getTradingTypeCodeByCode(@RequestParam("tradingTypeCode") String tradingTypeCode) {
			return sysTradingTypeService.getTradingTypeCodeByCode(tradingTypeCode);
		}
		
		@RequestMapping(value="sys/tradingtype/save.do",method=RequestMethod.POST)
		@ResponseBody
		public String saveTradingType(TradingType tradingType) {
			return sysTradingTypeService.saveTradingType(tradingType);
		}
		
		@RequestMapping(value="sys/tradingtype/getTradingType.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
		@ResponseBody
		public TradingType getTradingTypeByCode(@RequestParam("tradingTypeCode") String tradingTypeCode) {
			return sysTradingTypeService.getTradingTypeByCode(tradingTypeCode);
		}
		
		@RequestMapping(value="sys/tradingType/change.do",method=RequestMethod.POST)
		@ResponseBody
		public String changeTradingType(TradingType tradingType) {
			return sysTradingTypeService.changeTradingType(tradingType);
		}
		
		@RequestMapping(value="sys/tradingType/delete.do",method=RequestMethod.POST)
		@ResponseBody
		public String deleteTradingType(@RequestParam("chk_value[]") String[] arrays) {
			return sysTradingTypeService.deleteTradingType(arrays);
		}
		
		@RequestMapping(value="object/toObjectListtwo.do",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
		@ResponseBody
		public Map<String, Object> getObjectListForPage(@RequestParam("codeValue")String codeValue,
				@RequestParam("pageNo")String pageNo,@RequestParam("pageSize")String pageSize){
			Map<String, Object> map = new HashMap<>();
			int no,size;
			if(pageNo != null&&!"".equals(pageNo)) {
				no = Integer.parseInt(pageNo); 
			}else {
				no = 1;
			}
			if(pageSize != null&&!"".equals(pageSize)) {
				size = Integer.parseInt(pageSize);
			}else {
				size = 40;
			}
			if(codeValue != null&&!"".equals(codeValue)&&codeValue.length() == 4) {
				Page page = sysTradingTypeService.getListObjecCodetPage(codeValue,no,size);
				if(page == null) {
					page = new Page();
					System.out.println(page);
				}
				map.put("page", page);
				
				List<TradingObject> tList = sysParObjectTypeService.getAllTradingObjectTypeByObjectCode(codeValue,no,size);
				if(tList == null) {
					tList = new ArrayList<TradingObject>();
				}
				map.put("tList", tList);
			}else if(codeValue!= null&&!"".equals(codeValue)&&codeValue.length() == 8) {
				Page page = sysTradingTypeService.getListParObjecCodetPage(codeValue,no,size);
				if(page == null) {
					page = new Page();
				}
				map.put("page", page);
				
				List<TradingObject> tList = sysParObjectTypeService.getAllTradingObjectTypeByParObjectCode(codeValue,no,size);
				if(tList == null) {
					tList = new ArrayList<TradingObject>();
				}
				map.put("tList", tList);
			}
			return map;
		}
		
}
