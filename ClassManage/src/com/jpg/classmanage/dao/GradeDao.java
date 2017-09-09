package com.jpg.classmanage.dao;

import java.util.List;

import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Grade;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.grade_course;

public interface GradeDao {
	 public List findAll(PageBean page,Grade g);
	  public int countGrade();
	  public void add(Grade g);
	  public void add(grade_course gc);
	  public boolean existGradeWithGradeName(Grade g);
	  public boolean existGradeWithCourse(Grade g,int courseId);
	  public Grade loadByName(String name);
	  public Grade loadById(int id);
	  public List<Grade> gradeNameList(Grade g);
	  public void update(Grade g);
	  public void delete(Grade g);
	  public boolean getClassByGradeId(int id);
}
