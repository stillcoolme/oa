package com.stillcoolme.oa.dao;

import com.stillcoolme.oa.dao.base.BaseDao;
import com.stillcoolme.oa.domain.Kynamic;
import com.stillcoolme.oa.domain.Version;

import java.util.Collection;

/**
 * Created by zhangjaneh on 2018/9/14.
 */
public interface KynamicDao<T> extends BaseDao<T> {
    public T getKynamicByName(String name);

    public Collection<Kynamic> getSiblingNodes(Long kid);

    public Kynamic getParentNode(Long kid);

    Collection<Version> getVersionsByKid(Long kid);

    Boolean deleteVersionsByVid(Long vid);

    Boolean saveVersion(Version version);
}
