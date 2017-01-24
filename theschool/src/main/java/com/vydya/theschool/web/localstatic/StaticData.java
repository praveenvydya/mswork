package com.vydya.theschool.web.localstatic;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.exceptions.FileException;
import com.vydya.theschool.common.util.FileUtil;
import com.vydya.theschool.common.util.ImageUtil;

public class StaticData {

	private static final Logger logger = Logger.getLogger(FileUtil.class);
	private String staticPath;
	private String user;
	private String STATIC_FILE_ORG = "stfile-org/";
	private String STATIC_FILE_MENU = "stfile-menu/";
	private String STATIC_FILE_HTML = "stfile-html/";
	private String STATIC_FILE_XML = "stfile-xml/";
	private String STATIC_FILE_CONTENT = "stfile-content/";
	private String STATIC_ORG = "simg-org/";
	private String STATIC_FIT = "simg-fit/";
	private String STATIC_FIX = "simg-fix/";
	private String[] allowedSizes = {"185x125","107x72","213x130","96x68","262x140","203x137","96x120","302x180"};//wxh
	private String[] allowedFixSizes = {"352x140"};
	
	public StaticData(String sessionPath,String user) {
		super();
		this.staticPath = sessionPath;
		this.user = user;
	}


	public StaticData() {
		super();
	}
	
	
	public void saveImage(String name, byte[] bytes,String type) throws FileException{

		InputStream is = new BufferedInputStream(new ByteArrayInputStream(bytes));
		
		try {
			
			String orginlpath = staticPath+"/"+STATIC_ORG+name;//+"."+FileUtil.getImageMimeType(bytes);
			File f = new File(orginlpath);
			if(f.exists()){
				deleteImage(name);
			}
			
			
				save(orginlpath, bytes);
				if("B".equalsIgnoreCase(type)){
					bytes = ImageUtil.resizeImageThumb(bytes,155 , 117);
					save(staticPath+"/"+STATIC_FIT+"117x155/"+name, bytes);
					save(staticPath+"/"+STATIC_FIX+"117x155/"+name, bytes);
				}
				else if("T".equalsIgnoreCase(type)){
					bytes = ImageUtil.resizeImageThumb(bytes,133 , 231);
					save(staticPath+"/"+STATIC_FIT+"262x140/"+name, bytes);
				}
				else{
					List<String> allowedSizs = Arrays.asList(allowedSizes);
					for(String s:allowedSizs){
						String[] dim = s.split("x");
					byte[] 	nbytes = ImageUtil.resizeImageThumb(bytes,Integer.parseInt(dim[1]) , Integer.parseInt(dim[0]));
						save(staticPath+"/"+STATIC_FIT+s+"/"+name, nbytes);
					}
					List<String> allowedFixSizs = Arrays.asList(allowedFixSizes);
					for(String s:allowedFixSizs){
						String[] dim = s.split("x");
						byte[] nxbytes = ImageUtil.resizeImageThumb(bytes,Integer.parseInt(dim[1]) , Integer.parseInt(dim[0]));
						save(staticPath+"/"+STATIC_FIX+s+"/"+name, nxbytes);
					}
				}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void saveFile(String name, byte[] bytes,String type) throws IOException{
		String orginlpath = staticPath+"/"+STATIC_FILE_ORG+name;
		save(orginlpath, bytes);
	}
	
	public void saveMenuAttachment(String name, byte[] bytes,String type) throws IOException{
		String orginlpath = staticPath+"/"+STATIC_FILE_MENU+name;
		save(orginlpath, bytes);
	}
	public void saveContent(String name, String c ,String type) throws IOException{
		String orginlpath = staticPath+"/"+STATIC_FILE_CONTENT+name+".html";
		File file = new File(orginlpath);
		file.setWritable(true);
		FileUtils.writeStringToFile(file, c, "UTF-8");
		file.setWritable(false);
	}
	
	public String getContent(String name){
		String orginlpath = staticPath+"/"+STATIC_FILE_CONTENT+name+".html";
		BufferedReader br = null;
		StringBuffer bf = new StringBuffer();
		try {
			String sCurrentLine;
			br = new BufferedReader(new FileReader(orginlpath));
			while ((sCurrentLine = br.readLine()) != null) {
				bf.append(sCurrentLine);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null)br.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return bf.toString();
	}
	
private void save(String path, byte[] bytes) throws IOException{
	OutputStream out = null; 

	String folder = path.substring(0, path.lastIndexOf("/"));
	
	File f = new File(folder);
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
	
public void deleteImage(String id) throws FileException{
	
	String orginlpath = staticPath;
	
	try {
		FileUtil.deleteStatic(orginlpath, id);
	
	} 
	catch (FileException e) 
	{			
		throw new FileException(e.getErrorCode(), e.getErrorMessage());
	}
	catch (Exception e) 
	{
		FileException svcExp = new FileException(ErrorConstants.TS_5012, e.getMessage());
		logger.error(svcExp.toString(),e);		
		throw svcExp;
	}
}
	
public void deleteFile(String id) throws FileException{
	
	String orginlpath = staticPath;
	
	try {
		FileUtil.deleteStatic(orginlpath, id);
	
	} 
	catch (FileException e) 
	{			
		throw new FileException(e.getErrorCode(), e.getErrorMessage());
	}
	catch (Exception e) 
	{
		FileException svcExp = new FileException(ErrorConstants.TS_5012, e.getMessage());
		logger.error(svcExp.toString(),e);		
		throw svcExp;
	}
}

	/*public byte[] getImage(String path){
		
		try {
			
			String url = staticPath+"/"+path;
			BufferedImage bi = ImageIO.read(new File(url));
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write( bi, "jpeg", baos );
			baos.flush();
			byte[] imageInByte = baos.toByteArray();
			return imageInByte;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}*/
	
	public boolean isExistsOrginalImage(String imageName){
		boolean exists =false;
		
		try {
			String url = staticPath+"/simg-org/"+imageName;
			File file = new File(url);
			if(file.isFile())
				exists=true;
			else
				exists=false;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return exists;
	}
	
	/*public void delete(String unid){
		
		final String SRC_FOLDER = staticPath;
		FileUtil.deleteFolder(SRC_FOLDER);
	}*/

	public String getStaticPath() {
		return staticPath;
	}

	public void setStaticPath(String staticPath) {
		this.staticPath = staticPath;
	}


	

}


