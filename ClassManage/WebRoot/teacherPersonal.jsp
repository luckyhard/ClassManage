<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'TeacherPersonal.jsp' starting page</title>
    
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
<script type="text/javascript" src="js/validateExtends.js"></script>
  <script type="text/javascript">
  $(function(){
    //修改密码窗口
	    $("#passwordDialog").dialog({
	    	title: "修改密码",
	    	width: 500,
	    	height: 300,
	    	iconCls: "icon-add",
	    	modal: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: true,
	    	buttons: [
	  	    		{
	  					text:"提交",
	  					iconCls:"icon-user_add",
	  					handler:function(){
	  						var validate = $("#editPassword").form("validate");
	  						if(!validate){
	  							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
	  							return;
	  						} else{
	  							$.ajax({
	  								type: "post",
	  								url: "updateTeacherPasswordAction",
	  								data: $("#editPassword").serialize(),
	  								success: function(result){
	  								 var result=eval("("+result+")");
	  									if(result.success){
	  										$.messager.alert("消息提醒","修改成功，将重新登录","info");
	  										setTimeout(function(){
	  											top.location.href = "login.html";
	  										}, 1000);
	  									}
	  								}
	  							});
	  						}
	  					}
	  				},
	  				{
	  					text:'重置',
	  					iconCls:'icon-reload',
	  					handler:function(){
	  						//清空表单
	  						$("#old_password").textbox('setValue', "");
	  						$("#new_password").textbox('setValue', "");
	  						$("#re_password").textbox('setValue', "");
	  					}
	  				}
	  			],
	    });
		var table=$("#table1");
		var teacherId=$("#teacherId").val();
		//设置编辑学生窗口
	    $("#editDialog").dialog({
	    	title: "修改密码",
	    	width: 500,
	    	height: 400,
	    	fit: true,
	    	modal: false,
	    	noheader: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: false,
	    	onBeforeOpen: function(){
		$.ajax({
		type:"post",
		url:"loadCourseByTeacherAction?teacherId="+teacherId,
		dataType:"json",
		success:function(result){
		
		  for(var i=0;i<result.length;i++)
		  { 
		   var gradeId=result[i].gradeId;
		   var gradeName=result[i].gradeName;
		   var classId=result[i].classId;
		   var className=result[i].className;
		   var courseId=result[i].courseId;
		   var courseName=result[i].courseName;		  
		     
		   var tr = $("<tr class='chooseTr'><td><font style='font-size: 12pt' >课程:</font></td></tr>");           
           var gradeTd = $("<td></td>");
           var gradeInput = $("<input style='width:120px;height:28px; border: 1px solid #2468a2' data-options='readonly: true' class='easyui-textbox' name='gradeId'  />").val(gradeName).attr("gradeId", gradeId);
			    $(gradeInput).appendTo($(gradeTd));
			    $(gradeTd).appendTo(tr);
           var classTd = $("<td></td>");
		   var classInput = $("<input style='width:120px;height:28px; border: 1px solid #2468a2' data-options='readonly: true' class='easyui-textbox' name='classId' />").val(className).attr("classId", classId);
			    $(classInput).appendTo(classTd);
			    $(classTd).appendTo(tr);
		   var courseTd = $("<td></td>");
		   var courseInput = $("<input style='width:120px;height:28px; border: 1px solid #2468a2' data-options='readonly: true' class='easyui-textbox' name='courseId' />").val(courseName).attr("courseId", courseId);
			      $(courseInput).appendTo(courseTd);
			      $(courseTd).appendTo(tr);
			   $(tr).appendTo(table);				    		
						//解析
			$.parser.parse($(table).find(".chooseTr:last"));
		}
		
		 }
		});
		
		},
	    	toolbar: [
	    		{
					text:"提交",
					plain: true,
					iconCls:"icon-ok",
					handler:function(){
						var validate = $("#editForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
						} else{
							$.ajax({
								type: "post",
								url: "updateTeacherPersonAction",
								data: $("#editForm").serialize(),
								success: function(result){
								 var result=eval("("+result+")");
									if(result.success){
										$.messager.alert("消息提醒","更新成功!");
									} else{
										$.messager.alert("消息提醒","更新失败!");
										return;
									}
								}
							});
						}
					}
				},'-',
				{
					text:"重置",
					plain: true,
					iconCls:"icon-reload",
					handler:function(){
						//清空表单
						$("#teacherName").textbox("setValue", "");
						$("#teacherBirthday").textbox("setValue", "");
						$("#teacherTel").textbox("setValue", "");
						$("#teacherAddress").textbox("setValue", "");
					}
				},'-',
				{
					text:"修改密码",
					plain: true,
					iconCls:"icon-edit",
					handler:function(){
						$("#passwordDialog").dialog("open");
					}
				}
			],
			
	    });
		
  });
  </script>
  </head>
  
  <body>
   <div id="editDialog" style="padding: 20px">	    
    	<form id="editForm">
	    	<table cellpadding="8" id="table1" style="border-collapse:separate; border-spacing:0px 10px;">
	    		<tr>
	    			<td style="width:80px;height:35px;"><font style="font-size: 12pt" >编         号:</font></td>
	    			<td>
	    				<input id="teacherId" value="<s:property value="teacher.teacherId"/>" data-options="readonly: true" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="teacherId" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td style="width:80px;height:35px;"><font style="font-size: 12pt" >姓        名:</font></td>
	    			<td><input id="teacherName" value="<s:property value="teacher.teacherName"/>" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="teacherName" data-options="required:true, missingMessage:'请填写姓名'" /></td>
	    		</tr>
	    		<tr>
	    			<td style="width:80px;height:35px;"><font style="font-size: 12pt" >性         别:</font></td>
	    			<td><input id="teacherSex" value="<s:property value="teacher.teacherSex"/>" style="width: 200px; height: 30px;" data-options="readonly: true" class="easyui-textbox" type="text" name="teacherSex"  /></td>
	    		</tr>
	    		<tr style="display: none">
	    			<td style="width:80px;height:35px;"><font style="font-size: 12pt" >密          码：</font></td>
	    			<td><input id="teacherPassword"  value="<s:property value="teacher.teacherPassword"/>" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="teacherPassword" validType="mobile" /></td>
	    		</tr>
	    		<tr>
	    			<td style="width:80px;height:35px;"><font style="font-size: 12pt" >出生年月：</font></td>
	    			<td><input id="teacherBirthday"  value="<s:property value="teacher.teacherBirthday"/>" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="teacherBirthday" validType="mobile" /></td>
	    		</tr>
	    		<tr>
	    			<td style="width:80px;height:35px;"><font style="font-size: 12pt" >电        话:</font></td>
	    			<td><input id="teacherTel"  value="<s:property value="teacher.teacherTel"/>" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="teacherTel" validType="mobile"  /></td>
	    		</tr>
	    		<tr>
	    			<td style="width:80px;height:35px;"><font style="font-size: 12pt" >联系地址：</font></td>
	    			<td><input id="teacherAddress"  value="<s:property value="teacher.teacherAddress"/>" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="teacherAddress" validType="mobile" /></td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	
	<!-- 修改密码窗口 -->
	<div id="passwordDialog" style="padding: 20px">
    	<form id="editPassword">
	    	<table cellpadding="8"  style="border-collapse:separate; border-spacing:0px 10px;">
	    		<tr>
	    			<td style="width:80px;height:35px;"><font style="font-size: 12pt" >原密码:</font></td>
	    			<td>
	    				<input id="old_password" style ="width: 200px; height: 30px;" class="easyui-textbox" type="password" validType="oldPassword[<s:property value="teacher.teacherPassword"/>]"  data-options="required:true, missingMessage:'请输入原密码'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td style="width:80px;height:35px;"><font style="font-size: 12pt" >新密码:</font></td>
	    			<td>
	    				<input  type="hidden" name="teacherId" value="<s:property value="teacher.teacherId"/>" />
	    				<input id="new_password" style="width: 200px; height: 30px;" class="easyui-textbox" type="password"  name="teacherPassword" data-options="required:true, missingMessage:'请输入新密码'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td style="width:80px;height:35px;"><font style="font-size: 12pt" >新密码:</font></td>
	    			<td><input id="re_password" style="width: 200px; height: 30px;" class="easyui-textbox" type="password" validType="equals['#new_password']"  data-options="required:true, missingMessage:'再次输入密码'" /></td>
	    		</tr>
	    	</table>
	    </form>
	</div>

  </body>
</html>
