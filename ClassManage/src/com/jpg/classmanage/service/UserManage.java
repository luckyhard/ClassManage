package com.jpg.classmanage.service;

import com.jpg.classmanage.model.User;

public interface UserManage {
  public boolean logincheck(User user);
  public boolean loginTeacherCheck(User u);
  public boolean loginStudentCheck(User u);
}
