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
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="multipart/form-data; charset=UTF-8">
<title>GaGe交易平台</title>
<script type="text/javascript">
	$(document).ready(function () {
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
		 
		$("#save").click(function () {
			var objectCode = $("#objectCode").val();
			var evaluateText = $.trim($("#pingjia").val());
			var evaluatePicture = $("#pictureFile")[0].files[0];
			var evaluateUser = $("#evaluateUserCode").val();
			var userCode = $("#userCode").val();
			var orderCode = $("#orderCode").val();
			
			var data = new FormData();
			data.append("objectCode",objectCode);
			data.append("evaluateText",evaluateText);
			data.append("pictureFile",evaluatePicture);
			data.append("evaluateUser",evaluateUser);
			data.append("userCode",userCode);
			data.append("orderCode",orderCode);
			
			$.ajax({
				type:"POST",
				//url:"user/jump/changeTradingObjectByUserCode.do",
				url:"user/jump/saveEvaluate.do",
				data:data,
				cache:false,
				processData: false,
			    contentType: false,
				success:function (data) {
					if(data.success == "true"){
						success_prompt("评论成功",1500);
						window.location.href = "jump/toOrder.do?target=order/all/notpj&userCode="+data.userCode;
					}else{
						fail_prompt("评论失败",1500);
					}
				},
				error: function (err) {
					window.location.reload();
	              }
		});
		});
	});
</script>
</head>
<body>
<input type="text" hidden="hidden" id="orderCode" value="${orderCode }" />
<input type="text" hidden="hidden" id="objectCode" value="${objectCode }" />
<input type="text" hidden="hidden" id="evaluateUserCode" value="${userCode }" />
<input type="text" hidden="hidden" id="backURL" value="${backURL }" />
<input type="text" hidden="hidden" id="userCode" value="${tObject.objectUserCode }" />

<div id="center" style="position: absolute;top: 0px; bottom: 30px; left: 0px; right: 0px;">
	<div style="position: relative;top:20px;left: 0px;width: 60%;text-align:center">
			<span style="color: blue;font-size: 30px;">物品图片</span><br><br>
			<img src="${pageContext.request.contextPath }/${tObject.pictureDescri}" class="img-rounded" style="position:relative;width: 45%;height: 25%;">
	</div>

	<div style="position: absolute;top: 0px; left: 60%;width: 37%;text-align: left;">
			<input id="objectCode" hidden="hidden" value="${tObject.objectCode }" />
			<span style="color: blue;font-size: 30px;">${tObject.objectName }</span><br><br>
			<span>售价: </span><span style="color: red;"><i>￥</i> ${tObject.salePrice } 元</span><br><br>
			<span>原价: </span><span style="color: red;"><i>￥</i> ${tObject.originalPrince } 元</span><br><br>
			<span>邮费: </span><span style="color: red;"><i>￥</i> ${tObject.postage } 元</span><br><br>
			<span style="color:black;">卖家描述:</span><span style="color:blue"> ${tObject.textDescri }</span><br><br>
			<span style="color:black;">卖家地址:</span><span style="color:blue;"> ${tObject.provinceName }&nbsp;${tObject.cityName }</span><br><br>
			<span style="color:black;">其他描述:</span><span style="color:blue;"> ${tObject.msg }</span><br><br>
			<span style="color:black;">详细地址:</span><span style="color:blue;"> ${tObject.objectAddress }</span><br><br>
			<span style="color:black;">卖&nbsp;&nbsp;家:</span><span style="color:red;"> ${tObject.objectUserName }</span><span> 已认证</span><br><br>
			<span>交易日期: </span><span style="color: red;"><i>￥</i> ${tObject.tradingDate} </span><br><br>
	</div>
</div>
<div style="position: absolute;top: 380px;  left: 20px;width: 100%; text-align: left;">
<span style="position: absolute;">评价：</span><textarea style="position:absolute;left: 35px;" id="pingjia" rows="4" cols="20"></textarea>
<span style="position: absolute;left: 220px;">图片：</span><input style="position: absolute;top:-5px;left: 255px;" type="file" class="form-control" id="pictureFile" name="pictureFile" multiple="multiple"/>
<input style="position: absolute;top:80px;left: 250px;width: 220px;color: red;" type="button" id="save" value="发表" />
</div>

</body>
</html>
