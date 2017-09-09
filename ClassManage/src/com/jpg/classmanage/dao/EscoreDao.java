package com.jpg.classmanage.dao;

import java.util.List;
import java.util.Map;

import com.jpg.classmanage.model.Course;
import com.jpg.classmanage.model.Exam;
import com.jpg.classmanage.model.Student;

public interface EscoreDao {
   public  List<Map<String, Object>> getScoreList(Exam exam);
   public  List<Map<String, Object>> getScoreListByStudent(Exam exam,Student s);
   public List<Course> CourseList(Exam exam);
   public void registerScore(int scorseId,int scorse);
}
