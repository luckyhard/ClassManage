package com.jpg.classmanage.dao;

import java.util.List;

import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Student;

public interface StudentDao {
	public List findAll(PageBean page,Student s,String className); 
	public int count();
	public void add(Student s);
	public Student loadById(int id);
	public void update(Student s);
	public void delete(Student s);
	public boolean getStudentByClassId(int id);
	public List<Student> findAllInClass(PageBean page,Student s);
}
