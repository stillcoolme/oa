package com.stillcoolme.oa.service.impl;

import java.util.Collection;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.stillcoolme.oa.service.MenuitemService;
import com.stillcoolme.oa.dao.MenuitemDao;
import com.stillcoolme.oa.domain.Menuitem;

@Service("menuitemService")
public class MenuitemServiceImpl implements MenuitemService{
	@Resource(name="menuitemDao")
	private MenuitemDao menuitemDao;

	public Collection<Menuitem> getAllMenuitem() {
		// TODO Auto-generated method stub
		return this.menuitemDao.getAllEntry();
	}

	public Collection<Menuitem> getMenuitemsByPid(Long pid) {
		// TODO Auto-generated method stub
		return this.menuitemDao.getMenuitemsByPid(pid);
	}

	public Set<Menuitem> getMenuitemsByIDS(Long[] ids) {
		// TODO Auto-generated method stub
		return this.menuitemDao.getMenuitemsByIDS(ids);
	}

	public Collection<Menuitem> getMenuitemsByUser() {

		return this.menuitemDao.getMenuitemsByUser();
	}

	@Override
	public Collection<Menuitem> getMenuitemsByUID(Long uid) {
		return menuitemDao.getMenuitemsByUID(uid);
	}
}