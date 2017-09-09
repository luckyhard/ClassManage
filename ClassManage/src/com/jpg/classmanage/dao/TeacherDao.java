package com.jpg.classmanage.dao;

import java.util.List;

import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Teacher;
import com.jpg.classmanage.model.class_course_teacher;

public interface TeacherDao {
  public List findAll(PageBean page,Teacher g);
  public void addTeacher(Teacher t);
  public void addclass_course_teacher(class_course_teacher cct);
  public int count();
  public Teacher loadByName(Teacher t);
  public Teacher loadById(int teacherId);
  public List loadCourseByTeacher(int teacherId);
  public void updateTeacher(Teacher t);
  public void deleteTeacher(Teacher t);
  public void deleteCourseByTeacherId(int teacherId);
  public boolean existCourse(int gradeId,int classId,int courseId);
  public boolean existUpdateCourse(int gradeId,int classId,int courseId,int teacherId);
}
