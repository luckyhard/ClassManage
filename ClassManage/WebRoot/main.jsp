<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>班级管理界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
 <frameset rows="88,*" cols="*" frameborder="no" border="0" framespacing="0">
  <frame src="top.html" name="topFrame" scrolling="no" noresize="noresize" id="topFrame" title="topFrame" />
  <frameset cols="187,*" frameborder="no" border="0" framespacing="0">
    <%  int shenfen=(Integer)session.getAttribute("shenfen");            
    if(shenfen==1)
    {%>
     <frame src="left.html" name="leftFrame" scrolling="no" noresize="noresize" id="leftFrame" title="leftFrame" />
    <%}
    else if(shenfen==2)
    {
    %>
     <frame src="leftTeacher.html" name="leftFrame" scrolling="no" noresize="noresize" id="leftFrame" title="leftFrame" />
    <%
    } 
    else if(shenfen==3)
    {
   %>
   <frame src="leftStudent.html" name="leftFrame" scrolling="no" noresize="noresize" id="leftFrame" title="leftFrame" />
   <%}%>
   
    <frame src="index.jsp" name="rightFrame" id="rightFrame" title="rightFrame" />
  </frameset>
</frameset>
<noframes><body>
</body></noframes>
</html>
