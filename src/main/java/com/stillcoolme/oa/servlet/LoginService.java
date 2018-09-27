package com.stillcoolme.oa.servlet;


import com.stillcoolme.oa.domain.User;

public interface LoginService {

	public User checkUserByUAndP(String username, String password);
}
