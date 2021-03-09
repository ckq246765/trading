package com.gage.beans;

public class sysOrder {
	
	private String orderCode;//<th//>订单名称</th><!-- 订单编号 -->
	private String orderName;
	private String objectDesc;//<th>物品描述</th><!-- 物品编号 -->
	private String objectCode;
	private String orderAccount;//<th>订单金额</th>
	private String orderDate;//<th>订单时间</th>
	private String saleUserCode;//<th>卖家</th><!-- 用户编号 -->
	private String saleUserName;
	private String payUserCode;//<th>买家</th><!-- 用户编号 -->
	private String payUserName;
	private String tradeStatus;//<th>支付状态</th>
	private String fkStatus;//<th>发货状态</th>
	private String ysStatus;//<th>验收状态</th>
	private String pjStatus;//<th>评价状态</th>
	
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
	public String getObjectDesc() {
		return objectDesc;
	}
	public void setObjectDesc(String objectDesc) {
		this.objectDesc = objectDesc;
	}
	public String getObjectCode() {
		return objectCode;
	}
	public void setObjectCode(String objectCode) {
		this.objectCode = objectCode;
	}
	public String getOrderAccount() {
		return orderAccount;
	}
	public void setOrderAccount(String orderAccount) {
		this.orderAccount = orderAccount;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getSaleUserCode() {
		return saleUserCode;
	}
	public void setSaleUserCode(String saleUserCode) {
		this.saleUserCode = saleUserCode;
	}
	public String getSaleUserName() {
		return saleUserName;
	}
	public void setSaleUserName(String saleUserName) {
		this.saleUserName = saleUserName;
	}
	public String getPayUserCode() {
		return payUserCode;
	}
	public void setPayUserCode(String payUserCode) {
		this.payUserCode = payUserCode;
	}
	public String getPayUserName() {
		return payUserName;
	}
	public void setPayUserName(String payUserName) {
		this.payUserName = payUserName;
	}
	public String getTradeStatus() {
		return tradeStatus;
	}
	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
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
	
}
