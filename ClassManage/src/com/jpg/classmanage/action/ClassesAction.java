package com.jpg.classmanage.action;


import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.service.ClassesManage;
import com.jpg.classmanage.util.ResponseUtil;
import com.jpg.classmanage.util.StringUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;


@Component("classesAction")
@Scope("prototype")
public class ClassesAction extends ActionSupport implements ModelDriven{
	private static final long serialVersionUID = 1L;	 
	private List<Classes> classesList;
	private JSONObject resultObj;  
	private  Classes classes=new Classes();
    private ClassesManage  classesmanage;
    private String gradeName;
    private String delIds;
    private int page;
    private int rows;
    private int gradeIds;

	public String list() throws Exception{
		
		JSONObject resultObj=new JSONObject();
        Classes c=new Classes();         
    if(StringUtil.isNotEmpty(classes.getClassName())){
			c.setClassName(classes.getClassName());
		}
		if(classes.getClassId()!=0){
			c.setClassId(classes.getClassId());
		}
		int total=classesmanage.countClasses();
		PageBean pageBean=new PageBean(getPage(),getRows());
		this.classesList=classesmanage.findAll(pageBean,c,getGradeName());
		/*Map map = new HashMap();
		map.put("total", classesList.size());
		map.put("rows", classesList);	
		resultObj=JSONObject.fromObject(map);*/	
		resultObj.put("total", total);
		resultObj.put("rows", classesList);
		ResponseUtil.write(resultObj);
		return SUCCESS;	   	
	}
	
	public String addClasses() throws Exception
	{ 
		JSONObject result=new JSONObject();
		if(classesmanage.existClassesWithClassName(classes.getClassName()))
		{
			result.put("success", true);
			result.put("errorMsg", "此用户名已经存在");			
		}
		else		
		{ 
			if(classes.getClassId()!=0)
			{  
				     Classes c=new Classes();
				c=classesmanage.loadById(classes.getClassId());
				c.setClassName(classes.getClassName());
				c.setGradeId(classes.getGradeId());
			    classesmanage.updateClasses(c);			
				result.put("success", true);
			}
			else
			{
		     classesmanage.addClasses(classes);
		     result.put("success", true);		 
			}
		
		}
		ResponseUtil.write(result);
		return SUCCESS;
	}
	
	public String delete() throws Exception
	{
		JSONObject result=new JSONObject();
	
		
		   int delNums=classesmanage.deleteByIds(getDelIds());	
		    if(delNums>0)
		    	{
		    	result.put("success", true);
		    	result.put("delNums", delNums);
		    	}
		    else
		    	{
		    	result.put("errorMsg", "删除失败,班级下有学生！");
		    	}
		
		    ResponseUtil.write(result);
			return SUCCESS;
		
	}
	
	public List<Classes> getClassesList() {
		return classesList;
	}

	public void setClassesList(List<Classes> classesList) {
		this.classesList = classesList;
	}

	public String comBoList() throws Exception
	{
		JSONObject resultObj=new JSONObject();
		JSONArray jsonArray=new JSONArray();
		  Classes c=new Classes();
		if(getGradeIds()!=0)
		{
			c.setGradeId(getGradeIds());
		}
          
		resultObj.put("classId", "");
		resultObj.put("className","请选择");
		jsonArray.add(resultObj);
	    this.classesList=classesmanage.findAll(null,c,null);
	    jsonArray.addAll(jsonArray.fromObject(classesList)); 	
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
		resultObj.put("classId", "");
		resultObj.put("className","请选择");
		jsonArray.add(resultObj);	
	    this.classesList=classesmanage.findByTeacher(getGradeIds(), teacherId);	    
	    jsonArray.addAll(jsonArray.fromObject(classesList));
		ResponseUtil.write(jsonArray);
		return SUCCESS;	   
	}

	
	public Object getModel() {
		
		return this.classes;
	}

	public Classes getClasses() {
		return classes;
	}
	public void setClasses(Classes classes) {
		this.classes = classes;
	}

	public JSONObject getResultObj() {
		return resultObj;
	}

	public void setResultObj(JSONObject resultObj) {
		this.resultObj = resultObj;
	}

	public ClassesManage getClassesmanage() {
		return classesmanage;
	}
	@Resource(name="classesManage")
	public void setClassesmanage(ClassesManage classesmanage) {
		this.classesmanage = classesmanage;
	}

	public String getDelIds() {
		return delIds;
	}

	public void setDelIds(String delIds) {
		this.delIds = delIds;
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

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public int getGradeIds() {
		return gradeIds;
	}

	public void setGradeIds(int gradeIds) {
		this.gradeIds = gradeIds;
	}


	
}
