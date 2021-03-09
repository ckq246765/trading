package com.gage.service;

import java.util.List;

import com.gage.beans.Page;
import com.gage.beans.Province;
import com.gage.beans.TradingType;

public interface SysTradingTypeService {

	Page getAllAccountTradingType(Integer valueOf);

	List<TradingType> getAllTradingType(Integer valueOf, Integer valueOf2);

	String getTradingTypeCode();

	String getTradingTypeCodeByCode(String tradingTypeCode);

	String saveTradingType(TradingType tradingType);

	TradingType getTradingTypeByCode(String tradingTypeCode);

	String changeTradingType(TradingType tradingType);

	String deleteTradingType(String[] arrays);

	Page getListObjecCodetPage(String codeValue, int no, int size);

	Page getListParObjecCodetPage(String codeValue, int no, int size);

}
