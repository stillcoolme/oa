package com.stillcoolme.oa.dao.impl;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.stillcoolme.oa.dao.UserDao;
import com.stillcoolme.oa.dao.base.impl.BaseDaoImpl;
import com.stillcoolme.oa.domain.User;

@Repository("userDao")
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao<User>{

	//这里另外弄了这个getUsers(),使用迫切左外连接，这样能减少sql语句！！！没有用BaseDao的getEntry方法。。
	public Collection<User> getUsers() {
		//放到list能够去重！！！！！！！！！！
		List<User> useList = (List<User>) this.hibernateTemplate.find("from User u left join fetch u.department d left join fetch u.posts p");
		return new HashSet<User>(useList);
	}

	public User getUserByName(String username) {
		
		List<User> userList = (List<User>) this.hibernateTemplate.find("from User where username=?",username);
		if(userList.size()==0){
			return null;
		}else{
			return userList.get(0);
		}
	}
	
	

}
