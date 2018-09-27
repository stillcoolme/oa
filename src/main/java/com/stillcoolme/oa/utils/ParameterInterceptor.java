package com.stillcoolme.oa.utils;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

import org.junit.Test;

import com.stillcoolme.oa.domain.User;

public class ParameterInterceptor {
	@Test
	public void test()throws Exception{
		Class userClass = User.class;
		Field[] fields = userClass.getDeclaredFields();
		for(Field field:fields){
			String methodName = field.getName();
			if(methodName.equals("pname")){
				String firstNum = methodName.substring(0,1);
				String otherNum = methodName.substring(1);
				methodName = "set"+firstNum.toUpperCase()+otherNum;
				String methodName2 = "get"+firstNum.toUpperCase()+otherNum;
				Method method = userClass.getMethod(methodName, String.class);
				Method method2 = userClass.getMethod(methodName2);
				Object obj = userClass.newInstance();
				method.invoke(obj, "aaa");
				System.out.println(method2.invoke(obj));
			}
		}
	}
}
