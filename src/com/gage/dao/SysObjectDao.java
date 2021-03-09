package com.gage.dao;

import java.util.List;

import com.gage.beans.ObjectType;

public interface SysObjectDao {

	public int getAllAccountObject();

	public List<ObjectType> getAllObject(int pageNot, Integer valueOf2);

	public String getObjectCode(String objectCode);

	public int saveObject(ObjectType objectType);

	public ObjectType getobjectByCode(String objectCode);

	public int changeObject(ObjectType objectType);

	public int deleteObject(String[] arrays);

	
}
