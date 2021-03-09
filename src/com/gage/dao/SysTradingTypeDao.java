package com.gage.dao;

import java.util.List;

import com.gage.beans.TradingType;

public interface SysTradingTypeDao {

	int getAllAccountTradingType();

	List<TradingType> getAllTradingType(int pageNot, Integer valueOf2);

	Object getTradingTypeCode(String tradingTypeCode);

	int saveTradingType(TradingType tradingType);

	TradingType getTradingTypeByCode(String tradingTypeCode);

	int changeTradingType(TradingType tradingType);

	int deleteTradingType(String[] arrays);

	int getListObjecCodetAccount(String codeValue);

	int getListParObjecCodetPageAccount(String codeValue);

}
