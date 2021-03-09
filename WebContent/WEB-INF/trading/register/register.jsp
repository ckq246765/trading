<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/register.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GaGe交易平台</title>
<style>
	.center{
		width: 100%;height: 100%;
	}
	.center{
		background: url("img/1234.jpg");
	}
	label{
		color: cyan;
	}
</style>
</head>

<body>

	<!-- 顶部 -->
	<div id="top" style="height: 40px; background-color: #96FED1; width: 100%;">
		<div style="position: absolute; top: 2px; left: 15x; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">GAGE闲置</div>
		
		<div style="position: relative;top: 15px; left:40%;width: 20%;"><span style="color:yellowgreen;font-style: oblique;font-family: 'bookshelf symbol 7';">辽宁工程技术大学</span>
			<span style="color: cornflowerblue;font-style: oblique;font-family: 'bookshelf symbol 7';">@GAGE</span>
		</div>
		
		<div  style="position: absolute; top: 12px; right: 30px;font-size: 15px; font-weight: 300; color: red;font-family: 'times new roman'">
			<a href="${pageContext.request.contextPath }/jump/tojsp.do?target=show"><span style="color: red;">返回首页登录> </span></a>
		</div>
</div>   
	<!-- 中间 -->
	<div class="center" style="position: absolute;top: 40px; bottom: 30px; left: 0px;">
		
			<!-- 导航 -->
			<div id="myCarousel" class="carousel slide" style="position: relative;left:0%; width: 50%;">
			<!-- 轮播（Carousel）指标 -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" ></li>
				<li data-target="#myCarousel" data-slide-to="1" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>   
			<!-- 轮播（Carousel）项目 -->
			<div class="carousel-inner">
				<div class="item active">
					<img src="img/one.jpg" alt="First slide" style="height: 650px;width: 100%;">
				</div>
				<div class="item">
					<img src="img/two.jpg" alt="Second slide" style="height: 650px;width: 100%;">
				</div>
				<div class="item">
					<img src="img/three.jpg" alt="Third slide" style="height: 650px;width: 100%;">
				</div>
			</div>
				<!-- 轮播（Carousel）导航 -->
				<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
					<span class="sr-only">Previous</span>
				</a>
				<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
					<span class="sr-only">Next</span>
				</a>
			</div> 
			
		<div id="workarea" style="position: absolute; top:0px;left: 55%; width: 40%; height: 80%;">
			<div style="position: relative;left: 50%;" class="modal-title">
				<h3><span style="color: red;font-family: 'bookman old style';">注册用户</span></h3>
			</div>
			<form class="form-horizontal" role="form" id="userForm" >
			    <div class="form-group">
			   		<label class="col-sm-2 control-label">用&nbsp;&nbsp;户&nbsp;&nbsp;名</label>
			    	<div class="col-sm-10">
			        	<input  onblur="blurUserName()" onfocus="clickUserName()" class="form-control" id="userName" maxlength="20"  type="text" placeholder="输入用户名">
			        	<span id="userNameErrorMsg" style="color: yellow; font-size: 12px;"></span>
			    	</div>
			    </div>
			    <div class="form-group">
			    	<label class="col-sm-2 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码</label>
			    	<div class="col-sm-10">
			        	<input class="form-control"  onblur="blurPassWord()" onfocus="focusPassWord()" id="passWord" type="password" placeholder="输入密码">
			        	<span id="passWordErrorMsg" style="color: yellow;font-size: 12px;"></span>
			    	</div>
			    </div>
			    <div class="form-group">
			    	<label class="col-sm-2 control-label">确认密码</label>
			    	<div class="col-sm-10">
			        	<input class="form-control" onblur="blurPassWordAgin()" onfocus="focusPassWordAgin()" id="passWordAgin" type="password" placeholder="再次确认密码">
			        	<span id="passWordAginErrorMsg" style="color: yellow;font-size: 12px;"></span>
			    	</div>
			    </div>
			    <div class="form-group">
			    	<label class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
			    	<div class="col-sm-10">
			        	<input class="form-control" onblur="blurName()" onfocus="focusName()" id="name" type="text" placeholder="请输入姓名">
			        	<span id="nameErrorMsg" style="color: yellow;font-size: 12px;"></span>
			    	</div>
			    </div>
			    <div class="form-group">
			    	<label class="col-sm-2 control-label">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄</label>
			    	<div class="col-sm-10">
			        	<input class="form-control" id="age" onblur="blurAge()" onfocus="focusAge()" type="text" placeholder="请输入年龄">
			        	<span id="ageErrorMsg" style="color: yellow;font-size: 12px;"></span>
			    	</div>
			    </div>
			    <div class="form-group">
			    	<label class="col-sm-2 control-label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</label>
			    	    <div>
                    		<label style="position: relative;left: 2%;">
          						<input name="sex" type="radio" value="1"><span style="color: blue;">男</span> 
      						 </label>
      						    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<label>
        							<input name="sex" type="radio" value="0"><span style="color:red">女</span>
    						</label>
    					</div>
    			</div>
			    <div class="form-group">
			    	<label class="col-sm-2 control-label">手&nbsp;&nbsp;机&nbsp;&nbsp;号</label>
			    	<div class="col-sm-10">
			        	<input class="form-control" id="phone" onblur="blurPhone()" onfocus="focusPhone()" type="tel" placeholder="请输入手机号">
			        	<span id="phoneErrorMsg" style="color: yellow;font-size: 12px;"></span>
			    	</div>
			    </div>
			    <div class="form-group">
			    	<label class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱</label>
			    	<div class="col-sm-10">
			        	<input class="form-control" id="email" onblur="blurEmail()" onfocus="focusEmail()" type="email" placeholder="请输入邮箱">
			        	<span id="emailErrorMsg" style="color: yellow;font-size: 12px;"></span>
			    	</div>
			    </div>
			     <div class="form-group">
			    	<label class="col-sm-2 control-label">省&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份</label>
			    	<div class="col-sm-10">
			    		<select class="form-control" onchange="changeProvinceCode()" id="provinceCode" style="width: 100%;">
				 				  <option></option>
								 <!--<option value="provinceCode">provinceName</option>
								 <option value="Poo1">四川省</option>
								 <option value="Poo1">辽宁省</option>  -->
								 <c:if test="${empty pList}">
								 	<option>数据库出错了，请稍后再试</option>
								 </c:if>
								 <c:if test="${!empty pList}">
								 	<c:forEach items="${pList }" var="p" varStatus="vs">
								 		<option value="${p.provinceCode }">${p.provinceName}</option>
								 	</c:forEach>
								 </c:if>
						</select>
			    	</div>
			    </div>
			    <div class="form-group">
			    	<label class="col-sm-2 control-label">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市</label>
			    	<div class="col-sm-10">
			    		<select class="form-control" required="required" onchange="changeCityCode()" id="cityCode" style="width: 100%;">
			    				<option></option>
								<!-- <option value="cityCode">cityName</option>
								 <option value="Poo1">四川省</option>
								 <option value="Poo1">辽宁省</option>  -->
								 <c:if test="${empty cList}">
								 	<option>数据库出错了，请稍后再试</option>
								 </c:if>
								 <c:if test="${!empty cList}">
								 	<c:forEach items="${cList }" var="p" varStatus="vs">
								 		<option value="${p.cityCode }" provinceCode="${p.provinceCode }" provinceName="${p.provinceName }" >${p.cityName}</option>
								 	</c:forEach>
								 </c:if>
						</select>
			    	</div>
			    </div>
			    <div class="form-group">
			    	<label class="col-sm-2 control-label">详细地址</label>
			    	<div class="col-sm-10">
			        	<input class="form-control" required="required" onblur="blurAddress()" onfocus="focusAddress()" id="address" type="text" placeholder="请输入详细地址">
			        	<span id="addressErrorMsg" style="color: yellow;font-size: 12px;"></span>
			    	</div>
			    </div>
	           <div class="form-group" hidden="hidden">
			    	<label class="col-sm-2 control-label">注册时间</label>
			    	<div class="col-sm-10">
			        	<input class="form-control" id="regDate" type="text" placeholder="">
			    	</div>
			    </div>
			    <div class="form-group" hidden="hidden">
			    	<label class="col-sm-2 control-label">用户状态</label>
			    	<div class="col-sm-10">
			        	<input class="form-control" id="state" type="text" placeholder="" value="1">
			    	</div>
			    </div>
			    <div class="form-group" style="position: relative;left: 20%;">
			    	<button type="button" onclick="clickSubmit()" class="btn btn-default" style="width: 77.5%;background-color: red;">
			    		<span style="color: blue;font-family: '微软雅黑';">注册</span>
			  	  	</button>
			  	</div>
			  	<div class="form-group" style="position: relative;left: 20%;">
			  		<button type="reset" onclick="clickReset()" class="btn btn-default" style="width: 77.5%; background-color: gold;">
			    		<span style="color: green;font-family: '微软雅黑';">全部重置</span>
			    	</button>
			    </div>
			    <span id="ErrorMsg" style="color: yellow;font-size: 12px;"></span>
			</form>
		</div>
			
	</div>
	
</body>
</html>


