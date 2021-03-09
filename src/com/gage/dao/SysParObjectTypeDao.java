package com.gage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gage.beans.ObjectType;
import com.gage.beans.ParObjectType;
import com.gage.beans.TradingObject;

public interface SysParObjectTypeDao {

	int getAllAccountParObjectType();

	List<ParObjectType> getAllParObjectType(Integer pageNo, Integer pageSize);

	List<ObjectType> getAllObjectType();

	String getParObjectTypeCode(String parObjectTypeCode, String objectCode);

	String checkParObjectTypeCode(String parObjectTypeCode);

	int saveparObjectType(ParObjectType parObjectType);

	ParObjectType getParObjectTypeByParObjectTypeCode(String parObjectTypeCode);

	int changeParObjectType(String beforeObjectTypeCode, String parObjectTypeCode, String parObjectTypeName,
			String objectTypeCode);

	int deleteParObject(String[] chk_value);

	List<ParObjectType> getAllParObject();

	int getAllTradingObjectAccount();

	List<TradingObject> getAllTradingObject(@Param("no")int no,@Param("size")int size);

	TradingObject toObjectShowByObjectCode(String objectCode);

	List<TradingObject> toParObjectShowByObjectCode(String parObjectCode, String objectCode);

	String getObjectTypeByObjectCode(String objectCode);

	List<ParObjectType> getAllParObjectTypeByObjectCode(String objectCode);

	List<TradingObject> getAllTradingObjectTypeByObjectCode(@Param("objectCode")String objectCode, @Param("pageNo")int pageNo, @Param("pageSize")int pageSize);
	
	List<TradingObject> getAllTradingObjectTypeByParObjectCode(@Param("parObjectTypeCode")String parObjectTypeCode, @Param("pageNo")int pageNo, @Param("pageSize")int pageSize);

	String getObjectCodeByParObjectTypeCode(String parObjectTypeCode);

	List<TradingObject> getTradingObjectByUserCode(String userCode);

}
