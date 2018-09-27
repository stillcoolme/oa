package com.stillcoolme.oa.struts2.action;

import java.util.Collection;
import java.util.Date;

import javax.annotation.Resource;

import com.opensymphony.xwork2.interceptor.ParametersInterceptor;
import com.stillcoolme.oa.domain.Kynamic;
import com.stillcoolme.oa.domain.Version;
import com.stillcoolme.oa.service.KynamicService;
import com.stillcoolme.oa.struts2.action.base.BaseAction;
import com.stillcoolme.oa.utils.Constants;
import org.apache.commons.collections.ArrayStack;
import org.apache.struts2.json.JSONResult;
import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;


@Controller("kynamicAction")
@Scope("prototype")
public class KynamicAction extends BaseAction<Kynamic> {
	@Resource(name="kynamicService")
	private KynamicService kynamicService;
	
	private String message;

	private Long kid;

	private Kynamic kynamic;

	private Long vid;
	private String title;
	private String content;

	public void setTitle(String title) {
		this.title = title;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setVid(Long vid) {
		this.vid = vid;
	}


	private Collection<Version> versionList;

	public Collection<Version> getVersionList() {
		return versionList;
	}

	public Kynamic getKynamic() {
		return kynamic;
	}

	public Long getKid() {
		return kid;
	}

	public String getMessage() {
		return message;
	}

	public Collection<Kynamic> getKynamicList() {
		return kynamicList;
	}

	private Collection<Kynamic> kynamicList;
	
	public String showKynamicTree(){
		this.kynamicList = this.kynamicService.getAllKynamic();
		return SUCCESS;
	}

	public String saveKynamic(){
		Kynamic kynamic = new Kynamic();
		BeanUtils.copyProperties(this.getModel(), kynamic);
		this.kynamicService.saveKynamic(kynamic);
		this.kid = kynamic.getKid();
		this.message = Constants.SUCCESS;
		return SUCCESS;
	}

	public String existKynamicName(){
		boolean flag = this.kynamicService.isExistKynamic(this.getModel().getName());
		if(flag){
			message = "1";
		}else{
			message = "0";
		}
		return SUCCESS;
	}

	public String deleteNode(){
		this.kynamicService.deleteKynamicByID(this.getModel().getKid());
		this.message = Constants.SUCCESS;
		return SUCCESS;
	}

	public String showSiblingNodes(){
		this.kynamicList = this.kynamicService.getSiblingsNodes(this.getModel().getKid());
		return SUCCESS;
	}

	public String showParentNode(){
		this.kynamic = this.kynamicService.getParentNode(this.getModel().getKid());
		return SUCCESS;
	}

	public String updateKynamic(){
		Kynamic kynamic = this.kynamicService.getKynamicById(this.getModel().getKid());
		kynamic.setName(this.getModel().getName());
		this.kynamicService.updateKynamic(kynamic);
		return SUCCESS;
	}

	public String showVersionsByKid(){
		this.versionList = this.kynamicService.getVersionsByKid(this.getModel().getKid());
		return SUCCESS;
	}

	public String deleteVersionByVid(){
		Boolean flag = this.kynamicService.deleteVersionsByVid(vid);
		if(flag){
			message = Constants.SUCCESS;
		}else{
			message = Constants.FAIL;
		}
		return SUCCESS;
	}

	public String saveVersionBykid(){
		this.versionList = this.kynamicService.getVersionsByKid(this.getModel().getKid());
        kynamic = this.kynamicService.getKynamicById(this.getModel().getKid());
        Version version = new Version();
        version.setKynamic(kynamic);
        if(versionList != null){
            Version[] versions = versionList.toArray(new Version[versionList.size()]);
            Version version2 = versions[versionList.size()-1];
            version.setVid(version2.getVid() + 1);
            version.setVersion(version2.getVersion() + 1);
            version.setTitle(this.title);
            version.setContent(this.content);
            version.setUpdatetime(new Date());
        }else{
            version.setVid(1l);
            version.setVersion(1l);
            version.setTitle(this.title);
            version.setContent(this.content);
            version.setUpdatetime(new Date());
        }
        Boolean flag = this.kynamicService.saveVersion(version);
        if(flag){
            message = Constants.SUCCESS;
        }else {
            message = Constants.FAIL;
        }
		return SUCCESS;
	}
}
