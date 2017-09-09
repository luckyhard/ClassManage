package com.jpg.classmanage.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Student {
  private int studentId;
  private String studentName;
  private String studentSex;
  private String studentBirthday;
  private String studentPassword;
  private String studentTel;
  private String studentAddress;
  private int  classId;
  private int gradeId;

@Id
@GeneratedValue
public int getStudentId() {
	return studentId;
}
public void setStudentId(int studentId) {
	this.studentId = studentId;
}
public String getStudentSex() {
	return studentSex;
}
public void setStudentSex(String studentSex) {
	this.studentSex = studentSex;
}
public String getStudentBirthday() {
	return studentBirthday;
}
public void setStudentBirthday(String studentBirthday) {
	this.studentBirthday = studentBirthday;
}
public String getStudentPassword() {
	return studentPassword;
}
public void setStudentPassword(String studentPassword) {
	this.studentPassword = studentPassword;
}
public String getStudentTel() {
	return studentTel;
}
public void setStudentTel(String studentTel) {
	this.studentTel = studentTel;
}
public String getStudentAddress() {
	return studentAddress;
}
public void setStudentAddress(String studentAddress) {
	this.studentAddress = studentAddress;
}
public int getClassId() {
	return classId;
}
public void setClassId(int classId) {
	this.classId = classId;
}
public String getStudentName() {
	return studentName;
}
public void setStudentName(String studentName) {
	this.studentName = studentName;
}
public int getGradeId() {
	return gradeId;
}
public void setGradeId(int gradeId) {
	this.gradeId = gradeId;
}


}
