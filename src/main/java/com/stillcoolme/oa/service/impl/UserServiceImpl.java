package com.stillcoolme.oa.service.impl;

import java.io.Serializable;
import java.util.Collection;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.stillcoolme.oa.service.UserService;
import com.stillcoolme.oa.dao.UserDao;
import com.stillcoolme.oa.domain.User;

@Service("userService")
public class UserServiceImpl implements UserService{
	@Resource(name="userDao")
	private UserDao userDao;

	public Collection<User> getAllUser() {
		return this.userDao.getUsers();
	}
	
	public User getUserById(Serializable id) {
		return (User) this.userDao.getEntryById(id);
	}

	@Transactional(readOnly=false)
	public void saveUser(User user) {		//user维护 部门和岗位的 关系
		this.userDao.saveEntry(user);
	}


	@Transactional(readOnly=false)
	public void updateUser(User user) {
		this.userDao.updateEntry(user);
	}

	@Transactional(readOnly=false)
	public void deleteUserById(Serializable uid) {
		this.userDao.deleteEntry(uid);
	}

	@Transactional(readOnly=false)
	public User getUserByName(String username) {
		User user = this.userDao.getUserByName(username);
		return user;
	}
}
