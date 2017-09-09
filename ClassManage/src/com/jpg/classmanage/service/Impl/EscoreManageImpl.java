package com.jpg.classmanage.service.Impl;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Component;
import com.jpg.classmanage.dao.EscoreDao;
import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.Exam;
import com.jpg.classmanage.model.Student;
import com.jpg.classmanage.service.EscoreManage;
@Component("escoreManage")
public class EscoreManageImpl implements EscoreManage{
 private EscoreDao escoreDao;
	
	public List<Map<String, Object>> getScoreList(Exam exam) {
	
		return escoreDao.getScoreList(exam);
	}
	public List<Course> CourseList(Exam exam) {
		
		return escoreDao.CourseList(exam);
	}
	public EscoreDao getEscoreDao() {
		return escoreDao;
	}
  @Resource
	public void setEscoreDao(EscoreDao escoreDao) {
		this.escoreDao = escoreDao;
	}

   public void registerScore(int scorseId, int scorse) {
     escoreDao.registerScore(scorseId, scorse);
	
   }

public List<Map<String, Object>> getScoreListByStudent(Exam exam, Student s) {
	
	return escoreDao.getScoreListByStudent(exam, s);
}

 
}
