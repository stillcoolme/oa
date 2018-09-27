package com.stillcoolme.oa.dao.impl;

import org.springframework.stereotype.Repository;

import com.stillcoolme.oa.dao.DepartmentDao;
import com.stillcoolme.oa.dao.base.impl.BaseDaoImpl;
import com.stillcoolme.oa.domain.Department;


@Repository("departmentDao")
public class DepartmentDaoImpl extends BaseDaoImpl<Department> implements DepartmentDao<Department>{

	/*
	@Override
	public void saveDepartment(Department department) {
		this.saveEntry(department);
	}

	@Override
	public void updateDeparment(Department department) {
		this.getHibernateTemplate().update(department);
	}

	@Override
	public void deleteDepartmentByID(Serializable id, String deleteMode) { //直接删除隐患，因为表与表之间有键的关联就会报外键异常
		Department department = this.getDepartmentById(id);
		if("del".equals(deleteMode)){			//单表删除
			this.getHibernateTemplate().delete(department);		
		}else if("del_pre_release".equals(deleteMode)){		//多表删除
			Set<User> users = department.getUsers();
			for(User user: users){
				user.setDepartment(null);
			}
		}else if("del_cascade".equals(deleteMode)){			//级联删除
			//在xml文件加cascade属性就行了
		}
		this.getHibernateTemplate().delete(department);
	}

	@Override
	public Collection<Department> getAllDepartment() {
		return this.getHibernateTemplate().find("from Department");
		
	}

	@Override
	public Department getDepartmentById(Serializable id) {
		return (Department) this.getHibernateTemplate().get(Department.class, id);
	}
	* 
	*/

}
