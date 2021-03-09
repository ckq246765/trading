package com.gage.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gage.beans.ObjectType;
import com.gage.beans.Page;
import com.gage.dao.SysObjectDao;
import com.gage.service.SysObjectService;

@Service
public class SysObjectServiceImpl implements SysObjectService {

	@Autowired
	private SysObjectDao sysObjectDao;
	
	@Override
	public Page getAllAccountObject(Integer valueOf) {
		// TODO Auto-generated method stub
		int recordTotal = sysObjectDao.getAllAccountObject();
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
	public List<ObjectType> getAllObject(Integer valueOf, Integer valueOf2) {
		// TODO Auto-generated method stub
		int pageNot = (valueOf - 1) * 10;
		List<ObjectType> oList = sysObjectDao.getAllObject(pageNot, valueOf2);
		if (oList == null) {
			oList = new ArrayList<ObjectType>();
		}
		return oList;
	}

	@Override
	public String getObjectCode() {
		// TODO Auto-generated method stub
		String objectCode = "OT01";
		while (true) {
			if (sysObjectDao.getObjectCode(objectCode) == null) {
				return objectCode;
			} else {
				Integer s = Integer.parseInt(objectCode.substring(2, 4));
				s = s + 1;
				int len = s.toString().length();
				if (len == 1) {
					objectCode = "OT0" + s;
				} else {
					objectCode = "OT" + s;
				}
			}
		}
	}

	@Override
	public String getObjectCode(String objectCode) {
		// TODO Auto-generated method stub
		return sysObjectDao.getObjectCode(objectCode);
	}

	@Override
	public String saveObject(ObjectType objectType) {
		// TODO Auto-generated method stub
		if (sysObjectDao.saveObject(objectType) > 0) {
			return "true";
		}
		return "false";
	}

	@Override
	public ObjectType getobjectByCode(String objectCode) {
		// TODO Auto-generated method stub
		return sysObjectDao.getobjectByCode(objectCode);
	}

	@Override
	public String changeObject(ObjectType objectType) {
		// TODO Auto-generated method stub
		if(sysObjectDao.changeObject(objectType)>0){
			return "true";
		}
		return "false";
	}

	@Override
	public String deleteObject(String[] arrays) {
		// TODO Auto-generated method stub
		if(sysObjectDao.deleteObject(arrays)>0) {
			return "true";
		}
		return "false";
	}
}

