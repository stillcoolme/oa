package com.stillcoolme.oa.struts2.action;

import javax.annotation.Resource;

import com.stillcoolme.oa.domain.User;
import com.stillcoolme.oa.servlet.LoginService;
import com.stillcoolme.oa.struts2.action.base.BaseAction;
import com.stillcoolme.oa.utils.OAUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;


@Controller("loginAction")
@Scope("prototype")
public class LoginAction extends BaseAction<User> {

	@Resource(name="loginService")
	private LoginService loginService;
	
	public String login(){
		User user = this.loginService.checkUserByUAndP(this.getModel().getUsername(),this.getModel().getPassword());
		if(user!=null){
			OAUtils.putUser2Session(user);
			System.out.println("login on successful");
			return "index";
		}else{
			System.out.println("login on fail");
			return null;
		}
		
	}
	//登录成功跳转到 jsp/frame/index.jsp
	
	
}
