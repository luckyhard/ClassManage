package com.jpg.classmanage.service;

import java.util.List;

import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.PageBean;

public interface CourseManage {
	public List<Course> findAll(PageBean page,Course c); 
	public int countCourse();
	public boolean existCourseWithCourseName(String courseName);
	public void add(Course c);
	public void updateCourse(Course course);
	public Course loadById(int id);
	public int deleteByIds(String ids);
	public List<Course> findByGradeId(int id);
	public List<Course> findByTeacher(int gradeId, int classId, int teacherId);
}
