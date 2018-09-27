package com.stillcoolme.oa.struts2.action;

import java.util.Collection;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.stillcoolme.oa.service.PostService;
import com.stillcoolme.oa.struts2.action.base.BaseAction;

import com.opensymphony.xwork2.ActionContext;

import com.stillcoolme.oa.domain.Post;


@Controller("postAction")
@Scope("prototype")
public class PostAction extends BaseAction<Post>{

	@Resource(name="postService")
	private PostService postService;
	
	public String getAllPost(){
		Collection<Post> postList = this.postService.getAllPost();
		ActionContext.getContext().put("postList",postList);		//放到map栈
		return listAction;
	}
	
	public String addUI(){
		return addUI;
	}
	
	public String add(){
		
		Post post = new Post();
		BeanUtils.copyProperties(this.getModel(), post);
		this.postService.savePost(post);
		return action2action;
		
	}
	
	public String delete(){
		this.postService.deletePostById(this.getModel().getPid());
		return action2action;
	}
	
	public String updateUI(){
		
		ActionContext.getContext().getValueStack().pop();
		ActionContext.getContext().getValueStack().push(this.postService.getPostById(this.getModel().getPid()));
		return updateUI;
	}
	
	public String update(){
		
		Post post = this.postService.getPostById(this.getModel().getPid());
		BeanUtils.copyProperties(this.getModel(), post);
		//把下面这行去掉，即使post是持久化对象，上面两行也只有session环境，也没法update。所有不能去掉下面这行。
		//因为hibernate执行  增删改  一定要处于事务环境下，也就是service层。。下面这个就是调service层。
		this.postService.updatePost(post);
		return action2action;
	}
	
}
