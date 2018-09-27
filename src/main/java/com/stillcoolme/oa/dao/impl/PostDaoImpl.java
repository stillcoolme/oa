package com.stillcoolme.oa.dao.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.stillcoolme.oa.dao.PostDao;
import com.stillcoolme.oa.dao.base.impl.BaseDaoImpl;
import com.stillcoolme.oa.domain.Post;


@Repository("postDao")
public class PostDaoImpl extends BaseDaoImpl<Post> implements PostDao<Post>{
	
	//用于取得从user页面获得的多个post岗位信息
	public Set<Post> getPostsByIDS(Long[] pids) {
		
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("from Post where pid in ( ");
		for(int i=0;i<pids.length;i++){
			if(i<pids.length-1){
				stringBuffer.append(pids[i]+",");
			}else{
				stringBuffer.append(pids[i]);
			}
		}
		stringBuffer.append(")");
		List<Post> postList = (List<Post>) this.hibernateTemplate.find(stringBuffer.toString());
		return new HashSet<Post>(postList);
	}
	
}
