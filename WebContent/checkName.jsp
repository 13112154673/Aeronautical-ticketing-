<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>检查注册号码是否存在</title>
</head>
<%	

    String phone = request.getParameter("phone");
     
    if("321".equals(phone))
    	out.print("<font color='red'>已经存在</font>");
    else 
    	out.print("<font color='green'>可以使用</font>"); 
    	
     
%>
</html>