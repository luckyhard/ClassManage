package com.jpg.classmanage.dao.Impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.ClassesDao;
import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.service.StudentManage;
import com.jpg.classmanage.util.HibernateUtil;
import com.jpg.classmanage.util.StringUtil;
import com.jpg.classmanage.util.classes_grade;

@Component("classesDao")
public class ClassesDaoImpl implements ClassesDao{
	private HibernateTemplate hibernateTemplate;
	  private StudentManage studentManage;
	  private SessionFactory sf;
	public List findAll(PageBean page,Classes c,String gradeName) {
		
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		StringBuffer hql=new StringBuffer("select c.classId,c.className,c.gradeId,g.gradeName from Classes c,Grade g where c.gradeId=g.gradeId");
		
		if(StringUtil.isNotEmpty(gradeName))
		{
			hql.append(" and g.gradeName='"+gradeName+"'");
		}
		if(StringUtil.isNotEmpty(c.getClassName()))
		{
			hql.append(" and c.className='"+c.getClassName()+"'");
		}
		if(c.getClassId()!=0)
		{ 
			hql.append(" and c.classId='"+c.getClassId()+"'");
		}
		if(c.getGradeId()!=0)
		{ 
			hql.append(" and c.gradeId='"+c.getGradeId()+"'");
		}
		Query query= s.createQuery(hql.toString());		
		if(page!=null){
			query.setFirstResult((page.getPage()-1)*page.getRows());
			query.setMaxResults(page.getRows());			
		}
		 List listClass=query.list();
			s.getTransaction().commit();
		return listClass;
	}

	
	public void addClasses(Classes classes) {
		hibernateTemplate.save(classes);
	}



	public boolean existClassesWithClassName(String className) {
		List<Classes> list=hibernateTemplate.find("from Classes c where c.className='"+className+"'");
		 if(list.size()==0)
		 {
			 return false;
		 }
		return true;
	}

	public Classes loadById(int id) {
		
		List<Classes> c=hibernateTemplate.find("from Classes c where c.classId='"+id+"'");
		return c.get(0);
	}

	public Classes loadByName(String name) {
	
		List<Classes> c=hibernateTemplate.find("from Classes c where c.className='"+name+"'");
		return c.get(0);
	}
	
	public void updateClasses(Classes classes)
	{
		hibernateTemplate.update(classes);
	}

	public int deleteByIds(String ids) {
		
		String str[]=ids.split(",");
		int delNum=0;
		for(int i=0;i<str.length;i++)
		{
			
			
			int id=Integer.parseInt(str[i]);
			 boolean f=studentManage.gtStudentByClassId(id);
			 if(f)
			 {
				 break;
			 }
			hibernateTemplate.delete(loadById(id));
			delNum++;
		}
		return delNum;
		
	}
	
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}


	public int countClasses() {
		List<Classes> list=hibernateTemplate.find("from Classes");
		return list.size();
	}

	public StudentManage getStudentManage() {
		return studentManage;
	}
	@Resource(name="studentManage")
	public void setStudentManage(StudentManage studentManage) {
		this.studentManage = studentManage;
	}

	
	public SessionFactory getSf() {
		return sf;
	}
    @Resource(name="sessionFactory")
	public void setSf(SessionFactory sf) {
		this.sf = sf;
	}


	
	public List<Classes> findByTeacher(int gradeId, int teacherId) {
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		String hql="select c from Classes c,class_course_teacher cct where cct.gradeId='"+gradeId+"'  and cct.teacherId='"+teacherId+"' and cct.classId=c.classId";
		Query query=s.createQuery(hql);
		List<Classes> list=query.list();
		for (int i = 0; i < list.size(); i++)  //外循环是循环的次数
        {
            for (int j = list.size() - 1 ; j > i; j--)  //内循环是 外循环一次比较的次数
            {

                if (list.get(i) == list.get(j))
                {
                   list.remove(j);
                }

            }
        }
		s.getTransaction().commit();
		return list;
	}





}
