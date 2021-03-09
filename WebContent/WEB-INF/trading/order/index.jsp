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
<link href="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery.bs_pagination.min.css"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/localization/en.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GaGe交易平台</title>
</head>
<script type="text/javascript">
	$(document).ready(function () {
		//默认打开所有列表
		window.open("jump/toOrder.do?target=order/all/index&userCode="+$("#userCode").val(),"workareaFrame");
		
	});
</script>
<body>
	<input type="text" hidden="hidden" id="userCode" value="${userCode}">
	<!-- 顶部 -->
	<div id="top" style="height: 40px; background-color: #96FED1; width: 100%;">
		<div style="position: absolute; top: 2px; left: 15x; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">GAGE闲置</div>
		
		
		<div style="position: absolute; top: 5px; left:48% ;color: red;font-family: 'times new roman'">
			<a href=""><span style="color:red;font-size: 25px;">我的订单</span></a>
		</div>
		<div>
			<a href="${backURL}" style="position: absolute;top:8px;right: 3%;background: white;"><span>&laquo;</span><span style="color: red;">返回</span></a>
		</div>
</div>   
	
	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">
	
		<!-- 导航 -->
		<div id="navigation" style="left: 0px; width: 10%; position: relative; height: 100%; overflow:auto;">
		
			<ul id="no1" class="nav nav-pills nav-stacked">
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/toOrder.do?target=order/all/index&userCode=${userCode}" target="workareaFrame"><span class="glyphicon glyphicon-list"></span> 全&nbsp;&nbsp;&nbsp;&nbsp;部</a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/toOrder.do?target=order/all/notpay&userCode=${userCode}" target="workareaFrame"><span class="glyphicon glyphicon-book"></span> 待付款</a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/toOrder.do?target=order/all/notfh&userCode=${userCode}" target="workareaFrame"><span class="glyphicon glyphicon-list"></span> 待发货</a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/toOrder.do?target=order/all/notys&userCode=${userCode}" target="workareaFrame"><span class="glyphicon glyphicon-list"></span> 待收货</a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/toOrder.do?target=order/all/notpj&userCode=${userCode}" target="workareaFrame"><span class="glyphicon glyphicon-list"></span> 待评价</a></li>
				<li class="liClass"><a href="value/index.html" target="workareaFrame"><span class="glyphicon glyphicon-list"></span> 退款/售后</a></li>
				<!-- 不为空且有用户购买 -->
				<c:if test="${not empty oList }">
					<li class="liClass"><a href="${pageContext.request.contextPath}/jump/toOrder.do?target=order/userObject/notfh&userCode=${userCode}" target="workareaFrame"><span class="glyphicon glyphicon-list"></span> 待发货物品</a></li>
				</c:if>
			</ul>
			
			<!-- 分割线 -->
			<div id="divider1" style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;"></div>
		</div>
		
		<!-- 工作区 -->
		<div id="workarea" style="position: absolute; top : 0px; left: 10%; width: 90%; height: 100%;">
			<iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
		</div>
		
	</div>
	
	<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>
	
	<!-- 底部 -->
	<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;" style="">
		<div style="position: relative; left:40%;width: 20%;"><span style="color:yellowgreen;font-style: oblique;font-family: 'bookshelf symbol 7';">辽宁工程技术大学</span><span style="color: cornflowerblue;font-style: oblique;font-family: 'bookshelf symbol 7';">@GAGE</span></div>
	</div>

</body>
</html>