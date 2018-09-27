package com.stillcoolme.oa.dao;

import java.io.Serializable;
import java.util.Collection;

import com.stillcoolme.oa.dao.base.BaseDao;
import com.stillcoolme.oa.domain.Department;

public interface DepartmentDao<T> extends BaseDao<T>{
	

	/*
	//增
	public void saveDepartment(Department department);
	
	//改
	public void updateDeparment(Department department);
	
	//删
	public void deleteDepartmentByID(Serializable id,String deleteMode);		//要Serializable id!!Serializeble也是父类，因为Object可能有安全的隐患，Object能传入各种类型
	
	//查      //有时返回Set，有时返回List
	public Collection<Department> getAllDepartment();
	
	public Department getDepartmentById(Serializable id);
	*/
	
}
