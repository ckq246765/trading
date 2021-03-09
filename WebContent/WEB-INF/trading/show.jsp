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
<link type="text/css" href="${pageContext.request.contextPath }/css/show.css" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/login.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/show.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/register.js"></script>

<meta http-equiv="Content-Type" content="multipart/form-data; charset=UTF-8">
<title>GaGe交易平台</title>

<script type="text/javascript">
	 $(function() {
		 
		 if($("#aaaaa").val() != "" && $("#aaaaa").val() != "null" ){
			$("#loginBtn").prop("hidden",true);
		 	$("#registBtn").prop("hidden",true);
		 	$("#userBtn").removeProp("hidden");
			$("#user").text($("#aaaaa").val());
		 }else if($("#aaaaa").val() == "" || $("#aaaaa").val() == "null"){
			 $("#loginBtn").removeProp("hidden");
			 $("#registBtn").removeProp("hidden");
			 $("#userBtn").prop("hidden");
		 }

		 $("#myComment").click(function () {
			 var userName = $.trim($("#user").text());
			 var href="${pageContext.request.contextPath}/jump/toCommentByUserName.do?userName="+userName+"&backURL="+window.location.href;
				$("#myComment").prop("href",href);
		});
		 
		 $("#myOrder").click(function () {
			 var userName = $.trim($("#user").text());
				var href="${pageContext.request.contextPath}/jump/toOrderByUserName.do?userName="+userName+"&backURL="+window.location.href;
				$("#myOrder").prop("href",href);
		});
		 
		 $("#toShopping").click(function () {
			var userName = $.trim($("#user").text());
			var href="${pageContext.request.contextPath}/user/jump/shopping.do?userName="+userName+"&backURL="+window.location.href;
			$("#toShopping").prop("href",href);
		});
		 
		 $("#toObjectMsg").click(function () {
			var userName = $.trim($("#user").text());
			var href="${pageContext.request.contextPath}/user/jump/toObjectMsg.do?userName="+userName+"&backURL="+window.location.href;
			$("#toObjectMsg").prop("href",href);
		});
		 
		//用户名输入框
		 $("#userName").focus(function () {
			$("#userNameErrorMsg").text("");
			$("#loginErrorMsg").text("");
		});
		//用户名框失去焦点
		$("#userName").blur(function () {
			var userNameValue = $.trim(this.value);
			if(userNameValue == ""){
				$("#userNameErrorMsg").text("用户名不能为空");
			}
		});
		//密码输入框
		$("#passWord").focus(function () {
			$("#passWordErrorMsg").text("");
			$("#loginErrorMsg").text("");
		});
		//密码框失去焦点
		$("#passWord").blur(function () {
			var passWordValue = $.trim(this.value);
			if(passWordValue == ""){
				$("#passWordErrorMsg").text("密码不能为空");
			}
		});
		
		 //关闭模态窗口
		$("#closeBtn").click(function () {
			$("#longinSysUserModal").modal("dide");
			$("#userNameErrorMsg").text("");
			$("#passWordErrorMsg").text("");
			$("#loginErrorMsg").text("");
		});
		//创建模态窗口
		$("#indexLoginBtn").click(function () {
			//dom对象才有reset()方法
			$("#loginSysUserForm")[0].reset();
			$("#longinSysUserModal").modal("show");
			$("#userNameErrorMsg").text("");
			$("#passWordErrorMsg").text("");
			$("#loginErrorMsg").text("");
		}); 
		
		//登录按钮绑定事件
		$("#loginSysUserBtn").click(login);
		
		$(window).keydown(function(event){
			if(event.keyCode == 13){
				login();
			}
			if(event.keyCode == 27){
				$("#longinSysUserModal").modal("hide");
			}
		});
		
		$('#frameName').load(function(){
		    var text=$(this).contents().find("body").text();
		       // 根据后台返回值处理结果
		    var j=$.parseJSON(text);
		    if(text=="true") {
		        $("#tradingObjectForm").modal("hide");
		        alert("发布成功，可到发布信息查看");
		        var href = $(this).prop("src");
		        window.location.href=href;
		    } else {
		        alert('发布失败');
		        //location.href='BookResourceList.jsp'
		    }
		});
		
		//鼠标移入事件
		$(".dpdown").mouseover(function () {
	           $(this).addClass("open");
	       });
	   	$(".dpdown").mouseleave(function(){
	           $(this).removeClass("open");
	    });
	     //点击跳转到objectList
		$(".dpdown").click(function () {
			var url = $(this).children(".id").attr("href");
			window.location.href = url;
		});
	     
		var userMsgUserName =  $("#userMsgUserName").val();
	    $("#userMsgUserName").change(function () {
	    	if($(this).val()!= userMsgUserName){
	    		$.post(
		    			"user/checkUserName.do",
		    			{
		    				"userName":$.trim($("#userMsgUserName").val())
		    			},
		    			function(data) {
		    				if(data=="true"){
		    					$("#userMsgUserNameErrorMsg").text("用户名已使用，请重新输入");
		    				}
		    			}
		    		);
	    	}
	    	
		})
		
	});
	  function login(){
		 var userName = $.trim($("#userName").val());
		 var passWord = $.trim($("#passWord").val());
		 var checkUser = $('input:radio[name="sysOrUser"]:checked').val();
		 $.ajax({
			 type:"post",
			 url:"login.do",
			 data:{
				 "userName":userName,
				 "passWord":passWord,
				 "checkUser":checkUser
			 },
			 beforeSend : function(){
				 if(checkUser == null){
					 $("#loginErrorMsg").text("请选择登录身份");
					 return false;
				 }else if(userName==""||passWord==""){
					 $("#loginErrorMsg").text("用户名密码不能为空");
					 return false;
				 }
				 return true;
			 },
			 success : function (data) {
				 if(data=="sys/sys"){
					 window.location.href='jump/tojsp.do?target='+ data;
					// document.write(data);
				 }else if(data == "show"){
					 $("#loginErrorMsg").text("用户名密码不正确");
				 }else if(data == "noLogin"){
					 $("#loginErrorMsg").text("用户被限制，请联系管理员");
				 }else if(data!=null){
					 user = data;
					 $("#user").text(data);
					 $("#longinSysUserModal").modal("hide");
					 $("#loginBtn").prop("hidden",true);
					 $("#registBtn").prop("hidden",true);
					 $("#userBtn").removeProp("hidden");
					 
					 $("#objectModal").removeProp("hidden");
				 }
			}
		 }); 
		
		
 } 
</script>

</head>
<body>
<input hidden="hidden" id="aaaaa" value="<%= session.getAttribute("loginUser")%>">
	<!-- 登录模态窗口 -->
	<div class="modal fade" id="longinSysUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 50%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<div style="position: relative;left: 45%;" class="modal-title"><h4><span style="color: blue;">欢迎登录</span></h4></div>
				</div>
				<div class="modal-body">
					<form id="loginSysUserForm" class="form-horizontal" role="form" method="post">
						<div class="form-group">
							<label for="userName" class="col-sm-2 control-label"><span style="position: relative;width: 100%;left: 0%; color: royalblue;">用户名</span></label>
							<div class="col-sm-10">
							<input type="text" class="form-control" id="userName" style="position:relative;left:0%;width: 100%;" placeholder="请输入用户名,不能为空">
							<span id="userNameErrorMsg" style="color: red;font-size: 12px"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="passWord" class="col-sm-2 control-label"><span style="position: relative;width: 100%;left: 0%; color: royalblue;">密&nbsp;&nbsp;&nbsp;&nbsp;码</span></label>
							<div class="col-sm-10">
								<input class="form-control" type="password" id="passWord" style="position:relative;left:0%;width: 100%;" placeholder="请输入密码,不能为空">
								<span id="passWordErrorMsg" style="color: red;font-size: 12px"></span>
							</div>
						</div>
						
						<div class="form-group">
							<div class="radio" style="position:relative;left: 33%;width: 100%;">
                    			<label>
          							<input name="sysOrUser" type="radio" id="radio1" value="1"> 管理员
      						    </label>
      						    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<label>
        							<input name="sysOrUser" type="radio" id="radio2" value="0"> 用&nbsp;&nbsp;&nbsp;&nbsp;户
    						    </label>
    						</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="loginSysUserBtn">登录</button> <!--data-dismiss="modal"--> 
					&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closeBtn" >取消</button>
				</div>
				<div style="text-align: center;">
				<span id="loginErrorMsg" style="color: red;font-size: 12px;" ></span>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改密码的模态窗口 -->
	<div class="modal fade" id="editPwdModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 70%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title"><span style="position: relative;left: 40%;font-size:large;color: deepskyblue;">修改密码</span></h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="editPwdModalForm">
						<div class="form-group">
							<label for="oldPwd" class="col-sm-2 control-label">原&nbsp;&nbsp;密&nbsp;&nbsp;码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" onblur="blurOldPwd()" onfocus="focusOldPwd()" class="form-control" id="oldPwd" style="width: 200%;">
								<span id="oldPwdErrorMsg" style="color: red;font-size: 12px;" ></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="newPwd" class="col-sm-2 control-label">新&nbsp;&nbsp;密&nbsp;&nbsp;码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" onblur="blurNewPwd()" onfocus="focusNewPwd()" type="text" class="form-control" id="newPwd" style="width: 200%;">
								<span id="newPwdErrorMsg" style="color: red;font-size: 12px;" ></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" onblur="blurConfirmPwd()" onfocus="focusConfirmPwd()" type="text" class="form-control" id="confirmPwd" style="width: 200%;">
								<span id="confirmPwdErrorMsg" style="color: red;font-size: 12px;" ></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<span id="pwdErrorMsg" style="color: red;font-size: 12px;" ></span>
					<button type="button" style="position:relative;left:-20%;width: 30%;" class="btn btn-primary" data-dismiss="modal" id="savePwdBtn" onclick="savePwdBtn()">更新</button>
					<button type="button" style="position:relative;left:-15%;width: 30%; color: red;" class="btn btn-default" data-dismiss="modal" id="closeEditBtn" onclick="closeEditBtn()">取消</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 用户资料的模态窗口 -->
	<div class="modal fade" id="updateUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">我的资料</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="userMsgForm">
					
						<div class="form-group">
							<label for="create-loginActNo" class="col-sm-2 control-label">用&nbsp;&nbsp;户&nbsp;&nbsp;名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="userMsgUserName"  onblur="bluruserMsgUserName()" onfocus="focususerMsgUserName()">
								<span id="userMsgUserNameErrorMsg" style="color: red; font-size: 12px;"></span>
							</div>
							<label for="create-username" class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="name" onblur="blurName()" onfocus="focusName()">
								<span id="nameErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="sex" >
		      						<option></option>
		      						<option value="1">男</option>
		      						<option value="0">女</option>
		    					</select>
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="age" onblur="blurAge()" onfocus="focusAge()">
								<span id="ageErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">手&nbsp;&nbsp;机&nbsp;&nbsp;号</label>
							<div class="col-sm-10" style="width: 300px;">
								<input onblur="blurPhone()" onfocus="focusPhone()" type="text" class="form-control" id="phone">
								<span id="phoneErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input onblur="blurEmail()" onfocus="focusEmail()" type="text" class="form-control" id="email">
								<span id="emailErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">省&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份</label>
							<div class="col-sm-10" style="width: 300px;">
								<select onchange="changeProvinceCode()" class="form-control" id="provinceCode">
		  					    	<option></option>
		  					    	<option>云南省</option>
		  					    	<option>四川省</option>
		  					    	<option>宁夏回族自治区</option>
		 					     </select>
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市</label>
							<div class="col-sm-10" style="width: 300px;">
								<select onchange="changeCityCode()" class="form-control" id="cityCode">
		      						<option></option>
		     					 	<option>云南省</option>
		     					 	<option>四川省</option>
		     					 	<option>宁夏回族自治区</option>
		    					</select>
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">详细地址</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="address" onblur="blurAddress()" onfocus="focusAddress()">
								<span id="addressErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<span id="ErrorMsg" style="color: red;font-size: 12px;"></span>
					<button type="button" style="position:relative;left:-25%;width: 30%;" class="btn btn-primary" data-dismiss="modal" onclick="saveChangeUser()">更新</button>
					<button type="button" style="position:relative;left:-15%;width: 30%; color: red;" class="btn btn-default" data-dismiss="modal" onclick="closeUserMsg()">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 物品发布的模态窗口 -->
	<div class="modal fade" id="createObjModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">物品信息填写</h4>
				</div>
				<div class="modal-body">
				
					<form action="user/savecreateObjModal.do" target="frameName" method="POST" enctype="multipart/form-data" class="form-horizontal" role="form" id="tradingObjectForm" name="tradingObjectForm">
						<div class="form-group">
							<label for="create-loginActNo" class="col-sm-2 control-label">交易类型<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="tradingTypeTode" name="tradingTypeTode" onchange="changetradingTypeTode()" >
		      						<option></option>
		      						<option value="">交易品</option>
		      						<option>赠予品</option>
		      						<option>交换品</option>
		    					</select>
							</div>
							<label for="create-username" class="col-sm-2 control-label">物品类型<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="parObjectCode" name="parObjectCode" >
		      						<option></option>
		      						<option value="" objectCode="">手机</option>
		      						<option>笔记本</option>
		      						<option>耳机</option>
		    					</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-loginActNo" class="col-sm-2 control-label">物品名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="objectName" name="objectName" onblur="blurobjectName()" onfocus="focusobjectName()">
								<span id="objectNameErrorMsg" name="objectNameErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
							<label for="create-username" class="col-sm-2 control-label">原&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="originalPrince"  name="originalPrince1" onblur="bluroriginalPrince()" onfocus="focusoriginalPrince()">
								<span id="originalPrinceErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="create-loginPwd" class="col-sm-2 control-label">售&nbsp;&nbsp;卖&nbsp;&nbsp;价<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="salePrice" name="salePrice1" onblur="blursalePrice()" onfocus="focussalePrice()">
								<span id="salePriceErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
							<label for="create-confirmPwd" class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;费<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="postage" name="postage1" onblur="blurpostage()" onfocus="focuspostage()">
								<span id="postageErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="CityCode" name="citycode">
		      						<option></option>
		      						<option value="" provincecode="">昆明</option>
		      						<option>成都</option>
		    					</select>
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">详细地址</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="objectAddress" name="objectAddress" onblur="blurobjectAddress()" onfocus="focusobjectAddress()">
								<span id="objectAddressErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">物品描述</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="textDescri" name="textDescri">
								<span id="textDescriErrorMsg"  style="color: red;font-size: 12px;"></span>
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">物品图片</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="file" class="form-control" id="pictureFile" name="pictureFile" multiple="multiple"/>
							</div>
						</div>
						<div class="form-group">
							<label for="create-org" class="col-sm-2 control-label">其他说明</label>
                            <div class="col-sm-10" style="width: 300px;">
                            	<input type="text" class="form-control" id="msg" name="msg" />
                            	<span id="msgErrorMsg" value="" style="color: red;font-size: 12px;"></span>
							</div>
							<div id="divwantTradTypeCode" hidden="hidden" >
							<label for="create-org" class="col-sm-2 control-label">想要交换的物品类型</label>
                            <div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="wantTradTypeCode" name="wantTradTypeCode" >
		      						<option></option>
		      						<option value="" objectType="">手机</option>
		      						<option>笔记本</option>
		      						<option>耳机</option>
		    					</select>
							</div>
							</div>
						</div>
						<div class="form-group" hidden="hidden">
							<label for="create-org" class="col-sm-2 control-label">发布时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="releaseTime" name="releaseTime">
                            </div>
						</div>
						<div hidden="hidden">
						<input type="text" class="form-control" id="objectUserName" name="objectUserName">
						</div>
						<div class="modal-footer">
				<!-- onclick="savecreateObjModal()" -->
					<button type="submit" style="position:relative;left:-25%;width: 30%;" onmouseover="mouseoverGetUserName()" >立即发布</button>
					<button type="button" style="position:relative;left:-15%;width: 30%; color: red;" onclick="closecreateObjModal()">取消</button>
				</div>
					</form>
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
					<button type="button" class="btn btn-primary" onclick="window.location.href='jump/toIndex.do?';">确定</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 顶部 -->
	<div id="top" style="position:absolute;top:0px; height: 55px; background-color: #96FED1; width: 100%;">
		<div style="position: absolute; top: 15px; left: 15x; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">GAGE闲置</div>
			<div class="form-group">
			  	 <div style="position: absolute; top: 25px; left: 160px;font-size: 15px; font-weight: 200; color: red;font-family: 'times new roman'" class="input-group" class="input-group-addon">
					交易类型
				</div>
				<div style="position: absolute; top: 24px;width: 200px; left: 225px;font-size: 15px; font-weight: 300; color: red;font-family: 'times new roman'" class="input-group">
					<select style="color: red;">
						<option>全部</option>
						<option>售卖</option>
						<option>赠予dfghjk</option>
						<option>交换</option>
					</select>
				</div>
			</div>
		<div id="objectModal" hidden="hidden" style="position: absolute; top: 24px; right:280px;font-size: 15px; font-weight: 300; color: red;font-family: 'times new roman'">
			<a id="objectModal" onclick="clickObjectModal()">
				<span style="color: red;" class="glyphicon glyphicon-pencil">物品发布</span>
			</a>
		</div>
		
		<div style="position: absolute; top: 24px; right: 210px;font-size: 15px; font-weight: 300; color: red;font-family: 'times new roman'">
			<a id="toShopping" ><span style="color: red;" class="glyphicon glyphicon-shopping-cart">购物车</span></a>
		</div>
		
		<div style="position: absolute; top: 24px; right: 150px;font-size: 15px; font-weight: 300; color: red;font-family: 'times new roman'">
			<a href=""><span class="glyphicon glyphicon-envelope"></span><span style="color: red;">消息</span></a>
		</div>
		
		<div id="loginBtn" style="position: absolute; top: 25px; right: 80px;font-size: 15px; font-weight: 300; color: red;font-family: 'times new roman'">
			<a><span id="indexLoginBtn" class="glyphicon glyphicon-user"> 登录</span></a>
		</div>
		<div id="registBtn" style="position: absolute; top: 25px; right: 30px;font-size: 15px; font-weight: 300; color: red;font-family: 'times new roman'">
			<a href="${pageContext.request.contextPath}/jump/toRegister.do"><span class="glyphicon glyphicon-register">注册</span></a>
		</div>
		
		<div id="userBtn" hidden="hidden" style="position: absolute; top: 23px; right: 30px;">
			<ul>
				<li  class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: blue;" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span><span id="user"> </span><span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a id="toObjectMsg"><span class="glyphicon glyphicon-file"></span> 发布信息</a></li>
						<li><a id="myComment"><span class="glyphicon glyphicon-file"></span> 评论信息</a></li>
						<li><a id="myOrder"><span class="glyphicon glyphicon-file"></span> 我的订单</a></li>
						<li><a onclick="userMsg()"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
						<li><a onclick="editPwd()" ><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
						<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;出</a></li>
					</ul>
				</li>
			</ul>
		</div>
</div>   
	
	 <!--物品分类-->
			<div style="position: absolute;top: 56px;left:1%; width: 9%; text-align: center;height: 400px;background-color: black;">
				<ul id="objectType" class="nav nav-pills nav-stacked">
					<c:if test="${empty oList }">
						<li><span style="color: red;">请刷新</span></li>
					</c:if>
					<c:if test="${!empty oList }">
						<c:forEach items="${oList }" var="o" varStatus="vs">
							<li class="dpdown" id="dropdown">
							<a class="id" href="${pageContext.request.contextPath}/jump/toObjectList.do?objectCode=${o.objectCode}" data-toggle="dropdown">
				     		 ${o.objectName }</a>
				        		<ul class="dropdown-menu">
				        		<c:forEach items="${pList }" var="p" varStatus="vs">
					        		<c:if test="${o.objectCode == p.objectTypeCode }">
					        			<li><a href="${pageContext.request.contextPath}/jump/toObjectList.do?parObjectTypeCode=${p.parObjectTypeCode}">${p.parObjectTypeName }</a></li>
					        		</c:if>
				        		</c:forEach>
				        		</ul>
							</li> 
						</c:forEach>
					</c:if>
					<!-- <li class="liClass"><a href="release/show.html" target="workareaFrame" style="color: red;"><span class="glyphicon glyphicon-home"></span>热门</a></li>
					<li class="liClass"><a href="release/show.html" target="workareaFrame"><span class="glyphicon glyphicon-tag"></span>手机数码</a></li>
					<li class="liClass"><a href="release/show.html" target="workareaFrame"><span class="glyphicon glyphicon-search"></span>生活用品</a></li>
					<li class="liClass"><a href="release/show.html" target="workareaFrame"><span class="glyphicon glyphicon-user"></span>运动设备</a></li>
					<li class="liClass"><a href="release/show.html" target="workareaFrame"><span class="glyphicon glyphicon-phone-alt"></span>家电</a></li>
					<li class="dropdown" id="dropdown">
					<a href="blogPage.action?type_id=1003" data-toggle="dropdown" onclick="jump('1003')">
				     	 数据库</a>
				        <ul class="dropdown-menu">
				        	<li><a href="#">MySQL</a></li>
				            <li><a href="#">SQL Server</a></li>
				            <li><a href="#">Oracle</a></li>
				        </ul>
					</li>  -->
					</ul>
				</div>
				
	<div id="lunbotu" style="position: relative;top: 56px;left: 11%; width: 69%;">
		<!--轮播图-->
		<div id=""show>
			<div id="myCarousel" class="carousel slide" style="position: relative;left:0%; width: 100%;">
			<!-- 轮播（Carousel）指标 -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" ></li>
				<li data-target="#myCarousel" data-slide-to="1" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
				<li data-target="#myCarousel" data-slide-to="4"></li>
			</ol>   
			<!-- 轮播（Carousel）项目 -->
			<div class="carousel-inner">
				<div class="item active">
					<img src="img/1.jpg" alt="First slide" style="width:100%;height: 400px;">
				</div>
				<div class="item">
					<img src="img/6.jpg" alt="Second slide" style="width:100%;height: 400px;">
				</div>
				<div class="item">
					<img src="img/11.jpg" alt="Third slide" style="width:100%;height: 400px;">
				</div>
				<div class="item">
					<img src="img/12.jpg" alt="fourth slide" style="width:100%;height: 400px;">
				</div>
				<div class="item">
					<img src="img/15.jpg" alt="fifth slide" style="width:100%;height: 400px;">
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
		</div>
	</div>
	<div id="lunbotu" style="position: absolute;top: 56px;left: 81%; width: 18%;">
			<img src="img/2.jpg" alt="" style="width:100%;height: 199px;">
	</div>
	<div id="lunbotu" style="position: absolute;top: 257px;left: 81%; width: 18%;">
			<img src="img/5.jpg" alt="" style="width:100%;height: 199px;">
	</div>
	<div id="aaaa" style="position: relative;top: 30px;left: 0%; width: 100%;text-align: center;">
		<img src="img/a.png" alt="" style="width:150px;height: 50px;">
	</div>	
	<div style="position: relative;top: 40px;left: 2%; width: 100%;">
			<img src="img/b.png" alt="" style="width:24%;height: 80%;">
			<img src="img/c.png" alt="" style="width:24%;height: 80%;">
			<img src="img/d.png" alt="" style="width:24%;height: 80%;">
			<img src="img/e.png" alt="" style="width:24%;height: 80%;">
	</div>
	<div style="position: relative;top: 50px;left: 0%; width: 100%;text-align: center;">
		<img src="img/f.png" alt="" style="width:150px;height: 50px;">
	</div>
	
	<div id="object1" style="position: relative;top: 55px; bottom: 30px; left: 1%;width: 50%;">
		
		
	</div>
	
	<!-- 中间 -->
	<div id="center" style="position:relative;top: 55px; bottom: 30px; left: 0px; right: 0px;">
	
		<div style="position:relative; top:0px;align: center">
		<ul style="text-align: center;">
			<c:if test="${empty tList }">
				<div style="width: 100%"><span style="color: red;">暂无用户上传物品</span></div>
			</c:if>
			<c:if test="${not empty tList}">
				<c:forEach items="${tList}" var="o" varStatus="vs">
					<li class="goods-panel">
							<a class="a" href="${pageContext.request.contextPath }/jump/toObject.do?objectCode=${o.objectCode}" display="block">
								<img src="${pageContext.request.contextPath }/${o.pictureDescri}" width="200" height="200" title="点击查看物品详细信息" /><br/>
								<span>${o.objectName }</span><br/>
								<span>${o.textDescri }</span><br/>
								<span class="goods-price--grey"><span>售价:<i>￥</i>${o.salePrice }元</span></span><br/>
							</a>
						</li>
				</c:forEach>
			</c:if>		
		</ul>
	</div>
	<div style="position: relative;top:5px;"></div>
		<div style="position: relative;top:20px;left: 0.5%;">
			<img src="img/two.jpg" alt="加载出错" style="width: 100%;height: 100px;">
			<img src="img/foot1.jpg" alt="加载出错" style="width: 100%;height: 100px;">
		</div>
		<div style="position: relative;top:20px;text-align: center;">
			<span style="color:grey;font-style: oblique;font-family: 'bookshelf symbol 7';">辽宁工程技术大学</span>
			<span style="color: cornflowerblue;font-style: oblique;font-family: 'bookshelf symbol 7';">@GAGE</span>
		</div>
		<div style="position: relative;top:20px;text-align: center;background-color: black;">
			<div><span style="text-align: center;color: red;">
				联系方式|18242989732|QQ|2467650258|weixin|GAGE 
			</span></div>
			<div><span style="text-align: center;color: red;">
				所有解释权归GAGE所有|其他人不得抄袭|©201905-201906 gage.com版权所有
			</span></div>
		</div>
	</div>
	
	<iframe src="${pageContext.request.contextPath }/jump/tojsp.do?target=show" frameborder="0" id="frameName" name="frameName" style="display: none;"></iframe>
</body>
</html>
