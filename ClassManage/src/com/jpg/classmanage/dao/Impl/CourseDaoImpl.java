package com.jpg.classmanage.dao.Impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.ClassesDao;
import com.jpg.classmanage.dao.CourseDao;
import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.Grade;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.grade_course;
import com.jpg.classmanage.util.HibernateUtil;
import com.jpg.classmanage.util.StringUtil;
import com.jpg.classmanage.util.grade_courseUtil;
import com.jpg.classmanage.util.student_classes;

@Component("courseDao")
public class CourseDaoImpl implements CourseDao{
	private HibernateTemplate hibernateTemplate;
	 private SessionFactory sf;
	public List<Course> findAll(PageBean page,Course c) {
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		
		StringBuffer hql=new StringBuffer("from Course c where 1=1");
		if(StringUtil.isNotEmpty(c.getCourseName()))
		{
			hql.append(" and c.courseName='"+c.getCourseName()+"'");
		}
		if(c.getCourseId()!=0)
		{ 
			hql.append(" and c.courseId='"+c.getCourseId()+"'");
		}
		if(StringUtil.isNotEmpty(c.getCourseProperty()))
		{
			hql.append(" and c.courseProperty='"+c.getCourseProperty()+"'");
		}
		Query query=s.createQuery(hql.toString());		
		if(page!=null){
			query.setFirstResult((page.getPage()-1)*page.getRows());
			query.setMaxResults(page.getRows());
			
		}
		 List<Course> listCourse=query.list();
			s.getTransaction().commit();
		return listCourse;
	}

	public boolean existCourseWithCourseName(String courseName) {
		List<Course> list=hibernateTemplate.find("from Course c where c.courseName='"+courseName+"'");
		 if(list.size()==0)
		 {
			 return false;
		 }
		return true;
	}
	
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}
	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}


	public int countCourse() {
		List<Course> list=hibernateTemplate.find("from Course");
		return list.size();
	}

	public void add(Course c) {
		hibernateTemplate.save(c);
		
	}

	
	public void updateCourse(Course course) {
	
  hibernateTemplate.update(course);
	}


	public Course loadById(int id) {
	
		List<Course> c=hibernateTemplate.find("from Course c where c.courseId='"+id+"'");
		return c.get(0);
	}
	public void deleteById(Course c) {	
			hibernateTemplate.delete(c);	
	}


	public SessionFactory getSf() {
		return sf;
	}
    @Resource(name="sessionFactory")
	public void setSf(SessionFactory sf) {
		this.sf = sf;
	}

	
	public List<Course> findByGradeId(int id) {
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		String hql="select c from Course c,grade_course gc where gc.gradeId='"+id+"' and  gc.courseId=c.courseId";
		Query query=s.createQuery(hql);
		List<Course> list=query.list();	
		s.getTransaction().commit();
		return list;
	}


	public List<Course> findByTeacher(int gradeId, int classId, int teacherId) {
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		String hql="select c from Course c,class_course_teacher cct where cct.gradeId='"+gradeId+"' and  cct.classId='"+classId+"' and cct.teacherId='"+teacherId+"' and cct.courseId=c.courseId";
		Query query=s.createQuery(hql);
		List<Course> list=query.list();	
		s.getTransaction().commit();
		return list;
	}

}
