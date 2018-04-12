<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap需要JQuery才能正常工作，所以需要导入jquery.min.js
	接着是 Bootstrap的css，里面定义了各种样式
	最后是 Bootstrap的js，用于产生交互效果，比如关闭警告框 -->
<link href="../css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" />
<script src="../js/jquery/2.0.0/jquery.min.js"></script>
<script src="../js/bootstrap/3.3.6/bootstrap.min.js"></script>

<!-- 日期插件 -->
<script src="../layDate-v5.0.9/laydate/laydate.js"></script>

<title>个人信息</title>
<!-- 贴在顶部(不会消失） -->
<style>
body {
	padding-top: 70px;
}

div.container div.row div {
	margin: 5px 0px;
}

div.container div.row div {
	background-color: #EFEFEF;
	border: 1px solid gray;
	text-align: center;
}
</style>
</head>

<body>
	<!-- 贴在顶部(不会消失） -->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="text-right">
		<button class="btn btn-info"
			onclick="window.location='../index.jsp'">首页</button>
		<c:choose>
			<c:when test="${onlinePassenger==null}">
				<button class="btn btn-success"
					onclick="javascrtpt:window.location.href='../Passenger/jumpLogin'">登陆</button>
				<button class="btn btn-default"
					onclick="javascrtpt:window.location.href='../Passenger/jumpRegister'">注册</button>
			</c:when>
			<c:otherwise>
				<button class="btn btn-success"
					onclick="javascrtpt:window.location.href='../Passenger/jumpInformation'">个人</button>
				<button class="btn btn-default"
					onclick="javascrtpt:window.location.href='../Passenger/logout'">注销</button>
			</c:otherwise>
		</c:choose>
	</div>
	</nav>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 ">
				<table class="table table-hover" id="table1">
					<tbody>
							<tr>
								<td>出发地点:<input type="text" id="departurePlace"></td>
								<td>到达地点:<input type="text" id="arrivalPlace"></td>

								<td>出发时间:<input type="text" id="departureTime"></td>
								<td><button onclick="research()">重新搜索</button></td>
							</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-xs-6 ">航班信息</div>
			<div class="col-xs-2 ">头等舱</div>
			<div class="col-xs-2 ">经济舱</div>
			<div class="col-xs-2 ">选择</div>
		</div>
	</div>
	<div id="result"></div>
</body>
<script>
//进页面之前先请求一次航班数据
$(document).ready(function(){
	var departurePlace="${departurePlace}";
	var	arrivalPlace="${arrivalPlace}";
	console.log(departurePlace+arrivalPlace);
	$.ajax({
		type : "post",
		dataType : "json",
		url : "redetailedSearch",
		data : {
			departurePlace : departurePlace,
			arrivalPlace : arrivalPlace
		},
		success : function(date) {
			var str="";
			for(var i=0;i<date.length;i++){
			str+="<div class='container'>";
			str+="<div class='row'>";
			str+="<div class='col-xs-6 '>飞机编号："+date[i]['aId']+"<br>";
			str+=date[i]['departureTime']+" 至 "+date[i]['arrivalTime']+"<br>"
			str+=date[i]['departurePlace']+" -  "+date[i]['arrivalPlace']+"</div>"
			str+="<div class='col-xs-2 '>"+date[i]['fristclassPrice']+"<input type='radio' name="+date[i]['fId']+" value=0 ><br><br>剩余座位"+date[i]['fristclassCount']+"</div>";
			str+="<div class='col-xs-2 '>"+date[i]['economyPrice']+"<input type='radio' name="+date[i]['fId']+" value=1 ><br><br>剩余座位"+date[i]['economyCount']+"</div>";
			str+="<div class='col-xs-2 ' onclick='choose(this)' data-fId ="+date[i]['fId']+">确认</div>";
			str+="</div></div>";
			}
			$('#result').append(str);
		},
		error : function() {
			alert("查询失败");
		}
	});

})
//重新搜索，用ajax请求数据
function research(){
	$('#result').html("");
	var departurePlace=document.getElementById("departurePlace").value;
	var	arrivalPlace=document.getElementById("arrivalPlace").value;
	console.log(departurePlace+arrivalPlace);
	$.ajax({
		type : "post",
		dataType : "json",
		url : "redetailedSearch",
		data : {
			departurePlace : departurePlace,
			arrivalPlace : arrivalPlace
		},
		success : function(date) {
			var str="";
			for(var i=0;i<date.length;i++){
			str+="<div class='container'>";
			str+="<div class='row'>";
			str+="<div class='col-xs-6 '>飞机编号："+date[i]['aId']+"<br>";
			str+=date[i]['departureTime']+" 至 "+date[i]['arrivalTime']+"<br>"
			str+=date[i]['departurePlace']+" -  "+date[i]['arrivalPlace']+"</div>"
			str+="<div class='col-xs-2 '>"+date[i]['fristclassPrice']+"<input type='radio' name="+date[i]['fId']+" value=0 ><br><br>剩余座位"+date[i]['fristclassCount']+"</div>";
			str+="<div class='col-xs-2 '>"+date[i]['economyPrice']+"<input type='radio' name="+date[i]['fId']+" value=1 ><br><br>剩余座位"+date[i]['economyCount']+"</div>";
			str+="<div class='col-xs-2 ' onclick='choose(this)' data-fId ="+date[i]['fId']+">确认</div>";
			str+="</div></div>";
			}
			$('#result').append(str);
		},
		error : function() {
			alert("查询失败");
		}
	});
}

function choose(obj){
	var fId=obj.getAttribute('data-fId');
	//为了区分不同的单选项，采用航班ID做name
	var choose=$("input[name="+fId+"]:checked").val();

	if(choose==null){
		alert("未选择舱位");
	}else{
		if(${onlinePassenger!=null}){
			$.ajax({
				type : "post",
				url : "creatTicket",
				data : {
					fId : fId,
					choose : choose
				},
				success : function(date) {
					javascrtpt:window.location.href="../Passenger/jumpInformation";
				},
				error : function() {
					alert("请重试");
				}
			});
		}else{
			alert("请先登录");
		}
	}
}
</script>
</html>