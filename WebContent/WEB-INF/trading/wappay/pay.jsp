<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%> 
<%@page import="com.keqi.alipay.AlipayConfig" %>
<%@page import="com.alipay.api.AlipayClient"%>
<%@page import="com.alipay.api.DefaultAlipayClient"%>
<%@page import="com.alipay.api.AlipayApiException"%>
<%@page import="com.alipay.api.response.AlipayTradeWapPayResponse"%>
<%@page import="com.alipay.api.request.AlipayTradeWapPayRequest"%>
<%@page import="com.alipay.api.domain.AlipayTradeWapPayModel" %>
<%@page import="com.alipay.api.domain.AlipayTradeCreateModel"%>
<%

/* *
 * 功能：支付宝手机网站支付接口(alipay.trade.wap.pay)接口调试入口页面
 * 版本：2.0
 * 修改日期：2016-11-01
 * 说明：
 * 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 请确保项目文件有可写权限，不然打印不了日志。
 */
%>
<%
if(request.getParameter("WIDout_trade_no")!=null){
	// 商户订单号，商户网站订单系统中唯一订单号，必填
    String out_trade_no = new String(request.getParameter("WIDout_trade_no").getBytes("ISO-8859-1"),"UTF-8");
	// 订单名称，必填
    String subject = new String(request.getParameter("WIDsubject").getBytes("ISO-8859-1"),"UTF-8");
	System.out.println(subject);
    // 付款金额，必填
    String total_amount=new String(request.getParameter("WIDtotal_amount").getBytes("ISO-8859-1"),"UTF-8");
    // 商品描述，可空
    String body = new String(request.getParameter("WIDbody").getBytes("ISO-8859-1"),"UTF-8");
    // 超时时间 可空
   String timeout_express="2m";
    // 销售产品码 必填
    String product_code="QUICK_WAP_WAY";
    /**********************/
    // SDK 公共请求类，包含公共请求参数，以及封装了签名与验签，开发者无需关注签名与验签     
    //调用RSA签名方式
    AlipayClient client = new DefaultAlipayClient(AlipayConfig.URL, AlipayConfig.APPID, AlipayConfig.RSA_PRIVATE_KEY, AlipayConfig.FORMAT, AlipayConfig.CHARSET, AlipayConfig.ALIPAY_PUBLIC_KEY,AlipayConfig.SIGNTYPE);
    AlipayTradeWapPayRequest alipay_request=new AlipayTradeWapPayRequest();
    
    // 封装请求支付信息
    AlipayTradeWapPayModel model=new AlipayTradeWapPayModel();
    model.setOutTradeNo(out_trade_no);
    model.setSubject(subject);
    model.setTotalAmount(total_amount);
    model.setBody(body);
    model.setTimeoutExpress(timeout_express);
    model.setProductCode(product_code);
    
    alipay_request.setBizModel(model);
    // 设置异步通知地址
    alipay_request.setNotifyUrl(AlipayConfig.notify_url);
    // 设置同步地址
    alipay_request.setReturnUrl(AlipayConfig.return_url);   
    
    // form表单生产
    String form = "";
	try {
		// 调用SDK生成表单
		form = client.pageExecute(alipay_request).getBody();
		response.setContentType("text/html;charset=" + AlipayConfig.CHARSET); 
	    response.getWriter().write(form);//直接将完整的表单html输出到页面 
	    response.getWriter().flush(); 
	    response.getWriter().close();
	} catch (AlipayApiException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} 
}
%>
<!DOCTYPE html>
<html>
	<head>
	<base href="<%=basePath%>">
	<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery-1.11.1-min.js"></script>
	<title>支付宝手机网站支付接口</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
    *{
        margin:0;
        padding:0;
    }
    ul,ol{
        list-style:none;
    }
    body{
        font-family: "Helvetica Neue",Helvetica,Arial,"Lucida Grande",sans-serif;
    }
    .hidden{
        display:none;
    }
    .new-btn-login-sp{
        padding: 1px;
        display: inline-block;
        width: 75%;
    }
    .new-btn-login {
        background-color: #02aaf1;
        color: #FFFFFF;
        font-weight: bold;
        border: none;
        width: 100%;
        height: 30px;
        border-radius: 5px;
        font-size: 16px;
    }
    #main{
        width:100%;
        margin:0 auto;
        font-size:14px;
    }
    .red-star{
        color:#f00;
        width:10px;
        display:inline-block;
    }
    .null-star{
        color:#fff;
    }
    .content{
        margin-top:5px;
    }
    .content dt{
        width:100px;
        display:inline-block;
        float: left;
        margin-left: 20px;
        color: #666;
        font-size: 13px;
        margin-top: 8px;
    }
    .content dd{
        margin-left:120px;
        margin-bottom:5px;
    }
    .content dd input {
        width: 85%;
        height: 28px;
        border: 0;
        -webkit-border-radius: 0;
        -webkit-appearance: none;
    }
    #foot{
        margin-top:10px;
        position: absolute;
        bottom: 15px;
        width: 100%;
    }
    .foot-ul{
        width: 100%;
    }
    .foot-ul li {
        width: 100%;
        text-align:center;
        color: #666;
    }
    .note-help {
        color: #999999;
        font-size: 12px;
        line-height: 130%;
        margin-top: 5px;
        width: 100%;
        display: block;
    }
    #btn-dd{
        margin: 20px;
        text-align: center;
    }
    .foot-ul{
        width: 100%;
    }
    .one_line{
        display: block;
        height: 1px;
        border: 0;
        border-top: 1px solid #eeeeee;
        width: 100%;
        margin-left: 20px;
    }
    .am-header {
        display: -webkit-box;
        display: -ms-flexbox;
        display: box;
        width: 100%;
        position: relative;
        padding: 7px 0;
        -webkit-box-sizing: border-box;
        -ms-box-sizing: border-box;
        box-sizing: border-box;
        background: #1D222D;
        height: 50px;
        text-align: center;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        box-pack: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        box-align: center;
    }
    .am-header h1 {
        -webkit-box-flex: 1;
        -ms-flex: 1;
        box-flex: 1;
        line-height: 18px;
        text-align: center;
        font-size: 18px;
        font-weight: 300;
        color: #fff;
    }
</style>
</head>
<body text=#000000 bgColor="#ffffff" leftMargin=0 topMargin=4>
<header class="am-header">
        <h1>支付宝手机网站支付接口快速通道(接口名：alipay.trade.wap.pay)</h1>
</header>
<input hidden="hidden" type="text" id="userCode" value="${order.userCode }">
<input hidden="hidden" type="text" id="objectCode" value="${order.objectCode }">
<div id="main">
        <form name=alipayment action='' method=post target="_blank">
            <div id="body" style="clear:left">
                <dl class="content">
                    <dt>商户订单号：</dt>
                    <dd>
                        <input readonly="readonly" id="WIDout_trade_no" name="WIDout_trade_no" />
                    </dd>
                    <hr class="one_line">
                    <dt>订单名称：</dt>
                    <dd>
                        <input readonly="readonly" id="WIDsubject" name="WIDsubject" />
                    </dd>
                    <hr class="one_line">
                    <dt>付款金额：</dt>
                    <dd>
                        <input readonly="readonly" id="WIDtotal_amount" name="WIDtotal_amount" value="${order.orderAccount }" />
                    </dd>
                    <hr class="one_line"/>
                    <dt>商品描述：</dt>
                    <dd>
                        <input readonly="readonly" id="WIDbody" name="WIDbody" value="${order.objectDescribe }" />
                    </dd>
                    <hr class="one_line">
                    <dt></dt>
                    <dd id="btn-dd">
                        <span class="new-btn-login-sp">
                            <button id="submitBtn" class="new-btn-login" type="submit" style="text-align:center;">确 认</button>
                        </span>
                        <span class="note-help">如果您点击“确认”按钮，即表示您同意该次的执行操作。</span>
                    </dd>
                </dl>
            </div>
		</form>
        <div id="foot">
			<ul class="foot-ul">
				<li>
					支付宝版权所有 2015-2018 ALIPAY.COM 
				</li>
			</ul>
		</div>
	</div>
</body>
<script language="javascript">
	function GetDateNow() {
		var vNow = new Date();
		var sNow = "";
		sNow += String(vNow.getFullYear());
		sNow += String(vNow.getMonth() + 1);
		sNow += String(vNow.getDate());
		sNow += String(vNow.getHours());
		sNow += String(vNow.getMinutes());
		sNow += String(vNow.getSeconds());
		sNow += String(vNow.getMilliseconds());
		document.getElementById("WIDout_trade_no").value =  sNow;
		var objectDecribe = document.getElementById("WIDbody").value;
		document.getElementById("WIDsubject").value = objectDecribe.substr(0,5)+sNow;
		//document.getElementById("WIDtotal_amount").value = "0.01";
        //document.getElementById("WIDbody").value = "购买测试商品0.01元";
	}
	GetDateNow();
</script>
<script type="text/javascript">
	$(function () {
		Date.prototype.format = function (format) {
		    var args = {
		        "M+": this.getMonth() + 1,
		        "d+": this.getDate(),
		        "h+": this.getHours(),
		        "m+": this.getMinutes(),
		        "s+": this.getSeconds(),
		        "q+": Math.floor((this.getMonth() + 3) / 3), 
		        "S": this.getMilliseconds()
		    };
		    if (/(y+)/.test(format))
		        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		    for (var i in args) {
		        var n = args[i];
		        if (new RegExp("(" + i + ")").test(format))
		            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? n : ("00" + n).substr(("" + n).length));
		    }
		    return format;
		};
		
		$("#submitBtn").click(function () {
			$.post(
				"jump/user/saveOrder.do",
				{
					"orderCode":$("#WIDout_trade_no").val(),	
					"orderName":$("#WIDsubject").val(),
					"orderAccount":$("#WIDtotal_amount").val(),	
					"objectDescribe":$("#WIDbody").val(),
					"userCode":$("#userCode").val(),
					"orderDate":new Date().format("yyyy-MM-dd hh:mm:ss"),
					"objectCode":$("#objectCode").val()
				}
			);
		});
		
	});
</script>
</html>