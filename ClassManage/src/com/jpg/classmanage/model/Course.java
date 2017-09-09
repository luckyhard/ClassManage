package com.jpg.classmanage.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Course {
  private int courseId;
  private String courseName;
  private String courseProperty;
  private String courseCredit;
  @Id
  @GeneratedValue
public int getCourseId() {
	return courseId;
}
public void setCourseId(int courseId) {
	this.courseId = courseId;
}
public String getCourseName() {
	return courseName;
}
public void setCourseName(String courseName) {
	this.courseName = courseName;
}
public String getCourseProperty() {
	return courseProperty;
}
public void setCourseProperty(String courseProperty) {
	this.courseProperty = courseProperty;
}
public String getCourseCredit() {
	return courseCredit;
}
public void setCourseCredit(String courseCredit) {
	this.courseCredit = courseCredit;
}

  
}
