package com.jpg.classmanage.dao;

import com.jpg.classmanage.model.User;

public interface UserDao {
   public boolean logincheck(User user);
   public boolean loginTeacherCheck(User u);
   public boolean  loginStudentCheck(User u);
}
