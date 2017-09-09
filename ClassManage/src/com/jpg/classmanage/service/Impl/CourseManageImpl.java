package com.jpg.classmanage.service.Impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.CourseDao;
import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.service.CourseManage;

@Component("courseManage")
public class CourseManageImpl implements CourseManage{
    private CourseDao courseDao;
  
public List<Course> findAll(PageBean page,Course c) {
		
		return courseDao.findAll(page,c);
	}
	
    public int countCourse() {
		return courseDao.countCourse();
	}
    
    public boolean existCourseWithCourseName(String courseName) {
    	
		return courseDao.existCourseWithCourseName(courseName);
	}
    
   public void add(Course c) {
		courseDao.add(c);
	  }

	
   public void updateCourse(Course course) {
		
		courseDao.updateCourse(course);
	}

	
	public Course loadById(int id) {
	
		return courseDao.loadById(id);
	}

    public CourseDao getCourseDao() {
		return courseDao;
	}
    @Resource(name="courseDao")
	public void setCourseDao(CourseDao courseDao) {
		this.courseDao = courseDao;
	}


	public int deleteByIds(String ids) {
		String str[]=ids.split(",");
		int delNum=0;
		for(int i=0;i<str.length;i++)
		{
			delNum++;
			int id=Integer.parseInt(str[i]);
			courseDao.deleteById(loadById(id));
			
		}
		return delNum;
		
	}

	
	public List<Course> findByGradeId(int id) {
		
		return courseDao.findByGradeId(id);
	}

	
	public List<Course> findByTeacher(int gradeId, int classId, int teacherId) {
		
		return courseDao.findByTeacher(gradeId, classId, teacherId);
	}

	
	


	

	
}
