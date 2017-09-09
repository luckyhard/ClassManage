package com.jpg.classmanage.service.Impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.jpg.classmanage.dao.UserDao;
import com.jpg.classmanage.model.User;
import com.jpg.classmanage.service.UserManage;
@Component("userManage")
public class UserManageImpl implements UserManage{
 private UserDao userDao;
	
	public UserDao getUserDao() {
		return userDao;
	}
	  @Resource(name="userDao")
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	public boolean logincheck(User user) {
		
		return userDao.logincheck(user);
	}
	 public boolean loginTeacherCheck(User u) {
			
			return userDao.loginTeacherCheck(u);
		}
	
	public boolean loginStudentCheck(User u) {
		
		return userDao.loginStudentCheck(u);
	}
	
}
