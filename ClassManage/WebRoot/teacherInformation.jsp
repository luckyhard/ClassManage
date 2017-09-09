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
 //教师添加
 function openTeacherAddDialog(){
 table=$("#table1");
		$("#addTeacher").dialog("open").dialog("setTitle","添加教师信息");		 
	}

     function openChooseCourseDialog(){
		$("#chooseCourseDialog").dialog("open").dialog("setTitle","设置课程");
		$("#add_gradeList").combobox({  
                onChange: function () {             
                var gradeIds=$("#add_gradeList").combobox("getValue");                                                                                                       
                        $("#add_classList").combobox({                  
                            url:"listClassesName?gradeIds="+gradeIds,  
                       });
                         $("#add_courseList").combobox({                  
                            url:"listCourseName?gradeIds="+gradeIds,  
                       }); 
                 }
            });  
	}
	
         function saveTeacher(){
              var chooseCourse = [];
              $(table).find(".chooseTr").each(function(){
			  var gradeId = $(this).find("input[textboxname='gradeId']").attr("gradeId");		
			  var classId = $(this).find("input[textboxname='classId']").attr("classId");
			  var courseId = $(this).find("input[textboxname='courseId']").attr("courseId");
			  var course = gradeId+"_"+classId+"_"+courseId;
			  chooseCourse.push(course);
				});
	         $("#form1").form("submit",{
			url:"addTeacherAction?chooseCourse="+chooseCourse,
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
					closeAddTeacherDialog();
					$("#dg").datagrid("reload");
				}
			}
		});  
	} 
   function displayCourse(){  
    
       var chooseCourse = [];
	   $(table).find(".chooseTr").each(function(){ 		                     	
							var gradeId = $(table).find("input[textboxname='gradeId']").attr("gradeId");
							var classId = $(table).find("input[textboxname='classId']").attr("classId");
							var courseId = $(table).find("input[textboxname='courseId']").attr("courseId");
							var course= gradeId+"_"+classId+"_"+courseId;
							chooseCourse.push(course);
						});		
		      var gradeId=$("#add_gradeList").combobox("getValue"); 
              var classId=$("#add_classList").combobox("getValue");                                                   
              var courseId=$("#add_courseList").combobox("getValue");
              var newChoose = gradeId+"_"+classId+"_"+courseId;		    
       			     if(chooseCourse.length!=0)
						{
						 for(var i = 0;i < chooseCourse.length;i++){
							if(newChoose == chooseCourse[i]){
								$.messager.alert("消息提醒","已选择该门课程!");
								return;
							} 
						   } 
						}                     
              var gradeName=$("#add_gradeList").combobox("getText"); 
              var className=$("#add_classList").combobox("getText");                                                   
              var courseName=$("#add_courseList").combobox("getText");               
              var tr = $("<tr class='chooseTr'><td><font style='font-size: 12pt' >课程:</font></td></tr>");           
              var gradeTd = $("<td></td>");
              var gradeInput = $("<input style='width:120px;height:28px; border: 1px solid #2468a2' data-options='readonly: true' class=' easyui-textbox' name='gradeId'  />").val(gradeName).attr("gradeId", gradeId);
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
		   var removeTd = $("<td></td>");
		   var removeA = $("<a href='javascript:;' class='easyui-linkbutton removeBtn'></a>").attr("data-options", "iconCls:'icon-remove'");
			      $(removeA).appendTo(removeTd);
			      $(removeTd).appendTo(tr);	 
			      $(tr).appendTo(table);									    
			//解析
			      $.parser.parse($(table).find(".chooseTr:last"));
         }
     
     function closeDislpayCourse(){
		$("#chooseCourseDialog").dialog("close");		
	     }
     function closeAddTeacherDialog(){
		$("#addTeacher").dialog("close");
		$("#form1").form("clear");
		$(table).find(".chooseTr").remove();
	    }
     //教师信息修改
     function openTeacherModifyDialog(){
        table=$("#table2");
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		 }
		var row=selectedRows[0];
		  $("#modifyTeacher").dialog({
		 onBeforeOpen: function(){
		$.ajax({
		type:"post",
		url:"loadCourseByTeacherAction?teacherId="+row.teacherId,
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
		   var removeTd = $("<td></td>");
		   var removeA = $("<a href='javascript:;' class='easyui-linkbutton removeBtn'></a>").attr("data-options", "iconCls:'icon-remove'");
			      $(removeA).appendTo(removeTd);
			      $(removeTd).appendTo(tr);	 
				
			   $(tr).appendTo(table);				    		
						//解析
			$.parser.parse($(table).find(".chooseTr:last"));
		}
		    
		   $(table).find(".course:first").attr("checked", "checked");
		
		 }
		});
		
		},
		
		onClose: function(){
				$(table).find(".chooseTr").remove();
				}
		});
				
		$("#modifyTeacher").dialog("open").dialog("setTitle","修改教师信息");		 
		$("#form2").form("load",row);		
	}
	//修改提交
	   function updateTeacher(){
              var chooseCourse = [];
              $(table).find(".chooseTr").each(function(){
			  var gradeId = $(this).find("input[textboxname='gradeId']").attr("gradeId");			
			  var classId = $(this).find("input[textboxname='classId']").attr("classId");
			  var courseId = $(this).find("input[textboxname='courseId']").attr("courseId");
			  var course = gradeId+"_"+classId+"_"+courseId;
			  chooseCourse.push(course);
				});
	         $("#form2").form("submit",{
			url:"updateTeacherAction?chooseCourse="+chooseCourse,
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
					closeModifyTeacherDialog();
					$("#dg").datagrid("reload");
				}
			}
		});  
	} 
	    //取消
	    function closeModifyTeacherDialog(){
		$("#modifyTeacher").dialog("close");
		$("#form2").form("clear");
		$(table).find(".chooseTr").remove();
	    }
	//删除教师
	   function deleteTeacher(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].teacherId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){

				$.post("deleteTeacherAction",{delIds:ids},function(result){
			
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
	 if(biaoyin=="teacherName")
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
    <li><a href="#">教师管理</a></li>
    </ul>
    </div>  
 
 <div id="tb" >
   <div>
	  <ul class="toolbar">
        <li><a href="javascript:openTeacherAddDialog()"><span><img src="images/t01.png" /></span>添加</a></li>
        <li><a href="javascript:openTeacherModifyDialog()"><span><img src="images/t02.png" /></span>修改</a></li>
        <li><a href="javascript:deleteTeacher()"><span><img src="images/t03.png" /></span>删除</a></li>
        </ul>
         
     </div>
    <br>
    <br>
    <br>
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
   <!--     添加老师 -->
     <div id="addTeacher" class="easyui-dialog" style="width:700px;height: 520px;padding: 10px 20px"  closed="true" buttons="#dlg-buttons">  
      <form id="form1" method="post" >     
       <table cellspacing="5px;" id="table1">      
       </br>
       <tr style="display: none"><td style="width:100px;height:35px;"><font style="font-size: 12pt" >教师Id:</font></td><td><input type="text" name="teacherId"  class="easyui-textbox"  style="width:150px;height:28px "></td><td></td><td></td></tr>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >教师姓名:</font></td><td><input type="text" name="teacherName"  class="easyui-textbox" required="true" style="width:150px;height:28px "></td><td></td><td></td></tr>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >教师性别:</font></td>
            <td> <input type="radio" name="teacherSex" value="nan" class="easyui-validatebox" required="true" checked="checked"><font style="font-size: 12pt" >男</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="teacherSex" value="nv"  class="easyui-validatebox" required="true" ><font style="font-size: 12pt" >女</font>        
           </td>
            </tr>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >出生日期:</font></td> <td><input type="text" name="teacherBirthday"  class="easyui-textbox" required="true" style="width:150px;height:28px "></td><td style="width:150px;height:28px; "></td><td style="width:150px;height:28px; "></td></tr>      
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >密码:</font></td> <td><input type="text" name="teacherPassword"  class="easyui-textbox" required="true"  style="width:150px;height:28px;"></td><td style="width:150px;height:28px; " ></td><td style="width:150px;height:28px; "></td></tr>      
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >联系电话:</font></td><td><input type="text" name="teacherTel"  class="easyui-textbox" required="true" style="width:150px;height:28px;"></td><td style="width:150px;height:28px; "></td><td style="width:150px;height:28px; "></td></tr>      
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >家庭住址:</font></td><td><input type="text" name="teacherAddress"  class="easyui-textbox" required="true" style="width:150px;height:28px"></td><td style="width:150px;height:28px; "></td><td style="width:150px;height:28px; "></td></tr>           
       </table> 
       </form>       
    </div> 
     <div id="dlg-buttons">
		<a href="javascript:openChooseCourseDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">设置课程</a>
		<a href="javascript:saveTeacher()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">提交</a>
		 <a href="javascript:closeAddTeacherDialog()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">取消</a>
	</div> 
   <!--  修改老师信息 -->
  	     <div id="modifyTeacher" class="easyui-dialog" style="width:700px;height: 520px;padding: 10px 20px"  closed="true" buttons="#dlg-buttons1">  
      <form id="form2" method="post" >     
       <table cellspacing="5px;" id="table2">      
       </br>
        <tr style="display: none"><td style="width:100px;height:35px;"><font style="font-size: 12pt" >教师Id:</font></td><td><input type="text" name="teacherId"  class="easyui-textbox"  style="width:150px;height:28px "></td><td></td><td></td></tr>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >教师姓名:</font></td><td><input type="text" name="teacherName"  class="easyui-textbox" required="true" style="width:150px;height:28px "></td><td></td><td></td></tr>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >教师性别:</font></td>
            <td> <input type="radio" name="teacherSex" value="nan" class="easyui-validatebox" required="true" checked="checked"><font style="font-size: 12pt" >男</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="teacherSex" value="nv"  class="easyui-validatebox" required="true" ><font style="font-size: 12pt" >女</font>        
           </td>
            </tr>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >出生日期:</font></td> <td><input type="text" name="teacherBirthday"  class="easyui-textbox" required="true" style="width:150px;height:28px "></td><td style="width:150px;height:28px; "></td><td style="width:150px;height:28px; "></td></tr>      
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >密码:</font></td> <td><input type="text" name="teacherPassword"  class="easyui-textbox" required="true"  style="width:150px;height:28px;"></td><td style="width:150px;height:28px; " ></td><td style="width:150px;height:28px; "></td></tr>      
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >联系电话:</font></td><td><input type="text" name="teacherTel"  class="easyui-textbox" required="true" style="width:150px;height:28px;"></td><td style="width:150px;height:28px; "></td><td style="width:150px;height:28px; "></td></tr>      
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >家庭住址:</font></td><td><input type="text" name="teacherAddress"  class="easyui-textbox" required="true" style="width:150px;height:28px"></td><td style="width:150px;height:28px; "></td><td style="width:150px;height:28px; "></td></tr>           
       </table> 
       </form> 
       
    </div> 
     <div id="dlg-buttons1">
		<a href="javascript:openChooseCourseDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">设置课程</a>
		<a href="javascript:updateTeacher()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">提交</a>
		 <a href="javascript:closeModifyTeacherDialog()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">取消</a>
	</div>  
	<!-- 设置课程 -->
      <div id="chooseCourseDialog" style="width: 400px;height: 280px;padding: 10px 20px" class="easyui-dialog" style="padding: 10px"  closed="true" buttons="#dlg-buttons">
	  <form id="form2"> 
	   	<table cellpadding="8" style="border-collapse:separate; border-spacing:0px 10px;">
	   		<tr>
	   			<td>年级：</td>
	   			<td> <input class="easyui-combobox" id="add_gradeList" name="add_gradeList"  style="width:200px;height:30px; border: 1px solid #2468a2 " data-options="editable:false,panelHeight:'auto',valueField:'gradeId',textField:'gradeName',url:'listGradeName'"/></td>
	   		</tr>	   		
	   		<tr>
	   			<td>班级：</td>
	   			<td>
	   			 <input class="easyui-combobox" id="add_classList" name="add_classList" style="width: 200px; height: 30px;" data-options="editable:false,panelHeight:'auto',valueField:'classId',textField:'className',"/>
	   			 </td>
	   		</tr>
	   		<tr>
	   			<td>课程：</td>
	   			<td><input id="add_courseList" style="width: 200px; height: 30px;" class="easyui-combobox" name="courseId" style="width:220px;height:28px; border: 1px solid #2468a2 "data-options="editable:false,panelHeight:'auto',valueField:'courseId',textField:'courseName',"/></td>
	   			
	   		</tr>
	   	</table>
	   	</form>
	  </div>        
     <div id="dlg-buttons">
	<a href="javascript:displayCourse()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closeDislpayCourse()" class="easyui-linkbutton" iconCls="icon-cancel" >完成</a>
    </div>  
  
  </body>
</html>