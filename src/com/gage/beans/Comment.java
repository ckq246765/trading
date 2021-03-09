package com.gage.beans;

public class Comment {

	private String objectCode;
	private String evaluateText;
	private String evaluatePicture;
	private String evaluateDate;
	private String evaluateUser;
	private String userCode;
	
	private String text_descri;  //物品描述
	private String 	picture_descri;	//物品图片
	
	private String evaluateCode;  	//编号
	
	private String evaluateUserName;	//评价用户名
	
	public String getEvaluateUserName() {
		return evaluateUserName;
	}
	public void setEvaluateUserName(String evaluateUserName) {
		this.evaluateUserName = evaluateUserName;
	}
	public String getEvaluateCode() {
		return evaluateCode;
	}
	public void setEvaluateCode(String evaluateCode) {
		this.evaluateCode = evaluateCode;
	}
	public String getText_descri() {
		return text_descri;
	}
	public void setText_descri(String text_descri) {
		this.text_descri = text_descri;
	}
	public String getPicture_descri() {
		return picture_descri;
	}
	public void setPicture_descri(String picture_descri) {
		this.picture_descri = picture_descri;
	}
	public String getObjectCode() {
		return objectCode;
	}
	public void setObjectCode(String objectCode) {
		this.objectCode = objectCode;
	}
	public String getEvaluateText() {
		return evaluateText;
	}
	public void setEvaluateText(String evaluateText) {
		this.evaluateText = evaluateText;
	}
	public String getEvaluatePicture() {
		return evaluatePicture;
	}
	public void setEvaluatePicture(String evaluatePicture) {
		this.evaluatePicture = evaluatePicture;
	}
	public String getEvaluateDate() {
		return evaluateDate;
	}
	public void setEvaluateDate(String evaluateDate) {
		this.evaluateDate = evaluateDate;
	}
	public String getEvaluateUser() {
		return evaluateUser;
	}
	public void setEvaluateUser(String evaluateUser) {
		this.evaluateUser = evaluateUser;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	
}
