package com.jpg.classmanage.dao.Impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.ExamDao;
import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.Escore;
import com.jpg.classmanage.model.Exam;
import com.jpg.classmanage.model.Grade;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Student;
import com.jpg.classmanage.model.class_course_teacher;
import com.jpg.classmanage.model.grade_course;
import com.jpg.classmanage.util.ExamUtil;
import com.jpg.classmanage.util.StringUtil;

@Component("examDao")
public class ExamDaoImpl implements ExamDao{
 
	 private SessionFactory sf;
	 private HibernateTemplate hibernateTemplate;

	public List findAll(PageBean page, Exam e) {
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		StringBuffer hql=new StringBuffer("from Exam e1 where 1=1");
		if(e.getClassId()!=0)
		{
			hql.append("and e1.classId='"+e.getClassId()+"'");
		}
		if(e.getGradeId()!=0)
		{   
			hql.append("and e1.gradeId='"+e.getGradeId()+"'");
		}
		Query query=s.createQuery(hql.toString());
		 List<Object> listExam=query.list();
		 ExamUtil examUtil;
		 List<ExamUtil> listExamUtil=new LinkedList<ExamUtil>();
		 for(Object obj:listExam)
		 {
			 Exam exam=(Exam)obj;
			 if(exam.getClassId()!=0)
			 {  examUtil=new ExamUtil();
				 Query query1 =s.createQuery("from Course c where c.courseId='"+exam.getCourseId()+"'");
				 List<Course> CourseList=query1.list();
				 Query query2 =s.createQuery("from Classes c where c.classId='"+exam.getClassId()+"'"); 
				 List<Classes> ClassesList=query2.list();
				 Query query3=s.createQuery("from Grade g where g.gradeId='"+exam.getGradeId()+"'");
				 List<Grade> GradeList=query3.list();
				
				 examUtil.setExamId(exam.getExamId());
				 examUtil.setExamName(exam.getExamName());
				 examUtil.setExamRemark(exam.getExamRemark());
				 examUtil.setExamTime(exam.getExamTime());
				 examUtil.setType(exam.getType());
				 examUtil.setGradeId(exam.getGradeId());
				 examUtil.setGradeName((GradeList.get(0)).getGradeName());
				 examUtil.setCourseId(exam.getCourseId());
				 examUtil.setCourseName((CourseList.get(0)).getCourseName());
				 examUtil.setClassId(exam.getClassId());
				 examUtil.setClassName((ClassesList.get(0)).getClassName());				 
				 listExamUtil.add(examUtil);
			 }
			 else
			 {
				 examUtil=new ExamUtil();
				 Query query3=s.createQuery("from Grade g where g.gradeId='"+exam.getGradeId()+"'");
			   List<Grade> GradeList=query3.list();
			   examUtil.setExamId(exam.getExamId());
			   examUtil.setExamName(exam.getExamName());
			   examUtil.setExamRemark(exam.getExamRemark());
			   examUtil.setExamTime(exam.getExamTime());
			   examUtil.setType(exam.getType());
			   examUtil.setGradeId(exam.getGradeId());
			   examUtil.setGradeName((GradeList.get(0)).getGradeName());
			   examUtil.setCourseId(exam.getCourseId());
			   examUtil.setClassId(exam.getClassId());
			   listExamUtil.add(examUtil);
			 }
		 }
		 if(page!=null){
				query.setFirstResult((page.getPage()-1)*page.getRows());
				query.setMaxResults(page.getRows());
				
			}
			s.getTransaction().commit();
			
		return listExamUtil;
	}

	public List findByStudent(PageBean page, Student s) {
		Session s1=sf.getCurrentSession();
		s1.beginTransaction();
		String hql="from Exam e where e.gradeId='"+s.getGradeId()+"'";
		Query query=s1.createQuery(hql);
		 List<Object> listExam=query.list();
		 ExamUtil examUtil;
		 List<ExamUtil> listExamUtil=new LinkedList<ExamUtil>();
		 for(Object obj:listExam)
		 {
			 Exam exam=(Exam)obj;
			 if(exam.getClassId()!=0)
			 {  examUtil=new ExamUtil();
				 Query query1 =s1.createQuery("from Course c where c.courseId='"+exam.getCourseId()+"'");
				 List<Course> CourseList=query1.list();
				 Query query2 =s1.createQuery("from Classes c where c.classId='"+exam.getClassId()+"'"); 
				 List<Classes> ClassesList=query2.list();
				 Query query3=s1.createQuery("from Grade g where g.gradeId='"+exam.getGradeId()+"'");
				 List<Grade> GradeList=query3.list();
				
				 examUtil.setExamId(exam.getExamId());
				 examUtil.setExamName(exam.getExamName());
				 examUtil.setExamRemark(exam.getExamRemark());
				 examUtil.setExamTime(exam.getExamTime());
				 examUtil.setType(exam.getType());
				 examUtil.setGradeId(exam.getGradeId());
				 examUtil.setGradeName((GradeList.get(0)).getGradeName());
				 examUtil.setCourseId(exam.getCourseId());
				 examUtil.setCourseName((CourseList.get(0)).getCourseName());
				 examUtil.setClassId(exam.getClassId());
				 examUtil.setClassName((ClassesList.get(0)).getClassName());				 
				 listExamUtil.add(examUtil);
			 }
			 else
			 {
				 examUtil=new ExamUtil();
				 Query query3=s1.createQuery("from Grade g where g.gradeId='"+exam.getGradeId()+"'");
			   List<Grade> GradeList=query3.list();
			   examUtil.setExamId(exam.getExamId());
			   examUtil.setExamName(exam.getExamName());
			   examUtil.setExamRemark(exam.getExamRemark());
			   examUtil.setExamTime(exam.getExamTime());
			   examUtil.setType(exam.getType());
			   examUtil.setGradeId(exam.getGradeId());
			   examUtil.setGradeName((GradeList.get(0)).getGradeName());
			   examUtil.setCourseId(exam.getCourseId());
			   examUtil.setClassId(exam.getClassId());
			   listExamUtil.add(examUtil);
			 }
		 }
		 if(page!=null){
				query.setFirstResult((page.getPage()-1)*page.getRows());
				query.setMaxResults(page.getRows());
				
			}
			s1.getTransaction().commit();			
		return listExamUtil;
	}
	public List findByTeacher(PageBean page,Exam e, int teacherId) {
		 Session s=sf.getCurrentSession();
		 s.beginTransaction();
		 List<class_course_teacher> listCCT=hibernateTemplate.find("from class_course_teacher where teacherId='"+teacherId+"'");
		 StringBuffer g=new StringBuffer();
		 StringBuffer c=new StringBuffer();
		 for(class_course_teacher cct:listCCT)
		 {
			 g.append(","+cct.getGradeId());
			 c.append(","+cct.getCourseId());
		 }
		 StringBuffer sb=new StringBuffer("from Exam e where (e.gradeId IN (");
		 sb.append(g.toString().replaceFirst(",", ""));
		 sb.append(") and type=1) or (courseId in (");
		 sb.append(c.toString().replaceFirst(",",""));
		 sb.append(") and type=2)");
		 Query query=s.createQuery(sb.toString());
		 List<Object> listExam=query.list();
		 ExamUtil examUtil;
		 List<ExamUtil> listExamUtil=new LinkedList<ExamUtil>();
		 for(Object obj:listExam)
		 {
			 Exam exam=(Exam)obj;
			 if(exam.getClassId()!=0)
			 {  examUtil=new ExamUtil();
				 Query query1 =s.createQuery("from Course c where c.courseId='"+exam.getCourseId()+"'");
				 List<Course> CourseList=query1.list();
				 Query query2 =s.createQuery("from Classes c where c.classId='"+exam.getClassId()+"'"); 
				 List<Classes> ClassesList=query2.list();
				 Query query3=s.createQuery("from Grade g where g.gradeId='"+exam.getGradeId()+"'");
				 List<Grade> GradeList=query3.list();
				
				 examUtil.setExamId(exam.getExamId());
				 examUtil.setExamName(exam.getExamName());
				 examUtil.setExamRemark(exam.getExamRemark());
				 examUtil.setExamTime(exam.getExamTime());
				 examUtil.setType(exam.getType());
				 examUtil.setGradeId(exam.getGradeId());
				 examUtil.setGradeName((GradeList.get(0)).getGradeName());
				 examUtil.setCourseId(exam.getCourseId());
				 examUtil.setCourseName((CourseList.get(0)).getCourseName());
				 examUtil.setClassId(exam.getClassId());
				 examUtil.setClassName((ClassesList.get(0)).getClassName());				 
				 listExamUtil.add(examUtil);
			 }
			 else
			 {
				 examUtil=new ExamUtil();
				 Query query3=s.createQuery("from Grade g where g.gradeId='"+exam.getGradeId()+"'");
			   List<Grade> GradeList=query3.list();
			   examUtil.setExamId(exam.getExamId());
			   examUtil.setExamName(exam.getExamName());
			   examUtil.setExamRemark(exam.getExamRemark());
			   examUtil.setExamTime(exam.getExamTime());
			   examUtil.setType(exam.getType());
			   examUtil.setGradeId(exam.getGradeId());
			   examUtil.setGradeName((GradeList.get(0)).getGradeName());
			   examUtil.setCourseId(exam.getCourseId());
			   examUtil.setClassId(exam.getClassId());
			   listExamUtil.add(examUtil);
			 }
		 }
		 if(page!=null){
				query.setFirstResult((page.getPage()-1)*page.getRows());
				query.setMaxResults(page.getRows());
				
			}
			s.getTransaction().commit();
		return listExamUtil;
	}
   
	public void addExam(Exam e) {
		hibernateTemplate.save(e);
	}

	public Exam loadByName(String name) {
	List<Exam>	listExam=hibernateTemplate.find("from Exam e where e.examName='"+name+"'");
		return listExam.get(0);
	}
	
	public void createScore(Exam e) {
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		Escore escore;
		if(e.getType()==1)
		{	Query query1=s.createQuery("from grade_course gc where gc.gradeId='"+e.getGradeId()+"'");
			List<Object> courseList=query1.list();
			Query query2=s.createQuery("from Student s where s.gradeId='"+e.getGradeId()+"'");
		    List<Object> stuList=query2.list();
		    List<grade_course> couList = new LinkedList<grade_course>();
		    for(Object obj : courseList){
		    	grade_course course = (grade_course) obj;
				couList.add(course)	;
			}
		    for(int i=0;i<stuList.size();i++)
		    {
		    	Student student=(Student)stuList.get(i);
		    	 for(int j=0;j<courseList.size();j++)
		    	 {
		    		 escore=new Escore();
		    		 escore.setExamId(e.getExamId());
		    		 escore.setGradeId(e.getGradeId());
		    		 escore.setStudentId(student.getStudentId());
		    		 escore.setClassId(student.getClassId());
		    		 escore.setCourseId((couList .get(j)).getCourseId());
		    		 hibernateTemplate.save(escore);
		    	 }
		    }
		}
		else
		{
			Query query2=s.createQuery("from Student s where s.classId='"+e.getClassId()+"'");
		    List<Object> stuList=query2.list();
		    for(int i=0;i<stuList.size();i++)
		    {
		    	Student student=(Student)stuList.get(i);		    	
		    		 escore=new Escore();
		    		 escore.setExamId(e.getExamId());
		    		 escore.setGradeId(e.getGradeId());
		    		 escore.setStudentId(student.getStudentId());
		    		 escore.setClassId(e.getClassId());
		    		 escore.setCourseId(e.getCourseId());
		    		 hibernateTemplate.save(escore);
		    	
		    }
		}
		s.getTransaction().commit();
	}
	
	public int countExam() {
    List<Exam> list=hibernateTemplate.find("from Exam"); 		
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
}
