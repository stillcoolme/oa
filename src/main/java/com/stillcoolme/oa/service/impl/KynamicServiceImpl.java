package com.stillcoolme.oa.service.impl;

import java.util.Collection;

import javax.annotation.Resource;

import com.stillcoolme.oa.dao.KynamicDao;
import com.stillcoolme.oa.domain.Kynamic;
import com.stillcoolme.oa.domain.Version;
import com.stillcoolme.oa.service.KynamicService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service("kynamicService")
public class KynamicServiceImpl implements KynamicService {
	@Resource(name="kynamicDao")
	private KynamicDao kynamicDao;

	public Collection<Kynamic> getAllKynamic() {
		return this.kynamicDao.getAllEntry();
	}

	@Transactional(readOnly=false)
	public void saveKynamic(Kynamic kynamic) {
		this.kynamicDao.saveEntry(kynamic);
	}

	@Override
	public boolean isExistKynamic(String name) {
		Kynamic kynamic = (Kynamic) this.kynamicDao.getKynamicByName(name);
//		if(kynamic != null){
//			return true;
//		}
//		return false;
		return kynamic!=null?true:false;
	}

	@Override
	@Transactional(readOnly=false)
	public void deleteKynamicByID(Long kid) {
		this.kynamicDao.deleteEntry(kid);
	}

	public Collection<Kynamic> getSiblingsNodes(Long kid) {
		return this.kynamicDao.getSiblingNodes(kid);
	}

	public Kynamic getParentNode(Long kid) {
		return this.kynamicDao.getParentNode(kid);
	}

	@Transactional(readOnly=false)
	public void updateKynamic(Kynamic kynamic) {
		this.kynamicDao.updateEntry(kynamic);
	}

	public Kynamic getKynamicById(Long kid) {
		return (Kynamic) this.kynamicDao.getEntryById(kid);
	}

	@Override
	public Collection<Version> getVersionsByKid(Long kid) {
		return this.kynamicDao.getVersionsByKid(kid);
	}

	@Override
	@Transactional(readOnly=false)
	public Boolean deleteVersionsByVid(Long vid) {
		return this.kynamicDao.deleteVersionsByVid(vid);
	}

	@Transactional(readOnly=false)
	public Boolean saveVersion(Version version) {
		return this.kynamicDao.saveVersion(version);
	}


}
