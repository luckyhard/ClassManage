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
  url:"classesAction",
   pagination:true, 
   striped:true,
 rownumbers:true,
 /* singleSelect:true,  */
 frozenColumns : [ [ {  
            field:"ck",  
           checkbox:true,
        }]],
    columns:[ [ {  
            field :"classId",  
            title:"班级编号",
            width:150,
            align:"center",
        },
        {  
            field:"className",  
            title:"班级名称",
             width:150,
             align:"center",
        },
         {  
            field:"gradeId",  
            title:"年级编号",
             width:150,
             align:"center",
        },
         {  
            field:"gradeName",  
            title:"年级名称",
             width:150,
             align:"center",
        }]],
 });
 });  
 function openClassesAddDialog(){
		$("#dlgClasses").dialog("open").dialog("setTitle","添加班级信息");
		 $("#classesName").removeAttr("readonly");
		url="addClassesAction"; 
	}
 function saveClasses(){
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
					closeClassesAddDialog();
					$("#dg").datagrid("reload");
				}
			}
		}); 
	} 
function closeClassesAddDialog(){
		$("#dlgClasses").dialog("close");
		$("#form1").form("clear");
	}
function openClassesModifyDialog(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlgClasses").dialog("open").dialog("setTitle","修改班级信息");
		$("#form1").form("load",row);
			
		/* $("#userName").attr("readonly","readonly"); */
		 url="addClassesAction?classId="+row.classId;
	}
	
	function deleteClasses(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].classId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){

				$.post("deleteClassesAction",{delIds:ids},function(result){
			
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
	
	function searchClasses(){
	 var biaoyin=$("#biaoyin").combobox("getValue"); 
	 var tiaojian=$("#tiaojian").val();
	$("#dg").datagrid("load",{
		
		}); 	 
	  if(biaoyin=="classId")
	 {
	
	  $("#dg").datagrid("load",{
			classId:$("#tiaojian").val()
		}); 
	 }
	  if(biaoyin=="gradeName")
	 {
	
	  $("#dg").datagrid("load",{
			gradeName:$("#tiaojian").val()
		}); 
	 }
	 else
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
    <li><a href="#">班级管理</a></li>
    </ul>
    </div>  
     <!--  <table id="dg" class="easyui-datagrid"  fitColumns="true" pagination="true"rownumbers="true"url="classesAction" fit="true" toolbar="#tb">
    <thead>
    <tr>
     <th field="cb" checkbox="true" align="center"></th>
        <th field="classId" width="150" align="center">班级编号</th>
        <th  field="className" width="150" align="center">班级名称</th>
       
    </tr>
    </thead>
      
    </table>    -->
     
 <div id="tb" >
   <div>
	  <ul class="toolbar">
        <li><a href="javascript:openClassesAddDialog()"><span><img src="images/t01.png" /></span>添加</a></li>
        <li><a href="javascript:openClassesModifyDialog()"><span><img src="images/t02.png" /></span>修改</a></li>
        <li><a href="javascript:deleteClasses()"><span><img src="images/t03.png" /></span>删除</a></li>
        </ul>
         
     </div>
    <br>
    <br>
    <br>
     <div>
	    &nbsp;查询条件：&nbsp;
	 <select id="biaoyin" class="easyui-combobox" name="biaoyin" style="width:150px;height:23px" data-options="required:true,editable:false,panelHeight:'auto'">
	      <option>请选择</option>
         <option value="classId">班级编号</option>
		 <option value="className">班级名称</option>
		 <option value="gradeName">年级名称</option>
     </select>
		&nbsp;查询内容：&nbsp;<input class="easyui-textbox" name="tiaojian" id="tiaojian" style="width:150px;height:23px"/>
		<a href="javascript:searchClasses()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a> 
    </div>	
</div>    
    <table id="dg"></table>
    
     <div id="dlgClasses" class="easyui-dialog" style="width: 350px;height: 300px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">  
      <form id="form1" method="post" >
      <center>   
       <table cellspacing="5px;">      
       </br>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >班级名称:</font></td></tr>
       <tr><td><input type="text" name="className"  class="easyui-validatebox" required="true" style="width:220px;height:28px; border: 1px solid #2468a2 "></td></tr>                
      <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >所属年级:</font></td></tr>
           <tr> <td>
        <input class="easyui-combobox" id="gradeId" name="gradeId"  style="width:220px;height:28px; border: 1px solid #2468a2 " data-options="editable:false,panelHeight:'auto',valueField:'gradeId',textField:'gradeName',url:'listGradeName'"/>
        </td></tr>  
       </table> 
      </center>
       </form>              
    </div> 
   <div id="dlg-buttons">
	<a href="javascript:saveClasses()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closeClassesAddDialog()" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>
  </body>
</html>