package com.stillcoolme.oa.service.impl; 

import com.stillcoolme.oa.domain.User;
import com.stillcoolme.oa.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Collection;

/** 
* UserServiceImpl Tester. 
* 
* @author stillcoolme
* @since <pre>08/08/2018</pre> 
* @version 1.0 
*/
@RunWith(SpringJUnit4ClassRunner.class)
//告诉junit spring的配置文件
@ContextConfiguration(locations={"classpath:spring/applicationContext-db.xml"})
public class UserServiceImplTest {

    @Autowired
    UserService userService;

/**
* Method: getAllUser()
*/ 
@Test
public void testGetAllUser() throws Exception {
    Collection<User> list =  userService.getAllUser();
    System.out.println(list.size());
} 

/** 
* 
* Method: getUserById(Serializable id) 
* 
*/ 
@Test
public void testGetUserById() throws Exception {
    User user = userService.getUserById(1L);
    System.out.println(user.getUsername());
}

/** 
* 
* Method: saveUser(User user) 
* 
*/ 
@Test
public void testSaveUser() throws Exception { 
//TODO: Test goes here... 
} 

/** 
* 
* Method: updateUser(User user) 
* 
*/ 
@Test
public void testUpdateUser() throws Exception { 
//TODO: Test goes here... 
} 

/** 
* 
* Method: deleteUserById(Serializable uid) 
* 
*/ 
@Test
public void testDeleteUserById() throws Exception { 
//TODO: Test goes here... 
} 

/** 
* 
* Method: getUserByName(String username) 
* 
*/ 
@Test
public void testGetUserByName() throws Exception { 
//TODO: Test goes here... 
} 


} 
