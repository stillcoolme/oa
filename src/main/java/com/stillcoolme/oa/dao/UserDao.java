package com.stillcoolme.oa.dao;

import java.util.Collection;

import com.stillcoolme.oa.dao.base.BaseDao;
import com.stillcoolme.oa.domain.User;

public interface UserDao<T> extends BaseDao<T>{
	public Collection<User> getUsers();

	public User getUserByName(String username);
}
