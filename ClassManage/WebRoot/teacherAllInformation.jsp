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
    
    <title>教师信息管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
 <link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.1/themes/icon.css">
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.1/demo.css">
<script type="text/javascript" src="jquery-easyui-1.5.1/jquery.min.js"></script>
<script type="text/javascript" src="jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
  $(function(){
   var table;
 $("#dg").datagrid({
 fitColumns:true,
  url:"teacherAction",
   pagination:true, 
   striped:true,
 rownumbers:true,
 /*singleSelect:true,*/  
 frozenColumns : [ [ {  
            field:"ck",  
           checkbox:true,
        }]],
    columns:[ [ {  
            field :"teacherId",  
            title:"编号",
            width:20,
            align:"center",
        },
        {  
            field:"teacherName",  
            title:"教师姓名",
             width:40,
             align:"center",
        },
        {  
            field :"teacherSex",  
            title:"教师性别",
            width:40,
            align:"center",
        },
        {  
            field :"teacherBirthday",  
            title:"出生日期",
            width:50,
            align:"center",
        },
        {  
            field :"teacherPassword",  
            title:"密码",
            width:50,
            align:"center",
        },
        {  
            field :"teacherTel",  
            title:"联系电话",
            width:50,
            align:"center",
        },
        {  
            field :"teacherAddress",  
            title:"家庭住址",
            width:60,
            align:"center",
        },
        {  
            field :"obj",  
            title:"所教课程",
            width:160,
            align:"center",
            formatter: function(value,row,index){
 						if (row.obj){
 							var obj= row.obj;
 							var course = "";
 							for(var i = 0;i < obj.length;i++){
 								course += "[" +obj[i] +"] &nbsp;&nbsp;&nbsp;";							
 							}
 							return course;
 						} else {
 							return value;
 						}
 						}
        },
        ]],
 }); 
   
   
 });  
 
	function searchTeacher(){
	 var biaoyin=$("#biaoyin").combobox("getValue"); 
	 var tiaojian=$("#tiaojian").val();
	$("#dg").datagrid("load",{
		
		}); 	 
	  if(biaoyin=="teacherId")
	 {
	
	  $("#dg").datagrid("load",{
			teacherId:$("#tiaojian").val()
		}); 
	 }
	 if(biaoyin=="studentName")
	 {
	
	     $("#dg").datagrid("load",{
			teacherName:$("#tiaojian").val()
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
    <li><a href="#">教师信息</a></li>
    </ul>
    </div>  
 
 <div id="tb" >
     <div>
	    &nbsp;查询条件：&nbsp;
	 <select id="biaoyin" class="easyui-combobox" name="biaoyin" style="width:150px;height:23px" data-options="required:true,editable:false,panelHeight:'auto'">
	      <option>请选择</option>
         <option value="teacherId">教师编号</option>
		 <option value="teacherName">教师姓名</option>
     </select>
		&nbsp;查询内容：&nbsp;<input class="easyui-textbox" name="tiaojian" id="tiaojian" style="width:150px;height:23px"/>
		<a href="javascript:searchTeacher()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a> 
    </div>	
 </div>    
    <table id="dg"></table>
  
  </body>
</html>