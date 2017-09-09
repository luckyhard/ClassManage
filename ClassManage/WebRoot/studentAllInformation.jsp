<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>   
<%@ page import="java.sql.*,java.util.*,net.sf.json.*"%>  
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>班级信息管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
 <link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.1/themes/icon.css">
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.1/demo.css">
<script type="text/javascript" src="jquery-easyui-1.5.1/jquery.min.js"></script>
<script type="text/javascript" src="jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
  $(function(){
 $("#dg").datagrid({
 fitColumns:true,
  url:"studentAllAction",
   pagination:true, 
   striped:true,
 rownumbers:true,
 /*singleSelect:true,*/  
 frozenColumns : [ [ {  
            field:"ck",  
           checkbox:true,
        }]],
    columns:[ [ {  
            field :"studentId",  
            title:"学生编号",
            width:70,
            align:"center",
        },
        {  
            field:"studentName",  
            title:"学生姓名",
             width:70,
             align:"center",
        },
        {  
            field :"studentSex",  
            title:"学生性别",
            width:70,
            align:"center",
        },
        {  
            field :"studentBirthday",  
            title:"出生日期",
            width:70,
            align:"center",
        },
        {  
            field :"studentPassword",  
            title:"密码",
            width:70,
            align:"center",
        },
        {  
            field :"studentTel",  
            title:"联系电话",
            width:70,
            align:"center",
        },
        {  
            field :"studentAddress",  
            title:"家庭住址",
            width:70,
            align:"center",
        },]],
 }); 
 });  
 
 
	function searchStudent(){
	 var biaoyin=$("#biaoyin").combobox("getValue"); 
	 var tiaojian=$("#tiaojian").val();
	$("#dg").datagrid("load",{
		
		}); 	 
	  if(biaoyin=="studentId")
	 {
	
	  $("#dg").datagrid("load",{
			studentId:$("#tiaojian").val()
		}); 
	 }
	 if(biaoyin=="studentName")
	 {
	
	     $("#dg").datagrid("load",{
			studentName:$("#tiaojian").val()
		}); 	

	 }
	  if(biaoyin=="className")
	 {
	
	     $("#dg").datagrid("load",{
			className:$("#tiaojian").val()
		}); 	

	 }
}
	 
</script>
  </head>

  <body style="margin: 1px;">
   <div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">信息管理</a></li>
    <li><a href="#">学生管理</a></li>
    </ul>
    </div>  
 
 <div id="tb" >
     <div>
	    &nbsp;查询条件：&nbsp;
	 <select id="biaoyin" class="easyui-combobox" name="biaoyin" style="width:150px;height:23px" data-options="required:true,editable:false,panelHeight:'auto'">
	      <option>请选择</option>
         <option value="studentId">学生编号</option>
		 <option value="studentName">学生姓名</option>
		 <option value="className">所属班级名称</option>
     </select>
		&nbsp;查询内容：&nbsp;<input class="easyui-textbox" name="tiaojian" id="tiaojian" style="width:150px;height:23px"/>
		<a href="javascript:searchStudent()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a> 
    </div>	
</div>    
    <table id="dg"></table>
  </body>
</html>