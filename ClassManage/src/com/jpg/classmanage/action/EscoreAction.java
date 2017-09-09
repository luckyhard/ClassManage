package com.jpg.classmanage.action;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.Exam;
import com.jpg.classmanage.model.Student;
import com.jpg.classmanage.service.EscoreManage;
import com.jpg.classmanage.service.StudentManage;
import com.jpg.classmanage.util.ResponseUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class EscoreAction extends ActionSupport implements ModelDriven{
	private static final long serialVersionUID = 1L;	
	private Exam exam=new Exam();
	private EscoreManage escoreManage;
	private StudentManage studentManage;
    private List<Map<String, Object>> list;
    private List<Course> courseList;
    private String score;
	public String getEscoreList()
	 
	{   
		JSONArray resultObj=new JSONArray();
	    this.list=escoreManage.getScoreList(exam);
	    resultObj.addAll(resultObj.fromObject(list));
	    try {
			ResponseUtil.write(resultObj);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	    
	return SUCCESS;
	}
	
	public String getEscoreListByStudent()
	 
	{   System.out.println(11);
		JSONArray resultObj=new JSONArray();
		Student s=new Student();
		HttpServletRequest request=ServletActionContext.getRequest();
 		HttpSession session = request.getSession(true);
 		String studentId1= (String)session.getAttribute("studentId");
 		int studentId=Integer.parseInt(studentId1);
    	s=studentManage.loadById(studentId);
	    this.list=escoreManage.getScoreListByStudent(exam,s);
	    resultObj.addAll(resultObj.fromObject(list));
	    try {
			ResponseUtil.write(resultObj);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	    
	return SUCCESS;
	}
	
	public String CourseList() throws Exception {
		JSONArray result=new JSONArray();
        this.courseList=escoreManage.CourseList(exam);
        result.addAll(result.fromObject(courseList));
        ResponseUtil.write(result);
    	return SUCCESS;
    }
	
	public String registerScore() throws Exception
	{
		JSONObject result=new JSONObject();
		String str2=getScore().replaceAll(" ", ""); 
		String[] str=str2.split(",");
		for(int i=0;i<str.length;i++)
		{
		 String[] str1 = str[i].split("_");
		 int scorseId=Integer.parseInt(str1[0]);
		 int score1=Integer.parseInt(str1[1]);
		 escoreManage.registerScore(scorseId, score1);
		}
		 result.put("success", true);
		 ResponseUtil.write(result);
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
	public List<Map<String, Object>> getList() {
		return list;
	}
	public void setList(List<Map<String, Object>> list) {
		this.list = list;
	}
	public List<Course> getCourseList() {
		return courseList;
	}
	public void setCourseList(List<Course> courseList) {
		this.courseList = courseList;
	}
	public EscoreManage getEscoreManage() {
		return escoreManage;
	}
	@Resource
	public void setEscoreManage(EscoreManage escoreManage) {
		this.escoreManage = escoreManage;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}

	public StudentManage getStudentManage() {
		return studentManage;
	}
@Resource
	public void setStudentManage(StudentManage studentManage) {
		this.studentManage = studentManage;
	}	
}
