package com.stillcoolme.oa.result;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.Result;


/*
 * AjaxResult.java：自定义结果集(注：通过此结果集把服务器端(action)的数据回调到客户端)
 */
public class AjaxResult implements Result{
	
	public void execute(ActionInvocation invocation) throws Exception {
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");		//处理中文乱码问题  
		String message = ActionContext.getContext().getValueStack().peek().toString();	//得到栈顶元素  
		response.getWriter().print(message);	//将得到的栈顶元素返回到客户端 
		
	}
}