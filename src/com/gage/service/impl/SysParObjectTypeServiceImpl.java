package com.gage.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gage.beans.ObjectType;
import com.gage.beans.Page;
import com.gage.beans.ParObjectType;
import com.gage.beans.Province;
import com.gage.beans.TradingObject;
import com.gage.dao.SysParObjectTypeDao;
import com.gage.service.SysParObjectTypeService;

@Service
public class SysParObjectTypeServiceImpl implements SysParObjectTypeService {

	@Autowired
	private SysParObjectTypeDao sysParObjectTypeDao;
	
	@Override
	public Page getAllAccountParObjectType(Integer pageNo,Integer pageSize) {
		// TODO Auto-generated method stub
		int recordTotal = sysParObjectTypeDao.getAllAccountParObjectType();
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) pageSize));
		
		Page page = new Page();
		page.setRecordTotal(recordTotal);
		page.setPageSize(pageSize);
		page.setPageTotal(pageTotal);
		page.setPageNo(pageNo);

		return page;
	}

	@Override
	public List<ParObjectType> getAllParObjectType(Integer pageNo, Integer pageSize) {
		// TODO Auto-generated method stub
		int pageNot = (pageNo -1)*pageSize;
		List<ParObjectType> pList = sysParObjectTypeDao.getAllParObjectType(pageNot,pageSize);
		if (pList == null) {
			pList = new ArrayList<ParObjectType>();
		}
		return pList;
	}

	@Override
	public List<ObjectType> getAllObjectType() {
		// TODO Auto-generated method stub
		List<ObjectType> oList = sysParObjectTypeDao.getAllObjectType();
		if(oList == null) {
			oList = new ArrayList<ObjectType>();
		}
		return oList;
	}

	@Override
	public String getParObjectTypeCode(String objectCode) {
		// TODO Auto-generated method stub
		String parObjectTypeCode = objectCode+"PT01";
		while(true) {
			if(sysParObjectTypeDao.getParObjectTypeCode(parObjectTypeCode,objectCode) == null) {
				return parObjectTypeCode;
			}else {
				Integer s = Integer.parseInt(parObjectTypeCode.substring(6, 8));
				s = s + 1;
				int len = s.toString().length();
				if (len == 1) {
					parObjectTypeCode = objectCode+"PT0" + s;
				} else {
					parObjectTypeCode = objectCode+"PT" + s;
				}
			}
			
		}
	}

	@Override
	public String checkParObjectTypeCode(String parObjectTypeCode) {
		// TODO Auto-generated method stub
		return sysParObjectTypeDao.checkParObjectTypeCode(parObjectTypeCode);
	}

	@Override
	public String saveparObjectType(ParObjectType parObjectType) {
		// TODO Auto-generated method stub
		if(sysParObjectTypeDao.saveparObjectType(parObjectType)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public ParObjectType getParObjectTypeByParObjectTypeCode(String parObjectTypeCode) {
		// TODO Auto-generated method stub
		return sysParObjectTypeDao.getParObjectTypeByParObjectTypeCode(parObjectTypeCode);
	}

	@Override
	public String changeParObjectType(String beforeObjectTypeCode, String parObjectTypeCode, String parObjectTypeName,
			String objectTypeCode) {
		// TODO Auto-generated method stub
		if(sysParObjectTypeDao.changeParObjectType(beforeObjectTypeCode,parObjectTypeCode,parObjectTypeName,objectTypeCode)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public String deleteParObject(String[] chk_value) {
		// TODO Auto-generated method stub
		if(sysParObjectTypeDao.deleteParObject(chk_value)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public List<ParObjectType> getAllParObject() {
		// TODO Auto-generated method stub
		return sysParObjectTypeDao.getAllParObject();
	}

	@Override
	public List<TradingObject> getAllTradingObject(int no,int size) {
		// TODO Auto-generated method stub
		int count = sysParObjectTypeDao.getAllTradingObjectAccount();
		if(count>20) {
			return sysParObjectTypeDao.getAllTradingObject(no,size);
		}else if(count>0) {
			return sysParObjectTypeDao.getAllTradingObject(no,size);
		}else {
			return new ArrayList<TradingObject>();
		}
	}

	@Override
	public TradingObject toObjectShowByObjectCode(String objectCode) {
		// TODO Auto-generated method stub
		return sysParObjectTypeDao.toObjectShowByObjectCode(objectCode);
	}

	@Override
	public List<TradingObject> toParObjectShowByObjectCode(String objectCode) {
		// TODO Auto-generated method stub
		String parObjectCode = sysParObjectTypeDao.getObjectTypeByObjectCode(objectCode);
		if(parObjectCode == null) {
			return null;
		}else {
			return sysParObjectTypeDao.toParObjectShowByObjectCode(parObjectCode,objectCode);
		}
	}

	@Override
	public List<ParObjectType> getAllParObjectTypeByObjectCode(String objectCode) {
		// TODO Auto-generated method stub
		return sysParObjectTypeDao.getAllParObjectTypeByObjectCode(objectCode);
	}

	@Override
	public List<TradingObject> getAllTradingObjectTypeByObjectCode(String objectCode, int pageNo, int pageSize) {
		// TODO Auto-generated method stub
		int no = (pageNo -1)*pageSize;
		return sysParObjectTypeDao.getAllTradingObjectTypeByObjectCode(objectCode,no,pageSize);
	}

	@Override
	public List<TradingObject> getAllTradingObjectTypeByParObjectCode(String parObjectTypeCode, int pageNo, int pageSize) {
		// TODO Auto-generated method stub
		int no = (pageNo -1)*pageSize;
		return sysParObjectTypeDao.getAllTradingObjectTypeByParObjectCode(parObjectTypeCode,no,pageSize);
	}
	
	@Override
	public String getObjectCodeByParObjectTypeCode(String parObjectTypeCode) {
		// TODO Auto-generated method stub
		return sysParObjectTypeDao.getObjectCodeByParObjectTypeCode(parObjectTypeCode);
	}

	@Override
	public List<TradingObject> getTradingObjectByUserCode(String userCode) {
		// TODO Auto-generated method stub
		return sysParObjectTypeDao.getTradingObjectByUserCode(userCode);
	}

}
