package com.stillcoolme.oa.service;

import java.io.Serializable;
import java.util.Collection;

import com.stillcoolme.oa.domain.User;

public interface UserService {
	
	public Collection<User> getAllUser();
	
	public User getUserById(Serializable id);
	
	public void updateUser(User user);
	
	public void saveUser(User user);

	public void deleteUserById(Serializable uid);

	public User getUserByName(String username);
	
}
