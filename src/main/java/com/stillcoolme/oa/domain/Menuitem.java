package com.stillcoolme.oa.domain;

import org.apache.struts2.json.annotations.JSON;

import java.io.Serializable;
import java.util.Set;

public class Menuitem implements Serializable{
	private Long mid;
	private Long pid;//父节点ID
	private String name;//树上的节点的名称
	private Boolean isParent;//是否为文件夹节点
	private String icon;//图标图片的路径
	private String url;
	private Boolean checked;
	private Set<User> users;
	private String target;

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Boolean getChecked() {
		return checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

	public Long getMid() {
		return mid;
	}

	public void setMid(Long mid) {
		this.mid = mid;
	}

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	@JSON(serialize=false)  			//忽略该属性
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}
}
