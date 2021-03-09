package com.gage.dao;

import java.util.List;

import com.gage.beans.City;
import com.gage.beans.Province;

public interface SysCityDao {

	public int getAccountCity();

	public List<City> getAllCity(int pageNot, Integer pageSize);
	
	public List<Province> getAllProvince();

	public String getCityCode(String cityCode, String provinceCode);

	public String checkCityCode(String cityCode);
	
	public int saveCity(City city);
	
	public City getCityByCityCode(String cityCode);
	
	public int changeCity(String beforeCityCode, String cityCode, String cityName, String provinceCode);
	
	public int deleteCity(String[] chk_value);

	public List<City> getAllCityForRegister();

	public List<City> getAllCityByProvinceCode(String provinceCode);

}
