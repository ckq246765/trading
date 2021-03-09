package com.gage.service;

import java.util.List;

import com.gage.beans.ObjectType;
import com.gage.beans.Page;

public interface SysObjectService {

	Page getAllAccountObject(Integer valueOf);

	List<ObjectType> getAllObject(Integer valueOf, Integer valueOf2);

	String getObjectCode();

	String getObjectCode(String objectCode);

	String saveObject(ObjectType objectType);

	ObjectType getobjectByCode(String objectCode);

	String changeObject(ObjectType objectType);

	String deleteObject(String[] arrays);

}
