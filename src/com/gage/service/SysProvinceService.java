package com.gage.service;

import java.util.List;

import com.gage.beans.Page;
import com.gage.beans.Province;

public interface SysProvinceService {

	public Page getAllAccountProvince(Integer pageNo);
	
	public List<Province> getAllProvince(Integer pageNo, Integer pageSize);
	
	public String getProvinCode();
	
	public String getProvinCode(String provinceCode);
	
	public String saveProvince(Province province);
	
	public Province getProvinceByCode(String provinceCode);
	
	public String changeProvince(Province province);
	
	public String deleteProvince(String[] arrays);
	
}
