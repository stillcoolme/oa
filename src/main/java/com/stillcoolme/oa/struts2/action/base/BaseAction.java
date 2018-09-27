package com.stillcoolme.oa.struts2.action.base;

import java.lang.reflect.ParameterizedType;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.dispatcher.ng.PrepareOperations;

public class BaseAction<T> extends ActionSupport implements ModelDriven<T>{
	private T t;
	private Class classt;
	
	public BaseAction(){
		try{
			ParameterizedType type =  (ParameterizedType) this.getClass().getGenericSuperclass();
			this.classt = (Class) type.getActualTypeArguments()[0];
			this.t = (T)this.classt.newInstance();
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public static final String LISTACTION = "listAction";
	public static final String ADDUI = "addUI";
	public static final String UPDATEUI = "updateUI";
	public static final String ACTION2ACTION = "action2action";
	
	public String listAction = LISTACTION;
	public String updateUI = UPDATEUI;
	public String addUI = ADDUI;
	public String action2action = ACTION2ACTION;
	
	public T getModel() {
		return this.t;
	}
	
}
