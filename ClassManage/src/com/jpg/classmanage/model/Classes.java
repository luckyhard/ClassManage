package com.jpg.classmanage.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Class")
public class Classes {
 private int classId;
 private String className;
 private int gradeId;
 @Id
 @GeneratedValue
public int getClassId() {
	return classId;
}
public void setClassId(int classId) {
	this.classId = classId;
}
public String getClassName() {
	return className;
}
public void setClassName(String className) {
	this.className = className;
}
public int getGradeId() {
	return gradeId;
}
public void setGradeId(int gradeId) {
	this.gradeId = gradeId;
}

 
}
