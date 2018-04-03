<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" />
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<title>使用 layDate 独立版</title>
</head>
<body>
	<input type="text" id="test5" onclick="test(this)" value="">
	<button class="btn btn-primary " id="aaa">改签</button>
	<script src="layDate-v5.0.9/laydate/laydate.js"></script>
	<table class="table table-hover" id="DictTypeTable">
		<thead>
			<th>序号</th>
			<th>航班编号</th>
			<th>航空公司</th>
			<th>飞机编号</th>
			
		</thead>
		<tbody id="tbody-result">  
			
		</tbody>
	</table>


	<!-- 改成你的路径 -->
	<script>
		//执行一个laydate实例
		laydate.render({
			elem : '#test1' //指定元素
		});
		//时间选择器，YYYY-XX-ZZ-AA:BB:CC
		laydate.render({
			elem : '#test5',
			type : 'datetime'
		});

		$('#aaa').click(function() {
			var a = "aa";
			var tbody=window.document.getElementById("tbody-result");  
			$.ajax({
				type : "post",
				dataType : "json",
				url : "Backstage/showFlight",
				data : {
					a : a
				},
				success : function(data) {
					//alert(data[1].aircraft["aId"])
					//var json = eval("("+data+")");
					//alert(data.length)
					var i=data.length;
					var str="";
					
					for(i in data){
						d=data[i];
					 var tr = "<tr>";
				       tr += "<td>" + i + "</td>";
				       tr += "<td>" + d.flight["fId"] + "</td>";
				       tr += "<td>" + d.aircraft["company"] + "</td>";
				       tr += "<td>" + d.aircraft["aId"] + "</td>";
				       tr += "</tr>";
				       str += tr; 
					}
				       tbody.innerHTML = str;
					/* <tr id="${status.index+1}">
					<td>${status.index+1}</td>
					<td>${d.flight.fId }</td>
					<td>${d.aircraft.company }</td>
					<td>${d.aircraft.aId }</td>
					<td>${d.flight.departureTime }</td>
					<td>${d.flight.departurePlace }</td>
					<td>${d.flight.arrivalTime }</td>
					<td>${d.flight.arrivalPlace }</td>
					<td>${d.flight.fristclassPrice }</td>
					<td>${d.flight.fristclassCount }</td>
					<td>${d.flight.economyPrice }</td>
					<td>${d.flight.economyCount }</td> */
					
				},
				error : function() {
					alert("查询失败")
				}
			});
		});
	</script>
</body>

</html>