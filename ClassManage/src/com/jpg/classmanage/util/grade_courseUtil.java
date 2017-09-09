package com.jpg.classmanage.util;

import java.util.List;

import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.Course;

public class grade_courseUtil {
 private int gradeId;
 private String gradeName;
 private List<Course> courseNames;
 private List<Classes> classesNames;
public int getGradeId() {
	return gradeId;
}
public void setGradeId(int gradeId) {
	this.gradeId = gradeId;
}
public String getGradeName() {
	return gradeName;
}
public void setGradeName(String gradeName) {
	this.gradeName = gradeName;
}
public List<Course> getCourseNames() {
	return courseNames;
}
public void setCourseNames(List<Course> courseNames) {
	this.courseNames = courseNames;
}
public List<Classes> getClassesNames() {
	return classesNames;
}
public void setClassesNames(List<Classes> classesNames) {
	this.classesNames = classesNames;
}


}
