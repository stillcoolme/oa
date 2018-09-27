package com.stillcoolme.oa.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import com.stillcoolme.oa.dao.LoginDao;
import com.stillcoolme.oa.domain.User;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;



@Repository("loginDao")
public class LoginDaoImpl implements LoginDao {
	@Resource(name="hibernateTemplate")
	private HibernateTemplate hibernateTemplate;

	public User getUserByUAndP(String username, String password) {
		
		List<User> userList =  this.hibernateTemplate.find("from User u where u.username=? and u.password=?",new Object[]{username,password});
		if(userList.size()!=0){
			return userList.get(0);
		}else{
			return null;
		}
	}
}
