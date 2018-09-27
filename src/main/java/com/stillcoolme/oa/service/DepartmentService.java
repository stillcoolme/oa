package com.stillcoolme.oa.service;

import java.io.Serializable;
import java.util.Collection;

import com.stillcoolme.oa.utils.DeleteMode;
import com.stillcoolme.oa.domain.Department;

public interface DepartmentService {

	public void saveDepartment(Department department);
	
	public void deleteDepartmentById(Serializable id, String deleteMode);
	
	public void updateDepartment(Department department);
	
	public Collection<Department> getAllDepartment();
	
	public Department getDepartmentById(Serializable id);
	
}
