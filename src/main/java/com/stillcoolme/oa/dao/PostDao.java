package com.stillcoolme.oa.dao;

import java.util.Set;

import com.stillcoolme.oa.dao.base.BaseDao;
import com.stillcoolme.oa.domain.Post;

public interface PostDao<T> extends BaseDao<T>{

	Set<Post> getPostsByIDS(Long[] pids);

}
