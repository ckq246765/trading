function blurUserName() {
	if ($.trim($("#userName").val()) == "") {
		$("#userNameErrorMsg").text("用户名不能为空");
	}else{
		$.post(
			"user/checkUserName.do",
			{
				"userName":$.trim($("#userName").val())
			},
			function(data) {
				if(data=="true"){
					$("#userNameErrorMsg").text("用户名已使用，请重新输入");
				}
			}
		);
	}
}
function clickUserName() {
	$("#userNameErrorMsg").text("");
}
function blurPassWord() {
	if ($.trim($("#passWord").val()) == "") {
		$("#passWordErrorMsg").text("密码不能为空");
	} else if ($.trim($("#passWordAgin").val()) != $.trim($("#passWord").val())) {
		$("#passWordAginErrorMsg").text("密码不一致，请重新输入");
	}
}
function focusPassWord() {
	$("#passWordAginErrorMsg").text("");
	$("#passWordErrorMsg").text("");
}
function blurPassWordAgin() {
	if ($.trim($("#passWordAgin").val()) != $.trim($("#passWord").val())) {
		$("#passWordAginErrorMsg").text("密码不一致，请重新输入");
	}
}
function focusPassWordAgin() {
	$("#passWordAginErrorMsg").text("");
}
function blurName() {
	if ($.trim($("#name").val()) == "") {
		$("#nameErrorMsg").text("姓名不能为空");
	}
}
function focusName() {
	$("#nameErrorMsg").text("");
}
function blurAge() {
	var regExp = /^[1-9]\d*|0$/;
	var ok = regExp.test($.trim($("#age").val()));
	if (!ok) {
		$("#ageErrorMsg").text("年龄输入格式不正确");
	}
}
function focusAge() {
	$("#ageErrorMsg").text("");
}
function blurPhone() {
	var regExp = /^(\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$/;
	var ok = regExp.test($.trim($("#phone").val()));
	if (!ok) {
		$("#phoneErrorMsg").text("手机号码输入格式不正确");
	}
}
function focusPhone() {
	$("#phoneErrorMsg").text("");
}
function blurEmail() {
	var regExp = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	var ok = regExp.test($.trim($("#email").val()));
	if (!ok) {
		$("#emailErrorMsg").text("邮箱输入不正确");
	}
}
function focusEmail() {
	$("#emailErrorMsg").text("");
}
function changeProvinceCode() {
	var changeProvinceCode = $("#provinceCode option:selected").val();
	$.post("user/getCityByProvince.do", {
		"provinceCode" : changeProvinceCode
	}, function(data) {
		$("#cityCode").empty();
		$(data).each(
				function(i, n) {
					$("#cityCode").append(
							"<option value='" + n.cityCode + "' provinceCode='"
									+ n.provinceCode + "' provinceName='"
									+ n.provinceName + "' >" + n.cityName
									+ "</option>");
				})
	});
}
function blurAddress() {
	if ($.trim($("#address").val()) == "") {
		$("#addressErrorMsg").text("详细地址不能为空");
	}
}
function focusAddress() {
	$("#addressErrorMsg").text("");
}
function changeCityCode() {
	if ($("#provinceCode option:selected").val() == ""
			|| $("#provinceCode option:selected").val() != $("#cityCode").find(
					"option:selected").attr("provinceCode")) {
		$("#provinceCode").val(
				$("#cityCode").find("option:selected").attr("provinceCode"));
	}
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
function clickSubmit() {
	$("#userName").blur();
	$("#passWord").blur();
	$("#passWordAgin").blur();
	$("#name").blur();
	$("#phone").blur();
	$("#email").blur();
	if ($("#userNameErrorMsg").text() == ""
			&& $("#passWordErrorMsg").text() == ""
			&& $("#passWordAginErrorMsg").text() == ""
			&& $("#nameErrorMsg").text() == ""
			&& $("#phoneErrorMsg").text() == ""
			&& $("#emailErrorMsg").text() == ""
			&& $('input:radio[name="sex"]:checked').val() != null) {
		$.post("user/regist.do", {
			"userName" : $.trim($("#userName").val()),
			"passWord" : $.trim($("#passWordAgin").val()),
			"name" : $.trim($("#name").val()),
			"sex" : $('input:radio[name="sex"]:checked').val(),
			"age" : parseInt($.trim($("#age").val())),
			"phone" : $.trim($("#phone").val()),
			"email" : $.trim($("#email").val()),
			"address" : $.trim($("#address").val()),
			"provinceCode" : $("#provinceCode option:selected").val(),
			"cityCode" : $("#cityCode option:selected").val(),
			"regDate" : new Date().format("yyyy-MM-dd hh:mm:ss"),
			"state" : "1"
		}, function(data) {
			if (data == "true") {
				alert("注册成功");
				window.location.href="jump/tojsp.do?target=show";
			} else {
				$("#ErrorMsg").text("注册失败");
			}
		});
	} else {
		$("#ErrorMsg").text("请检查输入各项是否合规");
	}
}
function clickReset() {
	$("#ErrorMsg").text("");
	$("#userNameErrorMsg").text("");
	$("#passWordErrorMsg").text("");
	$("#passWordAginErrorMsg").text("");
	$("#nameErrorMsg").text("");
	$("#phoneErrorMsg").text("");
	$("#ageErrorMsg").text("");
	$("#emailErrorMsg").text("");
	$("#userForm")[0].reset();
}