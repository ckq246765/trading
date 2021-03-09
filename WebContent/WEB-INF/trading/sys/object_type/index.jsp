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
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

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
		getAllProvince();
		function getAllProvince() {
			$("#tBody").html("");
			$.post(
					"sys/object_type/index.do",
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
						$(data.oList).each(function(i,n){
							html += "<tr class='aa'>";
							html += "<td><input type='checkbox' class='bb' name='pcode' value='"+n.objectCode+"' /></td>";
							html += "<td>"+((i+1)+(pageNo-1)*pageSize)+"</td>";
							html += "<td name='Code'>"+n.objectCode+"</td>";
							html += "<td name='Name'>"+n.objectName+"</td>";
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
		$("#createObjectBtn").click(function () {
			$("#createObjectModal").modal("show");
			$("#objectForm")[0].reset();
			$("#createObjectCodeErrorMsg").text("");
			$("#createObjectNameErrorMsg").text("");
		});
		//关闭省份modal
		$("#closeCreateObjectBtn").click(function () {
			$("#createObjectModal").modal("hide");
			$("#objectForm")[0].reset();
			$("#createObjectCodeErrorMsg").text("");
			$("#createObjectNameErrorMsg").text("");
		});
		var createObjectCode = "";
		//鼠标提示省份码值
		$("#createObjectCode").hover(function () {
			$("#createObjectCodeErrorMsg").text("");
			$.ajax({
				type:"post",
				url:"sys/object/create.do",
				success : function (data) {
					createObjectCode = data;
					$("#createObjectCode").attr("placeholder","建议填写："+data);
				}
			});	
		});
		$("#createObjectCode").focus(function () {
			$("#createObjectCodeErrorMsg").text("");
			$("#createObjectCode").val(createObjectCode);
		});
		$("#createObjectCode").blur(function () {
			var objectCode = $.trim($(this).val());
			var regExp = /^[OT]{1}[0-9]{2}$/;
			var ok = regExp.test(objectCode);
			if(objectCode == ""){
				$("#createObjectCodeErrorMsg").text("码值不能为空");
			}else if (objectCode != "" && ok == false){
				$("#createObjectCode").text("码值必须是P开头的四位值 例如:OT01");
			}else{
				$.post(
						"sys/object/checkObjectCode.do",
						{
							"objectCode":objectCode
						},
						function(data){
							if(data != ""){
								$("#createObjectCodeErrorMsg").text("码值已经使用，请重新输入");
							}
						}
						);
			}
			
		});
		//省份名称失去焦点
		$("#createObjectName").blur(function () {
			var createObjectName = $.trim($(this).val());
			if(createObjectName == ""){
				$("#createObjectNameErrorMsg").text("名称不能为空");
			}
		});
		$("#createObjectName").focus(function () {
			$("#createObjectNameErrorMsg").text("");
		});
		//点击保存省份
		$("#saveCreateObjectBtn").click(function () {
			$("#createObjectCode").blur();
			$("#createObjectName").blur();
			var objectCode = $.trim($("#createObjectCode").val());
			var objectName = $.trim($("#createObjectName").val());
			if($.trim($("#createObjectCodeErrorMsg").text())=="" && $.trim($("#createObjectNameErrorMsg").text())==""){
				$.post(
						"sys/object/save.do",
						{
							"objectCode":objectCode,
							"objectName":objectName
						},
						function (data) {
							if(data=="true"){
								alert("添加成功");
								window.open("jump/tojsp.do?target=sys/object_type/index","workareaFrame");
							}else{
								alert("添加失败");
							}
						}
						);
		}else{
			$("#saveObjectErrorMsg").text("请检查输入项是否合格");
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
		$("#editObjectBtn").click(function () {
			
			$("#cahngeObjectNameErrorMsg").text("");
			var chk_value =[];
			$('input[name="pcode"]:checked').each(function(){   
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
				$("#editObjectModal").modal("show");
				$("#cahngeObjectCode").val("");
				$("#cahngeObjectName").val("");
				 $.post(
						"sys/object/getobject.do",
						{
							"objectCode":chk_value[0],
							"_":new Date().getTime()
						},
						function(data){
							$("#cahngeObjectCode").val(data.objectCode);
							$("#cahngeObjectName").val(data.objectName);
							$("#cahngeObjectCode").attr("disabled","true");
						}
					); 
			}
		});
		//关闭修改省份modal
		$("#closeChangeBtn").click(function () {
			$("#editObjectModal").modal("hide");
			$("#cahngeObjectNameErrorMsg").text("");
		});
		//xiu改省份名称失去焦点
		$("#cahngeObjectName").blur(function () {
			var cahngeObjectName = $.trim($(this).val());
			if(cahngeObjectName == ""){
				$("#cahngeObjectNameErrorMsg").text("名称不能为空");
			}
		});
		$("#cahngeObjectName").focus(function () {
			$("#cahngeObjectNameErrorMsg").text("");
		});
		//点击修改
		$("#saveChangeBtn").click(function () {
			$("#cahngeObjectName").blur();
			if($.trim($("#cahngeObjectNameErrorMsg").text("")) != ""){
				$.post(
						"sys/object/change.do",
						{
							"objectCode":$.trim($("#cahngeObjectCode").val()),
							"objectName":$.trim($("#cahngeObjectName").val())
						},
						function (data) {
							if(data=="true"){
								alert("修改成功");
								window.open("jump/tojsp.do?target=sys/object_type/index","workareaFrame");
							}else{
								alert("修改失败");
							}
						}
				);
			}else{
				$("#cahngeObjectErrorMsg").text("请检查输入是否合法");
			}
		});
		
		//点击删除选中的省份记录
		$("#deleteObjectBtn").click(function () {
			var chk_value =[];
			$('input[name="pcode"]:checked').each(function(){   
		    	chk_value.push($(this).val());    
		    });
			if(chk_value.length==0){
				alert("请至少选择一条要删除的");
			}else{
				$.post(
						"sys/object/delete.do",
						{"chk_value":chk_value},
						function (data) {
							if(data == "true"){
								alert("成功删除选中的记录");
								window.open("jump/tojsp.do?target=sys/object_type/index","workareaFrame");
							}else{
								alert("删除记录失败");
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
	<div class="modal fade" id="createObjectModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 50%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-plus"></span> 新增物品类型</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="objectForm">
					
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">码&nbsp;&nbsp;&nbsp;&nbsp;值
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px">
								<input type="text" class="form-control" id="createObjectCode" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性">
								<span id="createObjectCodeErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width:200px;">
								<input type="text" class="form-control" id="createObjectName" style="width: 200%;">
								<span id="createObjectNameErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<span id="saveObjectErrorMsg" style="color: red;font-size: 12px;"></span>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="saveCreateObjectBtn">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closeCreateObjectBtn">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改部门的模态窗口 -->
	<div class="modal fade" id="editObjectModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 50%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-edit"></span> 修改物品类型</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="changeObjectBtn">
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">码&nbsp;&nbsp;&nbsp;&nbsp;值
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<input type="text" class="form-control" id="cahngeObjectCode" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性" value="OT01">
								<span id="cahngeObjectCodeErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<input type="text" class="form-control" id="cahngeObjectName" style="width: 200%;" value="电子产品">
								<span id="cahngeObjectNameErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<span id="cahngeObjectErrorMsg" style="color: red;font-size: 12px;"></span>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChangeBtn">更新</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closeChangeBtn">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<div style="width: 95%">
		<div>
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>物品类型</h3>
					<div class="btn-group" style="position: absolute; top: 5%; right: 5px;">
			  			<button type="button" class="btn btn-primary" id="createObjectBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
			  			<button type="button" class="btn btn-default" id="editObjectBtn"><span class="glyphicon glyphicon-edit"></span> 修改</button>
			  			<button type="button" class="btn btn-danger" id="deleteObjectBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
					</div>
				</div>
			</div>
		</div>
		
		<div style="position: relative; left: 30px; top: -30px;">
			<table class="table table-hover" style="text-align: center;">
				<thead style="background-color: #40E0D0;text-align: center">
					<tr style="color: #FF0000;">
						<th><input type="checkbox" id="allStates" /></th>
						<th>序号</th>
						<th>物品类型码值</th>
						<th>物品类型名称</th>
					</tr>
				</thead>
				<tbody id="tBody">
					<tr class="active">
						<td><input type="checkbox" /></td>
						<td>01</td>
						<td>OT01</td>
						<td>电子产品</td>
					</tr>
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