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

		$("#clickBtn").click(function () {
				$.post(
					"user/jump/order/saveZengYu.do",
					{
						"orderCode":$("#orderCode").text(),
						"orderName":$("#orderName").text(),
						"objectCode":$("#objectCode").attr("objectCode"),
						"objectDescribe":$("#textDescri").text(),
						"userCode":$("#userCode").attr("userCode")
					},
					function (data) {
						if(data=="true"){
							success_prompt("提交成功",1500);
							window.history.go(-1);
						}else{
							warning_prompt("失败",1500);
							window.history.go(-1);
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
		<input type="button" id="objectCode" objectCode="${tObject.objectCode }" hidden="hidden"/>
		<div style="position: relative;left:1%;top:20px;width: 60%;text-align:center">
			<span style="color: blue;font-size: 30px;">物品图片</span><br><br>
			<img src="${pageContext.request.contextPath }/${tObject.pictureDescri}" class="img-rounded" style="position:relative;width: 45%;height: 50%;">
		</div>
		
		<div style="position: absolute;top: 40px; left: 60%;width: 37%;text-align: left;">
			<span style="color: blue;font-size: 30px;">你的信息</span><br>
			<span style="color:black;">手机号:</span><span style="color:blue" id="userCode" userCode="${user.user_code }"> ${user.phone }</span><br>
			<span style="color:black;">邮箱:</span><span style="color:blue;"> ${user.email }</span><br>
			<span style="color:black;">地址:</span><span style="color:blue;"> ${user.address }</span><br>
			
			<span style="color: blue;font-size: 30px;">订单信息</span><br>
			<span style="color:black;">订单编号:</span><span style="color:blue;" id ="orderCode"> ${order.orderCode }</span><br>
			<span style="color:black;">订单名称:</span><span style="color:blue;" id="orderName"> ${order.orderName }</span><br>
			<span style="color:black;">订单描述:</span><span style="color:blue;" id="textDescri"> ${tObject.textDescri }</span><br>
			
			<input type="button" id="clickBtn" value="确认">
			
		</div>
	</div>
</body>
</html>