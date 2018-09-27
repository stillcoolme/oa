package com.stillcoolme.oa.dao;

import java.util.Collection;
import java.util.Set;

import com.stillcoolme.oa.dao.base.BaseDao;
import com.stillcoolme.oa.domain.Menuitem;


public interface MenuitemDao<T> extends BaseDao<T>{
	public Collection<Menuitem> getMenuitemsByPid(Long pid);

	public Set<Menuitem> getMenuitemsByIDS(Long[] ids);

	public Collection<Menuitem> getMenuitemsByUser();

	public Collection<Menuitem> getMenuitemsByUID(Long uid);
}
