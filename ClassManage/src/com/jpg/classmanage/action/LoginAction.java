package com.jpg.classmanage.action;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.jpg.classmanage.model.User;
import com.jpg.classmanage.service.UserManage;
import com.jpg.classmanage.service.Impl.UserManageImpl;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class LoginAction extends ActionSupport implements ModelDriven{
	private static final long serialVersionUID = 1L;
	 private User user=new User();
     private  UserManage um;
/*     private Map session;*/
    
	public String login()
    {
	   if(um.logincheck(user))
	    {
		   HttpSession session = ServletActionContext.getRequest().getSession();
	       session.setAttribute("shenfen", 1);
		  return "success";
	    }
	   else
	   {
		   if(um.loginTeacherCheck(user))
		   {
			HttpSession session = ServletActionContext.getRequest().getSession();
		    session.setAttribute("shenfen", 2);
		    session.setAttribute("teacherId",user.getUsername());		
			   return "teacher";
		   }
		   else
		   {
			   if(um.loginStudentCheck(user))
			   {
				   HttpSession session = ServletActionContext.getRequest().getSession();
				    session.setAttribute("shenfen", 3);
				    session.setAttribute("studentId",user.getUsername());
					  return "student";
			   }
			   return "fail";

		   }
		 
	   }
    	
    }
	public Object getModel() {
		
		return this.user;
	}
	public UserManage getUm() {
		return um;
	}
	@Resource(name="userManage")
	public void setUm(UserManage um) {
		this.um = um;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	
	/*public Map getSession() {
		return session;
	}
	public void setSession(Map session) {
		this.session = session;
	}	*/
}
