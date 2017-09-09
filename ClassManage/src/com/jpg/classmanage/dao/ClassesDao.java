package com.jpg.classmanage.dao;

import java.util.List;

import com.jpg.classmanage.model.Classes;
import com.jpg.classmanage.model.PageBean;

public interface ClassesDao {
  public List findAll(PageBean page,Classes c,String gradeName);
  public void addClasses(Classes classes);
  public boolean existClassesWithClassName(String classsName);
  public void updateClasses(Classes classes);
  public Classes loadById(int id);
  public Classes loadByName(String name);
  public int deleteByIds(String ids);
  public int countClasses();
  public List<Classes> findByTeacher(int gradeId,int teacherId);
}
