package com.stillcoolme.oa.service;

import java.io.Serializable;
import java.util.Collection;
import java.util.Set;

import com.stillcoolme.oa.domain.Post;

public interface PostService{
	
    public Collection<Post> getAllPost();
	
	public void updatePost(Post post);
	
	public void savePost(Post post);
	
	public void deletePostById(Serializable id);
	
	public Post getPostById(Serializable id);

	public Set<Post> getPostsByIds(Long[] pids);

}
