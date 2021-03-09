package com.gage.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gage.beans.City;
import com.gage.beans.Page;
import com.gage.beans.Province;
import com.gage.dao.SysCityDao;
import com.gage.service.SysCityService;

@Service
public class SysCityServiceImpl implements SysCityService {

	@Autowired
	private SysCityDao sysCityDao;

	/**
	 * 获取全部城市记录
	 */
	@Override
	public Page getAccountCity(Integer pageNo) {
		// TODO Auto-generated method stub
		int recordTotal = sysCityDao.getAccountCity();
		int pageSize = 10;
		int pageTotal = (int) (Math.ceil((float) recordTotal / (float) pageSize));

		Page page = new Page();
		page.setRecordTotal(recordTotal);
		page.setPageSize(pageSize);
		page.setPageTotal(pageTotal);
		page.setPageNo(pageNo);

		return page;
	}

	/**
	 * 分页获取城市记录
	 */
	@Override
	public List<City> getAllCity(Integer pageNo, Integer pageSize) {
		// TODO Auto-generated method stub
		int pageNot = (pageNo - 1) * pageSize;
		List<City> cList = sysCityDao.getAllCity(pageNot,pageSize);
		if (cList == null) {
			cList = new ArrayList<City>();
		}
		return cList;
	}

	/**
	 * 获取省份
	 */
	@Override
	public List<Province> getAllProvince() {
		// TODO Auto-generated method stub
		List<Province> pList = sysCityDao.getAllProvince();
		if(pList == null) {
			pList = new ArrayList<Province>();
		}
		return pList;
	}

	/**
	 * 自动生成city码值
	 */
	@Override
	public String getCityCode(String provinceCode) {
		// TODO Auto-generated method stub
		String cityCode = provinceCode+"C001";
		while(true) {
			if(sysCityDao.getCityCode(cityCode,provinceCode) == null) {
				return cityCode;
			}else {
				Integer s = Integer.parseInt(cityCode.substring(5, 8));
				s = s + 1;
				int len = s.toString().length();
				if (len == 1) {
					cityCode = provinceCode+"C00" + s;
				} else if (len == 2) {
					cityCode = provinceCode+"C0" + s;
				} else {
					cityCode = provinceCode+"C" + s;
				}
			}
			
		}
	}

	/**
	 * 检查cityCode是否已经使用
	 */
	@Override
	public String checkCityCode(String cityCode) {
		// TODO Auto-generated method stub
		return sysCityDao.checkCityCode(cityCode);
	}

	/**
	 * 保存
	 */
	@Override
	public String saveCity(City city) {
		// TODO Auto-generated method stub
		if(sysCityDao.saveCity(city)>0) {
			return "true";
		}
		return "false";
	}

	/**
	 * 根据cityCode获取City
	 */
	@Override
	public City getCityByCityCode(String cityCode) {
		// TODO Auto-generated method stub
		return sysCityDao.getCityByCityCode(cityCode);
	}

	/**
	 * 更新城市
	 */
	@Override
	public String changeCity(String beforeCityCode, String cityCode, String cityName, String provinceCode) {
		// TODO Auto-generated method stub
		if(sysCityDao.changeCity(beforeCityCode,cityCode,cityName,provinceCode)>0) {
			return "true";
		}
		return "false";
	}

	/**
	 * 删除城市记录
	 */
	@Override
	public String deleteCity(String[] chk_value) {
		// TODO Auto-generated method stub
		if(sysCityDao.deleteCity(chk_value)>0) {
			return "true";
		}
		return "false";
	}

	@Override
	public List<City> getAllCityForRegister() {
		// TODO Auto-generated method stub
		return sysCityDao.getAllCityForRegister();
	}

	@Override
	public List<City> getAllCityByProvinceCode(String provinceCode) {
		// TODO Auto-generated method stub
		return sysCityDao.getAllCityByProvinceCode(provinceCode);
	}

}
