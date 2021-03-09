package com.gage.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gage.beans.Page;
import com.gage.beans.Province;
import com.gage.dao.SysProvinceDao;
import com.gage.service.SysProvinceService;

@Service
public class SysProvinceServiceImpl implements SysProvinceService {

	@Autowired
	private SysProvinceDao sysProvinceDao;

	/**
	 * 返回Province集合
	 */
	@Override
	public List<Province> getAllProvince(Integer pageNo, Integer pageSize) {
		int pageNot = (pageNo - 1) * 10;
		List<Province> pList = sysProvinceDao.getAllProvince(pageNot, pageSize);
		if (pList == null) {
			pList = new ArrayList<Province>();
		}
		return pList;
	}

	/**
	 * 返回所有省份的记录条数
	 */
	@Override
	public Page getAllAccountProvince(Integer pageNo) {
		// TODO Auto-generated method stub
		int recordTotal = sysProvinceDao.getAllAccountProvince();
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
	 * 获取省份码值
	 */
	@Override
	public String getProvinCode() {
		// TODO Auto-generated method stub
		String provinceCode = "P001";
		while (true) {
			if (sysProvinceDao.getProvinceCode(provinceCode) == null) {
				return provinceCode;
			} else {
				Integer s = Integer.parseInt(provinceCode.substring(1, 4));
				s = s + 1;
				int len = s.toString().length();
				if (len == 1) {
					provinceCode = "P00" + s;
				} else if (len == 2) {
					provinceCode = "P0" + s;
				} else {
					provinceCode = "P" + s;
				}
			}
		}
	}

	/**
	 * 获取省份码值
	 */
	@Override
	public String getProvinCode(String provinceCode) {
		return sysProvinceDao.getProvinceCode(provinceCode);
	}

	@Override
	public String saveProvince(Province province) {
		// TODO Auto-generated method stub
		if (sysProvinceDao.saveProvince(province) > 0) {
			return "true";
		}
		return "false";
	}

	/**
	 * 获取province
	 */
	@Override
	public Province getProvinceByCode(String provinceCode) {
		// TODO Auto-generated method stub
		return sysProvinceDao.getProvinceByCode(provinceCode);
	}

	/**
	 * 修改省份
	 */
	@Override
	public String changeProvince(Province province) {
		// TODO Auto-generated method stub
		if (sysProvinceDao.changeProvince(province) > 0) {
			return "true";
		}
		return "false";
	}

	/**
	 * 删除数据
	 */
	@Override
	public String deleteProvince(String[] arrays) {
		// TODO Auto-generated method stub
		if(sysProvinceDao.deleteProvince(arrays)>0) {
			return "true";
		}
		return "false";
	}


}
