package com.jpg.classmanage.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Grade;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.grade_course;
import com.jpg.classmanage.service.GradeManage;
import com.jpg.classmanage.util.ResponseUtil;
import com.jpg.classmanage.util.StringUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class GradeAction extends ActionSupport implements ModelDriven{
  private static final long serialVersionUID = 1L;
  private  Grade grade=new Grade();
  private List<Grade> gradeList;
  private int page;
  private int rows;
  private GradeManage gradeManage;
  private 	String  courseIds;
  private JSONObject resultObj; 
  private String delIds;
  
    public String list() throws Exception{
		
		JSONObject resultObj=new JSONObject();
		Grade g=new Grade();
		
	  if(StringUtil.isNotEmpty(grade.getGradeName()))
		{
			g.setGradeName(grade.getGradeName());
	
		}
	  if(grade.getGradeId()!=0)
	  {
		  g.setGradeId(grade.getGradeId());
	  }
	
		int total=gradeManage.countGrade();
		PageBean pageBean=new PageBean(getPage(),getRows());
		this.gradeList=gradeManage.findAll(pageBean,g);
		resultObj.put("total", total);
		resultObj.put("rows", gradeList);
		ResponseUtil.write(resultObj);
		return SUCCESS;	   	
	}
	
	public String addGrade() throws Exception
	{ 
		grade_course gc;
		Grade g=new Grade();
		JSONObject result=new JSONObject();	
		if(grade.getGradeId()!=0)
		{
			Grade g1=new Grade();
			g1=gradeManage.loadById(grade.getGradeId());
			g1.setGradeName(grade.getGradeName());
			gradeManage.update(g1);
		}
		else
		{
		  if(gradeManage.existGradeWithGradeName(grade))
		  {
			    result.put("success", true);
				result.put("errorMsg", "请检查填写的数据"); 
		  }
		  else
		  {
			   gradeManage.addGrade(grade);
			    g=gradeManage.loadByName(grade.getGradeName());
			    String str2 = getCourseIds().replaceAll(" +","");
	           String str[]=str2.split(",");
	           for(int i=0;i<str.length;i++)
	           {
	        	gc=new grade_course();
	        	gc.setGradeId(g.getGradeId());
	            gc.setCourseId(Integer.parseInt(str[i]));
	              gradeManage.addGrade(gc);
	           }
	            result.put("success", true);	
		  }
		}
			ResponseUtil.write(result);
		return SUCCESS;
	}
  
	public String delete() throws Exception
	{
	JSONObject result=new JSONObject();
	
	   int delNums=gradeManage.delete(getDelIds());	
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
	resultObj.put("gradeId", "");
	resultObj.put("gradeName","请选择");	
	jsonArray.add(resultObj);
    this.gradeList=gradeManage.GradeNameList(grade);
    jsonArray.addAll(jsonArray.fromObject(gradeList)); 
	ResponseUtil.write(jsonArray);
    
	return SUCCESS;	   	
	
}
  
  
   public Object getModel() {
		
		return this.grade;
	}

	public Grade getGrade() {
		return grade;
	}

	public void setGrade(Grade grade) {
		this.grade = grade;
	}

	public List<Grade> getGradeList() {
		return gradeList;
	}

	public void setGradeList(List<Grade> gradeList) {
		this.gradeList = gradeList;
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

	public GradeManage getGradeManage() {
		return gradeManage;
	}
	@Resource(name="gradeManage")
	public void setGradeManage(GradeManage gradeManage) {
		this.gradeManage = gradeManage;
	}

	public JSONObject getResultObj() {
		return resultObj;
	}

	public void setResultObj(JSONObject resultObj) {
		this.resultObj = resultObj;
	}

	public String getCourseIds() {
		return courseIds;
	}

	public void setCourseIds(String courseIds) {
		this.courseIds = courseIds;
	}

	public String getDelIds() {
		return delIds;
	}

	public void setDelIds(String delIds) {
		this.delIds = delIds;
	}
	
}
