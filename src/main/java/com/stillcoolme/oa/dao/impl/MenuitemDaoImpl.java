package com.stillcoolme.oa.dao.impl;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.stillcoolme.oa.dao.UserDao;
import com.stillcoolme.oa.domain.User;
import com.stillcoolme.oa.utils.OAUtils;
import org.springframework.stereotype.Repository;

import com.stillcoolme.oa.dao.MenuitemDao;
import com.stillcoolme.oa.dao.base.impl.BaseDaoImpl;
import com.stillcoolme.oa.domain.Menuitem;

import javax.annotation.Resource;

@Repository("menuitemDao")
public class MenuitemDaoImpl extends BaseDaoImpl<Menuitem> implements MenuitemDao<Menuitem>{

	@Resource(name="userDao")
	private UserDao userDao;

	public Collection<Menuitem> getMenuitemsByPid(Long pid) {
		// TODO Auto-generated method stub
		return this.hibernateTemplate.find("from Menuitem where pid=?",pid);
	}

	public Set<Menuitem> getMenuitemsByIDS(Long[] ids) {

		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("from Menuitem");
		stringBuffer.append(" where mid in(");
		for(int i=0;i<ids.length;i++){
			if(i<ids.length-1){
				stringBuffer.append(ids[i]+",");
			}else{
				stringBuffer.append(ids[i]);
			}
		}
		stringBuffer.append(")");
		List<Menuitem> menuitemList = this.hibernateTemplate.find(stringBuffer.toString());
		return new HashSet<Menuitem>(menuitemList);
	}

	public Collection<Menuitem> getMenuitemsByUser(){

		User user = OAUtils.fromSession();
		if("admin".equals(user.getUsername())){
			Collection<Menuitem> ms = this.getAllEntry();
			return ms;
		}else{
			return this.hibernateTemplate.find("from Menuitem m inner join fetch m.users u where u.uid=?",user.getUid());
		}
	}

	/*
	 * 如果是admin则把所有的菜单的checked设置为true
	 * 如果不是amdin,则先遍历所有的菜单项，再遍历用户能访问到的菜单项，然后把所有的菜单项中，用户能够访问到的checked设置为true
	 */

	@Override
	public Collection<Menuitem> getMenuitemsByUID(Long uid) {

		User user = (User) userDao.getEntryById(uid);
		Collection<Menuitem> allMenuitems = this.getAllEntry();
		 //上面当user被提取出来以后（User user = (User) userDao.getEntryById(uid);），session已经关闭了。
		 //所以这里不能user.getMenuitems()。
		Collection<Menuitem> menuitems = this.hibernateTemplate.find("from Menuitem m inner join fetch m.users u where u.uid=?",uid);
		if(user.getUsername().equals("admin")){
			for (Menuitem menuitem: menuitems){
				menuitem.setChecked(true);
			}
		}else {
			for(Menuitem menuitem1: allMenuitems){
				for(Menuitem menuitem2: menuitems){
					if(menuitem1.getMid().longValue()==menuitem2.getMid().longValue()){
						menuitem1.setChecked(true);
					}
				}
			}
		}
		return allMenuitems;
	}

}
