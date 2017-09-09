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
  url:"examByStudentAction",
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
 

     
	function openEscoreDialog(){
	  var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要查看的数据！");
			return;
		}
		else		
		 {  
		 
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
			    	$("#escoreList").datagrid("options").url = "escoreListActionByStudent";
			    	$("#escoreList").datagrid("options").queryParams = data;
			    	$("#escoreList").datagrid("reload");			    	
			    	  $("#escoreListDialog").dialog("open").dialog("setTitle","考试统计");
            	},80);
	  }  
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
   
    <div>
	  <ul class="toolbar">
        <li><a href="javascript:openEscoreDialog()"><span><img src="images/t04.png" /></span>查看成绩</a></li>
        </ul>        
     </div>   
     <br>
     <br>
    <br>
    <table id="dg"></table>   
  
  <!--   考试成绩表 -->
     <div id="escoreListDialog" class="easyui-dialog" style="width:700px;height: 450px" closed="true" >
       <div id="escoreToolbar">
       <table>
		  <tr> <td><a id="redo" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">导出</a></td></tr>
	    </table>
	   </div>
       <table id="escoreList" cellspacing="0" cellpadding="0"></table>
     </div> 
  </body>
</html>