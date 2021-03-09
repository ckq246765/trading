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
	th{text-align: center}
	table{
		background: url("img/sys.jpg");
	}
</style>
<script type="text/javascript">
	$(function () {
		//加载数据
		var recordTotal = 0; 	 //记录条数
		var pageSize = 10;  		//每页显示记录数
		var pageTotal = 0;		//总页数
		var pageNo = 1;		//当前默认第一页
		
		var pageOne = 1;    //页码默认
		var pageTwo = 2;
		var pageThree = 3;
		var pageFour = 4;
		var pageFive = 5;
		
		getAllProvince();
		function getAllProvince() {
			$("#tBody").html("");
			$.post(
					"sys/all_city/index.do",
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
						
						showPage(pageOne,pageTwo,pageThree,pageFour,pageFive,pageNo);
						
						$("#recordTotal").html(recordTotal);
						$("#pageSize").html(pageSize);
						$("#pageTotal").html(pageTotal);
						$("#pageNo").html(pageNo);
						
						var html = "";
						$(data.cList).each(function(i,n){
							html += "<tr class='aa'>";
							html += "<td><input type='checkbox' class='bb' name='ccode' value='"+n.cityCode+"' /></td>";
							html += "<td>"+((i+1)+(pageNo-1)*pageSize)+"</td>";
							html += "<td name='Code'>"+n.cityCode+"</td>";
							html += "<td name='Name'>"+n.cityName+"</td>";
							html += "<td hidden='hidden' name='pCode' >"+n.provinceCode+"</td>";
							html += "<td name='pName'>"+n.provinceName+"</td>"
							html += "</tr>";
						});
						$("#tBody").html(html);
					}
					);
		}
		//点击向前翻页
		 $("#before").hover(function () {
			if($("#one").html() == 1){
				$("#libefore").addClass("disabled");
			}else{
				$("#libefore").removeClass("disabled");
			}
			showPage(pageOne,pageTwo,pageThree,pageFour,pageFive,pageNo);
		}); 
		 $("#after").hover(function () {
				if($("#five").html() == pageTotal){
					$("#liafter").addClass("disabled");
				}else{
					$("#liafter").removeClass("disabled");
				}
				showPage(pageOne,pageTwo,pageThree,pageFour,pageFive,pageNo);
			});
		$("#before").click(function () {
			if($("#one").html() - 5 > 0){
				pageOne = $("#one").html() - 5;    //页码默认
				pageTwo = $("#two").html() - 5;
				pageThree = $("#three").html() - 5;
				pageFour = $("#four").html() - 5;
				pageFive = $("#five").html() - 5;
				showPage(pageOne,pageTwo,pageThree,pageFour,pageFive,pageNo);
			}else{
				pageOne = 1;    //页码默认
				pageTwo = 2;
				pageThree = 3;
				pageFour = 4;
				pageFive = 5;
				showPage(pageOne,pageTwo,pageThree,pageFour,pageFive);
			}
		});
		$("#after").click(function () {
			if($("#five").html()  < pageTotal-5){
				pageOne = parseInt($("#one").html())+5;    //页码默认
				pageTwo = parseInt($("#two").html())+5;
				pageThree = parseInt($("#three").html())+5;
				pageFour = parseInt($("#four").html())+5;
				pageFive = parseInt($("#five").html())+5;
				showPage(pageOne,pageTwo,pageThree,pageFour,pageFive,pageNo);
			}else{
				pageOne = pageTotal-4;    //页码默认
				pageTwo = pageTotal-3;
				pageThree = pageTotal-2;
				pageFour = pageTotal-1;
				pageFive = pageTotal;
				showPage(pageOne,pageTwo,pageThree,pageFour,pageFive);
			}
		});
		
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
				pageOne = 1;    //页码默认
				pageTwo = 2;
				pageThree = 3;
				pageFour = 4;
				pageFive = 5;
				
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
				if(pageNo == parseInt($("#one").html())){
					pageFive = pageFour;
					pageFour = pageThree;
					pageThree = pageTwo;
					pageTwo = pageOne;
					pageOne = pageNo-1;    //页码默认
				}else{
					if(pageNo < pageTotal-5){
						pageOne = pageNo-1;    //页码默认
						pageTwo = pageNo;
						pageThree = pageNo+1;
						pageFour = pageNo+2;
						pageFive = pageNo+3;
					}else{
						pageOne = pageTotal-4;    //页码默认
						pageTwo = pageTotal-3;
						pageThree = pageTotal-2;
						pageFour = pageTotal-1;
						pageFive = pageTotal;
					}
				}
				
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
				if(pageNo == parseInt($("#five").html())){
					pageOne = pageTwo;    //页码默认
					pageTwo = pageThree;
					pageThree = pageFour;
					pageFour = pageFive;
					pageFive = pageNo+1;
				}else{
					if(pageNo > 5){
						pageOne = pageNo-3;    //页码默认
						pageTwo = pageNo-2;
						pageThree = pageNo-1;
						pageFour = pageNo;
						pageFive = pageNo+1;
					}else{
						pageOne = 1;    //页码默认
						pageTwo = 2;
						pageThree = 3;
						pageFour = 4;
						pageFive = 5;
					}
				}				
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
				pageOne = pageTotal-4;    //页码默认
				pageTwo = pageTotal-3;
				pageThree = pageTotal-2;
				pageFour = pageTotal-1;
				pageFive = pageTotal;
				
				$("#lastPage").removeClass("disabled");
				$("#lifirstPage").removeClass("disabled");
				$("#proPage").removeClass("disabled");
				pageNo = pageTotal;
				getAllProvince();
				$("#allStates").prop('checked',false);
			}
		});
		//点击页码
		$("#one").click(function () {
			pageNo = parseInt($(this).html());
			getAllProvince();
		});
		$("#two").click(function () {
			pageNo = parseInt($(this).html());
			getAllProvince();
		});
		$("#three").click(function () {
			pageNo = parseInt($(this).html());
			getAllProvince();
		});
		$("#four").click(function () {
			pageNo = parseInt($(this).html());
			getAllProvince();
		});
		$("#five").click(function () {
			pageNo = parseInt($(this).html());
			getAllProvince();
		});
		
		//点击创建城市modal
		$("#createCityBtn").click(function () {
			$("#createCityModal").modal("show");
			$("#formCity")[0].reset();
			$("#cityCodeErrorMsg").text("");
			$("#cityNameErrorMsg").text("");
			$.post(
				"sys/city/getProvince.do",
				{"_":new Date().getTime()},
				function (data) {
					var html = "<option></option>";
					$.each(data,function(i,n){
						html += "<option value='"+n.provinceCode+"'>"+n.provinceName+"</option>";	
					})
					$("#provinceName").html(html);
				}
			);
		});
		//关闭创建城市modal
		$("#closeCityBtn").click(function () {
			$("#createCityModal").modal("hide");
			$("#formCity")[0].reset();
			$("#cityCodeErrorMsg").text("");
			$("#cityNameErrorMsg").text("");
		});
		$("#provinceName").change(function () {
			$("#cityCode").val("");			
		});
		var createCityCode = "";
		//鼠标提示省份码值
		 $("#cityCode").hover(function () {
			var provinceCodeforCity = $("#provinceName option:selected").val();
			if(provinceCodeforCity == ""){
				$("#cityCode").attr("placeholder","选择好归属省份，可自动生成码值");
				return false;
			}
			$.ajax({
				type:"post",
				url:"sys/city/createCityCode.do",
				data:{
					"provinceCode":provinceCodeforCity	
				},
				success : function (data) {
					createCityCode = data;
					$("#cityCode").attr("placeholder","建议填写："+data);
				}
			});	
		}); 
		 $("#cityCode").focus(function () {
				$("#cityCodeErrorMsg").text("");
				$("#cityCode").val(createCityCode);
			});
		 $("#cityCode").blur(function () {
				var cityCode = $.trim($(this).val());
				var regExp = /^[P]{1}[0-9]{3}[C]{1}[0-9]{3}$/;
				var ok = regExp.test(cityCode);
				if(cityCode == ""){
					$("#cityCodeErrorMsg").text("码值不能为空");
				}else if (cityCode != "" && ok == false){
					$("#cityCodeErrorMsg").text("码值必须是P开头的8位值 例如:P001C001");
				}else{
					$.post(
							"sys/city/checkCityCode.do",
							{
								"cityCode":cityCode
							},
							function(data){
								if(data != ""){
									$("#cityCodeErrorMsg").text("码值已经使用，请重新输入");
								}
							}
						);
				}
			});
		//城市名称失去焦点
		$("#cityName").blur(function () {
			var cityName = $.trim($(this).val());
			if(cityName == ""){
				$("#cityNameErrorMsg").text("名称不能为空");
			}
		});
		$("#createProvinceName").focus(function () {
			$("#cityNameErrorMsg").text("");
		});
		//保存城市
		$("#saveCityBtn").click(function () {
			$("#cityCode").blur();
			$("#cityName").blur();
			var cityCode = $.trim($("#cityCode").val());
			var cityName = $.trim($("#cityName").val());
			var provinceCodeforCity = $("#provinceName option:selected").val();
			if($.trim($("#cityCodeErrorMsg").text())=="" && $.trim($("#cityNameErrorMsg").text())==""){
				$.post(
						"sys/city/save.do",
						{
							"cityCode":cityCode,
							"cityName":cityName,
							"provinceCode":provinceCodeforCity
						},
						function (data) {
							if(data=="true"){
								alert("添加城市成功");
								window.open("jump/tojsp.do?target=sys/all_city/index","workareaFrame");
							}else{
								alert("添加城市失败");
							}
						}
					);
		}else{
			$("#saveCityErrorMsg").text("请检查输入项是否合格");
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
		var beforeCityCode = "";   //修改前的码值
		$("#changeCityBtn").click(function () {
			$("#changeCityNameErrorMsg").text("");
			var chk_value =[];
			$('input[name="ccode"]:checked').each(function(){   
		    	chk_value.push($(this).val());    
		    });
			/* $.each(chk_value,function(key,val){ 
			    alert('_mozi数组中 ,索引 : '+key+' 对应的值为: '+val); 
			});  */
			if(chk_value.length==0){
				alert("请选择一条需要修改的城市记录");
			}else if(chk_value.length > 1){
				alert("只能选择一条需要修改的城市记录");
			}else{
				beforeCityCode = chk_value[0];
				$("#changeCityModal").modal("show");
				$("#changeCityCode").val("");
				$("#changeCityName").val("");
				//获取省份
				$.post(
						"sys/city/getProvince.do",
						{"_":new Date().getTime()},
						function (data) {
							var html = "";
							$.each(data,function(i,n){
								html += "<option value='"+n.provinceCode+"'>"+n.provinceName+"</option>";	
							})
							$("#changeProvinceName").html(html);
						}
					);
				 $.post(
						"sys/city/getCity.do",
						{
							"cityCode":chk_value[0],
							"_":new Date().getTime()
						},
						function(data){
							$("#changeCityCode").val(data.cityCode);
							$("#changeCityName").val(data.cityName);
							$("#changeProvinceName option[value='"+data.provinceCode+"']").attr("selected",true);
							 //$("#changeProvinceName").find("option:contains('"+data.provinceCode+"')").attr("selected",true);
							$("#changeCityCode").attr("disabled","true");
						}
					); 
			}
		});
		//关闭修改城市modal
		$("#closeSaveChangeCityBtn").click(function () {
			$("#changeCityModal").modal("hide");
			$("#changeCityNameErrorMsg").text("");
	
		});
		//修改城市归属省份
		$("#changeProvinceName").change(function () {
			var provinceCodeforCity = $("#changeProvinceName option:selected").val();
			$.ajax({
				type:"post",
				url:"sys/city/createCityCode.do",
				data:{
					"provinceCode":provinceCodeforCity	
				},
				success : function (data) {
					$("#changeCityCode").val(data);
				}
			});	
		});
		//xiu改省份名称失去焦点
		$("#changeCityName").blur(function () {
			var changeCityName = $.trim($(this).val());
			if(changeCityName == ""){
				$("#changeCityNameErrorMsg").text("名称不能为空");
			}
		});
		$("#changeCityName").focus(function () {
			$("#changeCityNameErrorMsg").text("");
		});
		//点击修改
		$("#saveChangeCityBtn").click(function () {
			$("#changeCityName").blur();
			if($.trim($("#changeCityNameErrorMsg").text("")) != ""){
				$.post(
						"sys/city/change.do",
						{
							"beforeCityCode":beforeCityCode, //修改前码值
							"cityCode":$.trim($("#changeCityCode").val()),
							"cityName":$.trim($("#changeCityName").val()),
							"provinceCode":$("#changeProvinceName option:selected").val()
						},
						function (data) {
							if(data=="true"){
								alert("城市修改成功");
								window.open("jump/tojsp.do?target=sys/all_city/index","workareaFrame");
							}else{
								alert("城市修改失败");
							}
						}
				);
			}else{
				$("#changecityErrorMsg").text("请检查输入是否合法");
			}
		});
		//点击删除
		$("#deleteCityBtn").click(function () {
			var chk_value =[];
			$('input[name="ccode"]:checked').each(function(){   
		    	chk_value.push($(this).val());    
		    });
			if(chk_value.length==0){
				alert("请至少选择一条要删除的城市记录");
			}else{
				$.post(
						"sys/city/delete.do",
						{"chk_value":chk_value},
						function (data) {
							if(data == "true"){
								alert("成功删除选中的城市");
								window.open("jump/tojsp.do?target=sys/all_city/index","workareaFrame");
							}else{
								alert("城市删除失败");
							}
						}
					); 
			}
		});
	});
	//显示页码
	function showPage(pageOne,pageTwo,pageThree,pageFour,pageFive,pageNo) {
		$("#one").html(pageOne);
		$("#two").html(pageTwo);
		$("#three").html(pageThree);
		$("#four").html(pageFour);
		$("#five").html(pageFive);
		if(pageNo == pageOne){
			$("#lione").addClass("active");
			$("#litwo").removeClass("active");
			$("#lithree").removeClass("active");
			$("#lifour").removeClass("active");
			$("#lifive").removeClass("active");
		}else if(pageNo == pageTwo){
			$("#litwo").addClass("active");
			$("#lione").removeClass("active");
			$("#lithree").removeClass("active");
			$("#lifour").removeClass("active");
			$("#lifive").removeClass("active");
		}else if(pageNo == pageThree){
			$("#lithree").addClass("active");
			$("#lione").removeClass("active");
			$("#litwo").removeClass("active");
			$("#lifour").removeClass("active");
			$("#lifive").removeClass("active");
		}else if(pageNo == pageFour){
			$("#lifour").addClass("active");
			$("#lione").removeClass("active");
			$("#litwo").removeClass("active");
			$("#lithree").removeClass("active");
			$("#lifive").removeClass("active");
		}else if(pageNo == pageFive){
			$("#lifive").addClass("active");
			$("#lione").removeClass("active");
			$("#litwo").removeClass("active");
			$("#lithree").removeClass("active");
			$("#lifour").removeClass("active");
		}else{
			$("#lione").removeClass("active");
			$("#litwo").removeClass("active");
			$("#lithree").removeClass("active");
			$("#lifour").removeClass("active");
			$("#lifive").removeClass("active");
		}
	}
	
</script>
</head>
<body>
<!-- 创建城市的模态窗口 -->
	<div class="modal fade" id="createCityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 50%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-plus"></span> 新增城市</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="formCity">
					    <div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">归属省份
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<select class="form-control" id="provinceName" style="width: 200%;">
				 					<!-- <option></option>
								  	<option value="Poo1">云南省</option>
								  	<option value="Poo1">四川省</option>
								  	<option value="Poo1">辽宁省</option>  -->
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;值
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px">
								<input type="text" class="form-control" id="cityCode" style="width: 200%;" placeholder="编号为8位字符加数字，不能为空，具有唯一性">
								<span id="cityCodeErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width:200px;">
								<input type="text" class="form-control" id="cityName" style="width: 200%;">
								<span id="cityNameErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<span id="saveCityErrorMsg" style="color: red;font-size: 12px;"></span>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="saveCityBtn">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closeCityBtn">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改城市的模态窗口 -->
	<div class="modal fade" id="changeCityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 50%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-edit"></span> 修改城市信息</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					    <div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">归属城市
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<select class="form-control" id="changeProvinceName" style="width: 200%;">
				 					<option></option>
								  	<option>云南省</option>
								  	<option>四川省</option>
								  	<option>辽宁省</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">码&nbsp;&nbsp;&nbsp;&nbsp;值
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<input type="text" class="form-control" id="changeCityCode" style="width: 200%;" placeholder="编号为8位数字加字符，不能为空，具有唯一性" value="P001C001">
								<span id="changeCityCodeErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称
								<span style="font-size: 15px; color: red;">*</span>
							</label>
							<div class="col-sm-10" style="width: 200px;">
								<input type="text" class="form-control" id="changeCityName" style="width: 200%;" value="昆明">
								<span id="changeCityNameErrorMsg" style="color: red;font-size: 12px;"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<span id="changecityErrorMsg" style="color: red;font-size: 12px;"></span>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChangeCityBtn">更新</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closeSaveChangeCityBtn">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<div style="width: 95%">
		<div>
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>城市信息</h3>
					<div class="btn-group" style="position: absolute; top: 5%; right: 5px;">
					<!-- data-toggle="modal" data-target="#createCityModal" -->
					<!-- data-toggle="modal" data-target="#editDeptModal"  -->
			  			<button type="button" class="btn btn-primary"  id="createCityBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
			  			<button type="button" class="btn btn-default" id="changeCityBtn"><span class="glyphicon glyphicon-edit"></span> 修改</button>
			  			<button type="button" class="btn btn-danger" id="deleteCityBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
					</div>
				</div>
			</div> 
		</div>
		<div style="position: relative; left: 30px; top: -30px;">
			<table class="table table-hover">
				<thead style="background-color: #40E0D0;">
					<tr style="color: #FF0000;">
						<th><input type="checkbox" id="allStates" /></th>
						<th>序号</th>
						<th>城市码值</th>
						<th>城市名称</th>
						<th hidden="hidden" >归属省份码值</th>
						<th>归属省份名称</th>
					</tr>
				</thead>
				<tbody id="tBody">
					<tr class="active">
						<td><input type="checkbox" /></td>
						<td>01</td>
						<td>P001C001</td>
						<td>昆明</td>
						<td hidden="hidden" >P001</td>
						<td>云南省</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div style="height: 50px; position: relative;top: 0px;right: -9%;">
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
						<li id="libefore"><a href="javascript:void(0)" id="before"> << </a></li>
						<!-- class="active"  -->
						<li id="lione"><a href="javascript:void(0)" id="one"></a></li>
						<li id="litwo"><a href="javascript:void(0)" id="two"></a></li>
						<li id="lithree"><a href="javascript:void(0)" id="three"></a></li>
						<li id="lifour"><a href="javascript:void(0)" id="four"></a></li>
						<li id="lifive"><a href="javascript:void(0)" id="five"></a></li>
						<li id="liafter"><a href="javascript:void(0)" id="after"> >> </a></li>
						<li id="linextPage"><a href="javascript:void(0)" id="nextPage">下一页</a></li>
						<li id="lilastPage"><a href="javascript:void(0)" id="lastPage">末页</a></li>
					</ul>
				</nav>
			</div>
		</div>
			
	</div>
	
</body>
</html>