package com.jpg.classmanage.service.Impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.ClassesDao;
import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.service.ClassesManage;
import com.jpg.classmanage.util.classes_grade;
@Component("classesManage")
public class ClassesManageImpl implements ClassesManage{

private ClassesDao classesDao;
	
	
	public List findAll(PageBean page,Classes c,String gradeName) {
		List<classes_grade> list1=new LinkedList<classes_grade>();
		 @SuppressWarnings("unchecked")
		List<Object[]> objects = classesDao.findAll(page,c,gradeName);
		 classes_grade cg;
			for(Object[] object:objects){ 
				cg=new classes_grade();
	          cg.setClassId((Integer)object[0]);
	          cg.setClassName((String)object[1]);
	          cg.setGradeId((Integer)object[2]);
	          cg.setGradeName((String)object[3]);
	         list1.add(cg); 
	        }  
		return list1;
	}
	
	public ClassesDao getClassesDao() {
		return classesDao;
	}


	@Resource(name="classesDao")
	public void setClassesDao(ClassesDao classesDao) {
		this.classesDao = classesDao;
	}


	public void addClasses(Classes classes) {
		
		classesDao.addClasses(classes);
	}


	public boolean existClassesWithClassName(String classsName) {
		
		return classesDao.existClassesWithClassName(classsName);
	}


	public void updateClasses(Classes classes) {
		
		classesDao.updateClasses(classes);
		
	}

	
	public Classes loadById(int id) {
		
		return classesDao.loadById(id);
	}


	public Classes loadByName(String name) {
	
		return classesDao.loadByName(name);
	}

	public int deleteByIds(String ids) {
		
		 return classesDao.deleteByIds(ids);
	}

	
	public int countClasses() {
		
		return classesDao.countClasses();
	}

	
	public List<Classes> findByTeacher(int gradeId, int teacherId) {
		
		return classesDao.findByTeacher(gradeId, teacherId);
	}

}
