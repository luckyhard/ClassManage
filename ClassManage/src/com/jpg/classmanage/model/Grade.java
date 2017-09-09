package com.jpg.classmanage.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Grade{

	private int gradeId;
    private String gradeName;
@Id
@GeneratedValue
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

}
