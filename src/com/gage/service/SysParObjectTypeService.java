package com.gage.service;

import java.util.List;

import com.gage.beans.ObjectType;
import com.gage.beans.Page;
import com.gage.beans.ParObjectType;
import com.gage.beans.TradingObject;

public interface SysParObjectTypeService {

	Page getAllAccountParObjectType(Integer valueOf, Integer integer);

	List<ParObjectType> getAllParObjectType(Integer valueOf, Integer valueOf2);

	List<ObjectType> getAllObjectType();

	String getParObjectTypeCode(String objectCode);

	String checkParObjectTypeCode(String parObjectTypeCode);

	String saveparObjectType(ParObjectType parObjectType);

	ParObjectType getParObjectTypeByParObjectTypeCode(String parObjectTypeCode);

	String changeParObjectType(String beforeObjectTypeCode, String parObjectTypeCode, String parObjectTypeName,
			String objectTypeCode);

	String deleteParObject(String[] chk_value);

	List<ParObjectType> getAllParObject();

	List<TradingObject> getAllTradingObject(int no,int size);

	TradingObject toObjectShowByObjectCode(String objectCode);

	List<TradingObject> toParObjectShowByObjectCode(String objectCode);

	List<ParObjectType> getAllParObjectTypeByObjectCode(String objectCode);

	List<TradingObject> getAllTradingObjectTypeByObjectCode(String objectCode, int pageNo, int pageSize);
	
	List<TradingObject> getAllTradingObjectTypeByParObjectCode(String parObjectCode, int pageNo, int pageSize);

	String getObjectCodeByParObjectTypeCode(String parObjectTypeCode);

	List<TradingObject> getTradingObjectByUserCode(String userCode);

}
