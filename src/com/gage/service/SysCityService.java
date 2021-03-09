package com.gage.service;

import java.util.List;

import com.gage.beans.City;
import com.gage.beans.Page;
import com.gage.beans.Province;

public interface SysCityService {
	
	public Page getAccountCity(Integer pageNo);

	public List<City> getAllCity(Integer pageNo, Integer pageSize);
	
	public List<Province> getAllProvince();
	
	public String getCityCode(String provinceCode);
	
	public String checkCityCode(String cityCode);
	
	public String saveCity(City city);
	
	public City getCityByCityCode(String cityCode);
	
	public String changeCity(String beforeCityCode,String cityCode,String cityName,String provinceCode);
	
	public String deleteCity(String[] chk_value);

	public List<City> getAllCityForRegister();

	public List<City> getAllCityByProvinceCode(String provinceCode);

}
