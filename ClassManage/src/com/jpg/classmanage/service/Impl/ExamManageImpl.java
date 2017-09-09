package com.jpg.classmanage.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.ExamDao;
import com.jpg.classmanage.model.Exam;
import com.jpg.classmanage.model.PageBean;
import com.jpg.classmanage.model.Student;
import com.jpg.classmanage.service.ExamManage;
@Component("examManage")
public class ExamManageImpl implements ExamManage{
  private ExamDao examDao;

	public List findAll(PageBean page, Exam e) {
		
		return examDao.findAll(page, e);
	}
 
    public List findByTeacher(PageBean page, Exam e, int teacherId) {
			return examDao.findByTeacher(page, e, teacherId);
		  }
	public int countExam() {
		
		return examDao.countExam();
	}
	
	public void addExam(Exam e) {
       examDao.addExam(e); 
		
	}
	
	 public Exam loadByName(String name) {
			return examDao.loadByName(name);
     }
	 public void createScore(Exam e) {
		examDao.createScore(e);
	 }
	 
	public ExamDao getExamDao() {
		return examDao;
	}

   @Resource
	public void setExamDao(ExamDao examDao) {
		this.examDao = examDao;
	}


  public List findByStudent(PageBean page, Student s) {
	
	return examDao.findByStudent(page, s);
}

}
