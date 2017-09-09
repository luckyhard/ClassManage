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
import com.jpg.classmanage.model.Student;
import com.jpg.classmanage.model.Teacher;
import com.jpg.classmanage.service.StudentManage;
import com.jpg.classmanage.util.ResponseUtil;
import com.jpg.classmanage.util.StringUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class StudentAction extends ActionSupport implements ModelDriven{
	private static final long serialVersionUID = 1L;	
    private Student student=new Student();
    private StudentManage studentManage;
    private List<Student> studentList;
    private int page;
    private int rows;
    private String delIds;
    private String className;

	public String list() throws Exception{		
		JSONObject resultObj=new JSONObject();
		int total=studentManage.countStudent();
		PageBean pageBean=new PageBean(getPage(),getRows());
		this.studentList=studentManage.findAll(pageBean,student,getClassName());
		resultObj.put("total", total);
		resultObj.put("rows", studentList);
		ResponseUtil.write(resultObj);			
		return SUCCESS;	   	
	}
   public String listByClass() throws Exception{
	    JSONObject resultObj=new JSONObject();
		int total=studentManage.countStudent();
		Student s=new Student();
		PageBean pageBean=new PageBean(getPage(),getRows());		
		HttpServletRequest request=ServletActionContext.getRequest();
 		HttpSession session = request.getSession(true);
 		String studentId1= (String)session.getAttribute("studentId");
 		int studentId=Integer.parseInt(studentId1);
    	s=studentManage.loadById(studentId);
		this.studentList=studentManage.findAllInClass(pageBean, s);
		resultObj.put("total", total);
		resultObj.put("rows", studentList);
		ResponseUtil.write(resultObj);			
		return SUCCESS;	   
   }
	public String addStudent() throws Exception
	{  JSONObject result=new JSONObject();
	    if(student.getStudentId()==0)
	    {
			studentManage.add(student);
			result.put("success", true);	
	    }
	    else
	    {
	    	studentManage.update(student);
	    	result.put("success", true);	
	    }
	    ResponseUtil.write(result);
	   
	        return SUCCESS;
		
	}
		
	public String delete() throws Exception
	{
	JSONObject result=new JSONObject();
	   int delNums=studentManage.delete(getDelIds());	
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
	
	 public String studentPersonList()
     {			
 	    HttpServletRequest request=ServletActionContext.getRequest();
 		HttpSession session = request.getSession(true);
 		String studentId1= (String)session.getAttribute("studentId");
 		int studentId=Integer.parseInt(studentId1);
    	this.student=studentManage.loadById(studentId);
    	return "success";
     }
	 public String updateStudentPersonal() throws Exception
     {       
      JSONObject result=new JSONObject();
      Student s=new Student();
   	  s=studentManage.loadById(student.getStudentId());
   	  s.setStudentName(student.getStudentName());
   	  s.setStudentTel(student.getStudentTel());
   	  s.setStudentBirthday(student.getStudentBirthday());
   	  s.setStudentAddress(student.getStudentAddress());
   	  studentManage.update(s);
   	  result.put("success", true);
   	  ResponseUtil.write(result);
   	  return SUCCESS;
     }
     public String updateStudentPassword() throws Exception
     {
    	 JSONObject result=new JSONObject();
    	  Student s=new Student();
      	  s=studentManage.loadById(student.getStudentId());    	  
      	  s.setStudentPassword(student.getStudentPassword());
      	  studentManage.update(s);
          result.put("success", true);
     	  ResponseUtil.write(result);
     	  return SUCCESS;
     }   
	public String comBoList() throws Exception
	{
		JSONObject resultObj=new JSONObject();
		JSONArray jsonArray=new JSONArray();
      Student s=new Student();  
	   /* resultObj.put("studentName", "");*/
		/*resultObj.put("studentId","请选择");*/
		jsonArray.add(resultObj);
		/*jsonArray.add(resultObj);*/
	  this.studentList=studentManage.findAll(null,s,null);
	  jsonArray.addAll(jsonArray.fromObject(studentList));
		ResponseUtil.write(jsonArray);
	    
		return SUCCESS;	   	
		
	}
		public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	
	public Object getModel() {
		
		return this.student;
	}

	public StudentManage getStudentManage() {
		return studentManage;
	}
	@Resource(name="studentManage")
	public void setStudentManage(StudentManage studentManage) {
		this.studentManage = studentManage;
	}

	public List<Student> getStudentList() {
		return studentList;
	}

	public void setStudentList(List<Student> studentList) {
		this.studentList = studentList;
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

	public String getDelIds() {
		return delIds;
	}

	public void setDelIds(String delIds) {
		this.delIds = delIds;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

}
