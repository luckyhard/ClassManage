package com.jpg.classmanage.service;

import java.util.List;

import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Grade;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.grade_course;

public interface GradeManage {
	public List<Grade> findAll(PageBean page,Grade g);
	 public int countGrade();
	 public void addGrade(Grade g);
	  public void addGrade(grade_course gc);
	  public boolean existGradeWithGradeName(Grade g);
	  public boolean existGradeWithCourse(Grade g,int courseId);
	  public Grade loadByName(String name);
	  public Grade loadById(int id);
	  public List<Grade> GradeNameList(Grade g);
	  public void update(Grade g);
	  public int delete(String delIds);
	  public boolean getClassByGradeId(int id);
}
