package com.jpg.classmanage.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Teacher;
import com.jpg.classmanage.model.class_course_teacher;
import com.jpg.classmanage.service.TeacherManage;
import com.jpg.classmanage.util.ResponseUtil;
import com.jpg.classmanage.util.StringUtil;
import com.jpg.classmanage.util.class_course_grade_teacherUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class TeacherAction extends ActionSupport implements ModelDriven{
     private String chooseCourse;
     private Teacher teacher=new Teacher();
     private TeacherManage teacherManage;
     private int page;
     private int rows;
     private String delIds;
     private List<Teacher> teacherList;
     private List<class_course_grade_teacherUtil>  list1;

     public String list() throws Exception{
 		JSONObject resultObj=new JSONObject();
 		int total=teacherManage.count();
 		
 		PageBean pageBean=new PageBean(getPage(),getRows());
 		this.teacherList=teacherManage.findAll(pageBean,teacher);
 		resultObj.put("total", total);
 		resultObj.put("rows", teacherList);
 		ResponseUtil.write(resultObj);	    
 		return SUCCESS;	   	
 	}
     public String addTeacher() throws Exception
       {	  
    	    boolean flage=false;
	        JSONObject result=new JSONObject();
	        class_course_teacher  cct = null;
	        Teacher t=new Teacher();
		  
			String[] gcc = getChooseCourse().split(",");
			for(int i=0;i<gcc.length;i++)
			{
				String[] gcc1 = gcc[i].split("_");
			    if(teacherManage.existCourse(Integer.parseInt(gcc1[0]), Integer.parseInt(gcc1[1]), Integer.parseInt(gcc1[2])))
			   {
				  flage=true;
				  break;
			   }
			}
			if(!flage)
			{
				teacherManage.addTeacher(teacher);				   
	            t=teacherManage.loadByName(teacher); 
			  for(int i=0;i<gcc.length;i++)
			  {		
				String[] gcc1 = gcc[i].split("_");	
			    cct=new class_course_teacher();
			    cct.setGradeId(Integer.parseInt(gcc1[0]));
			    cct.setClassId(Integer.parseInt(gcc1[1]));
			    cct.setCourseId(Integer.parseInt(gcc1[2]));
			    cct.setTeacherId(t.getTeacherId());	
		         teacherManage.addclass_course_teacher(cct);   
			   }
			  result.put("success", true);
			}
			else
			{ result.put("errorMsg", "该课程已有人教！");}			
		    ResponseUtil.write(result);
		    
	        return SUCCESS;
   }
     public String loadCourseByTeacher() throws Exception
      {   int teacherId;
	     JSONArray result=new JSONArray();	
	    HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session = request.getSession(true);
		String teacherId1 = (String)session.getAttribute("teacherId");
		if(teacher.getTeacherId()==0)
		{
		 teacherId=Integer.parseInt(teacherId1);
		}
		else
		{
			 teacherId=teacher.getTeacherId();
		}
		this.list1=teacherManage.loadCourseByTeacher(teacherId);
		result.addAll(result.fromObject(list1));
	    ResponseUtil.write(result);
	
		   return SUCCESS;	   	
   }
	 
     public String updateTeacher() throws Exception
      {
    	  boolean flage=false;
    	  class_course_teacher  cct = null;
    	  JSONObject result=new JSONObject();
    	  Teacher t=new Teacher();
    	  t=teacherManage.loadById(teacher.getTeacherId());
    	  t.setTeacherName(teacher.getTeacherName());
    	  t.setTeacherSex(teacher.getTeacherSex());
    	  t.setTeacherPassword(teacher.getTeacherPassword());
    	  t.setTeacherTel(teacher.getTeacherTel());
    	  t.setTeacherBirthday(teacher.getTeacherBirthday());
    	  t.setTeacherAddress(teacher.getTeacherAddress());
    	  String[] gcc = getChooseCourse().split(",");
    	  for(int i=0;i<gcc.length;i++)
			{
				String[] gcc1 = gcc[i].split("_");
			    if(teacherManage.existUpdateCourse(Integer.parseInt(gcc1[0]), Integer.parseInt(gcc1[1]), Integer.parseInt(gcc1[2]),teacher.getTeacherId()))
			   {
				  flage=true;
				  break;
			   }
			}
    	  if(!flage)
			{
    		  teacherManage.updateTeacher(t);
        	  teacherManage.deleteCourseByTeacherId(teacher.getTeacherId());
			 for(int i=0;i<gcc.length;i++)
			  {		
			   String[] gcc1 = gcc[i].split("_");
			   cct=new class_course_teacher();
			   cct.setGradeId(Integer.parseInt(gcc1[0]));
			   cct.setClassId(Integer.parseInt(gcc1[1]));
			   cct.setCourseId(Integer.parseInt(gcc1[2]));
			   cct.setTeacherId(t.getTeacherId());	
		       teacherManage.addclass_course_teacher(cct);
			}
			 result.put("success", true);
		   }
    	  else
			{ result.put("errorMsg", "该课程已有人教！修改失败！");}		
		    ResponseUtil.write(result);
    	  return SUCCESS;
      }
     
     public String updateTeacherPersonal() throws Exception
     {
      JSONObject result=new JSONObject();
       Teacher t=new Teacher();
   	  t=teacherManage.loadById(teacher.getTeacherId());
   	  t.setTeacherName(teacher.getTeacherName());
   	  t.setTeacherTel(teacher.getTeacherTel());
   	  t.setTeacherBirthday(teacher.getTeacherBirthday());
   	  t.setTeacherAddress(teacher.getTeacherAddress());
   	  teacherManage.updateTeacher(t);
   	  result.put("success", true);
   	  ResponseUtil.write(result);
   	  return SUCCESS;
     }
     
     public String updateTeacherPassword() throws Exception
     {
    	 JSONObject result=new JSONObject();
    	  Teacher t=new Teacher();
      	  t=teacherManage.loadById(teacher.getTeacherId());    	  
      	  t.setTeacherPassword(teacher.getTeacherPassword());
      	  teacherManage.updateTeacher(t);
          result.put("success", true);
     	  ResponseUtil.write(result);
     	  return SUCCESS;
     }
     public String deleteTeacher() throws Exception
     {
      JSONObject result=new JSONObject();
      int delNums=teacherManage.deleteTeacher(getDelIds());	
	    if(delNums>0)
	    	{
	    	result.put("success", true);
	    	result.put("delNums", delNums);
	    	}
	    else
	    	{
	    	result.put("errorMsg", "删除失败,记录被其他记录引用！");
	    	}
	    ResponseUtil.write(result); 
    	 return SUCCESS;
     }
     
     public String teacherPersonList()
     {
       
 	    HttpServletRequest request=ServletActionContext.getRequest();
 		HttpSession session = request.getSession(true);
 		String teacherId1 = (String)session.getAttribute("teacherId");
 		int teacherId=Integer.parseInt(teacherId1);
    	 this.teacher=teacherManage.loadById(teacherId);
    	 return "success";
     }
     
     public Object getModel() {
		return this.teacher;
	}
	 public String getChooseCourse() {
		return chooseCourse;
	}
	 public void setChooseCourse(String chooseCourse) {
		this.chooseCourse = chooseCourse;
	}
	 public Teacher getTeacher() {
		return teacher;
	}
	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}
	public TeacherManage getTeacherManage() {
		return teacherManage;
	}
	@Resource(name="teacherManage")
	public void setTeacherManage(TeacherManage teacherManage) {
		this.teacherManage = teacherManage;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public List<Teacher> getTeacherList() {
		return teacherList;
	}
	public void setTeacherList(List<Teacher> teacherList) {
		this.teacherList = teacherList;
	}
	public List<class_course_grade_teacherUtil> getList1() {
		return list1;
	}
	public void setList1(List<class_course_grade_teacherUtil> list1) {
		this.list1 = list1;
	}
	public String getDelIds() {
		return delIds;
	}
	public void setDelIds(String delIds) {
		this.delIds = delIds;
	}


}
