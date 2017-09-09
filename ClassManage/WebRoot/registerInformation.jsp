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
    
    <title>考试信息管理</title>
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
      url:"examByTeacherAction",
      pagination:true, 
      striped:true,
      rownumbers:true,
      singleSelect:true,  
      frozenColumns : [ [ {  
            field:"ck",  
           checkbox:true,
        }]],
      columns:[ [ {  
            field :"examId",  
            title:"考试编号",
            width:70,
            align:"center",
        },
        {  
            field:"examName",  
            title:"考试名称",
             width:70,
             align:"center",
        },
        {  
            field:"type",  
            title:"考试类型",
             width:70,
             align:"center",
             formatter: function(value,row,index){
						if(value == 1){
							return "年级统考";
						} else {
							return "平时考试";
						}
 					}
        },
         {  
            field:"gradeId",  
            title:"年级编号",
             width:150,
             align:"center",
        },
        {  
            field:"gradeName",  
            title:"考试年级",
             width:150,
             align:"center",
        },
        {  
            field:"classId",  
            title:"班级编号",
             width:150,
             align:"center",
        },
         {  
            field:"className",  
            title:"考试班级",
             width:150,
             align:"center",
        },
         {  
            field:"courseId",  
            title:"课程编号",
             width:150,
             align:"center",
        },
        {  
            field:"courseName",  
            title:"考试课程",
             width:150,
             align:"center",
        },
         {  
            field:"examRemark",  
            title:"备注",
             width:70,
             align:"center",
        }]],
 });
   
   
   $("#addExamDialog").dialog({
		onBeforeOpen: function(){
		$.ajax({
		type:"post",
		url:"loadCourseByTeacherAction",
		dataType:"json",
		success:function(result){
		  for(var i=0;i<result.length;i++)
		  { 
		   var type=result[i].type;
		   if(type==1)
		   {continue;}
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
				    		
		   var radioTd = $("<td></td>");
		   var radioInput = $("<input class='course' type='radio' name='course' />").attr({gradeId:gradeId, classId:classId, courseId:courseId});
			   $(radioInput).appendTo(radioTd);
			   $(radioTd).appendTo(tr);
				
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
 });  
 
 function openExamAddDialog(){
     var table=$("#table");
		$("#addExamDialog").dialog("open").dialog("setTitle","添加考试信息");
		url="addExamAction"; 
	}
 function saveExam(){
		$("#form1").form("submit",{
			url:url,
			onSubmit:function(){
			   var validate=$(this).form("validate");
			   if(!validate){
				$.messager.alert("消息提醒","请检查你输入的数据!","warning");
				return;
				}
				else
				{ 
				   var course=$(table).find("input:checked");
				   var gradeId=$(course).attr("gradeId");
				   var classId=$(course).attr("classId");
				   var courseId=$(course).attr("courseId");			 
				   var examName=$("#examName").textbox("getValue");
				   var examTime=$("#examTime").textbox("getValue");
				   var examRemark=$("#examRemark").textbox("getValue");
				   var data={gradeId:gradeId,classId:classId,courseId:courseId,examName:examName,examTime:examTime,examRemark:examRemark,type:2};
				
				   $.ajax({
				     type:"post",
				     url:"addExamAction",
				     data:data, 
				     success:function(result){
				       var result=eval("("+result+")");
				       if(result.errorMsg){
					     $.messager.alert("系统提示","<font color=red>"+result.errorMsg+"</font>");
					       return;
				      }else{
					    $.messager.alert("系统提示","<font color=red>保存成功！</font>");
					     closeExamAddDialog();
					  $("#dg").datagrid("reload");
				      } 
			       }
				   });
				}
				
			},
			 
		}); 
	} 
     function closeRegisterDialog(){
     $("#escoreRegisterDialog").dialog("close");
	}
	function closeExamAddDialog(){
     $("#addExamDialog").dialog("close");
	}
	
	 function registerExamDialog(){
	  var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要查看的数据！");
			return;
		 }
		else{
		   var exam = $("#dg").datagrid("getSelected");	
		   var v;
		   var gradeIds=exam.gradeId;
		   if(exam.type==1)
		   { 
		    $("#escoreClassList1"). combobox({  
		      valueField:"classId",
              textField:"className",
              multiple: false, //可多选
	          editable: false, //不可编辑
	          readonly:false,
	          method: "post",
	          url:"classesByTeacherAction?gradeIds="+gradeIds,
	           onChange:function(newValue,oldValue)
	            {  v=newValue;
	              var data = {examId: exam.examId, gradeId: exam.gradeId,classId:newValue,courseId:exam.courseId, type: exam.type};  			
	  	           $("#escoreRegister").datagrid("options").url = "escoreListAction";
		           $("#escoreRegister").datagrid("options").queryParams = data;
		           $("#escoreRegister").datagrid("reload");
		           $("#escoreCourseList").combobox({  
		                 url:"courseByTeacherAction?gradeIds="+exam.gradeId+"&classIds="+newValue,  
                         valueField:"courseId",
                         textField:"courseName",
                         multiple: false, //可多选
	                     editable: false, //不可编辑
	                     readonly:false,
	                     method: "post",	                     
	                      onChange:function(newValue,oldValue)
	                     {    
	                       var data = {examId: exam.examId, gradeId: exam.gradeId,classId:v,courseId:newValue, type: exam.type};  			
	  	                     setTimeout(function(){
   	                              $.ajax({
   	                                 type:"post",
		                             url:"courseListAction",
		                             data:data,
		                             dataType:"json",
		                             async:false,
		                             success:function(result){
		                                console.log(result);//控制台输出，调试作用
		                                var columns = [];
		                                   $.each(result, function(i, course){
		                                      var column={}; 
		                                      column["field"]="course"+course.courseId;
		                                      column["title"]=course.courseName;
		                                      column["width"]=70;	   
		                                      column["resizable"] = false;  
			                                 /* column["sortable"] = true;   */ 
			                                 var escoreId="escoreId"+course.courseId;
			                                 column["formatter"] =
			                                 function(value,row,index){return "<input  style='height:20px;border: 1px solid #2468a2'' maxlength='3' onblur='scoreBlur(this)' id='"+row[escoreId]+"' class='score' value="+value+">"};
		                                     columns.push(column);
		                                   }); 
		                        $("#escoreRegister").datagrid({ 
			    	                    columns: [
								              columns
			    	                             ]
			    	                      }); 	    
		                             }
		                     //
   	                          });
   	                      setTimeout(function(){
			    	          $("#escoreRegister").datagrid("options").url = "escoreListAction";
			    	          $("#escoreRegister").datagrid("options").queryParams = data;
			    	          $("#escoreRegister").datagrid("reload");			    	
            	             }, 30);
   	                     setTimeout(function(){
    		                  $("#escoreRegisterDialog").dialog("open");
    			             }, 80);
   	                 },100);
   	                 ////  	       
	                   },
	                  
	                    onLoadSuccess: function(){
				      //默认选择第一条数据
				       var data2 = $(this).combobox("getData");
				      $(this).combobox("setValue", data2[1].courseId);	
				    		
	  		    }	                  
		             });		             
	            },
	             onLoadSuccess: function(){
				      //默认选择第一条数据
				       var data3 = $(this).combobox("getData");
				      $(this).combobox("setValue", data3[1].classId);
				
	  		    }	             
	            
		    });
		    }
		   else
		   {
		    $("#escoreClassList1"). combobox({  
		      valueField:"classId",
              textField:"className",
              multiple: false, //可多选
	          editable: false, //不可编辑
	          readonly:true,
	          method: "post",
	          url:"classesByTeacherAction?gradeIds="+gradeIds,
	           onLoadSuccess: function () { //加载完成后,设置选中第一项 
                var data = $(this).combobox("getData"); 
 
                  for(var i =0 ;i<data.length;i++){
                    if(data[i].className==exam.className){
                          $("#escoreClassList1").combobox("select", data[i].className);
                      }
                    }
                  } 
	          });
	        
	          $("#escoreCourseList").combobox({  
		                 url:"courseByTeacherAction?gradeIds="+exam.gradeId+"&classIds="+exam.classId,  
                         valueField:"courseId",
                         textField:"courseName",
                         multiple: false, //可多选
	                     editable: false, //不可编辑
	                     readonly:true,
	                     method: "post",	
	                     onLoadSuccess: function () { //加载完成后,设置选中第一项 
                           var data = $(this).combobox("getData"); 
                             for(var i =0 ;i<data.length;i++){
                               if(data[i].courseName==exam.courseName){
                              $("#escoreCourseList").combobox("select", data[i].courseName);
                               }
                             }
                           }  
	               });
	           
		   }
		    ////
		      $("#escoreRegister").datagrid({ 
		          fitColumns:true,
                  striped:true,
                  rownumbers:true,
                  toolbar: "#escoreToolbar1",
                  pagination:false, 
   	             frozenColumns: [[  
   				{field:"studentId",title:"学生编号",width:120,resizable: false,sortable: false},    
   				{field:"studentName",title:"学生姓名",width:120,resizable: false},          
   	        ]],
   	        });
   	       // 
   	       var exam = $("#dg").datagrid("getSelected");
   	       setTimeout(function(){
   	        data={examId:exam.examId,gradeId:exam.gradeId,classId:exam.classId,courseId:exam.courseId,type:exam.type};
   	         $.ajax({
   	          type:"post",
		      url:"courseListAction",
		      data:data,
		      dataType:"json",
		      async:false,
		       success:function(result){
		       console.log(result);//控制台输出，调试作用
		         var columns = [];
		        $.each(result, function(i, course){
		           var column={}; 
		           column["field"]="course"+course.courseId;
		           column["title"]=course.courseName;
		           column["width"]=70;	   
		           column["resizable"] = false;  
			       /* column["sortable"] = true;   */ 
			       var escoreId="escoreId"+course.courseId;
			       column["formatter"] =
			       function(value,row,index){return "<input style='height:20px;border: 1px solid #2468a2'' maxlength='3' onblur='scoreBlur(this)' id='"+row[escoreId]+"' class='score' value="+value+">"};
		           columns.push(column);
		           }); 
		          $("#escoreRegister").datagrid({ 		
			    	        columns: [
								columns
			    	        ]
			    	    });		    	    
		          }
		          
		       //
   	         });
   	         setTimeout(function(){
			    	$("#escoreRegister").datagrid("options").url = "escoreListAction";
			    	$("#escoreRegister").datagrid("options").queryParams = data;
			    	$("#escoreRegister").datagrid("reload");			    	
			    	
            	}, 30);
   	         setTimeout(function(){
   	               $("#escoreRegisterDialog").dialog("open").dialog("setTitle","成绩登记");
    			   }, 80);
    			   
   	       },100);
   	       //
   	       
		}
	 }
	 //成绩统计
	function openEscoreDialog(){
	  var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要查看的数据！");
			return;
		}
		else
		 { 
		   var exam = $("#dg").datagrid("getSelected");
		    var gradeIds=exam.gradeId;
		   if(exam.type==1)
		   {	  
		   $("#escoreClassList"). combobox({
              valueField:"classId",
              textField:"className",
              multiple: false, //可多选
	          editable: false, //不可编辑
	           readonly:false,
	          method: "post",
	          url:"listClassesName?gradeIds="+gradeIds,
	          onChange:function(newValue,oldValue)
	            {
	               
	                var data = {examId: exam.examId, gradeId: exam.gradeId, classId:newValue,courseId:exam.courseId, type: exam.type};	  			
	  	           $("#escoreList").datagrid("options").url = "escoreListAction";
		           $("#escoreList").datagrid("options").queryParams = data;
		           $("#escoreList").datagrid("reload");
	  		
	            }
           });
           }
         else{
            $("#escoreClassList").combobox({
              valueField:"classId",
              textField:"className",
              multiple: false, //可多选
	          editable: false, //不可编辑
	          readonly:true,
	          method: "post",
	          url:"listClassesName?gradeIds="+gradeIds,
	          onLoadSuccess: function () { //加载完成后,设置选中第一项 
                var data = $(this).combobox("getData"); 
 
                  for(var i =0 ;i<data.length;i++){
                    if(data[i].className==exam.className){
                          $("#escoreClassList").combobox("select", data[i].className);
                     }
                  }
            
                } 
	          }); 
		   }
          $("#escoreList").datagrid({   
   	       fitColumns:true,
           striped:true,
           rownumbers:true,
             pagination:false, 
   	        toolbar: "#escoreToolbar",
   	        frozenColumns: [[  
   				{field:"studentId",title:"学生编号",width:120,resizable: false,sortable: false},    
   				{field:"studentName",title:"学生姓名",width:120,resizable: false},          
   	        ]],
   	        
   	    });  
   	      
		var exam = $("#dg").datagrid("getSelected");
		 data={examId:exam.examId,gradeId:exam.gradeId,classId:exam.classId,courseId:exam.courseId,type:exam.type};		
		  $.ajax({
		    type:"post",
		    url:"courseListAction",
		    data:data,
		    dataType:"json",
		    async:false,
		    success:function(result){
		    console.log(result);//控制台输出，调试作用
		  var columns = []; 	     
		   $.each(result, function(i, course){
		    var column={}; 
		    column["field"]="course"+course.courseId;
		    column["title"]=course.courseName;
		    column["width"]=70;	   
		    column["resizable"] = false;  
			/* column["sortable"] = true;   */ 
		    columns.push(column);
		    }); 
		  
		  if(exam.type==1)
		  {
		  columns.push({field:"total",title:"总分",width:70,});
		  }
		 $("#escoreList").datagrid({ 
		
			    	        columns: [
								columns
			    	        ]
			    	    }); 
		}
	  });
	  setTimeout(function(){
			    	$("#escoreList").datagrid("options").url = "escoreListAction";
			    	$("#escoreList").datagrid("options").queryParams = data;
			    	$("#escoreList").datagrid("reload");			    	
			    	 $("#escoreListDialog").dialog("open").dialog("setTitle","考试统计");
            	}, 100);
            	
	  }  
	
	}
	//成绩提交
	function escoreAdd(){
	 var score=[];
	 $(".score").each(function(){
	  var d=$(this).attr("id")+"_"+$(this).val();	  
	  score.push(d);
	 });	
	   $.ajax({	
	       traditional: true,    
	       type:"post",
	       url:"registerScoreAction",
	       data:{score:score},
	       success:function(result){
	       if(result){
	        $.messager.alert("系统提示","<font color=red>保存成功！</font>");	 
	         $("#escoreRegisterDialog").dialog("close");
	        }
	      }
	    }); 
	}
	
	/* function searchExam(){
	 var gradeId=$("#gradeId").combobox("getValue");      
	 var classId=$("#classId").combobox("getValue");
	 if(classId=="")
	 {
	 classId=0;
	 }  	 
	  $("#dg").datagrid("load",{
	   gradeId:gradeId,
	   classId:classId,
		}); 
	
} */
	 
</script>
  </head>

  <body style="margin: 1px;">
   <div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">信息管理</a></li>
    <li><a href="#">考试信息管理</a></li>
    </ul>
    </div> 
     
 <div id="tb" >
   <div>
	  <ul class="toolbar">
        <li><a href="javascript:openExamAddDialog()"><span><img src="images/t01.png" /></span>添加考试</a></li>
        <li><a href="javascript:registerExamDialog()"><span><img src="images/t02.png" /></span>成绩登记</a></li>
        <li><a href="javascript:openEscoreDialog()"><span><img src="images/t04.png" /></span>成绩统计</a></li>
        </ul>
        
     </div>
    <br>
    <br>
    <br>
  <!--   查询 -->
    <!--  <div>
	    <font style="font-size: 12pt" >&nbsp;查询条件：&nbsp; </font>  
	   	<font style="font-size: 12pt" >年级：</font>
	   	 <input class="easyui-combobox" id="gradeId" name="gradeId"  style="width:150px;height:30px; border: 1px solid #2468a2 " data-options="editable:false,panelHeight:'auto',valueField:'gradeId',textField:'gradeName',url:'listGradeName'"/>
	   	<font style="font-size: 12pt" >班级：</font>			
	   	 <input class="easyui-combobox" id="classId" name="classId" style="width: 150px; height: 30px;" data-options="editable:false,panelHeight:'auto',valueField:'classId',textField:'className',"/>
		<a href="javascript:searchExam()" class="easyui-linkbutton" iconCls="icon-search" plain="true"><font style="font-size: 12pt" >搜索</font></a> 
    </div>	 -->
   </div>    
    <table id="dg"></table>   
  <!--   考试信息添加 -->
     <div id="addExamDialog" class="easyui-dialog" style="width:800px;height: 450px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">  
      <form id="form1" method="post" >
       <table id="table" cellspacing="8px;" align="left">      
       </br>
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >考试名称:</font></td>
       <td><input type="text" id="examName" name="examName"  class="easyui-textbox" required="true" style="width:180px;height:28px;"></td><td style="width:150px;height:28px; "></td><td style="width:150px;height:28px; "></td></tr>    
       <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >考试时间:</font></td>
       <td><input type="text" id="examTime" name="examTime"  class="easyui-textbox" required="true" style="width:180px;height:28px; "></td><td style="width:150px;height:28px; "></td><td style="width:150px;height:28px; "></td></tr>                          
        <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >考试类型:</font></td>
            <td><input type="text"  name="leixing"  class="easyui-textbox" required="true" value="putong" style="width:180px;height:28px; ">
                <input type="hidden" id="type" name="type"  value="2"/>
           </td><td style="width:150px;height:28px; "></td><td style="width:150px;height:28px; "></td></tr>                        
        <tr><td style="width:100px;height:35px;"><font style="font-size: 12pt" >备注:</font></td>
        <td><input type="text" id="examRemark"name="examRemark"  class="easyui-textbox" required="true" style="width:220px;height:80px; "></td><td style="width:150px;height:28px; "></td><td style="width:150px;height:28px; "></td></tr>                      
       
       </table> 
       </form>              
    </div> 
     <div id="dlg-buttons">
	 <a href="javascript:saveExam()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	 <a href="javascript:closeExamAddDialog()" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>
  <!--   考试成绩表 -->
     <div id="escoreListDialog" class="easyui-dialog" style="width:800px;height: 550px" closed="true" >
       <div id="escoreToolbar">
       <table>
		  <tr> <td><a id="redo" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">导出</a></td>
		   <td><span style="margin-left:10px;">班级：<input id="escoreClassList" class="easyui-textbox" name="class" /></span></td></tr>
	    </table>
	   </div>
       <table id="escoreList" cellspacing="0" cellpadding="0"></table>
     </div> 
  <!--   考试成绩登记表 -->
     <div id="escoreRegisterDialog" class="easyui-dialog" style="width:800px;height: 550px" closed="true" buttons="#dlg-buttons1">
       <div>
       <table id="escoreToolbar1">
		  <tr> <td><a id="redo" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">导出</a></td>
		   <td><span style="margin-left:10px;">班级：<input id="escoreClassList1" class="easyui-textbox" name="class1" /></span></td>
		   <td><span style="margin-left:10px;">课程：<input id="escoreCourseList" class="easyui-textbox" name="course" /></span></td></tr>
	   </table>
	   </div>
       <table id="escoreRegister" cellspacing="0" cellpadding="0"></table>
     </div>
     <div id="dlg-buttons1">
	 <a href="javascript:escoreAdd()" class="easyui-linkbutton" iconCls="icon-ok" >提交</a>
	 <a href="javascript:closeRegisterDialog()" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div> 
  </body>
</html>