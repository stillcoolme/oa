package com.stillcoolme.oa.service;

import com.stillcoolme.oa.domain.Kynamic;
import com.stillcoolme.oa.domain.Version;

import java.util.Collection;


public interface KynamicService {
	public Collection<Kynamic> getAllKynamic();
	
	public void saveKynamic(Kynamic kynamic);

	public boolean isExistKynamic(String name);

	public void deleteKynamicByID(Long kid);

	public Collection<Kynamic> getSiblingsNodes(Long kid);

	public Kynamic getParentNode(Long kid);

	public void updateKynamic(Kynamic kynamic);

	public Kynamic getKynamicById(Long kid);

	public Collection<Version> getVersionsByKid(Long kid);

    public Boolean deleteVersionsByVid(Long vid);

	public Boolean saveVersion(Version version);
}
