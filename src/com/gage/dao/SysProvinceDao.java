package com.gage.dao;

import java.util.List;

import com.gage.beans.Province;

public interface SysProvinceDao {
	/**
	 * 获取所有的省份信息
	 * @return
	 */
	public List<Province> getAllProvince(Integer pageNo, Integer pageSize);
	
	/**
	 * 获取所有省份的记录条数
	 * @return
	 */
	public int getAllAccountProvince();
	
	/**
	 * 获取省份的码值
	 * @return
	 */
	public String getProvinceCode(String provinceCode);
	/**
	 * 保存省份
	 * @param province
	 * @return
	 */
	public int saveProvince(Province province);
	/**
	 * 获取province
	 * @param provinceCode
	 * @return
	 */
	public Province getProvinceByCode(String provinceCode);
	/**
	 * 修改省份
	 * @param province
	 * @return
	 */
	public int changeProvince(Province province);
	
	/**
	 * 删除省份
	 * @param arrays
	 * @return
	 */
	public int deleteProvince(String[] arrays);
	
}
