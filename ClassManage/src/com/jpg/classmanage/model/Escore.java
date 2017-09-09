package com.jpg.classmanage.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
@Entity
public class Escore {
  private int escoreId;
  private int examId;
  private int gradeId;
  private int studentId;
  private int classId;
  private int courseId;
  private int score;
  @Id
  @GeneratedValue
public int getEscoreId() {
	return escoreId;
}
public void setEscoreId(int escoreId) {
	this.escoreId = escoreId;
}
public int getGradeId() {
	return gradeId;
}
public void setGradeId(int gradeId) {
	this.gradeId = gradeId;
}
public int getStudentId() {
	return studentId;
}
public void setStudentId(int studentId) {
	this.studentId = studentId;
}
public int getClassId() {
	return classId;
}
public void setClassId(int classId) {
	this.classId = classId;
}
public int getCourseId() {
	return courseId;
}
public void setCourseId(int courseId) {
	this.courseId = courseId;
}
public int getScore() {
	return score;
}
public void setScore(int score) {
	this.score = score;
}
public int getExamId() {
	return examId;
}
public void setExamId(int examId) {
	this.examId = examId;
}
  
}
