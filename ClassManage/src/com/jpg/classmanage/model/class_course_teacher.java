package com.jpg.classmanage.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class class_course_teacher {
   private int cctId;
   private int gradeId;
   private int classId;
   private int courseId;
   private int teacherId;
   @Id
   @GeneratedValue
public int getCctId() {
	return cctId;
}
public void setCctId(int cctId) {
	this.cctId = cctId;
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
public int getTeacherId() {
	return teacherId;
}
public void setTeacherId(int teacherId) {
	this.teacherId = teacherId;
}
public int getGradeId() {
	return gradeId;
}
public void setGradeId(int gradeId) {
	this.gradeId = gradeId;
}
}
