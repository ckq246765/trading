package com.gage.beans;

public class Page {

	private Integer recordTotal;  //所有记录条数
	private Integer pageSize;   //每页显示条数
	private Integer pageTotal;  //总页码
	private Integer pageNo;  //页码
	
	public Integer getRecordTotal() {
		return recordTotal;
	}
	public void setRecordTotal(Integer recordTotal) {
		this.recordTotal = recordTotal;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getPageTotal() {
		return pageTotal;
	}
	public void setPageTotal(Integer pageTotal) {
		this.pageTotal = pageTotal;
	}
	public Integer getPageNo() {
		return pageNo;
	}
	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
	
}
