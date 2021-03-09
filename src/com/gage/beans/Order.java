package com.gage.beans;

public class Order {

	private String orderCode; 		//订单编号	
	private String orderName;		//订单名称
	private Float orderAccount;		//订单金额1	
	private String objectDescribe;	//订单描述1
	private String userCode;		//用户编号1 买家
	private String orderDate;		//订单时间
	private String objectCode;  	//物品编号1
	//物品名称
	
	private String tradeNo;		//支付交易号
	private String tradeStatus;	//支付状态 
	
	private String fkStatus;	//发货状态
	private String ysStatus;	//验收状态
	private String pjStatus;	//评价状态
	
	private String pictureDescri;		//物品图片
	
	private String object_user_fh;		//卖家确认发货222
	
	
	private String text_descri;
	private String userName;		//另加的为了方便【订单的卖家获取买家】
	private String phone;			
	private String email;
	private String address;
	
	
	public String getText_descri() {
		return text_descri;
	}
	public void setText_descri(String text_descri) {
		this.text_descri = text_descri;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getObject_user_fh() {
		return object_user_fh;
	}
	public void setObject_user_fh(String object_user_fh) {
		this.object_user_fh = object_user_fh;
	}
	public String getFkStatus() {
		return fkStatus;
	}
	public void setFkStatus(String fkStatus) {
		this.fkStatus = fkStatus;
	}
	public String getYsStatus() {
		return ysStatus;
	}
	public void setYsStatus(String ysStatus) {
		this.ysStatus = ysStatus;
	}
	public String getPjStatus() {
		return pjStatus;
	}
	public void setPjStatus(String pjStatus) {
		this.pjStatus = pjStatus;
	}
	public String getPictureDescri() {
		return pictureDescri;
	}
	public void setPictureDescri(String pictureDescri) {
		this.pictureDescri = pictureDescri;
	}
	public String getTradeNo() {
		return tradeNo;
	}
	public void setTradeNo(String tradeNo) {
		this.tradeNo = tradeNo;
	}
	public String getTradeStatus() {
		return tradeStatus;
	}
	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
	}
	public String getObjectCode() {
		return objectCode;
	}
	public void setObjectCode(String objectCode) {
		this.objectCode = objectCode;
	}
	public String getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}
	public String getOrderName() {
		return orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public Float getOrderAccount() {
		return orderAccount;
	}
	public void setOrderAccount(Float orderAccount) {
		this.orderAccount = orderAccount;
	}
	public String getObjectDescribe() {
		return objectDescribe;
	}
	public void setObjectDescribe(String objectDescribe) {
		this.objectDescribe = objectDescribe;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	
}
