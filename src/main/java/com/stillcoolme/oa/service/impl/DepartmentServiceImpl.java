package com.stillcoolme.oa.service.impl;

import java.io.Serializable;
import java.util.Collection;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.stillcoolme.oa.service.DepartmentService;
import com.stillcoolme.oa.dao.DepartmentDao;
import com.stillcoolme.oa.domain.Department;

@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService{

	@Resource(name="departmentDao")
	private DepartmentDao departmentDao;
	
	@Transactional(readOnly=false)
	@Override
	public void saveDepartment(Department department) {
		this.departmentDao.saveEntry(department);
	}

	@Transactional(readOnly=false)
	@Override
	public void updateDepartment(Department department) {
		this.departmentDao.updateEntry(department);
	}

	
	@Transactional(readOnly=false)
	public void deleteDepartmentById(Serializable id, String deleteMode) {
		this.departmentDao.deleteEntry(id);
	}

	@Override
	public Collection<Department> getAllDepartment() {
		return this.departmentDao.getAllEntry();
	}

	@Override
	public Department getDepartmentById(Serializable id) {
		return (Department)this.departmentDao.getEntryById(id);
	}

	

	
}
