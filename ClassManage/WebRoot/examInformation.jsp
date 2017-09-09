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
  url:"examAction",
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
 });  
 
 function openExamAddDialog(){
		$("#addExamDialog").dialog("open").dialog("setTitle","添加考试信息");
		url="addExamAction"; 
	}
 function saveExam(){
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
					closeExamAddDialog();
					$("#dg").datagrid("reload");
				}
			}
		}); 
	} 
     function closeExamAddDialog(){
		$("#addExamDialog").dialog("close");
		$("#form1").form("clear");
	  }
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
		  else
		  {}
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
            	},80);
	  }  
	}
	
	/* function deleteClasses(){
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
	}*/
	
	function searchExam(){
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
	
}
	 
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
        <li><a href="javascript:openExamAddDialog()"><span><img src="images/t01.png" /></span>添加</a></li>
<%--       
        <li><a href="javascript:openClassesModifyDialog()"><span><img src="images/t03.png" /></span>删除</a></li> --%>
        <li><a href="javascript:openEscoreDialog()"><span><img src="images/t04.png" /></span>成绩统计</a></li>
        </ul>
        
     </div>
    <br>
    <br>
    <br>
  <!--   查询 -->
     <div>
	    <font style="font-size: 12pt" >&nbsp;查询条件：&nbsp; </font>  
	   	<font style="font-size: 12pt" >年级：</font>
	   	 <input class="easyui-combobox" id="gradeId" name="gradeId"  style="width:150px;height:30px; border: 1px solid #2468a2 " data-options="editable:false,panelHeight:'auto',valueField:'gradeId',textField:'gradeName',url:'listGradeName'"/>
	   	<font style="font-size: 12pt" >班级：</font>			
	   	 <input class="easyui-combobox" id="classId" name="classId" style="width: 150px; height: 30px;" data-options="editable:false,panelHeight:'auto',valueField:'classId',textField:'className',"/>

	<%--  <select id="biaoyin" class="easyui-combobox" name="biaoyin" style="width:150px;height:23px" data-options="required:true,editable:false,panelHeight:'auto'">
	      <option>请选择</option>
         <option value="gradeName">考试年级</option>
		 <option value="examName">考试名称</option>
     </select> 
		&nbsp;查询内容：&nbsp;<input class="easyui-textbox" name="tiaojian" id="tiaojian" style="width:150px;height:23px"/>--%>
		<a href="javascript:searchExam()" class="easyui-linkbutton" iconCls="icon-search" plain="true"><font style="font-size: 12pt" >搜索</font></a> 
    </div>	
   </div>    
    <table id="dg"></table>   
  <!--   考试信息添加 -->
     <div id="addExamDialog" class="easyui-dialog" style="width:600px;height: 450px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">  
      <form id="form1" method="post" >
       <table cellspacing="10px;" align="left">      
       </br>
       <tr><td style="width:80px;height:35px;"><font style="font-size: 12pt" >考试名称:</font></td>
       <td><input type="text" name="examName"  class="easyui-textbox" required="true" style="width:220px;height:28px;"></td></tr>    
       <tr><td style="width:80px;height:35px;"><font style="font-size: 12pt" >考试时间:</font></td>
       <td><input type="text" name="examTime"  class="easyui-textbox" required="true" style="width:220px;height:28px; "></td>                           
       <tr><td style="width:80px;height:35px;"><font style="font-size: 12pt" >考试年级:</font></td>
           <td>
        <input class="easyui-combobox" id="gradeId" name="gradeId"  style="width:220px;height:28px; " data-options="editable:false,panelHeight:'auto',valueField:'gradeId',textField:'gradeName',url:'listGradeName'"/>
        </td></tr>
        <tr><td style="width:80px;height:35px;"><font style="font-size: 12pt" >考试类型:</font></td>
            <td><input type="text" name="leixing"  class="easyui-textbox" required="true" value="tongkao" style="width:220px;height:28px; ">
                <input type="hidden" name="type"  value="1"/>
           </td>                           
        <tr><td style="width:80px;height:35px;"><font style="font-size: 12pt" >备注:</font></td>
        <td><input type="text" name="examRemark"  class="easyui-textbox" required="true" style="width:250px;height:80px; "></td></tr>                      
       </table> 
       </form>              
    </div> 
     <div id="dlg-buttons">
	 <a href="javascript:saveExam()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	 <a href="javascript:closeExamAddDialog()" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>
  
  <!--   考试成绩表 -->
     <div id="escoreListDialog" class="easyui-dialog" style="width:800px;height:450px" closed="true" >
       <div id="escoreToolbar">
       <table>
		  <tr> <td><a id="redo" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">导出</a></td>
		   <td><span style="margin-left:10px;">班级：<input id="escoreClassList" class="easyui-textbox" name="class" /></span></td></tr>
	    </table>
	   </div>
       <table id="escoreList" cellspacing="0" cellpadding="0"></table>
     </div> 
  </body>
</html>