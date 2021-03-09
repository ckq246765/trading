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
	th{text-align: center;}
</style>
<script type="text/javascript">
	$(function () {
		//加载数据
		var recordTotal = 0; 	 //记录条数
		var pageSize = 10;  		//每页显示记录数
		var pageTotal = 0;		//总页数
		var pageNo = 1;		//当前默认第一页
		getAllProvince(pageNo,pageSize);
		function getAllProvince(pageNo,pageSize) {
			$("#tBody").html("");
			$.post(
					"sys/objectParType/index.do",
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
						$(data.pList).each(function(i,n){
							html += "<tr class='aa'>";
							html += "<td><input type='checkbox' class='bb' name='ccode' value='"+n.parObjectTypeCode+"' /></td>";
							html += "<td>"+((i+1)+(pageNo-1)*pageSize)+"</td>";
							html += "<td name='Code'>"+n.parObjectTypeCode+"</td>";
							html += "<td name='Name'>"+n.parObjectTypeName+"</td>";
							html += "<td name='pName' value='"+n.objectTypeCode+"'>"+n.objectTypeName+"</td>"
							html += "</tr>";
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
							 showRowsPerPage: false,
							 showRowsInfo: false,
							  showRowsDefaultInfo: true,
							});
						$("#mypagination").bs_pagination({
							  onChangePage: function(event, data) {
								  getAllProvince(data.currentPage,data.rowsPerPage);
							  }
							});
					});
		}
		
		//点击创建城市modal
		$("#createParObjectTypeBtn").click(function () {
			$("#createParObjectTypeModal").modal("show");
			$("#parObjectTypeForm")[0].reset();
			$("#parObjectTypeCodeErrorMsg").text("");
			$("#parObjectTypeNameErrorMsg").text("");
			$.post(
				"sys/parObjectType/getParObjectType.do",
				{"_":new Date().getTime()},
				function (data) {
					var html = "<option></option>";
					$.each(data,function(i,n){
						html += "<option value='"+n.objectCode+"'>"+n.objectName+"</option>";	
					})
					$("#objectTypeName").html(html);
				}
			);
		});
		//关闭创建城市modal
		$("#closeParObjectType").click(function () {
			$("#createParObjectTypeModal").modal("hide");
			$("#parObjectTypeForm")[0].reset();
			$("#parObjectTypeCodeErrorMsg").text("");
			$("#parObjectTypeNameErrorMsg").text("");
		});
		$("#objectTypeName").change(function () {
			$("#parObjectTypeCode").val("");			
		});
		var createParObjectTypeCode = "";
		//鼠标提示省份码值
		 $("#parObjectTypeCode").hover(function () {
			var objectCodeforParObjectType = $("#objectTypeName option:selected").val();
			if(objectCodeforParObjectType == ""){
				$("#parObjectTypeCode").attr("placeholder","选择好归属，可自动生成码值");
				return false;
			}
			$.ajax({
				type:"post",
				url:"sys/parObjectType/createparObjectTypeCode.do",
				data:{
					"objectCode":objectCodeforParObjectType	
				},
				success : function (data) {
					createParObjectTypeCode = data;
					$("#parObjectTypeCode").attr("placeholder","建议填写："+data);
				}
			});	
		}); 
		 $("#parObjectTypeCode").focus(function () {
				$("#parObjectTypeCodeErrorMsg").text("");
				$("#parObjectTypeCode").val(createParObjectTypeCode);
			});
		 $("#parObjectTypeCode").blur(function () {
				var parObjectTypeCode = $.trim($(this).val());
				var regExp = /^[OT]{2}[0-9]{2}[PT]{2}[0-9]{2}$/;
				var ok = regExp.test(parObjectTypeCode);
				if(parObjectTypeCode == ""){
					$("#parObjectTypeCodeErrorMsg").text("码值不能为空");
				}else if (parObjectTypeCode != "" && ok == false){
					$("#parObjectTypeCodeErrorMsg").text("码值必须是P开头的8位值 例如:OT01PT01");
				}else{
					$.post(
							"sys/parObjectType/checkparObjectTypeCode.do",
							{
								"parObjectTypeCode":parObjectTypeCode
							},
							function(data){
								if(data != ""){
									$("#parObjectTypeCodeErrorMsg").text("码值已经使用，请重新输入");
								}
							}
						);
				}
			});
		//城市名称失去焦点
			$("#parObjectTypeName").blur(function () {
				var parObjectTypeName = $.trim($(this).val());
				if(parObjectTypeName == ""){
					$("#parObjectTypeNameErrorMsg").text("名称不能为空");
				}
			});
			$("#parObjectTypeName").focus(function () {
				$("#parObjectTypeNameErrorMsg").text("");
			});
			$("#saveParObjectType").click(function () {
				$("#parObjectTypeCode").blur();
				$("#parObjectTypeName").blur();
				var parObjectTypeCode = $.trim($("#parObjectTypeCode").val());
				var parObjectTypeName = $.trim($("#parObjectTypeName").val());
				var objectCodeforParObjectType = $("#objectTypeName option:selected").val();
				if($.trim($("#parObjectTypeCodeErrorMsg").text())=="" && $.trim($("#parObjectTypeNameErrorMsg").text())==""){
					$.post(
							"sys/parObjectType/save.do",
							{
								"parObjectTypeCode":parObjectTypeCode,
								"parObjectTypeName":parObjectTypeName,
								"objectTypeCode":objectCodeforParObjectType
							},
							function (data) {
								if(data=="true"){
									alert("添加成功");
									window.open("jump/tojsp.do?target=sys/obj_par_type/index","workareaFrame");
								}else{
									alert("添加失败");
								}
							}
						);
			}else{
				$("#parObjectTypeErrorMsg").text("请检查输入项是否合格");
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
			//修改城市modal
			var beforeObjectCode = "";   //修改前的码值
			$("#editBtn").click(function () {
				$("#parObjectTypeNameErrorMsg").text("");
				var chk_value =[];
				$('input[name="ccode"]:checked').each(function(){   
			    	chk_value.push($(this).val());    
			    });
				/* $.each(chk_value,function(key,val){ 
				    alert('_mozi数组中 ,索引 : '+key+' 对应的值为: '+val); 
				});  */
				if(chk_value.length==0){
					alert("请选择一条需要修改的记录");
				}else if(chk_value.length > 1){
					alert("只能选择一条需要修改的记录");
				}else{
					beforeObjectCode = chk_value[0];
					$("#changeParObjectTypeModal").modal("show");
					$("#changeParObjectTypeCode").val("");
					$("#changeParObjectTypeName").val("");
					//获取省份
					$.post(
							"sys/parObjectType/getParObjectType.do",
							{"_":new Date().getTime()},
							function (data) {
								var html = "";
								$.each(data,function(i,n){
									html += "<option value='"+n.objectCode+"'>"+n.objectName+"</option>";	
								});
								$("#changeObjectName").html(html);
							}
						);
					 $.post(
							"sys/parObjectType/getParObject.do",
							{
								"parObjectTypeCode":chk_value[0],
								"_":new Date().getTime()
							},
							function(data){
								$("#changeParObjectTypeCode").val(data.parObjectTypeCode);
								$("#changeParObjectTypeName").val(data.parObjectTypeName);
								$("#changeObjectName option[value='"+data.objectTypeCode+"']").attr("selected",true);
								 //$("#changeProvinceName").find("option:contains('"+data.provinceCode+"')").attr("selected",true);
								$("#changeParObjectTypeCode").attr("disabled","true");
							}
						); 
				}
			});
			
			//关闭修改城市modal
			$("#closeSaveParObjectTypeBtn").click(function () {
				$("#changeParObjectTypeModal").modal("hide");
				$("#parObjectTypeNameErrorMsg").text("");
			});
			//修改城市归属省份
			$("#changeObjectName").change(function () {
				var objectCodeforParObjectType = $("#changeObjectName option:selected").val();
				$.ajax({
					type:"post",
					url:"sys/parObjectType/createparObjectTypeCode.do",
					data:{
						"objectCode":objectCodeforParObjectType	
					},
					success : function (data) {
						$("#changeParObjectTypeCode").val(data);
					}
				});	
			});
			//xiu改省份名称失去焦点
			$("#changeParObjectTypeName").blur(function () {
				var changeParObjectTypeName = $.trim($(this).val());
				if(changeParObjectTypeName == ""){
					$("#changeParObjectTypeNameErrorMsg").text("名称不能为空");
				}
			});
			$("#changeParObjectTypeName").focus(function () {
				$("#changeParObjectTypeNameErrorMsg").text("");
			});
			//点击修改
			$("#saveChangeParObjectTypeBtn").click(function () {
				$("#changeParObjectTypeName").blur();
				if($.trim($("#changeParObjectTypeNameErrorMsg").text("")) != ""){
					$.post(
							"sys/parObject/change.do",
							{
								"beforeObjectTypeCode":beforeObjectCode, //修改前码值
								"parObjectTypeCode":$.trim($("#changeParObjectTypeCode").val()),
								"parObjectTypeName":$.trim($("#changeParObjectTypeName").val()),
								"objectTypeCode":$("#changeObjectName option:selected").val()
							},
							function (data) {
								if(data=="true"){
									alert("修改成功");
									window.open("jump/tojsp.do?target=sys/obj_par_type/index","workareaFrame");
								}else{
									alert("修改失败");
								}
							}
					);
				}else{
					$("#changeParObjectTypeErrorMsg").text("请检查输入是否合法");
				}
			});
			//点击删除
			$("#deleteBtn").click(function () {
				var chk_value =[];
				$('input[name="ccode"]:checked').each(function(){   
			    	chk_value.push($(this).val());    
			    });
				if(chk_value.length==0){
					alert("请至少选择一条要删除的记录");
				}else{
					$.post(
							"sys/parObject/delete.do",
							{"chk_value":chk_value},
							function (data) {
								if(data == "true"){
									alert("成功删除选中的记录");
									window.open("jump/tojsp.do?target=sys/obj_par_type/index","workareaFrame");
								}else{
									alert("删除失败");
								}
							}
						); 
				}
			});
			
	});

</script>
</head>
<body>
<!-- 创建部门的模态窗口 -->

	<div class="modal fade" id="createParObjectTypeModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 50%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-plus"></span> 新增具体类型</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="parObjectTypeForm">
					    <div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">归属名称
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<select class="form-control" id="objectTypeName" style="width: 200%;">
				 					<option ></option>
								  	<option >电子产品</option>
								  	<option >家具家电</option>
								  	<option >纯手工品</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;值
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px">
								<input type="text" class="form-control" id="parObjectTypeCode" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性">
								<span id="parObjectTypeCodeErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width:200px;">
								<input type="text" class="form-control" id="parObjectTypeName" style="width: 200%;">
								<span id="parObjectTypeNameErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						
					</form>
				</div>
				<div class="modal-footer">
					<span id="parObjectTypeErrorMsg" style="color: red;font-size: 12px;"></span>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="saveParObjectType">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closeParObjectType">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改部门的模态窗口 -->
	<div class="modal fade" id="changeParObjectTypeModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 50%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-edit"></span> 修改具体类型</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="changeParObjectTypeForm">
					    <div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">归属名称
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<select class="form-control" id="changeObjectName" style="width: 200%;">
								
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">码&nbsp;&nbsp;&nbsp;&nbsp;值
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<input type="text" class="form-control" id="changeParObjectTypeCode" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性" value="">
								<span id="changeParObjectTypeCodeErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<input type="text" class="form-control" id="changeParObjectTypeName" style="width: 200%;" value="手机">
								<span id="changeParObjectTypeNameErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<span id="changeParObjectTypeErrorMsg" style="color: red;font-size: 12px;"></span>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChangeParObjectTypeBtn">更新</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closeSaveParObjectTypeBtn">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<div style="width: 95%">
		<div>
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>物品具体类型</h3>
					<div class="btn-group" style="position: absolute; top: 5%;right: 5px">
						<!-- data-toggle="modal" data-target="#createDeptModal" -->
			 	 		<button type="button" class="btn btn-primary"  id="createParObjectTypeBtn"> <span class="glyphicon glyphicon-plus"></span> 创建</button>
			  			<button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-edit"></span> 修改</button>
			  			<button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
					</div>
				</div>
			</div>
		</div>
		
		<div style="position: relative; left: 30px; top: -30px;">
			<table class="table table-hover" style="text-align: center;">
				<thead style="background-color: #40E0D0;text-align: center">
					<tr style="color: red;">
						<th><input type="checkbox" id="allStates" /></th>
						<th>序号</th>
						<th>物品详细类型码值</th>
						<th>物品详细类型名称</th>
						<th>归属物品类型名称</th>
					</tr>
				</thead>
				<tbody id="tBody">
					<tr class="active">
						<td><input type="checkbox" /></td>
						<td>01</td>
						<td>OT01PT01</td>
						<td>手机</td>
						<td>电子产品</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div style="height: 50px; position: relative;top: 0px;left: 30px;">
			<div id="mypagination" style="background-color: white;"></div>
		</div>
			
	</div>
	
</body>
</html>