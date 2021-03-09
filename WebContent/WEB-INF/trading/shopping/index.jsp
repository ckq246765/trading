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
<link href="${pageContext.request.contextPath }/css/shop.css" type="text/css" rel="stylesheet" />

<meta http-equiv="Content-Type" content="multipart/form-data; charset=UTF-8">
<title>GaGe交易平台</title>
<script type="text/javascript">
	$(document).ready(function () {
		//复选框全选中=状态
		$("#allStates").click(function () {
			var b = $('#tBody tr.active input[type="checkbox"]');
			if($(this).prop('checked')){
				b.prop('checked',true);
			}else{
				b.prop('checked',false);
			}
		});
		
		//点击删除
		$("#deleteBtn").click(function () {
			var userCode = $("#userCode").val();
			var chk_value =[];
			$('input[name="objectCode"]:checked').each(function(){   
		    	chk_value.push($(this).val());    
		    });
			if(chk_value.length==0){
				alert("请至少选择一条要删除的记录");
			}else{
				$.post(
						"user/jump/deleteTradingObject.do",
						{
							"chk_value":chk_value,
							"userCode":userCode
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
		
		
	});
</script>
</head>
<body>
	<!-- 顶部 -->
	<div id="top" style="height: 40px; background-color: #96FED1; width: 100%;">
		<div style="position: absolute; top: 2px; left: 15x; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">GAGE闲置</div>
		
		
		<div style="position: absolute; top: 5px; left:53% ;color: red;font-family: 'times new roman'">
			<a href=""><span style="color:red;font-size: 25px;">购物车清单</span></a>
		</div>
		<div>
			<a href="${pageContext.request.contextPath}${backURL}" style="position: absolute;top:8px;right: 3%;background: white;"><span>&laquo;</span><span style="color: red;">返回</span></a>
		</div>
	</div> 
	
	<div style="position:relative;top:30px;width: 100%">
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
			<div class="btn-group" style="position: relative; top: 18%;">
			  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editDeptModal"><span class="glyphicon glyphicon-edit"></span> 点击结算</button>
			  <button id="deleteBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>
		</div>
		<%-- 单前用户编码 --%>
		<input id="userCode" type="text" hidden=true value="${sList[0].userCode}">
		
		<div style="position: relative; left: 30px; top: -10px;">
			<table class="table table-hover" style="text-align: center;">
				<thead>
					<c:if test="${not empty tList }">
						<tr style="color: #B3B3B3;">
							<th style="text-align: left;">
							<input id="allStates" type="checkbox" />全选</th>
							<th>物品列表</th>
							<th>添加时间</th>
						</tr>
					</c:if>
				</thead>
				<tbody id="tBody">
					<c:if test="${not empty tList }">
						<c:forEach items="${tList }" var="t" varStatus="vs">
							<tr class="active">
								<td style="text-align: left;">
									<input type="checkbox" name="objectCode" value="${t.objectCode }" />
								</td>
								<td>
									<a class="a" href="${pageContext.request.contextPath }/jump/toObject.do?objectCode=${t.objectCode}">
										<img src="${pageContext.request.contextPath }/${t.pictureDescri}" width="50" height="50" title="点击查看物品详细信息" /><br/>
										<span>${t.objectName }</span><br/>
										<span>${t.textDescri }</span><br/>
										<span class="goods-price--grey"><span>售价:<i>￥</i>${t.salePrice }元</span></span><br/>
									</a>
								</td>
								<td>
									<c:forEach items="${sList}" var="s" varStatus="vs">
										<c:if test="${s.objectCode == t.objectCode }">
											${s.addDate }
										</c:if>
									</c:forEach>
								</td>
						</c:forEach>
					</c:if>
				</tbody>
		</table>
	</div>
	<br/>
	<div style="text-align: center;">
		<h2>
			<span style="color: red;">推&nbsp;&nbsp;&nbsp;&nbsp;荐</span>
		</h2>
		<div>
			<ul style="text-align: center;" id="ulBody">
				<c:if test="${not empty toList}">
					<c:forEach items="${toList }" var="o" varStatus="vs">
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
	</div>
	
	
	<div style="position: relative;top:10px;"></div>
		<div style="position: relative;top:20px;left: 0.1%;">
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

</body>
</html>