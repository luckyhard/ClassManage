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
  url:"gradeAction",
   pagination:true, 
   striped:true,
 rownumbers:true,
 /* singleSelect:true,  */
 frozenColumns : [ [ {  
            field:"ck",  
           checkbox:true,
        }]],
    columns:[ [ {  
            field :"gradeId",  
            title:"年级编号",
            width:70,
            align:"center",
        },
        {  
            field:"gradeName",  
            title:"年级名称",
             width:70,
             align:"center",
        },
        {  
            field:"classesNames",  
            title:"开设班级名称",
             width:70,
             align:"center",
          
        },
        {  
            field:"courseNames",  
            title:"开设课程名称",
             width:70,
             align:"center",
        }
        
       /*  {  
            field:"mm",  
            title:"操作",
             width:70,            
            formatter : function(value, row, index) {  
                     return "<a  class='easyui-linkbutton' href='#' iconCls='icon-add'>添加班级</a>";
                    }   
             
        } */
       
        ]],
 });
 });  
 function openGradeAddDialog(){
		$("#dlgGrade").dialog("open").dialog("setTitle","添加年级信息");
		 
		url="addGradeAction"; 
	}
 function saveGrade(){
		$("#form1").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");//验证表单，true则提交
			},
			 success:function(result){
				 var result=eval("("+result+")");
				if(result.errorMsg){
					$.messager.alert("系统提示","<font color=red>"+result.errorMsg+"</font>");
					return;
				}else{
					$.messager.alert("系统提示","<font color=red>保存成功！</font>");
					closeGradeAddDialog();
					$("#dg").datagrid("reload");
				}
			}
		}); 
	} 
function closeGradeAddDialog(){
		$("#dlgGrade").dialog("close");
		$("#form1").form("clear");
		
	}
function openGradeModifyDialog(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		  /* var ele=document.getElementById("courseId"); //给每一行设置一个ID
          ele.style.display="none";
           var ele=document.getElementById("courseName"); //给每一行设置一个ID
          ele.style.display="none";  */
		var row=selectedRows[0];
		$("#dlgGrade").dialog("open").dialog("setTitle","修改班级信息");
		$("#form1").form("load",row);
			
		
		 url="addGradeAction?gradeId="+row.gradeId;
	}
	
	function deleteGrade(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].gradeId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){

				$.post("deleteGradeAction",{delIds:ids},function(result){
			
					 if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示",result.errorMsg);
					} 
				},"json");
			}
		});
	}
	
	function searchGrade(){
	 var biaoyin=$("#biaoyin").combobox("getValue"); 
	 var tiaojian=$("#tiaojian").val();
	$("#dg").datagrid("load",{
		
		}); 	 
	  if(biaoyin=="gradeId")
	 {
	
	  $("#dg").datagrid("load",{
			gradeId:$("#tiaojian").val()
		}); 
	 }
	 else
	 {
	
	     $("#dg").datagrid("load",{
			gradeName:$("#tiaojian").val()
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
    <li><a href="#">年级管理</a></li>
    </ul>
    </div>  
     
 <div id="tb" >
   <div>
	  <ul class="toolbar">
        <li><a href="javascript:openGradeAddDialog()"><span><img src="images/t01.png" /></span>添加</a></li>
        <li><a href="javascript:openGradeModifyDialog()"><span><img src="images/t02.png" /></span>修改</a></li>
        <li><a href="javascript:deleteGrade()"><span><img src="images/t03.png" /></span>删除</a></li>
        </ul>
         
     </div>
    <br>
    <br>
    <br>
     <div>
	    &nbsp;查询条件：&nbsp;
	 <select id="biaoyin" class="easyui-combobox" name="biaoyin" style="width:150px;height:23px" data-options="required:true,editable:false,panelHeight:'auto'">
	      <option>请选择</option>
         <option value="gradeId">年级编号</option>
		 <option value="gradeName">年级名称</option>
     </select>
		&nbsp;查询内容：&nbsp;<input class="easyui-textbox" name="tiaojian" id="tiaojian" style="width:150px;height:23px"/>
		<a href="javascript:searchGrade()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a> 
    </div>	
</div>    
    <table id="dg"></table>
    
     <div id="dlgGrade" class="easyui-dialog" style="width: 350px;height: 300px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">  
      <form id="form1" method="post" >
      <center>   
       <table cellspacing="5px;">      
       </br>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >年级名称:</font></td></tr>
       <tr><td><input type="text" name="gradeName"  class="easyui-validatebox" required="true" style="width:220px;height:28px; border: 1px solid #2468a2 "></td></tr>   
         <tr id="courseName"><td style="width:100px;height:35px;"><font style="font-size: 12pt" >课程名称:</font></td></tr>
            <tr id="courseId"><td>
         <input class="easyui-combobox" id="courseIds"  name="courseIds"  style="width:220px;height:28px; border: 1px solid #2468a2 "data-options="multiple:true,editable:false,panelHeight:'auto',valueField:'courseId',textField:'courseName',url:'listCourseName'"/>
        </td></tr>  
        <!--  <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >班级名称:</font></td></tr>
           <tr> <td>
        <input class="easyui-combobox" id="classId" name="classId" style="width:220px;height:28px; border: 1px solid #2468a2 " size="20" data-options="multiple:true,editable:false,panelHeight:'auto',valueField:'classId',textField:'className',url:'listClassesName'"/>
        </td></tr>    -->            
       </table> 
      </center>
       </form>              
    </div> 
     
   <div id="dlg-buttons">
	<a href="javascript:saveGrade()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closeGradeAddDialog()" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>
  </body>
</html>