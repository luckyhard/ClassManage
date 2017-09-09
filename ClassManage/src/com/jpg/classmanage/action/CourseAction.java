package com.jpg.classmanage.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.service.CourseManage;
import com.jpg.classmanage.util.ResponseUtil;
import com.jpg.classmanage.util.StringUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
@Scope("prototype")
public class CourseAction extends ActionSupport implements ModelDriven{
	private static final long serialVersionUID = 1L;
	private Course course=new Course();
	private int page;
	private int rows;
	private List<Course> courseList;
	private JSONObject resultObj;
	private CourseManage courseManage;
	private String delIds;
	private int gradeIds;
	private int classIds;
	
	public String list() throws Exception{
		JSONObject resultObj=new JSONObject();
        Course c=new Course();
         if(StringUtil.isNotEmpty(course.getCourseName())){
			c.setCourseName(course.getCourseName());
		}
		if(course.getCourseId()!=0){
			c.setCourseId(course.getCourseId());
		}
		if(StringUtil.isNotEmpty(course.getCourseProperty()))
		{
			c.setCourseProperty(course.getCourseProperty());
		}
		int total=courseManage.countCourse();
		
		PageBean pageBean=new PageBean(getPage(),getRows());
		this.courseList=courseManage.findAll(pageBean,c);
		resultObj.put("total", total);
		resultObj.put("rows", courseList);	
		ResponseUtil.write(resultObj);
		return SUCCESS;	   	
	}
	
	
	public String addCourse() throws Exception

	{ 
		JSONObject result=new JSONObject();
		if(course.getCourseId()!=0)
		{    Course c=new Course();
		    c=courseManage.loadById(course.getCourseId()); 
			if(course.getCourseName().equals((c.getCourseName())))
		   {
				c.setCourseProperty(course.getCourseProperty());
				c.setCourseCredit(course.getCourseCredit());
			    courseManage.updateCourse(c);			
				result.put("success", true);		
		  }
		  else
		   {
			if(courseManage.existCourseWithCourseName(course.getCourseName()))
			   {
				result.put("success", true);
				result.put("errorMsg", "此课程已经存在");
				}
			else
			 {
				c.setCourseName(course.getCourseName());
			    c.setCourseProperty(course.getCourseProperty());
				c.setCourseCredit(course.getCourseCredit());
			    courseManage.updateCourse(c);			
				result.put("success", true);					
			 }					
		   }
		}
		else
		{
		  if(courseManage.existCourseWithCourseName(course.getCourseName()))
		   {
			result.put("success", true);
			result.put("errorMsg", "此课程已经存在");			
		  }
		else		
		{ 			
		     courseManage.add(course);
		     result.put("success", true);		 
		}
		}
		ResponseUtil.write(result);
		return SUCCESS;
	}

	public String delete() throws Exception
	{
		JSONObject result=new JSONObject();
		   int delNums=courseManage.deleteByIds(getDelIds());	
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
	 	
	
	public String comBoList() throws Exception
	{
		JSONObject resultObj=new JSONObject();
		JSONArray jsonArray=new JSONArray();   
		resultObj.put("courseId", "");
		resultObj.put("courseName","请选择");
		jsonArray.add(resultObj);	
		Course c=new Course();
		if(getGradeIds()!=0)
		{
	       this.courseList=courseManage.findByGradeId(getGradeIds());
		}
		else
		{ 
			this.courseList=courseManage.findAll(null, c);}
	        jsonArray.addAll(jsonArray.fromObject(courseList));
		    ResponseUtil.write(jsonArray);
		return SUCCESS;	   	
		
	}
	public String comBoListByTeacher() throws Exception
	{   
		 HttpServletRequest request=ServletActionContext.getRequest();
	     HttpSession session = request.getSession(true);
	     String teacherId1 = (String)session.getAttribute("teacherId");
		 int teacherId=Integer.parseInt(teacherId1);
		JSONObject resultObj=new JSONObject();
		JSONArray jsonArray=new JSONArray();   
		resultObj.put("courseId", "");
		resultObj.put("courseName","请选择");
		jsonArray.add(resultObj);	
	    this.courseList=courseManage.findByTeacher(getGradeIds(), getClassIds(), teacherId);	    
	    jsonArray.addAll(jsonArray.fromObject(courseList));
		ResponseUtil.write(jsonArray);
		return SUCCESS;	   	
	}
	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}
   public Object getModel() {
		
		return this.course;
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

public List<Course> getCourseList() {
	return courseList;
}

public void setCourseList(List<Course> courseList) {
	this.courseList = courseList;
}

public JSONObject getResultObj() {
	return resultObj;
}

public void setResultObj(JSONObject resultObj) {
	this.resultObj = resultObj;
}

public CourseManage getCourseManage() {
	return courseManage;
}
@Resource(name="courseManage")
public void setCourseManage(CourseManage courseManage) {
	this.courseManage = courseManage;
}


public String getDelIds() {
	return delIds;
}


public void setDelIds(String delIds) {
	this.delIds = delIds;
}


public int getGradeIds() {
	return gradeIds;
}


public void setGradeIds(int gradeIds) {
	this.gradeIds = gradeIds;
}


public int getClassIds() {
	return classIds;
}


public void setClassIds(int classIds) {
	this.classIds = classIds;
}




}
