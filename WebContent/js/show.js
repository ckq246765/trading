function editPwd() {
	$("#editPwdModalForm")[0].reset();
	$("#editPwdModal").modal("show");
	$("#oldPwdErrorMsg").text("");
	$("#newPwdErrorMsg").text("");
	$("#confirmPwdErrorMsg").text("");
	$("#pwdErrorMsg").text("");
}

function closeEditBtn() {
	$("#editPwdModal").modal("hide");
	$("#oldPwdErrorMsg").text("");
	$("#newPwdErrorMsg").text("");
	$("#confirmPwdErrorMsg").text("");
	$("#pwdErrorMsg").text("");
}

function blurOldPwd() {
	if($.trim($("#oldPwd").val())==""){
		$("#oldPwdErrorMsg").text("密码不能为空");
	}
}

function focusOldPwd() {
	$("#oldPwdErrorMsg").text("");
	$("#pwdErrorMsg").text("");
	$("#confirmPwdErrorMsg").text("");
}

function blurConfirmPwd() {
	var confirmpwd = $.trim($("#confirmPwd").val());
	var newpwd = $.trim($("#newPwd").val());
	if(confirmpwd != newpwd){
		$("#confirmPwdErrorMsg").text("密码不一致，请重新输入");
	}
}

function focusConfirmPwd() {
	$("#confirmPwdErrorMsg").text("");
	$("#pwdErrorMsg").text("");
}

function blurNewPwd() {
	var oldPwd = $.trim($("#oldPwd").val());
	var newpwd = $.trim($("#newpwd").val());
	var confirmpwd = $.trim($("#confirmpwd").val());
	if($.trim($("#newPwd").val())==""){
		$("#newPwdErrorMsg").text("密码不能为空");
	}else if($.trim($("#newPwd").val()) == oldPwd){
		$("#newPwdErrorMsg").text("请输入新密码");
	}else if(confirmpwd != newpwd){
		$("#confirmPwdErrorMsg").text("密码不一致，请重新输入");
	}
	$("#confirmPwdErrorMsg").text("");
}

function focusNewPwd() {
	$("#newPwdErrorMsg").text("");
	$("#pwdErrorMsg").text("");
}

function savePwdBtn() {
	var oldPwd = $.trim($("#oldPwd").val());
		var newPwd = $.trim($("#newPwd").val());
		var userName = $("#user").text();
		$("#oldPwd").blur();
		$("#newPwd").blur();
		$("#confirmPwd").blur();
		var oldPwd = $("#oldPwdErrorMsg").text();
		var newPwd = $("#newPwdErrorMsg").text();
		var confirmPwd = $("#confirmPwdErrorMsg").text();
		if(oldPwd=="" && newPwd=="" && confirmPwd==""){
			$.ajax({
				type:"post",
				url:"sys/changeUserPwd.do",
				data:{
					"userName":userName,
					"oldPwd":$.trim($("#oldPwd").val()),
					"newPwd":$.trim($("#newPwd").val())
				},
				success : function (data) {
					if(data != null){
						alert(data);
						$("#editPwdModal").modal("hide");
					}else{
						alert("提交失败,请重试");
					}
				}
			});
		}else{
			$("#pwdErrorMsg").text("请检查填写是否正确");
		}
}

//userMsg
function userMsg() {
	var userName = $("#user").text();
	$("#userMsgForm")[0].reset();
	$("#updateUserModal").modal("show");
	$.post(
			"user/getProvinceAndCity.do",
			{
				"userName":userName
			},
			function(data) {
				$("#provinceCode").empty();
				$("#CityCode").empty();
				$(data.pList).each(function(i,n) {
					$("#provinceCode").append("<option value='"+n.provinceCode+"'>"+n.provinceName+"</option>");
				})
				$(data.cList).each(function(i,n) {
					$("#CityCode").append("<option value='"+n.cityCode+"' provinceCode='"+n.provinceCode+"' provinceName='"+n.provinceName+"'>"+n.cityName+"</option>");
				})
				$("#userMsgUserName").attr("user_code",data.user.user_code);
				$("#userMsgUserName").val(data.user.userName);
				$("#name").val(data.user.name);
				$("#sex").val(data.user.sex);
				$("#age").val(data.user.age);
				$("#phone").val(data.user.phone);
				$("#email").val(data.user.email);
				$("#provinceCode").val(data.user.provinceCode);
				$("#cityCode").val(data.user.cityCode);
				$("#address").val(data.user.address);
			}
			);
}

function closeUserMsg() {
	$("#updateUserModal").modal("hide");
	$("#userMsgUserNameErrorMsg").text("");
	$("#ErrorMsg").text("");
	$("#nameErrorMsg").text("");
	$("#ageErrorMsg").text("");
	$("#phoneErrorMsg").text("");
	$("#emailErrorMsg").text("");
	$("#addressErrorMsg").text("");
}
function bluruserMsgUserName() {
	if ($.trim($("#userMsgUserName").val()) == "") {
		$("#userMsgUserNameErrorMsg").text("用户名不能为空");
	}
}

function focususerMsgUserName() {
	$("#userMsgUserNameErrorMsg").text("");
}
function saveChangeUser() {
	$("#userMsgUserName").blur();
	$("#name").blur();
	$("#phone").blur();
	$("#email").blur();
	if ($("#userMsgUserNameErrorMsg").text() == ""
			&& $("#nameErrorMsg").text() == ""
			&& $("#phoneErrorMsg").text() == ""
			&& $("#emailErrorMsg").text() == "") {
		$.post("user/cahngeUserMsg.do", {
			"user_code":$("#userMsgUserName").attr("user_code"),
			"userName" : $.trim($("#userMsgUserName").val()),
			"name" : $.trim($("#name").val()),
			"sex" : $('input:radio[name="sex"]:checked').val(),
			"age" : parseInt($.trim($("#age").val())),
			"phone" : $.trim($("#phone").val()),
			"email" : $.trim($("#email").val()),
			"address" : $.trim($("#address").val()),
			"provinceCode" : $("#provinceCode option:selected").val(),
			"cityCode" : $("#cityCode option:selected").val()
		}, function(data) {
			if (data == "true") {
				alert("修改成功");
				$("#updateUserModal").modal("hide");
			} else {
				$("#ErrorMsg").text("修改失败");
			}
		});
	} else {
		$("#ErrorMsg").text("请检查输入各项是否合规");
	}
}

//objectModal
function clickObjectModal() {
	var userName = $("#user").text();
	$("#tradingObjectForm")[0].reset();
	$("#createObjModal").modal("show");
	/*if($("#user").innerHtml == undefined){
		$("#createObjModal").modal("hide");
		alert("请先登录");
	}else{*/
		$.post(
				"user/objectShow.do",
				{"userName":userName},
				function(data) {
					var html = "<option value=''></option>";
					$(data.pList).each(function(i,n) {
						html += "<option value='"+n.parObjectTypeCode+"' objectCode='"+n.objectTypeCode+"'>"+n.parObjectTypeName+"</option>";
					});
					$("#wantTradTypeCode").html(html);
					/*$("#wantTradTypeCode").empty();
					$(data.pList).each(function(i,n) {
						$("#wantTradTypeCode").append("<option value='"+n.parObjectTypeCode+"' objectCode='"+n.objectTypeCode+"'>"+n.parObjectTypeName+"</option>");
					});*/
					$("#tradingTypeTode").empty();
					$(data.tList).each(function(i,n) {
						$("#tradingTypeTode").append("<option value='"+n.tradingTypeCode+"'>"+n.tradingTypeName+"</option>");
					});
					$("#parObjectCode").empty();
					$(data.pList).each(function(i,n) {
						$("#parObjectCode").append("<option value='"+n.parObjectTypeCode+"' objectCode='"+n.objectTypeCode+"'>"+n.parObjectTypeName+"</option>");
					});
					$("#CityCode").empty();
					$(data.cList).each(function(i,n) {
						$("#CityCode").append("<option value='"+n.cityCode+"' provincecode='"+n.provinceCode+"'>"+n.cityName+"</option>");
					});
					$("#CityCode").val(data.user.cityCode);
					$("#objectAddress").val(data.user.address);
				});
}
function changetradingTypeTode() {
	var tradingTypeTode = $("#tradingTypeTode option:selected").val();
	if(tradingTypeTode == "TY02"){
		$("#divwantTradTypeCode").removeProp("hidden");
	}else{
		$("#divwantTradTypeCode").prop("hidden",true);
	}
}
function changechangetradingTypeTode() {
	var tradingTypeTode = $("#changetradingTypeTode option:selected").val();
	if(tradingTypeTode == "TY02"){
		$("#changewantTradTypeCode").removeProp("disabled");
	}else{
		$("#changewantTradTypeCode").val("");
		$("#changewantTradTypeCode").prop("disabled","disabled");
	}
}
function blurobjectName() {
	if($.trim($("#objectName").val())==""){
		$("#objectNameErrorMsg").text("请输入商品名称");
	}
}
function changeblurobjectName() {
	if($.trim($("#changeobjectName").val())==""){
		$("#changeobjectNameErrorMsg").text("请输入商品名称");
	}
}
function focusobjectName() {
	$("#objectNameErrorMsg").text("");
}
function changefocusobjectName() {
	$("#changeobjectNameErrorMsg").text("");
}
function bluroriginalPrince() {
	var regExp = /^(([1-9]{1}[0-9]*)|([0]{1}))(.[0-9]{1,2})?$/;
	var originalPrince = $.trim($("#originalPrince").val());
	if(originalPrince!=""){
		if(!regExp.test(originalPrince)){
			$("#originalPrinceErrorMsg").text("请检查输入格式是否正确");
		}
	}
}
function changebluroriginalPrince() {
	var regExp = /^(([1-9]{1}[0-9]*)|([0]{1}))(.[0-9]{1,2})?$/;
	var changeoriginalPrince = $.trim($("#changeoriginalPrince").val());
	if(changeoriginalPrince!=""){
		if(!regExp.test(changeoriginalPrince)){
			$("#changeoriginalPrinceErrorMsg").text("请检查输入格式是否正确");
		}
	}
}
function focusoriginalPrince() {
	$("#originalPrinceErrorMsg").text("");
}
function changefocusoriginalPrince() {
	$("#changeoriginalPrinceErrorMsg").text("");
}
function blursalePrice() {
	var regExp = /^(([1-9]{1}[0-9]*)|([0]{1}))(.[0-9]{1,2})?$/;
	var salePrice = $.trim($("#salePrice").val());
	if(salePrice!=""){
		if(!regExp.test(salePrice)){
			$("#salePriceErrorMsg").text("请检查输入格式是否正确");
		}
	}
}
function changeblursalePrice() {
	var regExp = /^(([1-9]{1}[0-9]*)|([0]{1}))(.[0-9]{1,2})?$/;
	var salePrice = $.trim($("#changesalePrice").val());
	if(salePrice!=""){
		if(!regExp.test(salePrice)){
			$("#changesalePriceErrorMsg").text("请检查输入格式是否正确");
		}
	}
}
function focussalePrice() {
	$("#salePriceErrorMsg").text("");
}
function changefocussalePrice() {
	$("#changesalePriceErrorMsg").text("");
}
function blurpostage() {
	var regExp = /^(([1-9]{1}[0-9]*)|([0]{1}))(.[0-9]{1,2})?$/;
	var postage = $.trim($("#postage").val());
	if(postage!=""){
		if(!regExp.test(postage)){
			$("#postageErrorMsg").text("请检查输入格式是否正确");
		}
	}
}
function changeblurpostage() {
	var regExp = /^(([1-9]{1}[0-9]*)|([0]{1}))(.[0-9]{1,2})?$/;
	var postage = $.trim($("#changepostage").val());
	if(postage!=""){
		if(!regExp.test(postage)){
			$("#changepostageErrorMsg").text("请检查输入格式是否正确");
		}
	}
}
function focuspostage() {
	$("#postageErrorMsg").text("");
}
function changefocuspostage() {
	$("#changepostageErrorMsg").text("");
}
function blurobjectAddress() {
	if($.trim($("#objectAddress").val())==""){
		$("#objectAddressErrorMsg").text("地址不能为空");
	}
}
function focusobjectAddress() {
	$("#objectAddressErrorMsg").text("");
}
function closecreateObjModal() {
	$("#tradingObjectForm")[0].reset();
	$("#createObjModal").modal("hide");
}
Date.prototype.format = function (format) {
    var args = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter
        "S": this.getMilliseconds()
    };
    if (/(y+)/.test(format))
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var i in args) {
        var n = args[i];
        if (new RegExp("(" + i + ")").test(format))
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? n : ("00" + n).substr(("" + n).length));
    }
    return format;
};
/*function savecreateObjModal() {
	$("#objectName").blur();
	$("#originalPrince").blur();
	$("#salePrice").blur();
	$("#postage").blur();
	$("#objectAddress").blur();
	if ($("#objectNameErrorMsg").text() == ""
			&& $("#originalPrinceErrorMsg").text() == ""
			&& $("#salePriceErrorMsg").text() == ""
			&& $("#postageErrorMsg").text() == ""
			&& $("#objectAddressErrorMsg").text() == "") {
		$.post(
			"user/savecreateObjModal.do",
			{
				"objectName":$.trim($("#objectName").val()),
				"salePrice1":$.trim($("#salePrice").val()),
				"originalPrince1":$.trim($("#originalPrince").val()),
				"postage1":$.trim($("#postage").val()),
				"provincecode":$("#CityCode option:selected").attr("provincecode"),
				"citycode":$("#CityCode option:selected").val(),
				"textDescri":$.trim($("#textDescri").val()),
				"parObjectCode":$("#parObjectCode option:selected").val(),
				"tradingTypeTode":$("#tradingTypeTode option:selected").val(),
				"releaseTime":new Date().format("yyyy-MM-dd hh:mm:ss"),
				"msg":$.trim($("#msg").val()),
				"wantTradTypeCode":$("#wantTradTypeCode option:selected").val(),
				"objectAddress":$.trim($("#objectAddress").val()),
				"objectUserName":$("#user").text(),
				"pictureFile":$("#pictureFile").val()
			},
			function(data) {
				alert(data);
			}
		);
	}
}*/

function mouseoverGetUserName() {
	 $("#objectUserName").val($.trim($("#user").text()));
	 $("#releaseTime").val(new Date().format("yyyy-MM-dd hh:mm:ss"));
	 $("#objectName").val($.trim($("#objectName").val()));
	 $("#CityCode").val($("#CityCode option:selected").val());
}

