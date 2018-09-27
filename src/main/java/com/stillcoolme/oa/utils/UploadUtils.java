package com.stillcoolme.oa.utils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

public class UploadUtils {
	
	public static String saveUploadFile(File resource){
		
		InputStream is = UploadUtils.class.getClassLoader().getResourceAsStream("config.properties");
		Properties pro = new Properties();
		try {
			pro.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		}
		String basePath = pro.getProperty("uploadPath");
		
		SimpleDateFormat sdf = new SimpleDateFormat("/yyyy/MM/dd/");
		String subPath = sdf.format(new Date());
		
		File dir = new File(basePath+subPath);
		if(!dir.exists()){
			dir.mkdirs();
		}
		
		String uploadPath = basePath+subPath+UUID.randomUUID().toString()+".doc";	//UUID.randomUUID().toString()能够保证名字的唯一性
		File dest = new File(uploadPath);
		//把文件移动到dest处
		resource.renameTo(dest);
		return uploadPath;
		
	}
	
}
