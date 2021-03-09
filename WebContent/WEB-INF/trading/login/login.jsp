<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>GaGe交易登录</title>
    <link href="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<link type="text/css" href="${pageContext.request.contextPath }/css/login.css" rel="stylesheet">
</head>
<body class="text-center">
    <form class="form-signin">
      <img class="mb-4" src="./Signin Template for Bootstrap_files/bootstrap-solid.svg" alt="" width="72" height="72">
      <h1 class="h3 mb-3 font-weight-normal">欢迎登录</h1>
      <label for="inputEmail" class="sr-only">用户名</label>
      <input type="email" id="inputEmail" class="form-control" placeholder="请输入用户名" required="" autofocus="" data-form-un="1554132300059.98">
      <label for="inputPassword" class="sr-only">密码</label>
      <input type="password" id="inputPassword" class="form-control" placeholder="请输入密码" required="" data-form-pw="1554132300059.98">
      <div class="radio">
        <label>
          <input name="123" type="radio" value="sys_user"> 管理员
        </label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label>
          <input name="123" type="radio" value="user"> 用户
        </label>
      </div>
      <button class="btn btn-lg btn-primary btn-block" type="submit" data-form-sbm="1554132300059.98" style="pointer-events: auto;">登录</button>
      <p class="mt-5 mb-3 text-muted">©GAGE闲置</p>
    </form>

</body>
</html>