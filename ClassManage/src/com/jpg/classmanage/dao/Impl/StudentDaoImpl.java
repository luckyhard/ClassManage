package com.jpg.classmanage.dao.Impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.StudentDao;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Student;
import com.jpg.classmanage.util.StringUtil;

@Component("studentDao")
public class StudentDaoImpl implements StudentDao{
	 private SessionFactory sf;
	private HibernateTemplate hibernateTemplate;
	@SuppressWarnings("unchecked")
	public List findAll(PageBean page, Student s,String className) {
		Session s1 = sf.getCurrentSession();
		s1.beginTransaction();
		StringBuffer hql=new StringBuffer("select s.studentId,s.studentName,s.studentSex,s.studentBirthday,s.studentPassword,s.studentTel,s.studentAddress,c.classId,c.className,g.gradeId,g.gradeName from Student s,Classes c,Grade g where s.classId=c.classId and s.gradeId=g.gradeId");
		if(StringUtil.isNotEmpty(s.getStudentName()))
		{
			hql.append(" and s.studentName='"+s.getStudentName()+"'");
		}
		if(s.getStudentId()!=0)
		{ 
			hql.append(" and s.studentId='"+s.getStudentId()+"'");
		}
		if(StringUtil.isNotEmpty(className))
		{ 
			hql.append(" and c.className='"+className+"'");
		}
		Query query=s1.createQuery(hql.toString());	
		List listStudent=query.list();
		if(page!=null){
			query.setFirstResult((page.getPage()-1)*page.getRows());
			query.setMaxResults(page.getRows());
			
		}		
			s1.getTransaction().commit();
			return listStudent;
	}
	
	public List<Student> findAllInClass(PageBean page, Student s) {
		List<Student> list=hibernateTemplate.find("from Student s where s.classId='"+s.getClassId()+"'");
		return list;
	}
    public int count() {    	
    	List<Student> list=hibernateTemplate.find("from Student");
		return list.size();
	  }
	
     public void add(Student s) {
		hibernateTemplate.save(s);
		
	}
	
     public Student loadById(int id) {
 		
    	 List<Student> s=hibernateTemplate.find("from Student s where s.studentId='"+id+"'");
 		return s.get(0);
 	}
     
     public void update(Student s) {
 		hibernateTemplate.update(s);
 		
 	}
     public void delete(Student s) {
    	 hibernateTemplate.delete(s);	
 	}
     
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}
	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	public boolean getStudentByClassId(int id) {
		List<Student> s=hibernateTemplate.find("from Student s where s.classId='"+id+"'");
		
		if(s.size()==0)
		{
			return false;
		}
		return true;
	}

	
	public SessionFactory getSf() {
		return sf;
	}
    @Resource(name="sessionFactory")
	public void setSf(SessionFactory sf) {
		this.sf = sf;
	}	 
}
