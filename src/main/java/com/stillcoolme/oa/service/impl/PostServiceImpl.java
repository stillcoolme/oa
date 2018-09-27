package com.stillcoolme.oa.service.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.stillcoolme.oa.service.PostService;
import com.stillcoolme.oa.dao.PostDao;
import com.stillcoolme.oa.domain.Post;

@Service("postService")
public class PostServiceImpl implements PostService {
	
	@Resource(name="postDao")
	private PostDao postDao;

	public Collection<Post> getAllPost() {
		return this.postDao.getAllEntry();
	}

	@Transactional(readOnly=false)
	public void updatePost(Post post) {
		this.postDao.updateEntry(post);
	}

	@Transactional(readOnly=false)
	public void savePost(Post post) {
		this.postDao.saveEntry(post);
	}

	@Transactional(readOnly=false)
	public void deletePostById(Serializable id) {
		this.postDao.deleteEntry(id);
	}

	public Post getPostById(Serializable id) {
		return (Post)this.postDao.getEntryById(id);
	}

	public Set<Post> getPostsByIds(Long[] pids) {
		return this.postDao.getPostsByIDS(pids);
	}
}
