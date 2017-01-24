package com.vydya.theschool.web.localstatic;

import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import com.vydya.theschool.common.util.FileUtil;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.security.SessionBox;

public class StaticSession {

	private String sessionPath;
	private String id;
	private String user;
	private HttpSession session;
	
	
	
	public StaticSession(String sessionPath, String id, String user) {
		super();
		this.sessionPath = sessionPath;
		this.id = id;
		this.user = user;
	}

	public StaticSession(HttpSession session) {
		super();
	}
	public StaticSession() {
		super();
	}

	public int getSessionCount(){
		return SessionBox.getActiveSessions();
	}

	public void saveImage(String name, byte[] bytes) throws IOException{
		
		OutputStream out = null; 
		
		//String fullDir = name.substring(0, name.lastIndexOf("\\"));
		String path = sessionPath+"/"+name+".jpg";
		File f = new File(sessionPath);
		if(!f.exists()){
			f.mkdirs();
		}
		try {
		     out = new BufferedOutputStream(new FileOutputStream(path));
		    out.write(bytes);
		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
		    if (out != null) out.close();
		}
		
	}
	

	public byte[] getImage(String name){
		
		try {
			
			//String path = sessionPath+"/"+name+".jpeg";
			BufferedImage bi = null;
			File directory = new File(sessionPath);
			if(directory.list().length!=0){
				
				String[] images = directory.list();
				 for (String image : images) {
					if(image.contains(name)){
						bi = ImageIO.read(new File(sessionPath+"/"+image));
					}
				 }
			}
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write( bi, "jpeg", baos );
			byte[] imageInByte = baos.toByteArray();
			baos.close();
			return imageInByte;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
public String getImageType(String name){
			
			String imageType = null;
			File directory = new File(sessionPath);
			if(directory.list().length!=0){ 
				
				String[] images = directory.list();
				 for (String image : images) {
					if(image.contains(name)){
						imageType = image.substring(image.indexOf("."));
					}
				 }
			}
			return imageType;
	}

	public boolean isExistsImage(String name){
		boolean exists =false;
		
		try {
			String path = sessionPath+"/"+name;
			File file = new File(path);
			if(file.isFile())
				exists=true;
			else
				exists=false;
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return exists;
	}
	
	public void invalidate(){
		
		final String SRC_FOLDER = sessionPath;
		FileUtil.deleteFolder(SRC_FOLDER);
	}


	public String getSessionPath() {
		return sessionPath;
	}


	public void setSessionPath(String sessionPath) {
		this.sessionPath = sessionPath;
	}


	public String getUser() {
		return user;
	}


	public void setUser(String user) {
		this.user = user;
	}


	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.id=session.getId();
		this.user=(String)session.getAttribute(WebConstants.SESSION_USER_NAME);
	}
	
	
}


