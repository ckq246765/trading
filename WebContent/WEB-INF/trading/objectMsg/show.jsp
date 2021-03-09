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
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/show.js"></script>
<link href="${pageContext.request.contextPath }/css/shop.css" type="text/css" rel="stylesheet" />

<meta http-equiv="Content-Type" content="multipart/form-data; charset=UTF-8">
<title>GaGe交易平台</title>
<style type="text/css">
table tbody input{
	width: 50px;
	height: 35px;
}
table tbody option{、
	width: 50px;
	height: 30px;
	text-align: center;
}
</style>
<script type="text/javascript">
	$(document).ready(function () {
		$('#frameName').load(function(){
		    var text=$(this).contents().find("body").text();
		       // 根据后台返回值处理结果
		    var j=$.parseJSON(text);
		    if(text=="true") {
		    	var href = $(this).prop("src");
		        window.location.href=href;
		    } else {
		        alert('发布失败');
		        //location.href='BookResourceList.jsp'
		    }
		});
		//复选框全选中=状态
		$("#allStates").click(function () {
			var b = $('#tBody tr.active input[type="checkbox"]');
			if($(this).prop('checked')){
				b.prop('checked',true);
			}else{
				b.prop('checked',false);
			}
		});
		
		$("#tBody tr.active td input[name='objectCode']").click(function () {
			if($(this).is(':checked')){
				$(this).parent().parent().children("td").children(".abc").removeProp("readonly");	  
				$(this).parent().parent().children("td").children(".cba").removeProp("disabled");	  
				$(this).parent().parent().children("td").children(".xyz").removeProp("disabled");
			}else{
				$(this).parent().parent().children("td").children(".abc").prop("readonly","readonly");
				$(this).parent().parent().children("td").children(".cba").prop("disabled","disabled");
				$(this).parent().parent().children("td").children(".xyz").prop("disabled","disabled");
			}	
		}); 
		
		//点击删除
		$("#deleteBtn").click(function () {
			var chk_value =[];
			$('input[name="objectCode"]:checked').each(function(){   
		    	chk_value.push($(this).val());    
		    });
			if(chk_value.length==0){
				alert("请至少选择一条要删除的记录");
			}else{
				$.post(
						"user/jump/deleteTradingObjectByUserCode.do",
						{
							"chk_value":chk_value
							},
						function (data) {
							if(data == "true"){
								window.location.reload();
							}else{
								alert("删除失败");
							}
						}
					); 
			}
		});
		//点击修改
		$("#editBtn").click(function () {
			var chk_value =[];
			$('input[name="objectCode"]:checked').each(function(){   
		    	chk_value.push($(this).val());    
		    });
			if(chk_value.length==0){
				alert("请选择一条需要修改的记录");
			}else if(chk_value.length > 1){
				alert("只能选择一条需要修改的记录");
			}else{
			 	$("#changeobjectName").blur();
				$("#changeoriginalPrince").blur();
				$("#changesalePrice").blur();
				$("#changepostage").blur();
				if($("#changeobjectNameErrorMsg").text()==""
						&& $("#changeoriginalPrinceErrorMsg").text()==""
						&& $("#changesalePriceErrorMsg").text()==""
						&& $("#changepostageErrorMsg").text()=="" ){ 
					var data = new FormData();
					var objectCode = $("#tBody tr.active td input[name='objectCode']:checked").val();
					var objectName = $("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changeobjectName").val();
					var tradingTypeTode = $("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changetradingTypeTode").val();
					var parObjectCode = $("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changeparObjectCode").val();
					var originalPrince = parseFloat($("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changeoriginalPrince").val());
					var salePrice = parseFloat($("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changesalePrice").val());
					var postage = parseFloat($("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changepostage").val());
					var citycode = $("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changecityCode").val();
					var objectAddress = $.trim($("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changeobjectAddress").val());
					var textDescri = $.trim($("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changetextDescri").val());
					var pictureDescri = $("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changepictureFile")[0].files[0];
					var msg = $.trim($("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changemsg").val());
					var wantTradTypeCode = $("#tBody tr.active td input[name='objectCode']:checked").parent().parent().children("td").children("#changewantTradTypeCode").val();
					data.append("objectCode",objectCode);
					data.append("objectName",objectName);
					data.append("tradingTypeTode",tradingTypeTode);
					data.append("parObjectCode",parObjectCode);
					data.append("originalPrince",originalPrince);
					data.append("salePrice",salePrice);
					data.append("postage",postage);
					data.append("citycode",citycode);
					data.append("objectAddress",objectAddress);
					data.append("textDescri",textDescri);
					data.append("msg",msg);
					data.append("wantTradTypeCode",wantTradTypeCode); 
					data.append("pictureFile",pictureDescri);
					$.ajax({
							type:"POST",
							url:"user/jump/changeTradingObjectByUserCode.do",
							data:data,
							cache:false,
							processData: false,
						    contentType: false,
							success:function (data) {
								if(data == "true"){
									window.location.reload();
								}else{
									alert("修改失败");
								}
							},
							error: function (err) {
								window.location.reload();
				              }
					});
				 } 
			}
		});
		
		
		
	});
</script>
</head>
<body>

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

	<!-- 顶部 -->
	<div id="top" style="height: 40px; background-color: #96FED1; width: 100%;">
		<div style="position: absolute; top: 2px; left: 15x; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">GAGE闲置</div>
		
		
		<div style="position: absolute; top: 5px; left:48% ;color: red;font-family: 'times new roman'">
			<a href=""><span style="color:red;font-size: 25px;">发布的物品信息</span></a>
		</div>
		<div>
			<a href="${pageContext.request.contextPath}${backURL}" style="position: absolute;top:8px;right: 3%;background: white;"><span>&laquo;</span><span style="color: red;">返回</span></a>
		</div>
	</div>
	
	<div style="position:relative;top:30px;width: 100%">
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
			<div class="btn-group" style="position: relative; top: 18%;">
				<button id="editBtn" type="button" class="btn btn-warning"><span class="glyphicon glyphicon-pencil"></span> 点击修改</button>
				<button id="deleteBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span> 删除</button>
				<button id="objectModal" onclick="clickObjectModal()" type="button" class="btn btn-primary"><span class="glyphicon glyphicon-edit"></span> 物品发布</button>
			</div>
		</div>
		
		<div style="position: relative; left: 30px; top: -10px;">
			<table class="table table-hover" style="text-align: center;">
				<thead>
					<c:if test="${empty tList }">
						<tr>
							<th>您暂时还没有发布的物品</th>
						</tr>
					</c:if>
					<c:if test="${not empty tList }">
						<tr style="color: #B3B3B3;">
							<th style="text-align: left;">
							<input id="allStates" type="checkbox" />全选</th>
							<th>物品名称</th>
							<th>交易类型</th>
							<th>物品类型</th>
							<th>原价</th>
							<th>售卖价</th>
							<th>邮费</th>
							<th>城市</th>
							<th>详细地址</th>
							<th>物品描述</th>
							<th>物品图片</th>
							<th>其他说明</th>
							<th>想要交换的物品类型</th>
							<th>发布时间</th>
						</tr>
					</c:if>
				</thead>
				<tbody id="tBody">
					<c:if test="${not empty tList }">
						<c:forEach items="${tList }" var="t" varStatus="vs">
							<tr class="active">
								<td style="text-align: left;">
									<input type="checkbox" id="changeobjectCode" name="objectCode" value="${t.objectCode }" />
								</td>
								<td>
									<input class="abc" readonly="readonly" type="text" id="changeobjectName" name="changeobjectName" value="${t.objectName }" title="${t.objectName }" onblur="changeblurobjectName()" onfocus="changefocusobjectName()"><br/>
									<span id="changeobjectNameErrorMsg" style="color: red;font-size: 12px;"></span>
								</td>
								<td>
									<select class="xyz" disabled="disabled" id="changetradingTypeTode" name="changetradingTypeTode" onchange="changechangetradingTypeTode()" title="${t.tradingTypeName } ">
										<c:forEach items="${tradingTypeList }" var="ttl" varStatus="vs">
											<c:if test="${ttl.tradingTypeCode == t.tradingTypeTode }">
												<option value="${ttl.tradingTypeCode }" selected="selected">${ttl.tradingTypeName}</option>
											</c:if>
											<c:if test="${ttl.tradingTypeCode != t.tradingTypeTode }">
												<option value="${ttl.tradingTypeCode }">${ttl.tradingTypeName}</option>
											</c:if>
										</c:forEach>
		    						</select>
								</td>
								<td>
									<select class="xyz" disabled="disabled" id="changeparObjectCode" name="changeparObjectCode" title="${t.parObjectName }" >
										<c:forEach items="${parObjectTypeList }" var="potl" varStatus="vs">
											<c:if test="${potl.parObjectTypeCode == t.parObjectCode }">
												<option value="${potl.parObjectTypeCode }" objectCode="${potl.objectTypeCode }" selected="selected">${potl.parObjectTypeName }</option>
											</c:if>
											<c:if test="${potl.parObjectTypeCode != t.parObjectCode }">
												<option value="${potl.parObjectTypeCode }" objectCode="${potl.objectTypeCode }">${potl.parObjectTypeName }</option>
											</c:if>
										</c:forEach>
		    						</select>
								</td>
								<td>
									<input class="abc" readonly="readonly" type="text" id="changeoriginalPrince"  name="changeoriginalPrince" value="${t.originalPrince }" title="${t.originalPrince }元" onblur="changebluroriginalPrince()" onfocus="changefocusoriginalPrince()">
									<br/><span id="changeoriginalPrinceErrorMsg" style="color: red;font-size: 12px;"></span>
								</td>
								<td>
									<input class="abc" readonly="readonly" type="text" id="changesalePrice" name="changesalePrice" value="${t.salePrice }" title="${t.salePrice }元" onblur="changeblursalePrice()" onfocus="changefocussalePrice()">
									<br/><span id="changesalePriceErrorMsg" style="color: red;font-size: 12px;"></span>
								</td>
								<td>
									<input class="abc" readonly="readonly" type="text" id="changepostage" name="changepostage" value="${t.postage }" title="${t.postage }元" onblur="changeblurpostage()" onfocus="changefocuspostage()">
									<br/><span id="changepostageErrorMsg" style="color: red;font-size: 12px;"></span>
								</td>
								<td>
									<select class="xyz" disabled="disabled" id="changecityCode" name="changecitycode" title="${t.cityName }">
										<c:forEach items="${cList }" var="c" varStatus="vs">
											<c:if test="${c.cityCode == t.citycode }">
												<option value="${c.cityCode }" provincecode="${c.provinceCode }" selected="selected">${c.cityName }</option>
											</c:if>
											<c:if test="${c.cityCode != t.citycode }">
												<option value="${c.cityCode }" provincecode="${c.provinceCode }">${c.cityName }</option>
											</c:if>
										</c:forEach>
		    						</select>
								</td>
								<td>
									<input class="abc" readonly="readonly" type="text" id="changeobjectAddress" name="changeobjectAddress" value="${t.objectAddress }" title="${t.objectAddress }">
								</td>
								<td>
									<input class="abc" readonly="readonly" type="text" id="changetextDescri" name="changetextDescri" value="${t.textDescri }" title="${t.textDescri }" />
								</td>
								<td>
									<img src="${pageContext.request.contextPath }/${t.pictureDescri}" width="50px" height="50px" title="点击查看物品详细信息" />
									<input class="cba" disabled="disabled" type="file" id="changepictureFile" name="changepictureFile" multiple="multiple" />
								</td>
								<td>
									<input class="abc" readonly="readonly" type="text" id="changemsg" name="changemsg" value="${t.msg }" title="${t.msg }" />
								</td>
								<td>
									<select class="zyx" disabled="disabled" id="changewantTradTypeCode" name="changewantTradTypeCode" title="${t.wantTradTypeName }" >
											<option value=""></option>
										<c:forEach items="${parObjectTypeList }" var="potl" varStatus="vs">
											<c:if test="${potl.parObjectTypeCode == t.wantTradTypeCode }">
												<option value="${potl.parObjectTypeCode }" objectCode="${potl.objectTypeCode }" selected="selected">${potl.parObjectTypeName }</option>
											</c:if>
											<c:if test="${potl.parObjectTypeCode != t.wantTradTypeCode }">
												<option value="${potl.parObjectTypeCode }" objectCode="${potl.objectTypeCode }">${potl.parObjectTypeName }</option>
											</c:if>
										</c:forEach>
		    						</select>
								</td>
								<td>
									<span id="releaseTime" name="releaseTime">${t.releaseTime}</span>
								</td>
						</c:forEach>
					</c:if>
				</tbody>
		</table>
	</div>
</div>	

	<input id="userCode" type="text" hidden=true value="${userCode}">	
	<span id="user" hidden="hidden">${userName }</span>
	<iframe src="${pageContext.request.contextPath}/user/jump/toObjectMsg.do?userName=${userName}&backURL=${pageContext.request.contextPath}${backURL}" frameborder="0" id="frameName" name="frameName" style="display: none;"></iframe>
</body>
</html>
