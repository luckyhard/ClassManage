package com.jpg.classmanage.service;

import java.util.List;

import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Student;

public interface StudentManage {
	public List<Student> findAll(PageBean page,Student c,String className); 
	public int countStudent();
	public void add(Student s);
	public void update(Student s);
	public Student loadById(int id);
	public int delete(String ids);
	public boolean gtStudentByClassId(int id);
	public List<Student> findAllInClass(PageBean page,Student s);
}
