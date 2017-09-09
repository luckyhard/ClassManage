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
   $("#gradeId").combobox({  
                onChange: function () {             
                var gradeIds=$("#gradeId").combobox("getValue");                                                                                                       
                        $("#classId").combobox({                  
                            url:"listClassesName?gradeIds="+gradeIds,  
                       });
                 }
            }); 
           
 
 $("#dg").datagrid({
 fitColumns:true,
  url:"studentAction",
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
        },
        {  
            field :"classId",  
            title:"所属班级编号",
            width:70,
            align:"center",
        },
         {  
            field :"className",  
            title:"所属班级名称",
            width:70,
            align:"center",
        },
        {  
            field :"gradeId",  
            title:"所属年级编号",
            width:70,
            align:"center",
        },
         {  
            field :"gradeName",  
            title:"所属年级名称",
            width:70,
            align:"center",
        },]],
 }); 
 });  
 function openStudentAddDialog(){
		$("#dlgStudent").dialog("open").dialog("setTitle","添加学生信息");
		$("#gradeId").combobox({  
                onChange: function () {             
                var gradeIds=$("#gradeId").combobox("getValue");                                                                                                       
                        $("#classId").combobox({                  
                            url:"listClassesName?gradeIds="+gradeIds,  
                       });
                 }
            });  
		url="addStudentAction"; 
	}
 function saveStudent(){
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
					closeStudentAddDialog();
					$("#dg").datagrid("reload");
				}
			}
		}); 
	} 
function closeStudentAddDialog(){
		$("#dlgStudent").dialog("close");
		$("#form1").form("clear");
	}
function openStudentModifyDialog(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlgStudent").dialog("open").dialog("setTitle","修改学生信息");
		$("#form1").form("load",row);
			
		/* $("#userName").attr("readonly","readonly"); */
		 url="addStudentAction?studentId="+row.studentId;
	}
	
	function deleteStudent(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].studentId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){

				$.post("deleteStudentAction",{delIds:ids},function(result){
			
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
	  <ul class="toolbar">
        <li><a href="javascript:openStudentAddDialog()"><span><img src="images/t01.png" /></span>添加</a></li>
        <li><a href="javascript:openStudentModifyDialog()"><span><img src="images/t02.png" /></span>修改</a></li>
        <li><a href="javascript:deleteStudent()"><span><img src="images/t03.png" /></span>删除</a></li>
        </ul>
         
     </div>
    <br>
    <br>
    <br>
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
    
     <div id="dlgStudent"  class="easyui-dialog" style="width: 400px;height: 420px;padding: 10px 20px;   top:100px"
  closed="true" buttons="#dlg-buttons">  
      <form id="form1" method="post" >
      <center>   
       <table cellspacing="5px;">      
       </br>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >学生姓名:</font></td><td><input type="text" name="studentName"  class="easyui-textbox" required="true" style="width:150px;height:28px; "></td></tr>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >学生性别:</font></td>
            <td> <input type="radio" name="studentSex" value="nan" class="easyui-validatebox" required="true" checked="checked"><font style="font-size: 12pt" >男</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="studentSex" value="nv"  class="easyui-validatebox" required="true" ><font style="font-size: 12pt" >女</font>        
           </td>
            </tr>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >出生日期:</font></td> <td><input type="text" name="studentBirthday"  class="easyui-textbox" required="true" style="width:150px;height:28px; "></td></tr>      
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >密码:</font></td> <td><input type="text" name="studentPassword"  class="easyui-textbox" required="true"  style="width:150px;height:28px;"></td></tr>      
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >联系电话:</font></td><td><input type="text" name="studentTel"  class="easyui-textbox" required="true" style="width:150px;height:28px;"></td></tr>      
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >家庭住址:</font></td><td><input type="text" name="studentAddress"  class="easyui-textbox" required="true" style="width:150px;height:28px; "></td></tr>      
       <tr>
	   			<td><font style="font-size: 12pt" >所属年级：</font></td>
	   			<td> <input class="easyui-combobox" id="gradeId" name="gradeId"  style="width:150px;height:30px; border: 1px solid #2468a2 " data-options="editable:false,panelHeight:'auto',valueField:'gradeId',textField:'gradeName',url:'listGradeName'"/></td>
	   		</tr>	   		
	   		<tr>
	   			<td><font style="font-size: 12pt" >所属班级：</font></td>
	   			<td>
	   			 <input class="easyui-combobox" id="classId" name="classId" style="width: 150px; height: 30px;" data-options="editable:false,panelHeight:'auto',valueField:'classId',textField:'className',"/>
	   			 </td>
	   		</tr>
       </table> 
      </center>
       </form>              
    </div> 
   <div id="dlg-buttons">
	<a href="javascript:saveStudent()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closeStudentAddDialog()" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>
  </body>
</html>