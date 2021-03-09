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

<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery.bs_pagination.min.css"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/localization/en.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/bootstrap-datetimepicker-master/js/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GaGe交易平台</title>
<style type="text/css">
table{
	align:center;
	width: 100%;
	height: 100%;
	word-break:break-all; 
	word-wrap:break-all;
}
table th{
	text-align: center;
	color: red;
}
table td{
	 text-align: center;
}
a:link {
	text-decoration: none;
}
table span {
	color: blue;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	
	var recordTotal = 0; 	 //记录条数
	var pageSize = 2;  		//每页显示记录数
	var pageTotal = 0;		//总页数
	var pageNo = 1;		//当前默认第一页
	
	getAllUser(1,2);
	
	//绑定时间
	$(".time").datetimepicker({
		  language: 'zh-CN',//显示中文
		  format: 'yyyy-mm-dd hh:ii:ss',
		  //format: 'yyyy-mm-dd',//显示格式
		  minView: "hour",//设置只显示到小时
		  //minView: "month",//设置只显示到月份
		  initialDate: new Date(),//初始化当前日期
		  autoclose: true,//选中自动关闭
		  todayBtn: true,//显示今日按钮
		  clearBtn: true//显示清除按钮
		 });
	$("#sAge").blur(function () {
		if($.trim($("#age").val()) != ""){
			var regExp = /^[1-9]\d*|0$/;
			var ok = regExp.test($.trim($("#age").val()));
			if (!ok) {
				$("#sAgeErrorMsg").text("年龄输入格式不正确");
			}
		}
	});
	$("#sAge").focus(function () {
		if($.trim($("#sAgeErrorMsg").text())!=""){
			$("#sAgeErrorMsg").text("");
		}
	});
	$("#sPhone").blur(function () {
		if($.trim($("#sPhone").val()) != ""){
			var regExp = /^(\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$/;
			var ok = regExp.test($.trim($(this).val()));
			if (!ok) {
				$("#sPhoneErrorMsg").text("手机号码输入格式不正确");
			}
		}
	});
	$("#sPhone").focus(function () {
		if($("#sPhoneErrorMsg").text()!=""){
			$("#sPhoneErrorMsg").text("");
		}
	});
	$("#sEmail").blur(function () {
		if($.trim($("#sEmail").val()) != ""){
			var regExp = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
			var ok = regExp.test($.trim($("#email").val()));
			if (!ok) {
				$("#sEmailErrorMsg").text("邮箱输入不正确");
			}
		}
	});
	$("#sEmail").focus(function () {
		if($("#sEmailErrorMsg").text() !=""){
			$("#sEmailErrorMsg").text("");
		}
	});
	$("#searchBtn").click(function () {
		if($("#sAgeErrorMsg").text() == ""
				&& $("#sPhoneErrorMsg").text() == ""
				&& $("#sEmailErrorMsg").text() == ""){
			
			$("#sUserName1").val($.trim($("#sUserName").val()));
			$("#sName1").val($.trim($("#sName").val()));
			$("#sSex1").val($("#sSex option:selected").val());
			$("#sAge1").val($.trim($("#sAge").val()));
			$("#sPhone1").val($.trim($("#sPhone").val()));
			$("#sEmail1").val( $.trim($("#sEmail").val()));
			$("#sProvince1").val($("#sProvince option:selected").val());
			$("#sCity1").val($("#sCity option:selected").val());
			$("#sAdress1").val($.trim($("#sAdress").val()));
			$("#startTime1").val($("#startTime").val());
			$("#endTime1").val($("#endTime").val());
			getAllUser(1,$("#mypagination").bs_pagination('getOption' , 'rowsPerPage'));
			 }else{
			$("#errorMsg").text("请检查填写信息项是否有错误");
		}
	});
	//delegate为每一个dom对象添加
	$("tbody").delegate("tr td .changeState","click",function () {
		var state = $(this).attr("state");
		var str = "";
		var userCode = $(this).parent().parent().children("td").children(".aaa").attr("userCode");
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
					"userCode":userCode,
					"state":state
				},
				function (data) {
					if(data == "1"){
						getAllUser($("#mypagination").bs_pagination('getOption', 'currentPage'),$("#mypagination").bs_pagination('getOption', 'rowsPerPage'));
					}else{
						alert("修改失败，请重试");
					}
				});
		}
	})
});

function getAllUser(pageNo,pageSize) {
	$("#tBody").html("");
	$.ajax({
			url:"sys/user/getAllUser.do",
			type:"post",
			cache : false,
			async: false,
			data:{
				"pageNo":pageNo,
				"pageSize":pageSize,
				"userName":$.trim($("#sUserName1").val()),
				"name":$.trim($("#sName1").val()),
				"sex":$.trim($("#sSex1").val()),
				"age":$.trim($("#sAge1").val()),
				"phone":$.trim($("#sPhone1").val()),
				"email":$.trim($("#sEmail1").val()),
				"province":$.trim($("#sProvince1").val()),
				"city":$.trim($("#sCity1").val()),
				"adress":$.trim($("#sAdress1").val()),
				"startTime":$.trim($("#startTime1").val()),
				"endTime":$.trim($("#endTime1").val()),
				"_":new Date().getTime()
			},
			success : function (data) {
				recordTotal = data.page.recordTotal; 	 
				pageSize = data.page.pageSize;  		
				pageTotal = data.page.pageTotal;
				pageNo = data.page.pageNo;		
				var str="";
				var html = "";
				$(data.uList).each(function(i,n){
					html += '<tr>';
					html += '<td><a href="${pageContext.request.contextPath }/sys/user/toUserMsg.do?userCode='+n.user_code+'" class="aaa" userCode="'+n.user_code+'">'+n.userName+'</a></td>';
					html += '<td><a href="${pageContext.request.contextPath }/sys/user/toUserMsg.do?userCode='+n.user_code+'">'+n.name+'</a></th>';
					html += '<td>'+n.regDate+'</td>';
					if(n.state == 1){str="激活";}else{str="限制";}
					html += '<td><span class="changeState" state="'+n.state+'">'+str+'</span></td>';
					html +='</tr>';
				});
				$("#tBody").html(html);
				//分页
				$("#mypagination").bs_pagination({
					  // your options here - see below or code examples
					 currentPage: pageNo,
					 rowsPerPage: pageSize,
					 maxRowsPerPage: recordTotal,
					 totalPages: pageTotal,
					 totalRows: 0,
					 
					 visiblePageLinks: 5,
					 
					 showGoToPage: true,
					 showRowsPerPage: true,
					 showRowsInfo: true,
					 showRowsDefaultInfo: false,
					});
				$("#mypagination").bs_pagination({
					  onChangePage: function(event, data) {
						  getAllUser(data.currentPage,data.rowsPerPage);
					  }
					});
			},
			dataType : "json"
			});
	
}
</script>
</head>
<body>

	<!-- 创建用户的模态窗口 -->
	<div class="modal fade" id="createUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增用户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-loginActNo" class="col-sm-2 control-label">用&nbsp;&nbsp;户&nbsp;&nbsp;名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-loginActNo">
							</div>
							<label for="create-username" class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-username">
							</div>
						</div>
						<div class="form-group">
							<label for="create-loginPwd" class="col-sm-2 control-label">登录密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="create-loginPwd">
							</div>
							<label for="create-confirmPwd" class="col-sm-2 control-label">确认密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="create-confirmPwd">
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-dept" >
		      						<option></option>
		      						<option>男</option>
		      						<option>女</option>
		    					</select>
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-expireTime">
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">手&nbsp;&nbsp;机&nbsp;&nbsp;号</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-expireTime">
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">省&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-dept">
		  					    	<option></option>
		  					    	<option>云南省</option>
		  					    	<option>四川省</option>
		  					    	<option>宁夏回族自治区</option>
		 					     </select>
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-dept">
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
								<input type="text" class="form-control" id="create-email">
							</div>
							<label for="create-lockStatus" class="col-sm-2 control-label">用户状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-lockStatus">
								  <option></option>
								  <option>启用</option>
								  <option>锁定</option>
								</select>
							</div>
						</div>
						<div class="form-group" hidden="hidden">
							<label for="create-org" class="col-sm-2 control-label">注册时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-email">
                            </div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" style="position:relative;left:-25%;width: 30%;" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='../login.html';">注册</button>
					<button type="button" style="position:relative;left:-15%;width: 30%; color: red;" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>用户列表</h3>
			</div>
		</div>
	</div>
	
	<div class="btn-toolbar" role="toolbar" style="position: relative; height: 80px; left: 30px; top: -10px;">
		<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">用&nbsp;户&nbsp;名</div>
		      <input hidden="hidden" type="text" id="sUserName1" />
		      <!-- text-center居中 -->
		      <input class="form-control" type="text" id="sUserName" />
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">姓&nbsp;&nbsp;名</div>
		      <input hidden="hidden" type="text" id="sName1" />
		      <input class="form-control" type="text" id="sName" />
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group" style="width: 240px;">
		      <div class="input-group-addon">性&nbsp;&nbsp;别</div>
		      <select hidden="hidden" id="sSex1">
		      	<option value=""></option>
		      	<option value="1">男</option>
		      	<option value="0">女</option>
		      </select>
		      <select class="form-control" id="sSex" >
		      	<option value=""></option>
		      	<option value="1">男</option>
		      	<option value="0">女</option>
		      </select>
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">年&nbsp;&nbsp;龄</div>
		      <input hidden="hidden" type="text" id="sAge1" />
		      <input class="form-control" type="text" id="sAge" />
		      <span id="sAgeErrorMsg" style="color: red;font-size: 12px;" ></span>
		    </div>
		  </div>
		 <br><br>
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">手&nbsp;机&nbsp;号</div>
		      <input hidden="hidden" type="text" id="sPhone1" />
		      <input class="form-control" type="text" id="sPhone" />
		      <span id="sPhoneErrorMsg" style="color: red;font-size: 12px;" ></span>
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">邮&nbsp;&nbsp;箱</div>
		      <input hidden="hidden" type="text" id="sEmail1" />
		      <input class="form-control" type="text" id="sEmail" />
		      <span id="sEmailErrorMsg" style="color: red;font-size: 12px;" ></span>
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group" style="width: 240px;">
		      <div class="input-group-addon">省&nbsp;&nbsp;份</div>
		      <input hidden="hidden" type="text" id="sProvince1" />
		      <select class="form-control" id="sProvince" >
		      	<option value=""></option>
		      	<c:forEach items="${pList }" var="p">
			      	<option value="${p.provinceCode }">${p.provinceName }</option>
		      	</c:forEach>
		      </select>
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group" style="width: 240px;">
		      <div class="input-group-addon">城&nbsp;&nbsp;市</div>
		       <input hidden="hidden" type="text" id="sCity1" />
		      <select class="form-control" style="width: 180px;" id="sCity">
		      	<option value=""></option>
		      	<c:forEach items="${cList }" var="c">
			      	<option value="${c.cityCode }">${c.cityName }</option>
		      	</c:forEach>
		      </select>
		    </div>
		  </div>
		  <br><br>
		  <div class="form-group" style="width: 260px;">
		    <div class="input-group">
		      <div class="input-group-addon">详细地址</div>
		      <input hidden="hidden" type="text" id="sAdress" />
		      <input class="form-control" type="text" id="sAdress" />
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">注册时间</div>
			  <input hidden="hidden" type="text" id="startTime1" />
			  <input class="form-control time" type="text" id="startTime" />
		    </div>
		  </div>
		  ~
		  <div class="form-group">
		    <div class="input-group">
			  <input hidden="hidden" type="text" id="endTime1" />
			  <input class="form-control time" type="text" id="endTime" />
		    </div>
		  </div>
		  <button style="width: 70px;height: 35px;" type="button" class="btn btn-default " title="查询" id="searchBtn"><span class="glyphicon glyphicon-search" style="color:red;"></span></button>
		  <span id="errorMsg" style="color: red;font-size: 12px;" ></span>
		</form>
	</div>
	
	
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; width: 110%; top: 70px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createUserModal">
			<span class="glyphicon glyphicon-plus"></span> 创建
		</button>
		<button type="button" class="btn btn-danger">
			<span class="glyphicon glyphicon-minus"></span> 删除
		</button>
		</div>
		<div class="btn-group" style="position: relative; top: 18%; left: 5px;">
			<button type="button" class="btn btn-default">设置显示字段</button>
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				<span class="caret"></span><span style="color: red;font-family: 'bookshelf symbol 7';">请选择</span>
				<span class="sr-only">Toggle Dropdown</span>
			</button>
			<ul id="definedColumns" class="dropdown-menu" role="menu"> 
				<li><a href="javascript:void(0);"><input type="checkbox"/> 用户名</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 姓名</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 性别</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 年龄</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 手机号</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 邮箱</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 省份</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 城市</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 地址详细</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 注册时间</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 用户状态</a></li>
			</ul>
		</div>
	</div>
	
	<div style="position: relative; left: 30px; top: 80px; width: 100%">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>用户名</th>
					<th>姓名</th>
					<th>注册时间</th>
					<th>用户状态</th>
				</tr>
			</thead>
			<tbody id="tBody">
			
			</tbody>
		</table>
	</div>
	
	<div style="height: 50px; position: relative;top: 80px;">
		<div id="mypagination" ></div>
	</div>
			
</body>
</html>