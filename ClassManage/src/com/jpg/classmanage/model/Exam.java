package com.jpg.classmanage.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Exam {
  private int examId;
  private String examName;
  private String examTime;
  private String examRemark;
  private  int gradeId;
  private  int classId;
  private  int courseId;  
  private int type;
  @Id
  @GeneratedValue
public int getExamId() {
	return examId;
}
public void setExamId(int examId) {
	this.examId = examId;
}
public String getExamName() {
	return examName;
}
public void setExamName(String examName) {
	this.examName = examName;
}
public String getExamTime() {
	return examTime;
}
public void setExamTime(String examTime) {
	this.examTime = examTime;
}
public String getExamRemark() {
	return examRemark;
}
public void setExamRemark(String examRemark) {
	this.examRemark = examRemark;
}
public int getGradeId() {
	return gradeId;
}
public void setGradeId(int gradeId) {
	this.gradeId = gradeId;
}
public int getClassId() {
	return classId;
}
public void setClassId(int classId) {
	this.classId = classId;
}
public int getType() {
	return type;
}
public void setType(int type) {
	this.type = type;
}
public int getCourseId() {
	return courseId;
}
public void setCourseId(int courseId) {
	this.courseId = courseId;
}
}
