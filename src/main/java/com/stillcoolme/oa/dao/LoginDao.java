package com.stillcoolme.oa.dao;


import com.stillcoolme.oa.domain.User;

public interface LoginDao {
	
	public User getUserByUAndP(String username, String password);
	
}
