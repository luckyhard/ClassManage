package com.jpg.classmanage.service.Impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.GradeDao;
import com.jpg.classmanage.model.Grade;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.grade_course;
import com.jpg.classmanage.service.GradeManage;
import com.jpg.classmanage.util.grade_courseUtil;

@Component("gradeManage")
public class GradeManageImpl implements GradeManage
{ private GradeDao gradeDao;

	
	public void addGrade(Grade g) {
	 gradeDao.add(g);
		
	}
	  public void addGrade(grade_course gc)
	  {
		  gradeDao.add(gc);
	  }

	public List findAll(PageBean page, Grade g) {
		return gradeDao.findAll(page, g);
	}
	public Grade loadByName(String name) {
		
		return gradeDao.loadByName(name);
	}

	public GradeDao getGradeDao() {
		return gradeDao;
	}

    @Resource(name="gradeDao")
	public void setGradeDao(GradeDao gradeDao) {
		this.gradeDao = gradeDao;
	}

	public int countGrade() {
		
		return gradeDao.countGrade();
	}

	public boolean existGradeWithGradeName(Grade g) {
		
		return gradeDao.existGradeWithGradeName(g);
	}

	public boolean existGradeWithCourse(Grade g, int courseId) {
		
		return gradeDao.existGradeWithCourse(g, courseId);
	}
	
	public List<Grade> GradeNameList(Grade g) {
		
		return gradeDao.gradeNameList(g);
	}
	
	public Grade loadById(int id) {
		
		return gradeDao.loadById(id);
		}

	public void update(Grade g) {
		gradeDao.update(g);
		
	}
	
	public int delete(String ids) {
		
		String str[]=ids.split(",");
		int delNum=0;
		for(int i=0;i<str.length;i++)
		{
			
			int id=Integer.parseInt(str[i]);
			if(getClassByGradeId(id))
			{				
				delNum=0;		
				break;
			}
			delNum++;
			gradeDao.delete(loadById(id));
		
		}
		return delNum;
		
	}
	
	public boolean getClassByGradeId(int id) {
		
		return gradeDao.getClassByGradeId(id);
	}
	


}
