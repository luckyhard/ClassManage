package com.jpg.classmanage.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class grade_course {
 private int gcId;
 private int gradeId;
 private int courseId;
 @Id
 @GeneratedValue
public int getGcId() {
	return gcId;
}
public void setGcId(int gcId) {
	this.gcId = gcId;
}
public int getGradeId() {
	return gradeId;
}
public void setGradeId(int gradeId) {
	this.gradeId = gradeId;
}
public int getCourseId() {
	return courseId;
}
public void setCourseId(int courseId) {
	this.courseId = courseId;
}
 
}
