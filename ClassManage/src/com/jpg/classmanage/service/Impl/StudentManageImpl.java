package com.jpg.classmanage.service.Impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.StudentDao;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Student;
import com.jpg.classmanage.service.StudentManage;
import com.jpg.classmanage.util.student_classes;

@Component("studentManage")
public class StudentManageImpl implements StudentManage{
   private StudentDao studentDao;
	
	public List findAll(PageBean page, Student s,String className) {
		List<student_classes> list1=new LinkedList<student_classes>();
		 List<Object[]> objects =studentDao.findAll(page, s,className);
			student_classes ab;
			for(Object[] object:objects){ 
				ab=new student_classes();
	          ab.setStudentId((Integer)object[0]);
	          ab.setStudentName((String)object[1]);
	          ab.setStudentSex((String)object[2]);
	          ab.setStudentBirthday((String)object[3]);
	          ab.setStudentPassword((String)object[4]);
	          ab.setStudentTel((String)object[5]);
	          ab.setStudentAddress((String)object[6]);
	          ab.setClassId((Integer)object[7]);
	          ab.setClassName((String)object[8]);
	          ab.setGradeId((Integer)object[9]);
	          ab.setGradeName((String)object[10]);
	         list1.add(ab); 
	        }  
		return list1;
	}

	public List<Student> findAllInClass(PageBean page, Student s) {
		
		return studentDao.findAllInClass(page, s);
	}
	public int countStudent() {
		
		return studentDao.count();
	}

    public Student loadById(int id) {
		
		return studentDao.loadById(id);
	}
    
    public int delete(String ids) {
    	String str[]=ids.split(",");
		int delNum=0;
		for(int i=0;i<str.length;i++)
		{
			delNum++;
			int id=Integer.parseInt(str[i]);
			studentDao.delete(loadById(id));
			
		}
		return delNum;
		
	}

	public StudentDao getStudentDao() {
		return studentDao;
	}

@Resource(name="studentDao")
  public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}

    public void add(Student s) {

	  studentDao.add(s);
     }



	public void update(Student s) {
		studentDao.update(s);
		
	}


	public boolean gtStudentByClassId(int id) {
	
		return studentDao.getStudentByClassId(id);
	}

}
