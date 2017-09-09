package com.jpg.classmanage.dao.Impl;

import java.util.LinkedList;
import java.util.List;
import javax.annotation.Resource;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;
import com.jpg.classmanage.dao.TeacherDao;
import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.Grade;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Teacher;
import com.jpg.classmanage.model.class_course_teacher;
import com.jpg.classmanage.util.StringUtil;
import com.jpg.classmanage.util.class_course_grade_teacherUtil;
import com.jpg.classmanage.util.class_course_teacherUtil;
@Component("teacherDao")
public class TeacherDaoImpl implements TeacherDao{
	private HibernateTemplate hibernateTemplate;
	 private SessionFactory sf;
	 
	 public List findAll(PageBean page, Teacher t1) {
		 List<class_course_teacherUtil> listCCTU=new LinkedList<class_course_teacherUtil>();
			Session s=sf.getCurrentSession();
			s.beginTransaction();
			StringBuffer hql=new StringBuffer("from Teacher t where 1=1 ");
			/*System.out.println(StringUtil.isNotEmpty(t1.getTeacherName()));
			if(StringUtil.isNotEmpty(t1.getTeacherName())==true);
			{System.out.println(t1.getTeacherName());
				hql.append("and t.teacherName='"+t1.getTeacherName()+"'");
		     }*/
		
			if(t1.getTeacherId()!=0)
			{
				hql.append("and t.teacherId='"+t1.getTeacherId()+"'");
			}
			Query query=s.createQuery(hql.toString());
			List<Object> list=query.list();
			class_course_teacherUtil cctu;
			for(Object obj:list)
			{   cctu=new class_course_teacherUtil();
				Teacher t=(Teacher)obj;
				Query query1 =s.createQuery("select grade.gradeName,classes.className,course.courseName from class_course_teacher cct,Grade grade,Classes classes,Course course where cct.teacherId='"+t.getTeacherId()+"' and cct.gradeId=grade.gradeId and cct.courseId=course.courseId and cct.classId=classes.classId");				
				List<Object> list1=query1.list();
				cctu.setTeacherId(t.getTeacherId());
				cctu.setTeacherName(t.getTeacherName());
				cctu.setTeacherSex(t.getTeacherSex());
				cctu.setTeacherBirthday(t.getTeacherBirthday());
				cctu.setTeacherPassword(t.getTeacherPassword());
				cctu.setTeacherTel(t.getTeacherTel());
				cctu.setTeacherAddress(t.getTeacherAddress());
				cctu.setObj(list1);
				listCCTU.add(cctu);
			}
			
			return listCCTU;
		}
	 
	 public List loadCourseByTeacher(int teacherId) {
		 Session s=sf.getCurrentSession();
		 s.beginTransaction();
		 String hql="from class_course_teacher cct where cct.teacherId='"+teacherId+"'";
		 Query query=s.createQuery(hql);
		 List<Object> list=query.list();
		 class_course_grade_teacherUtil ccgt;
		 List<class_course_grade_teacherUtil> list1=new LinkedList();
		 for(Object obj:list)
		 {  
			 ccgt=new class_course_grade_teacherUtil();
			 class_course_teacher cct1=(class_course_teacher)obj;
			 Query query1=s.createQuery("from Grade g where g.gradeId='"+cct1.getGradeId()+"'");	
			 List<Grade> listGrade=query1.list();
			 Query query2=s.createQuery("from Course c where c.courseId='"+cct1.getCourseId()+"'");
			 List<Course> listCourse=query2.list();
			 Query query3=s.createQuery("from  Classes c where c.classId='"+cct1.getClassId()+"'");
			 List<Classes> listClasses=query3.list();
			 ccgt.setClassId((listClasses.get(0)).getClassId());
			 ccgt.setClassName((listClasses.get(0)).getClassName());
			 ccgt.setCourseId((listCourse.get(0)).getCourseId());
			 ccgt.setCourseName((listCourse.get(0)).getCourseName());
			 ccgt.setGradeId((listGrade.get(0)).getGradeId());
			 ccgt.setGradeName((listGrade.get(0)).getGradeName());
			 list1.add(ccgt);
		 }
			return list1;
		}
	 
	 public void updateTeacher(Teacher t) {
			hibernateTemplate.update(t);
		}

	 public void deleteCourseByTeacherId(int teacherId) {
        Session s=sf.openSession();
        Transaction tx = s.beginTransaction();
        Query query=s.createQuery("delete from class_course_teacher cct where cct.teacherId='"+teacherId+"'");
        query.executeUpdate();
        tx.commit();
        s.close();
		}	
		
	 public void addTeacher(Teacher t) {
	    hibernateTemplate.save(t);
		
	}
     public void addclass_course_teacher(class_course_teacher cct) {
    	hibernateTemplate.save(cct);
	}
     public void deleteTeacher(Teacher t) {
 		hibernateTemplate.delete(t);
 	}
     public boolean existCourse(int gradeId, int classId, int courseId) {
 		List<class_course_teacher> list=hibernateTemplate.find("from class_course_teacher cct where cct.gradeId='"+gradeId+"' and cct.classId='"+classId+"' and cct.courseId='"+courseId+"'");
 		if(list.size()==0)
 		{
 			return false;
 		}
 		return true;
 	}
     public boolean existUpdateCourse(int gradeId, int classId, int courseId,int teacherId) {
    	 List<class_course_teacher> list=hibernateTemplate.find("from class_course_teacher cct where cct.gradeId='"+gradeId+"' and cct.classId='"+classId+"' and cct.courseId='"+courseId+"' and cct.teacherId!='"+teacherId+"'");
  		if(list.size()==0)
  		{
  			return false;
  		}
  		return true;
 	}
     public int count() {
		List<Teacher> list=hibernateTemplate.find("from Teacher");
		return list.size();
	 }
	
     public Teacher loadByName(Teacher t) {
    	List<Teacher> list=hibernateTemplate.find("from Teacher t where t.teacherName='"+t.getTeacherName()+"'");
		return list.get(0);
	}
     
     public Teacher loadById(int teacherId) {
    	 List<Teacher> list=hibernateTemplate.find("from Teacher t where t.teacherId='"+teacherId+"'");
 		return list.get(0);
 		
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
