<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GaGe交易平台</title>
<style type="text/css">
	div input{
		color: blue;
		width: 200px;
	}
	#objectCode{
		color: red;
	}
</style>
<script type="text/javascript">
	$(function () {
		var prompt = function (message, style, time){
		     style = (style === undefined) ? 'alert-success' : style;
		     time = (time === undefined) ? 1200 : time;
		     $('<div>')
		         .appendTo('body')
		         .addClass('alert ' + style)
		         .html(message)
		         .show()
		         .delay(time)
		         .fadeOut();
		     };
		 var success_prompt = function(message, time){ prompt(message, 'alert-success', time);};
		 var fail_prompt = function(message, time){prompt(message, 'alert-danger', time);};
		 var warning_prompt = function(message, time){prompt(message, 'alert-warning', time);};
		 var info_prompt = function(message, time){prompt(message, 'alert-info', time);};

		$("#objectCode").click(function () {
			var objectCode = $(this).attr("objectCode");
			if(confirm("你确定要删除该用户发布的物品？")){
				$.post(
					"sys/tradingobject/deleteObject.do",
					{
						"objectCode":objectCode
					},
					function (data) {
						if(data=="true"){
							success_prompt("删除成功",10);
							window.history.go(-1);
						}else{
							warning_prompt("删除失败",1500);
						}
					}
				);
			}
		});
	});
</script>
</head>
<body>
	<div>
		<input type="button" onclick="window.history.go(-1)" value="back">
		<input type="button" id="objectCode" objectCode="${tObject.objectCode }" value="删除"/>
		<div style="position: relative;left:1%;top:20px;width: 60%;text-align:center">
			<span style="color: blue;font-size: 30px;">物品图片</span><br><br>
			<img src="${pageContext.request.contextPath }/${tObject.pictureDescri}" class="img-rounded" style="position:relative;width: 45%;height: 50%;">
		</div>
		
		<div style="position: absolute;top: 40px; left: 60%;width: 37%;text-align: left;">
			<span style="color: blue;font-size: 30px;">${tObject.objectName }</span><br>
			<span>售价: </span><span style="color: red;"><i>￥</i> ${tObject.salePrice } 元</span><br>
			<span>原价: </span><span style="color: red;"><i>￥</i> ${tObject.originalPrince } 元</span><br>
			<span>邮费: </span><span style="color: red;"><i>￥</i> ${tObject.postage } 元</span><br><br>
			<span style="color:black;">卖家描述:</span><span style="color:blue"> ${tObject.textDescri }</span><br>
			<span style="color:black;">卖家地址:</span><span style="color:blue;"> ${tObject.provinceName }&nbsp;${tObject.cityName }</span><br>
			<span style="color:black;">其他描述:</span><span style="color:blue;"> ${tObject.msg }</span><br>
			<span style="color:black;">详细地址:</span><span style="color:blue;"> ${tObject.objectAddress }</span><br><br>
			<span style="color:black;">卖&nbsp;&nbsp;家:</span><span style="color:red;"> ${tObject.objectUserName }</span><span> 已认证</span><br><br>
			<span style="color:black;">发布时间:</span><span style="color:red;"> ${tObject.releaseTime }</span><br>
			<span style="color:black;">交易类型:</span><span style="color:red;"> ${tObject.tradingTypeName }</span><br>
			<span style="color:black;">交易日期:</span><span style="color:red;"> ${tObject.tradingDate }</span><br>
			<span style="color:black;">交易对手:</span><span style="color:red;"> ${tObject.tradingUser }</span><br>
			<c:if test="${not empty tObject.wantTradTypeName }">
				<span style="color:black;">想要交易的物品:</span><span style="color:red;"> ${tObject.wantTradTypeName }</span><br><br>
			</c:if>
		</div>
	</div>
</body>
</html>