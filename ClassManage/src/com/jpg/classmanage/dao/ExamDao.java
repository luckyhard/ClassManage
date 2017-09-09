package com.jpg.classmanage.dao;

import java.util.List;

import com.jpg.classmanage.model.Exam;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Student;

public interface ExamDao {
	  public List findAll(PageBean page,Exam e);
	  public int countExam();
	  public void addExam(Exam e);
	  public Exam loadByName(String name);
	  public void createScore(Exam e);
	  public List findByTeacher(PageBean page,Exam e,int teacherId);
	  public List findByStudent(PageBean page,Student s);
}
