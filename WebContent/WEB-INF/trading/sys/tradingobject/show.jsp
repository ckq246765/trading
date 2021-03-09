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

<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery.bs_pagination.min.css"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/localization/en.js"></script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GaGe交易平台</title>
<style type="text/css">
table{
	align="center";
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
</style>
<script type="text/javascript">
$(document).ready(function(){
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
	
	var recordTotal = 0; 	 //记录条数
	var pageSize = 2;  		//每页显示记录数
	var pageTotal = 0;		//总页数
	var pageNo = 1;		//当前默认第一页
	getAllObject(pageNo,pageSize);
	function getAllObject(pageNo,pageSize) {
		$("#tBody").html("");
		$.post(
				"sys/tradingobject/getAllUserTradingObject.do",
				{
					"pageNo":pageNo,
					"pageSize":pageSize,
					"_":new Date().getTime()
				},
				function (data) {
					recordTotal = data.page.recordTotal; 	 
					pageSize = data.page.pageSize;  		
					pageTotal = data.page.pageTotal;
					pageNo = data.page.pageNo;		
					
					var html = "";
					$(data.tList).each(function(i,n){
						html += '<tr>';
						html += '<td><a href="${pageContext.request.contextPath }/sys/user/toUserMsg.do?userCode='+n.objectUserCode+'">'+n.objectUserName+'</a></td>';
						html += '<td><a href="${pageContext.request.contextPath }/sys/tradingobject/toTradingObjectMsg.do?objectCode='+n.objectCode+'">'+n.objectName+'</a></td>';
						html += '<td><a href="${pageContext.request.contextPath }/sys/tradingobject/toTradingObjectMsg.do?objectCode='+n.objectCode+'">'+n.textDescri+'</a></td>';
						html += '<td><a href="${pageContext.request.contextPath }/sys/tradingobject/toTradingObjectMsg.do?objectCode='+n.objectCode+'">'+n.msg+'</a></td>';
						html += '<td><a href="${pageContext.request.contextPath }/sys/tradingobject/toTradingObjectMsg.do?objectCode='+n.objectCode+'"><img src="${pageContext.request.contextPath }/'+n.pictureDescri+'" width="50" height="50" title="点击查看物品详细信息" /></a></td>';
						html += '<td>'+n.tradingTypeName+'</td>';
						html += '<td>'+n.parObjectName+'</td>';
						html += '<td class="id"><input class="del" type="button" objectCode="'+n.objectCode+'" value="删除"></td>';
						html += '</tr>';
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
							  getAllObject(data.currentPage,data.rowsPerPage);
						  }
						});
				});
	}
	 
	$("#tBody").on("click","td input[class='del']",{text:"确定要删除吗？"},function(event){
		var objectCode = $(this).attr("objectCode");
		if(confirm(event.data.text)){
			$.post(
				"sys/tradingobject/deleteObject.do",
				{
					"objectCode":objectCode
				},
				function (data) {
					if(data=="true"){
						getAllObject(pageNo,pageSize);
						success_prompt("删除成功",1500);
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
	<table class="table table-hover">
		<thead>
			<tr>
				<th>用户名</th>
				<th>物品名称</th>
				<th>物品描述</th>
				<th>其他说明</th>
				<th>物品图片</th>
				<th>交易类型</th>
				<th>物品类型</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="tBody">
			
		</tbody>
	</table>
	<div id="mypagination" ></div>
	</div>
</body>
</html>