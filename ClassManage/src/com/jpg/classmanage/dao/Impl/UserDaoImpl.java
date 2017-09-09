package com.jpg.classmanage.dao.Impl;


import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jpg.classmanage.dao.UserDao;
import com.jpg.classmanage.model.Student;
import com.jpg.classmanage.model.Teacher;
import com.jpg.classmanage.model.User;

@Component("userDao")
public class UserDaoImpl implements UserDao{
	private  HibernateTemplate hibernateTemplate;
    private SessionFactory sf;
	public boolean logincheck(User user) {
	
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		long count = (Long)s.createQuery("select count(*) from User u where u.username = :username and password=:password")
			.setString("username", user.getUsername())
			.setString("password", user.getPassword())
			.uniqueResult();
		s.getTransaction().commit();
		if(count > 0) return true;
		return false;
	}
	public boolean loginTeacherCheck(User u) {
		List<Teacher> listTeacher=hibernateTemplate.find("from Teacher t where t.teacherId ='"+u.getUsername()+"' and t.teacherPassword='"+u.getPassword()+"'");
		if(listTeacher.size() > 0) return true;
		return false;
	}
	public boolean loginStudentCheck(User u) {
		List<Student> listStudent=hibernateTemplate.find("from Student s where s.studentId ='"+u.getUsername()+"' and s.studentPassword='"+u.getPassword()+"'");
		if(listStudent.size() > 0) return true;
		return false;
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
}
