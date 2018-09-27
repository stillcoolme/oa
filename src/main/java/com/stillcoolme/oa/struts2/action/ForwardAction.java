package com.stillcoolme.oa.struts2.action;

import com.opensymphony.xwork2.ActionSupport;

public class ForwardAction extends ActionSupport{

	public String left(){
		return "left";
	}
	
	public String right(){
		return "right";
	}
	
	public String top(){
		return "top";
	}
	
	public String bottom(){
		return "bottom";
	}

	public String kynamic(){
		return "kynamic";
	}
	
//jbpm
	//流程定义文件
	public String pdManager(){
		return "pdManager";
	}
	//表单模板
	public String formTemplate(){
		return "formTemplate";
	}
	//发起申请的
	public String workFlow(){
		return "workFlow";
	}
	
	//我发起的申请
	public String showMySubmit(){
		return "showMySubmit";
	}
	
	//查看待我审批的流程
	public String showMyTaskList(){
		return "showMyTaskList";
	}
}
