package com.stillcoolme.oa.service.impl;

import javax.annotation.Resource;

import com.stillcoolme.oa.dao.LoginDao;
import com.stillcoolme.oa.domain.User;
import com.stillcoolme.oa.servlet.LoginService;
import org.springframework.stereotype.Service;



@Service("loginService")
public class LoginServiceImpl implements LoginService {

	@Resource(name="loginDao")
	private LoginDao loginDao;
	public User checkUserByUAndP(String username, String password){
		return this.loginDao.getUserByUAndP(username, password);
		
	}
}
