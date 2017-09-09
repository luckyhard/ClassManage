package com.jpg.classmanage.action;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletResponseAware;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.jpg.classmanage.model.Exam;
import com.jpg.classmanage.model.Grade;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Student;
import com.jpg.classmanage.service.ExamManage;
import com.jpg.classmanage.service.StudentManage;
import com.jpg.classmanage.util.ResponseUtil;
import com.jpg.classmanage.util.StringUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class ExamAction extends ActionSupport implements ModelDriven{
  private Exam exam=new Exam();
  private StudentManage studentManage;
  private ExamManage examManage;
  private int page;
  private int rows;
  private JSONObject resultObj;
  private List examList;
  private String gradeName;
  
    public String list() throws Exception{
    	JSONObject resultObj=new JSONObject();
    	Exam e=new Exam();
    	if(exam.getGradeId()!=0)
    	{ 
    		e.setGradeId(exam.getGradeId());
    	}
    	if(exam.getClassId()!=0)
    	{
          e.setClassId(exam.getClassId());
    	}
		int total=examManage.countExam();
		PageBean pageBean=new PageBean(getPage(),getRows());
		this.examList=examManage.findAll(pageBean,e);
		resultObj.put("total", total);
		resultObj.put("rows", examList);
		ResponseUtil.write(resultObj);
		return SUCCESS;	   	
	}
    
    public String listByTeacher() throws Exception{
    	JSONObject resultObj=new JSONObject();
    	/*Exam e=new Exam();
    	if(exam.getGradeId()!=0)
    	{ 
    		e.setGradeId(exam.getGradeId());
    	}
    	if(exam.getClassId()!=0)
    	{
          e.setClassId(exam.getClassId());
    	}*/
    	    HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session = request.getSession(true);
			String teacherId1 = (String)session.getAttribute("teacherId");
			int teacherId=Integer.parseInt(teacherId1);
		    int total=examManage.countExam();
		    PageBean pageBean=new PageBean(getPage(),getRows());
		    this.examList=examManage.findByTeacher(pageBean, null,teacherId);
		    resultObj.put("total", total);
		    resultObj.put("rows", examList);
	     	ResponseUtil.write(resultObj);
		   return SUCCESS;	   	
	} 
    public String listByStudent() throws Exception
    {
    	    JSONObject resultObj=new JSONObject();
    	    Student s=new Student();
    	    HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session = request.getSession(true);
			String student1 = (String)session.getAttribute("studentId");
			int studentId=Integer.parseInt(student1);
		    int total=examManage.countExam();
		    PageBean pageBean=new PageBean(getPage(),getRows());
		    s=studentManage.loadById(studentId);
		    this.examList=examManage.findByStudent(pageBean,s);
		    resultObj.put("total", total);
		    resultObj.put("rows", examList);
	     	ResponseUtil.write(resultObj);
		   return SUCCESS;	   	
    }
    public String addExam() 
    {  try {
	   JSONObject result=new JSONObject();
	   if(exam.getType()==1)
	    {
		   exam.setClassId(0);
		   exam.setCourseId(0);
	    }

	   examManage.addExam(exam);
	   Exam m=new Exam();
	   m=examManage.loadByName(exam.getExamName());
	   examManage.createScore(m);
	   result.put("success",true);	 
		ResponseUtil.write(result);
	} catch (Exception e) {
		
		e.printStackTrace();
	}
	   return SUCCESS;
    }
	
    public Object getModel() {
		
		return this.exam;
	}

	public Exam getExam() {
		return exam;
	}

	public void setExam(Exam exam) {
		this.exam = exam;
	}

	public ExamManage getExamManage() {
		return examManage;
	}
    
	@Resource	
    public void setExamManage(ExamManage examManage) {
		this.examManage = examManage;
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

	public JSONObject getResultObj() {
		return resultObj;
	}

	public void setResultObj(JSONObject resultObj) {
		this.resultObj = resultObj;
	}

	public List getExamList() {
		return examList;
	}

	public void setExamList(List examList) {
		this.examList = examList;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public StudentManage getStudentManage() {
		return studentManage;
	}
@Resource
	public void setStudentManage(StudentManage studentManage) {
		this.studentManage = studentManage;
	}
}
