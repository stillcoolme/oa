package com.stillcoolme.oa.struts2.action;

import java.util.Collection;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.stillcoolme.oa.service.DepartmentService;
import com.stillcoolme.oa.service.PostService;
import com.stillcoolme.oa.service.UserService;
import com.stillcoolme.oa.struts2.action.base.BaseAction;

import com.opensymphony.xwork2.ActionContext;

import com.stillcoolme.oa.domain.Department;
import com.stillcoolme.oa.domain.Post;
import com.stillcoolme.oa.domain.User;

@Controller("userAction")
@Scope("prototype")
public class UserAction extends BaseAction<User>{
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="departmentService")
	private DepartmentService departmentService;
	
	@Resource(name="postService")
	private PostService postService;
	
	//用属性驱动取得 user用户页面的部门和岗位数据。
	private Long did;
	
	private Long[] pids;
	
	public Long getDid() {
		return did;
	}

	public void setDid(Long did) {
		this.did = did;
	}

	public Long[] getPids() {
		return pids;
	}

	public void setPids(Long[] pids) {
		this.pids = pids;
	}
	
    private String message;
	
	public String getMessage() {
		return message;
	}

	public String getAllUser(){
		Collection<User> userList = this.userService.getAllUser();
		ActionContext.getContext().getValueStack().push(userList);
		return listAction;
	}
	
	public String addUI(){
		/**
		 * 1、把部门表的所有的数据查询出来
		 * 2、把岗位表的数据查询出来
		 * 3、跳转到增加页面
		 */
		Collection<Department> departmentList = departmentService.getAllDepartment();
		ActionContext.getContext().put("departmentList", departmentList);
		Collection<Post> postList = postService.getAllPost();
		ActionContext.getContext().put("postList", postList);
		return addUI;
	}
	
	//add.jsp提交用js实现，提交到这里add().    
	public String add(){
		/**
		 * 如何获取页面中的数据
		 *    *  如果页面中的数据来源于一张表，直接用模型驱动获取就可以了
		 *    *  如果页面中的数据来源于多张表，则可以采用模型驱动结合属性驱动的方式
		 */
		/**
		 * 1、创建一个user对象
		 * 2、把模型驱动的值赋值给user对象
		 * 3、根据 did提取出该部门
		 * 4、根据pids提取出岗位,,在PostDaoImpl要建个getposts取得多个岗位的方法。
		 * 5、建立user对象和部门和岗位之间的关系，user来维护关系
		 * 6、执行save操作
		 */
		User user = new User();
		//一般属性的赋值
		BeanUtils.copyProperties(this.getModel(), user);
		//建立user与department之间的关系
		Department department = this.departmentService.getDepartmentById(this.did);
		user.setDepartment(department);
		//建立user与posts之间的关系
		Set<Post> posts = this.postService.getPostsByIds(this.pids);
		user.setPosts(posts);
		this.userService.saveUser(user);
		return action2action;
	}
	
	
	public String updateUI(){
		/**
		 * 1、值的回显，回显就是保留原数据嘛
		 *    * 用户的一般属性的回显
		 *    * 部门的回显！！！
		 *    * 岗位的回显！！！
		 * 2、把部门和岗位的数据全部提取出来
		 */
		User user = this.userService.getUserById(this.getModel().getUid());
		ActionContext.getContext().getValueStack().push(user);	//把用户放入到对象栈中
		this.did = user.getDepartment().getDid();
		Set<Post> posts = user.getPosts();
		int index =0;
		this.pids = new Long[posts.size()];
		for(Post post: posts){
			this.pids[index++] = post.getPid();
		}
		
		Collection<Department> departmentList = this.departmentService.getAllDepartment();
		ActionContext.getContext().put("departmentList", departmentList);
		Collection<Post> postList = this.postService.getAllPost();
		ActionContext.getContext().put("postList", postList);
		return updateUI;
	}
	
	public String update(){
		
		/**
		 * 1、利用模型驱动获取用户的一般数据
		 * 2、利用属性驱动获取最新的did和pids
		 * 3、根据用户的id提取出user对象
		 * 4、把模型驱动的值复制到user对象中
		 * 5、重新建立user对象和岗位和部门之间的关系
		 */
		//一般属性的赋值
		User user = this.userService.getUserById(this.getModel().getUid());
		BeanUtils.copyProperties(this.getModel(),user);
		//重新建立user和部门之间的关系，维护关系
		Department department = this.departmentService.getDepartmentById(did);
		user.setDepartment(department);
		//重新建立user和岗位之间的关系，维护关系
		Set<Post> posts = this.postService.getPostsByIds(pids);
		user.setPosts(posts);
		
		this.userService.updateUser(user);
		
		return action2action;
	}
	
	
	public String delete(){
		
		this.userService.deleteUserById(this.getModel().getUid());
		return action2action;
	}
	
	
	public String checkUsername(){
		int a = 1/0;
		User user = this.userService.getUserByName(this.getModel().getUsername());
		if(user==null){
			this.message = "该用户名可以使用";
		}else{
			this.message = "该用户名已经存在";
		}
		return SUCCESS;
	}
	
	
	
	
	
}
