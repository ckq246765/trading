<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		//默认打开用户界面
		window.open("jump/tojsp.do?target=sys/user/index","workareaFrame");
		
		//查看自己的信息
		$("#showMySource").click(function () {
			$.post(
					"showMySource.do",
					{
						"userName":$("#currLoginSys").html()
					},
					function (data) {
						$("#sysUserName").html(data.name);
						$("#sysUserNo").html(data.userName);
						$("#sysUseremail").html(data.email);
					},
					"json"
			);
		});
		//创建modal
		$("#editPwd").click(function () {
			$("#changeForm")[0].reset();
			$("#editpasswordModal").modal("show");
			$("#oldPwdErrorMsg").text("");
			$("#newPwdErrorMsg").text("");
			$("#confirmPwdErrorMsg").text("");
			$("#pwdErrorMsg").text("");
		});
		//关闭modal
		$("#closeEditBtn").click(function () {
			$("#editpasswordModal").modal("hide");
			$("#oldPwdErrorMsg").text("");
			$("#newPwdErrorMsg").text("");
			$("#confirmPwdErrorMsg").text("");
			$("#pwdErrorMsg").text("");
		});
		
		//原密码失去焦点
		$("#oldPassword").blur(function () {
			if($.trim(this.value)==""){
				$("#oldPwdErrorMsg").text("密码不能为空");
			}
		});
		$("#oldPassword").focus(function () {
			$("#oldPwdErrorMsg").text("");
			$("#pwdErrorMsg").text("");
			$("#confirmPwdErrorMsg").text("");
		});
		//校验确认密码和新密码一样
		$("#confirmPassword").blur(function () {
			var confirmpwd = $.trim(this.value);
			var newpwd = $.trim($("#newPassword").val());
			if(confirmpwd != newpwd){
				$("#confirmPwdErrorMsg").text("密码不一致，请重新输入");
			}
		});
		$("#confirmPassword").focus(function () {
				$("#confirmPwdErrorMsg").text("");
				$("#pwdErrorMsg").text("");
		});
		//新密码
		$("#newPassword").blur(function () {
			var oldPwd = $.trim($("#oldPassword").val());
			var newpwd = $.trim(this.value);
			var confirmpwd = $.trim($("#confirmPassword").val());
			if($.trim(this.value)==""){
				$("#newPwdErrorMsg").text("密码不能为空");
			}else if($.trim(this.value) == oldPwd){
				$("#newPwdErrorMsg").text("请输入新密码");
			}else if(confirmpwd != newpwd){
				$("#confirmPwdErrorMsg").text("密码不一致，请重新输入");
			}
			$("#confirmPwdErrorMsg").text("");
		});
		$("#newPassword").focus(function () {
			$("#newPwdErrorMsg").text("");
			$("#pwdErrorMsg").text("");
		});
		//点击更新密码
		$("#changeBtn").click(function () {
			var oldPwd = $.trim($("#oldPassword").val());
			var newPwd = $.trim($("#newPassword").val());
			var userName = $("#currLoginSys").text();
			$("#oldPassword").blur();
			$("#newPassword").blur();
			$("#confirmPassword").blur();
			var oldPwd = $("#oldPwdErrorMsg").text();
			var newPwd = $("#newPwdErrorMsg").text();
			var confirmPwd = $("#confirmPwdErrorMsg").text();
			if(oldPwd=="" && newPwd=="" && confirmPwd==""){
				$.ajax({
					type:"post",
					url:"sys/changePwd.do",
					data:{
						"userName":userName,
						"oldPwd":$.trim($("#oldPassword").val()),
						"newPwd":$.trim($("#newPassword").val())
					},
					success : function (data) {
						if(data != null){
							alert(data);
							$("#editpasswordModal").modal("hide");
						}else{
							alert("提交失败,请重试");
						}
					}
				});
			}else{
				$("#pwdErrorMsg").text("请检查填写是否正确");
			}
		});
		
	});
</script>
</head>
<body>
	<!-- 我的资料 -->
	<div class="modal fade" id="myInformation" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title"><span style="position: relative;left: 40%;font-size:large;color: deepskyblue;">我的资料</span></h4>
				</div>
				<div class="modal-body">
					<div style="position: relative; left: 40px;">
						姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：<b id="sysUserName"></b><br><br>
						登录帐号：<b id="sysUserNo"></b><br><br>
						邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：<b id="sysUseremail"></b><br><br>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 修改密码的模态窗口 -->
	<div class="modal fade" id="editpasswordModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 70%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true" style="color: red;">×</span>
					</button>
					<h4 class="modal-title"><span style="position: relative;left: 40%;font-size:large;color: deepskyblue;">修改密码</span></h4>
				</div>
				<div class="modal-body">
					<form id="changeForm" class="form-horizontal" role="form">
						<div class="form-group">
							<label for="oldPwd" class="col-sm-2 control-label">原&nbsp;&nbsp;密&nbsp;&nbsp;码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="oldPassword" style="width: 200%;" placeholder="请输入原密码">
								<span id="oldPwdErrorMsg" style="color: red;font-size: 12px;" ></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="newPwd" class="col-sm-2 control-label">新&nbsp;&nbsp;密&nbsp;&nbsp;码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="newPassword" style="width: 200%;" placeholder="请输入新密码">
								<span id="newPwdErrorMsg" style="color: red;font-size: 12px;" ></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="confirmPassword" style="width: 200%;" placeholder="请输入新密码">
								<span id="confirmPwdErrorMsg" style="color: red;font-size: 12px;" ></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" style="position:relative;left:-20%;width: 30%;" class="btn btn-primary" " id="changeBtn">更新</button>
					<button type="button" style="position:relative;left:-15%;width: 30%; color: red;" class="btn btn-default" id="closeEditBtn">取消</button>
					<span id="pwdErrorMsg" style="color: red;font-size: 12px;" ></span>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 退出系统的模态窗口 -->
	<div class="modal fade" id="exitModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title"><span style="position: relative;left: 40%;font-size:large;color: deepskyblue;">退出系统</span></h4>
				</div>
				<div class="modal-body">
					<p><span style="position: relative;left:29%;font-size:large;color: deepskyblue;">你确定退出系统吗？</span></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='${pageContext.request.contextPath}/jump/tojsp.do?target=show';">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 顶部 -->
	<div id="top" style="height: 40px; background-color: #96FED1; width: 100%;">
		<div style="position: absolute; top: 2px; left: 15x; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">GAGE闲置</div>
		<div>
			<span style="position: absolute; left:50%;top: 10px; font-size: 20px; font-weight: 400;font-style:oblique; font-family:'bookshelf symbol 7'; color:red;;">管理员</span>
		    <span style="position: absolute; left:56%;top: 10px; font-size: 20px; font-weight: 400;font-style:oblique; font-family:'bookshelf symbol 7'; color:red;;">你好!</span>
		</div>
		<div style="position: absolute; top: 15px; right: 35px;">
			<ul>
				<li class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: red;" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span><span id="currLoginSys"><%=request.getSession().getAttribute("loginSys")%> </span><span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="${pageContext.request.contextPath}/jump/tojsp.do?target=show"><span class="glyphicon glyphicon-home"></span> 首&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;页</a></li>
						<li><a href="javascript:void(0)"  data-toggle="modal" data-target="#myInformation" id="showMySource"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
						<li><a id="editPwd"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
						<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal">
						<span class="glyphicon glyphicon-off"></span> 退&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;出</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 40px; bottom: 30px; left: 0px; right: 0px;">
	
		<!-- 导航 -->
		<div id="navigation" style="left: 0px; width: 10%; position: relative; height: 100%; overflow:auto;">
		
			<ul id="no1" class="nav nav-pills nav-stacked">
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/tojsp.do?target=sys/user/index" target="workareaFrame"><span class="glyphicon glyphicon-book">所有注册用户</span></a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/tojsp.do?target=sys/tradingobject/show" target="workareaFrame"><span class="glyphicon glyphicon-list">所有商品信息</span></a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/tojsp.do?target=sys/order/index" target="workareaFrame"><span class="glyphicon glyphicon-list">所有订单信息</span></a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/tojsp.do?target=sys/trading_type/index" target="workareaFrame"><span class="glyphicon glyphicon-list">物品交易类型</span></a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/tojsp.do?target=sys/object_type/index" target="workareaFrame"><span class="glyphicon glyphicon-list">物品类型信息</span></a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/tojsp.do?target=sys/obj_par_type/index" target="workareaFrame"><span class="glyphicon glyphicon-list">物品具体类型</span></a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/tojsp.do?target=sys/all_province/index" target="workareaFrame"><span class="glyphicon glyphicon-list">全部省份信息</span></a></li>
				<li class="liClass"><a href="${pageContext.request.contextPath}/jump/tojsp.do?target=sys/all_city/index" target="workareaFrame"><span class="glyphicon glyphicon-list">全部城市信息</span></a></li>
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