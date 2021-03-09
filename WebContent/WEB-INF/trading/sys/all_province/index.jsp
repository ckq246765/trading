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
<style type="text/css">
	th{text-align: center;}
	table{
		background: url("img/1234.jpg");
	}
</style>
<script type="text/javascript">
	$(function () {
		//加载数据
		var recordTotal = 0; 	 //记录条数
		var pageSize = 10;  		//每页显示记录数
		var pageTotal = 0;		//总页数
		var pageNo = 1;		//当前默认第一页
		getAllProvince();
		function getAllProvince() {
			$("#tBody").html("");
			$.post(
					"sys/all_province/index.do",
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
						
						$("#recordTotal").html(recordTotal);
						$("#pageSize").html(pageSize);
						$("#pageTotal").html(pageTotal);
						$("#pageNo").html(pageNo);
						
						var html = "";
						$(data.pList).each(function(i,n){
							html += "<tr class='aa'>";
							html += "<td><input type='checkbox' class='bb' name='pcode' value='"+n.provinceCode+"' /></td>";
							html += "<td>"+((i+1)+(pageNo-1)*pageSize)+"</td>";
							html += "<td name='Code'>"+n.provinceCode+"</td>";
							html += "<td name='Name'>"+n.provinceName+"</td>";
							html += "</tr>";
						});
						$("#tBody").html(html);
					}
					);
		}
		
		$("#firstPage").hover(function () {
			if(pageNo == 1){
				$("#lifirstPage").addClass("disabled");
			}else{
				$("#lifirstPage").removeClass("disabled");
			}
		});
		//点击首页
		$("#firstPage").click(function () {
			if(pageNo == 1){
				$("#lifirstPage").addClass("disabled");
				return false;
			}else{
				$("#lifirstPage").removeClass("disabled");
				$("#nextPage").removeClass("disabled");
				$("#lastPage").removeClass("disabled");
				pageNo = 1;
				getAllProvince();
				$("#allStates").prop('checked',false);
			}
		});
		$("#proPage").hover(function () {
			if(pageNo == 1){
				$("#liproPage").addClass("disabled");
			}else{
				$("#liproPage").removeClass("disabled");
			}
		});
		//点击上一页
		$("#proPage").click(function () {
			if(pageNo == 1){
				$("#proPage").addClass("disabled");
				return false;
			}else{
				$("#proPage").removeClass("disabled");
				$("#nextPage").removeClass("disabled");
				$("#lastPage").removeClass("disabled");
				pageNo--;
				getAllProvince();
				$("#allStates").prop('checked',false);
			}
		});
		$("#nextPage").hover(function () {
			if(pageNo == pageTotal){
				$("#linextPage").addClass("disabled");
			}else{
				$("#linextPage").removeClass("disabled");
			}
		});
		//点击下一页
		$("#nextPage").click(function () {
			if(pageNo == pageTotal){
				$("#nextPage").addClass("disabled");
				return false;
			}else{
				$("#nextPage").removeClass("disabled");
				$("#lastPage").removeClass("disabled");
				$("#lifirstPage").removeClass("disabled");
				$("#proPage").removeClass("disabled");
				pageNo++;
				getAllProvince();
				$("#allStates").prop('checked',false);
			}
		});
		$("#lastPage").hover(function () {
			if(pageNo == pageTotal){
				$("#lilastPage").addClass("disabled");
			}else{
				$("#lilastPage").removeClass("disabled");
			}
		});
		//点击尾页
		$("#lastPage").click(function () {
			if(pageNo == pageTotal){
				$("#lastPage").addClass("disabled");
				return false;
			}else{
				$("#lastPage").removeClass("disabled");
				$("#lifirstPage").removeClass("disabled");
				$("#proPage").removeClass("disabled");
				pageNo = pageTotal;
				getAllProvince();
				$("#allStates").prop('checked',false);
			}
		});
		
		//创建省份modal
		$("#createBtn").click(function () {
			$("#createProvinceModal").modal("show");
			$("#provinceForm")[0].reset();
			$("#createProvinceCodeErrorMsg").text("");
			$("#createProvinceNameErrorMsg").text("");
		});
		//关闭省份modal
		$("#closeProvinceBtn").click(function () {
			$("#createProvinceModal").modal("hide");
			$("#provinceForm")[0].reset();
			$("#createProvinceCodeErrorMsg").text("");
			$("#createProvinceNameErrorMsg").text("");
		});
		var createProvinceCode = "";
		//鼠标提示省份码值
		$("#createProvinceCode").hover(function () {
			$("#createProvinceCodeErrorMsg").text("");
			$.ajax({
				type:"post",
				url:"sys/province/create.do",
				success : function (data) {
					createProvinceCode = data;
					$("#createProvinceCode").attr("placeholder","建议填写："+data);
				}
			});	
		}
		);
		$("#createProvinceCode").focus(function () {
			$("#createProvinceCodeErrorMsg").text("");
			$("#createProvinceCode").val(createProvinceCode);
		});
		$("#createProvinceCode").blur(function () {
			var provinceCode = $.trim($(this).val());
			var regExp = /^[P]{1}[0-9]{3}$/;
			var ok = regExp.test(provinceCode);
			if(provinceCode == ""){
				$("#createProvinceCodeErrorMsg").text("码值不能为空");
			}else if (provinceCode != "" && ok == false){
				$("#createProvinceCodeErrorMsg").text("码值必须是P开头的四位值 例如:P001");
			}else{
				$.post(
						"sys/province/checkprovinceCode.do",
						{
							"provinceCode":provinceCode
						},
						function(data){
							if(data != ""){
								$("#createProvinceCodeErrorMsg").text("码值已经使用，请重新输入");
							}
						}
						);
			}
			
		});
		//省份名称失去焦点
		$("#createProvinceName").blur(function () {
			var createProvinceName = $.trim($(this).val());
			if(createProvinceName == ""){
				$("#createProvinceNameErrorMsg").text("名称不能为空");
			}
		});
		$("#createProvinceName").focus(function () {
			$("#createProvinceNameErrorMsg").text("");
		});
		//点击保存省份
		$("#saveProvinceBtn").click(function () {
			$("#createProvinceCode").blur();
			$("#createProvinceName").blur();
			var provinceCode = $.trim($("#createProvinceCode").val());
			var provinceName = $.trim($("#createProvinceName").val());
			if($.trim($("#createProvinceCodeErrorMsg").text())=="" && $.trim($("#createProvinceNameErrorMsg").text())==""){
				$.post(
						"sys/province/save.do",
						{
							"provinceCode":provinceCode,
							"provinceName":provinceName
						},
						function (data) {
							if(data=="true"){
								alert("添加省份成功");
								window.open("jump/tojsp.do?target=sys/all_province/index","workareaFrame");
							}else{
								alert("添加省份失败");
							}
						}
						);
		}else{
			$("#saveProvinceErrorMsg").text("请检查输入项是否合格");
		}
		});
		
		//复选框全选中=状态
		$("#allStates").click(function () {
			var b = $('#tBody tr.aa input[type="checkbox"]');
			if($(this).prop('checked')){
				b.prop('checked',true);
			}else{
				b.prop('checked',false);
			}
		});
		//修改省份modal
		$("#editBtn").click(function () {
			
			$("#changProvinceNameErrorMsg").text("");
			var chk_value =[];
			$('input[name="pcode"]:checked').each(function(){   
		    	chk_value.push($(this).val());    
		    });
			/* $.each(chk_value,function(key,val){ 
			    alert('_mozi数组中 ,索引 : '+key+' 对应的值为: '+val); 
			});  */
			if(chk_value.length==0){
				alert("请选择一条需要修改的省份记录");
			}else if(chk_value.length > 1){
				alert("只能选择一条需要修改的省份记录");
			}else{
				$("#editProvinceModal").modal("show");
				$("#changProvinceCode").val("");
				$("#changProvinceName").val("");
				 $.post(
						"sys/province/getProvince.do",
						{
							"provinceCode":chk_value[0],
							"_":new Date().getTime()
						},
						function(data){
							$("#changProvinceCode").val(data.provinceCode);
							$("#changProvinceName").val(data.provinceName);
							$("#changProvinceCode").attr("disabled","true");
						}
					); 
			}
		});
		//关闭修改省份modal
		$("#closechangeProvinceBtn").click(function () {
			$("#createProvinceModal").modal("hide");
			$("#changProvinceNameErrorMsg").text("");
		});
		//xiu改省份名称失去焦点
		$("#changProvinceName").blur(function () {
			var changProvinceName = $.trim($(this).val());
			if(changProvinceName == ""){
				$("#changProvinceNameErrorMsg").text("名称不能为空");
			}
		});
		$("#changProvinceName").focus(function () {
			$("#changProvinceNameErrorMsg").text("");
		});
		//点击修改
		$("#changeProvinceBtn").click(function () {
			$("#changProvinceName").blur();
			if($.trim($("#changProvinceNameErrorMsg").text("")) != ""){
				$.post(
						"sys/province/change.do",
						{
							"provinceCode":$.trim($("#changProvinceCode").val()),
							"provinceName":$.trim($("#changProvinceName").val())
						},
						function (data) {
							if(data=="true"){
								alert("省份修改成功");
								window.open("jump/tojsp.do?target=sys/all_province/index","workareaFrame");
							}else{
								alert("省份修改失败");
							}
						}
				);
			}else{
				$("#changeProvinceErrorMsg").text("请检查输入是否合法");
			}
		});
		
		//点击删除选中的省份记录
		$("#deleteBtn").click(function () {
			var chk_value =[];
			$('input[name="pcode"]:checked').each(function(){   
		    	chk_value.push($(this).val());    
		    });
			if(chk_value.length==0){
				alert("请至少选择一条要删除的省份");
			}else{
				$.post(
						"sys/province/delete.do",
						{"chk_value":chk_value},
						function (data) {
							if(data == "true"){
								alert("成功删除选中的省份");
								window.open("jump/tojsp.do?target=sys/all_province/index","workareaFrame");
							}else{
								alert("省份删除失败");
							}
						}
					); 
			}
		});
		
	});
</script>
</head>
<body>
<!-- 创建省份的模态窗口 -->
	<div class="modal fade" id="createProvinceModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 50%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true"><span style="color: red">×</span></span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-plus"></span> 新增省份</h4>
				</div>
				<div class="modal-body">
				
					<form id="provinceForm" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">码&nbsp;&nbsp;&nbsp;&nbsp;值
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px">
								<input type="text" class="form-control" id="createProvinceCode" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性">
								<span id="createProvinceCodeErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width:200px;">
								<input type="text" class="form-control" id="createProvinceName" style="width: 200%;">
								<span id="createProvinceNameErrorMsg" style="color: red;font-size: 12px"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<span id="saveProvinceErrorMsg" style="color: red;font-size: 12px"></span>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="saveProvinceBtn">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closeProvinceBtn">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改省份的模态窗口 -->
	<div class="modal fade" id="editProvinceModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 50%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true"><span style="color: red;">×</span></span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-edit"></span> 修改省份信息</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">码&nbsp;&nbsp;&nbsp;&nbsp;值
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<input type="text" class="form-control" id="changProvinceCode" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<input type="text" class="form-control" id="changProvinceName" style="width: 200%;">
								<span id="changProvinceNameErrorMsg" style="color: red;font-size: 12px"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
				<span id="changeProvinceErrorMsg" style="color: red;font-size: 12px"></span>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="changeProvinceBtn">更新</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closechangeProvinceBtn">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<div style="width: 95%">
		<div>
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>省份信息</h3>
					<div class="btn-group" style="position: absolute; top: 5%;right: 5px">
			 	 		<button type="button" class="btn btn-primary" id="createBtn"> <span class="glyphicon glyphicon-plus"></span> 创建</button>
			  			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editDeptModal" id="editBtn"><span class="glyphicon glyphicon-edit"></span> 修改</button>
			  			<button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
					</div>
				</div>
			</div>
		</div>
		<!-- <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
			<div class="btn-group" style="position: relative; top: 18%;">
			  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createDeptModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
			  <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editDeptModal"><span class="glyphicon glyphicon-edit"></span> 修改</button>
			  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>
		</div> -->
		<div style="position: relative; left: 30px; top: -30px;">
			<table class="table table-hover" style="text-align: center;" id="Tab">
				<thead style="background-color: #40E0D0;text-align: center">
					<tr style="color: #FF0000;"> 
						<th><input type="checkbox" id="allStates" /></th>
						<th>序号</th>
						<th>省份码值</th>
						<th>省份名称</th>
					</tr>
				</thead>
				<tbody id="tBody">
					<!-- <tr class="aa">
						<td><input type="checkbox" /></td>
						<td>01</td>
						<td>P001</td>
						<td>云南省</td>
					</tr>  -->
				</tbody>
			</table>
		</div>
		
		<div style="height: 50px; position: relative;top: 0px;right: -20%;">
			<div style="position: relative;top: -30px;">
				<button type="button" class="btn btn-default" style="cursor: default;">共
				<b style="color: red;" id="recordTotal"></b>条记录</button>
			</div>
			<div class="btn-group" style="position: relative;top: -64px; left: 100px;">
				<button type="button" class="btn btn-default" style="cursor: default;">显示</button>
				<div class="btn-group">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						<b style="color: red;" id="pageSize"></b>
					</button>
				</div>
				<button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
			</div>
			<div style="position: relative;top: -98px; left: 255px;">
				<button type="button" class="btn btn-default" style="cursor: default;">共
				<b style="color: red;" id="pageTotal"></b>页</button>
			</div>
			<div style="position: relative;top: -132px; left: 320px;">
				<button type="button" class="btn btn-default" style="cursor: default;">当前第
				<b style="color: red;" id="pageNo"></b>页</button>
			</div>
			<div style="position: relative;top: -186px; left: 415px;">
				<nav>
					<ul class="pagination">
					<!-- class="disabled" -->
						<li id="lifirstPage"><a href="javascript:void(0)" id="firstPage">首页</a></li>
						<li id="liproPage"><a href="javascript:void(0)" id="proPage">上一页</a></li>
						<li id="linextPage"><a href="javascript:void(0)" id="nextPage">下一页</a></li>
						<li id="lilastPage"><a href="javascript:void(0)" id="lastPage">末页</a></li>
					</ul>
				</nav>
			</div>
		</div>
			
	</div>
	
</body>
</html>