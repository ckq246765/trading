package com.gage.beans;

public class Shopping {

	private String objectCode;   //物品编号
	private String payFlag;		//付款标志
	private String fhFlag;		//发货标志
	private String ysFlag;		//验收标志
	private String pjFlag;		//评价标志
	private String addDate;     //添加时间
	private String userCode;	//用户
	
	public String getAddDate() {
		return addDate;
	}
	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}
	public String getObjectCode() {
		return objectCode;
	}
	public void setObjectCode(String objectCode) {
		this.objectCode = objectCode;
	}
	public String getPayFlag() {
		return payFlag;
	}
	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}
	public String getFhFlag() {
		return fhFlag;
	}
	public void setFhFlag(String fhFlag) {
		this.fhFlag = fhFlag;
	}
	public String getYsFlag() {
		return ysFlag;
	}
	public void setYsFlag(String ysFlag) {
		this.ysFlag = ysFlag;
	}
	public String getPjFlag() {
		return pjFlag;
	}
	public void setPjFlag(String pjFlag) {
		this.pjFlag = pjFlag;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	
}
