package com.vydya.theschool.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;

import org.apache.commons.io.FileUtils;

public class FilesCopyExample {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub

		//copyFile();
		copyFiles2();
	}

	public static void copyFile() throws IOException{
		   String path ="http://subversion.assembla.com/svn/weblog4j/Weblog4jDemo/trunk";    
		   File destination = new File ("D:/myschool/webservice/spring-jx1"); 
		   FileUtils.copyFile(destination, new File(path));      
		}

	public static void copyFiles2() throws IOException {
		File destinationDir  = new File("D:/myschool/webservice/spring-jx1");

		File sourceFile =new File("http://subversion.assembla.com/svn/weblog4j/Weblog4jDemo/trunk/"); 
		
	    FileInputStream fis = new FileInputStream(sourceFile); 
	    FileOutputStream fos = new FileOutputStream(destinationDir);  
	    FileChannel srcChannel = fis.getChannel();  
	    FileChannel destChannel = fos.getChannel();  
	    srcChannel.transferTo(0, sourceFile.length(), destChannel); 
	    srcChannel.close();  
	    destChannel.close();  
	    fis.close();  
	    fos.close();      
	}
	
}
