package com.jpg.classmanage.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.TeacherDao;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Teacher;
import com.jpg.classmanage.model.class_course_teacher;
import com.jpg.classmanage.service.TeacherManage;

@Component("teacherManage")
public class TeacherManageImpl implements TeacherManage{
     private TeacherDao teacherDao;
	
	public void addTeacher(Teacher t) {
	
		teacherDao.addTeacher(t);
	}
	
	public void addclass_course_teacher(class_course_teacher cct) {
      
		teacherDao.addclass_course_teacher(cct);
	}
	public int count() {

		return teacherDao.count();
	}
	public Teacher loadByName(Teacher t) {
		
		return teacherDao.loadByName(t);
	}
	public Teacher loadById(int teacherId) {
		
		return teacherDao.loadById(teacherId);
	}
	public List findAll(PageBean page, Teacher g) {
		return teacherDao.findAll(page, g);
	}
	
	public TeacherDao getTeacherDao() {
		return teacherDao;
	}
   @Resource(name="teacherDao")
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
	}


    public List loadCourseByTeacher(int teacherId) {
	
	return teacherDao.loadCourseByTeacher(teacherId);
}


    public void updateTeacher(Teacher t) {
	teacherDao.updateTeacher(t);
	
}


    public void deleteCourseByTeacherId(int teacherId) {

	teacherDao.deleteCourseByTeacherId(teacherId);
}

	public int deleteTeacher(String ids) {
		String str[]=ids.split(",");
		int delNum=0;
		for(int i=0;i<str.length;i++)
		{
			delNum++;
			int id=Integer.parseInt(str[i]);
			teacherDao.deleteTeacher(loadById(id));	
			teacherDao.deleteCourseByTeacherId(id);
		}
		return delNum;
	}

	
	public boolean existCourse(int gradeId, int classId, int courseId) {
		
		return teacherDao.existCourse(gradeId, classId, courseId);
	}


	public boolean existUpdateCourse(int gradeId, int classId, int courseId,int teacherId) {
		
		return teacherDao.existUpdateCourse(gradeId, classId, courseId,teacherId);
	}

	
}
