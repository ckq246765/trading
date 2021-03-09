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
		
		$("#stateName").click(function () {
			var str = "";
			var strState = $(this).text();
			if(strState=="激活"){
				str = "限制";
			}else{
				str = "激活";
			}
			if(confirm("你确定"+str+"该用户登录吗？")){
				$.post(
						"sys/user/changeState.do",
						{
							"userCode":$(this).attr("userCode"),
							"state":$(this).attr("state")
						},
						function (data) {
							if(data == "1"){
								window.location.reload();    //刷新当前页面
							}else{
								alert("修改失败，请重试");
							}
						});
			}
		}) 
	});
</script>
</head>
<body>
	<div>
		<input type="button" onclick="window.history.go(-1)" value="back">
		
		<div style="position: absolute;top: 40px; left: 1%;width: 100%;text-align: center;">
			<span>用户名: </span><span style="color: blue;font-size: 30px;" id="userName"> ${user.userName}</span><br><br>
			<span>姓名: </span><span style="color: red;"> ${user.name} </span><br><br>
			<c:if test="${user.sex == 1 }">
				<span>性别: </span><span style="color: red;"> 男 </span><br><br>
			</c:if>
			<c:if test="${user.sex == 0 }">
				<span>性别: </span><span style="color: red;"> 女 </span><br><br>
			</c:if>
			<c:if test="${user.sex != 1 and user.sex != 0 }">
				<span>性别: </span><span style="color: red;">  </span><br><br>
			</c:if> 
			<span>年龄: </span><span style="color: red;"> ${user.age} </span><br><br>
			<span style="color:black;">手机号:</span><span style="color:blue"> ${user.phone}</span><br><br>
			<span style="color:black;">邮箱:</span><span style="color:blue;"> ${user.email }</span><br><br>
			<span style="color:black;">详细地址:</span><span style="color:blue;"> ${user.address}</span><br><br>
			
			<span style="color:black;">省份:</span><span style="color:red;"> ${user.provinceName}</span><span></span><br><br>
			<span style="color:black;">城市:</span><span style="color:red;"> ${user.cityName}</span><br><br>
			<span style="color:black;">注册日期:</span><span style="color:red;"> ${user.regDate}</span><br><br>
			<c:if test="${user.state == 1 }">
				<span style="color:black;">用户状态:</span><span style="color:red;"> <span state="${user.state }" userCode="${user.user_code }" id="stateName">激活</span></span><br><br>
			</c:if>
			<c:if test="${user.state == 0 }">
				<span style="color:black;">用户状态:</span><span style="color:red;"> <span state="${user.state }" userCode="${user.user_code }" id="stateName">限制</span></span><br><br>
			</c:if>
		</div>
	</div>
</body>
</html>