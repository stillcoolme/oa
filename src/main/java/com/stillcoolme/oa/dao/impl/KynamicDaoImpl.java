package com.stillcoolme.oa.dao.impl;

import com.stillcoolme.oa.dao.KynamicDao;
import com.stillcoolme.oa.dao.base.impl.BaseDaoImpl;
import com.stillcoolme.oa.domain.Kynamic;
import com.stillcoolme.oa.domain.Version;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

/**
 * Created by zhangjaneh on 2018/9/14.
 */
@Repository(value="kynamicDao")
public class KynamicDaoImpl extends BaseDaoImpl<Kynamic> implements KynamicDao<Kynamic> {

    @Override
    public Kynamic getKynamicByName(String name) {
        List<Kynamic> kynamicList =  this.hibernateTemplate.find("from Kynamic where name=?",name);
        if(kynamicList.size()==0){
            return null;
        }else{
            return kynamicList.get(0);
        }
    }

    public Collection<Kynamic> getSiblingNodes(Long kid) {
        // TODO Auto-generated method stub
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("from Kynamic");
        stringBuffer.append(" where pid=(");
        stringBuffer.append("select pid from Kynamic where kid=?)");
        return this.hibernateTemplate.find(stringBuffer.toString(),kid);
    }

    public Kynamic getParentNode(Long kid) {
        // TODO Auto-generated method stub
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("from Kynamic");
        stringBuffer.append(" where kid=(");
        stringBuffer.append("select pid from Kynamic where kid=?)");
        List<Kynamic> kynamicList = this.hibernateTemplate.find(stringBuffer.toString(),kid);
        return kynamicList.get(0);
    }

    public Collection<Version> getVersionsByKid(Long kid) {
        // TODO Auto-generated method stub
        return this.hibernateTemplate.find("from Version v where v.kynamic.kid=?",kid);
    }


    @Override
    public Boolean deleteVersionsByVid(Long vid) {
        List<Version> list = this.hibernateTemplate.find("from Version v where v.vid = ?", vid);
        if(list != null && list.size() != 0){
            this.hibernateTemplate.delete(list.get(0));
            return true;
        }
        return false;
    }

    @Override
    public Boolean saveVersion(Version version) {
        try{
            this.hibernateTemplate.save(version);
        }catch (Exception e){
            return false;
        }
        return true;
    }

}
