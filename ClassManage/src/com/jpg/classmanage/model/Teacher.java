package com.jpg.classmanage.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Teacher {
  private int teacherId;
  private String teacherName;
  private String teacherSex;
  private String teacherBirthday;
  private String teacherPassword;
  private String teacherTel;
  private String teacherAddress;
  @Id
  @GeneratedValue
public int getTeacherId() {
	return teacherId;
}
public void setTeacherId(int teacherId) {
	this.teacherId = teacherId;
}
public String getTeacherName() {
	return teacherName;
}
public void setTeacherName(String teacherName) {
	this.teacherName = teacherName;
}
public String getTeacherSex() {
	return teacherSex;
}
public void setTeacherSex(String teacherSex) {
	this.teacherSex = teacherSex;
}
public String getTeacherBirthday() {
	return teacherBirthday;
}
public void setTeacherBirthday(String teacherBirthday) {
	this.teacherBirthday = teacherBirthday;
}
public String getTeacherPassword() {
	return teacherPassword;
}
public void setTeacherPassword(String teacherPassword) {
	this.teacherPassword = teacherPassword;
}
public String getTeacherTel() {
	return teacherTel;
}
public void setTeacherTel(String teacherTel) {
	this.teacherTel = teacherTel;
}
public String getTeacherAddress() {
	return teacherAddress;
}
public void setTeacherAddress(String teacherAddress) {
	this.teacherAddress = teacherAddress;
}
}
