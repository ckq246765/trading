package com.gage.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gage.beans.Page;
import com.gage.beans.Province;
import com.gage.beans.TradingType;
import com.gage.dao.SysTradingTypeDao;
import com.gage.service.SysTradingTypeService;

@Service
public class SysTradingTypeServiceImpl implements SysTradingTypeService {

	@Autowired
	private SysTradingTypeDao sysTradingTypeDao;
	
	@Override
	public Page getAllAccountTradingType(Integer valueOf) {
		// TODO Auto-generated method stub
		int recordTotal = sysTradingTypeDao.getAllAccountTradingType();
		int pageSize = 10;
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) pageSize));

		Page page = new Page();
		page.setRecordTotal(recordTotal);
		page.setPageSize(pageSize);
		page.setPageTotal(pageTotal);
		page.setPageNo(valueOf);

		return page;
	}

	@Override
	public List<TradingType> getAllTradingType(Integer valueOf, Integer valueOf2) {
		// TODO Auto-generated method stub
		int pageNot = (valueOf - 1) * 10;
		List<TradingType> tList = sysTradingTypeDao.getAllTradingType(pageNot, valueOf2);
		if (tList == null) {
			tList = new ArrayList<TradingType>();
		}
		return tList;
	}

	@Override
	public String getTradingTypeCode() {
		// TODO Auto-generated method stub
		String tradingTypeCode = "TY01";
		while (true) {
			if (sysTradingTypeDao.getTradingTypeCode(tradingTypeCode) == null) {
				return tradingTypeCode;
			} else {
				Integer s = Integer.parseInt(tradingTypeCode.substring(2, 4));
				s = s + 1;
				int len = s.toString().length();
				if (len == 1) {
					tradingTypeCode = "TY0" + s;
				} else {
					tradingTypeCode = "TY" + s;
				}
			}
		}
	}

	@Override
	public String getTradingTypeCodeByCode(String tradingTypeCode) {
		// TODO Auto-generated method stub
		return (String) sysTradingTypeDao.getTradingTypeCode(tradingTypeCode);
	}

	@Override
	public String saveTradingType(TradingType tradingType) {
		// TODO Auto-generated method stub
		if (sysTradingTypeDao.saveTradingType(tradingType) > 0) {
			return "true";
		}
		return "false";
	}

	@Override
	public TradingType getTradingTypeByCode(String tradingTypeCode) {
		// TODO Auto-generated method stub
		return sysTradingTypeDao.getTradingTypeByCode(tradingTypeCode);
	}

	@Override
	public String changeTradingType(TradingType tradingType) {
		// TODO Auto-generated method stub
		if (sysTradingTypeDao.changeTradingType(tradingType) > 0) {
			return "true";
		}
		return "false";
	}

	@Override
	public String deleteTradingType(String[] arrays) {
		// TODO Auto-generated method stub
		if(sysTradingTypeDao.deleteTradingType(arrays)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public Page getListObjecCodetPage(String codeValue, int no, int size) {
		// TODO Auto-generated method stub
		Page page = new Page();
		
		int recordTotal = sysTradingTypeDao.getListObjecCodetAccount(codeValue);
		int pageSize = size;
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) pageSize));
		
		page.setRecordTotal(recordTotal);
		page.setPageSize(pageSize);
		page.setPageTotal(pageTotal);
		page.setPageNo(no);
		return page;
	}

	@Override
	public Page getListParObjecCodetPage(String codeValue, int no, int size) {
		// TODO Auto-generated method stub
Page page = new Page();
		
		int recordTotal = sysTradingTypeDao.getListParObjecCodetPageAccount(codeValue);
		int pageSize = size;
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) pageSize));
		
		page.setRecordTotal(recordTotal);
		page.setPageSize(pageSize);
		page.setPageTotal(pageTotal);
		page.setPageNo(no);
		return page;
	}

}
