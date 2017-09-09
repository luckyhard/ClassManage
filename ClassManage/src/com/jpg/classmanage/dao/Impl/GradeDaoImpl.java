package com.jpg.classmanage.dao.Impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JsonConfig;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.GradeDao;
import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.Grade;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Student;
import com.jpg.classmanage.model.grade_course;
import com.jpg.classmanage.util.StringUtil;
import com.jpg.classmanage.util.grade_courseUtil;

@Component("gradeDao")
public class GradeDaoImpl implements GradeDao{
	 private SessionFactory sf;
	 private HibernateTemplate hibernateTemplate;
  
	public List findAll(PageBean page, Grade g) {
		List<grade_courseUtil> list1=new LinkedList<grade_courseUtil>();
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		StringBuffer hql=new StringBuffer("from Grade g where 1=1");
		
		if(StringUtil.isNotEmpty(g.getGradeName()))
		{
			hql.append(" and g.gradeName='"+g.getGradeName()+"'");
			
		}
		if(g.getGradeId()!=0)
		{ 
			hql.append(" and g.gradeId='"+g.getGradeId()+"'");
		}
		Query query=s.createQuery(hql.toString());
		List<Object> list=query.list();		
		grade_courseUtil gcu;
		 for(Object obj : list){
				Grade grade = (Grade) obj;
				Query query1 =s.createQuery("select c.courseName from Course c,grade_course gc where gc.gradeId='"+grade.getGradeId()+"' and  gc.courseId=c.courseId");
				List<Course> CourseList=query1.list();
				Query query2 =s.createQuery("select c.className from Classes c where c.gradeId='"+grade.getGradeId()+"'");
				List<Classes> ClassesList=query2.list();
				gcu=new grade_courseUtil();
				gcu.setGradeName(grade.getGradeName());
				gcu.setGradeId(grade.getGradeId());
				gcu.setCourseNames(CourseList);
				gcu.setClassesNames(ClassesList);
				 list1.add(gcu);				
		 }
		 if(page!=null){
				query.setFirstResult((page.getPage()-1)*page.getRows());
				query.setMaxResults(page.getRows());				
			}
			s.getTransaction().commit();
			
		return list1;
	}
	public boolean existGradeWithGradeName(Grade g) {
		List<Grade> list=hibernateTemplate.find("from Grade g where g.gradeName='"+g.getGradeName()+"'");
		 if(list.size()==0)
		 {
			 return false;
		 }
		return true;
	}
   public boolean existGradeWithCourse(Grade g, int courseId) {
	   List<grade_course> list=hibernateTemplate.find("from grade_course gc where g.gradeId=gc.gradeId and gc.courseId='"+courseId+"'");
		 if(list.size()==0)
		 {
			 return false;
		 }
		return true;
		
	}

   
   public void add(Grade g) {
	hibernateTemplate.save(g);
	}
   
   
   public void add(grade_course gc) {
		hibernateTemplate.save(gc);
		}

	public int countGrade() {
List<Grade> list=hibernateTemplate.find("from Grade"); 		
		return list.size();
	}
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}
	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	public SessionFactory getSf() {
		return sf;
	}
    @Resource(name="sessionFactory")
	public void setSf(SessionFactory sf) {
		this.sf = sf;
	}
	
	public Grade loadByName(String name) {
		List<Grade> g=hibernateTemplate.find("from Grade g where g.gradeName='"+name+"'");
		return g.get(0);
	}
	
	public List<Grade> gradeNameList(Grade g) {
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		Query query=s.createQuery("from Grade");
	List<Grade> list=query.list();
	s.getTransaction().commit();
	return list;
	}
	
	public Grade loadById(int id) {
		List<Grade> g=hibernateTemplate.find("from Grade g where g.gradeId='"+id+"'");
		return g.get(0);
	}

	public void update(Grade g) {
		hibernateTemplate.update(g);
		
	}


	public void delete(Grade g) {
		List<grade_course> gcList=hibernateTemplate.find("from grade_course gc where gc.gradeId='"+g.getGradeId()+"'");
		 for(int i=0;i<gcList.size();i++)
		 {
			 hibernateTemplate.delete(gcList.get(i));
		 }
		hibernateTemplate.delete(g);
	
	
	}

	public boolean getClassByGradeId(int id) {	
			List<Classes> c=hibernateTemplate.find("from Classes c where c.gradeId='"+id+"'");
			
			if(c.size()==0)
			{
				return false;
			}
			return true;
		
	}
	
	
	
	

	
}
