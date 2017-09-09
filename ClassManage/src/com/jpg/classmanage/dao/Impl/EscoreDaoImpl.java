package com.jpg.classmanage.dao.Impl;

import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.EscoreDao;
import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.Escore;
import com.jpg.classmanage.model.Exam;
import com.jpg.classmanage.model.Student;
@Component("EscoreDao")
public class EscoreDaoImpl implements EscoreDao{
    private SessionFactory sf;
	private HibernateTemplate hibernateTemplate;
	public List<Map<String, Object>> getScoreList(Exam exam) {	
	
		Session s=sf.getCurrentSession();
		s.beginTransaction();
		StringBuffer hql=new StringBuffer("from Student s where s.gradeId='"+exam.getGradeId()+"'");
		if(exam.getClassId()!=0)
		{
			hql.append(" and s.classId='"+exam.getClassId()+"'");
		}
		Query query=s.createQuery(hql.toString());
		
		//该年级下（或班级）的所有学生
		List<Object> stuList=query.list();
		List<Map<String, Object>> list = new LinkedList<>();		
		for(int i=0;i<stuList.size();i++)
		{ 	
			StringBuffer hql1=new StringBuffer("from Escore e where e.examId='"+exam.getExamId()+"'");
			Map<String, Object> map = new LinkedHashMap<>();
			Student student = (Student) stuList.get(i);
			map.put("studentName",student.getStudentName());
			map.put("studentId",student.getStudentId());
			hql1.append("and e.studentId='"+student.getStudentId()+"'");
			Query query1=s.createQuery(hql1.toString());			
			List<Object> scoreList=query1.list();
			int total=0;
			for(Object obj:scoreList)
			{
				Escore score = (Escore) obj;
				total += score.getScore();
				map.put("course"+score.getCourseId(), score.getScore());
				map.put("escoreId"+score.getCourseId(), score.getEscoreId());
				
			}
			
			if(exam.getType() == 1){
				map.put("total", total);
			}
			
			list.add(map);
		}
		s.getTransaction().commit();
		return list;
	}
	public List<Course> CourseList(Exam e) {
		List<Course> courseList;
		if(e.getCourseId()==0)
		{
		courseList=hibernateTemplate.find("select c from Course c,grade_course gc where gc.gradeId='"+e.getGradeId()+"'and gc.courseId=c.courseId");
		}
		else
		{
			courseList=hibernateTemplate.find("select c from Course c,grade_course gc where gc.courseId='"+e.getCourseId()+"'and gc.courseId=c.courseId");
		}
		return courseList;
	} 
	
	public SessionFactory getSf() {
		return sf;
	}
	  @Resource(name="sessionFactory")
	public void setSf(SessionFactory sf) {
		this.sf = sf;
	}
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}
	 @Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	@Override
	public void registerScore(int scorseId, int scorse) {
		Session s=sf.getCurrentSession();
		s.beginTransaction();
		String hql="update  Escore e set e.score='"+scorse+"' where e.escoreId='"+scorseId+"'";
		Query query=s.createQuery(hql);
		query.executeUpdate();
		s.getTransaction().commit();
	}
	
	public List<Map<String, Object>> getScoreListByStudent(Exam exam,Student student1) {
		Session s=sf.getCurrentSession();
		s.beginTransaction();
		StringBuffer hql=new StringBuffer("from Student s where s.gradeId='"+exam.getGradeId()+"' and s.classId='"+student1.getClassId()+"'");
		Query query=s.createQuery(hql.toString());
		
		//该年级下（或班级）的所有学生
		List<Object> stuList=query.list();
		List<Map<String, Object>> list = new LinkedList<>();		
		for(int i=0;i<stuList.size();i++)
		{ 	
			StringBuffer hql1=new StringBuffer("from Escore e where e.examId='"+exam.getExamId()+"'");
			Map<String, Object> map = new LinkedHashMap<>();
			Student student = (Student) stuList.get(i);
			map.put("studentName",student.getStudentName());
			map.put("studentId",student.getStudentId());
			hql1.append("and e.studentId='"+student.getStudentId()+"'");
			Query query1=s.createQuery(hql1.toString());			
			List<Object> scoreList=query1.list();
			int total=0;
			for(Object obj:scoreList)
			{
				Escore score = (Escore) obj;
				total += score.getScore();
				map.put("course"+score.getCourseId(), score.getScore());
				map.put("escoreId"+score.getCourseId(), score.getEscoreId());
				
			}
			
			if(exam.getType() == 1){
				map.put("total", total);
			}
			
			list.add(map);
		}
		s.getTransaction().commit();
		return list;
	}

   
}
