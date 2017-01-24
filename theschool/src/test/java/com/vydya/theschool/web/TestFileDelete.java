package com.vydya.theschool.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.List;

import com.vydya.theschool.common.util.ImageUtil;


public class TestFileDelete {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		String  path = "C:/DBdata/localSession/06CC49A2D9F5E701E342D952ADDDC60E";
			//deleteFile(path);
		//createfolder();
		
		//deleteFile(path);
		//deleteEmptyFolders(path);
		//removeFile("");
		//isExists();
		//deleteMultipleWithSameName();
		testImageExisted();
	}

	public static void isExists(){
		
		String path1 ="C:/DBdata/localSession/B7C617F8302F1B9CF5D31796E86FE1C1/O63d_CRP.jpeg";
		File file = new File(path1);
		System.out.println(file.isFile());
	}
	
	public static void testImageExisted(){
		
		/*try {
				ImageUtil.copyImage("5461a8e5019f16304cb90fc9.jpeg", "62x", "C:/DBdata/staticData/simg-org", "C:/DBdata/theschool/context/images");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
		String s ="";
		//System.out.println("xx=="+Integer.parseInt(s));
		

	}
	
	private static void deleteFile(String path) throws IOException {
		// TODO Auto-generated method stub
		 List<String> filesList = new ArrayList<String>();
	        List<String> folderList = new ArrayList<String>();
	        fetchCompleteList(filesList, folderList, path); 
	       /* for(String filePath : filesList) {
	            File tempFile = new File(filePath);
	            //tempFile.delete();
	            String s =   filePath.substring(filePath.lastIndexOf(File.separator));
	            String path2 = "C:"+File.separator+"Temp"+File.separator+"vydya"+File.separator+s;
	            File destFile = new File(path2);
	            copyImageFiles(tempFile, destFile);
	            
	        }*/
	        for(String filePath : filesList) {
	            File tempFile = new File(filePath);
	            tempFile.delete();
	        }
	}

	
private static void fetchCompleteList(List<String> filesList, List<String> folderList, String path) {
	    File file = new File(path);
	    File[] listOfFile = file.listFiles();
	    for(File tempFile : listOfFile) {
	        if(tempFile.isDirectory()) {
	            folderList.add(tempFile.getAbsolutePath());
	            fetchCompleteList(filesList, folderList, tempFile.getAbsolutePath());
	        } else {
	            filesList.add(tempFile.getAbsolutePath());
	        }
	    }
	}

private static void createfile(String path) throws IOException{
	
	//String path2 = "C:"+File.separator+"hello"+File.separator+"hi.txt";
	String path2 = "C:"+File.separator+"Temp"+File.separator+"vydya"+File.separator+path;
	//(use relative path for Unix systems)
	File f = new File(path2);
	//(works for both Windows and Linux)
	f.mkdirs(); 
	//f.createNewFile();
	
}

public static void copyImageFiles(File sourceFile, File destinationDir) throws IOException {

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


/*private creteByByte(){
	
	
	try {
	    OutputStream out = new BufferedOutputStream(new FileOutputStream(path));
	    out.write(bytes);
	} finally {
	    if (out != null) out.close();
	}
}*/

private static void createfolder() throws IOException{
	
	//String path2 = "C:"+File.separator+"hello"+File.separator+"hi.txt";
	String path2 = "C:\\Temp\\praveen\\vydya\\1\\";
	//(use relative path for Unix systems)
	File f = new File(path2);
	
	 File[] listOfFile = f.listFiles();
	//(works for both Windows and Linux)
	if(f.exists()){
		System.out.println("is already existed");
	}
	else{
		f.mkdirs(); 
	}
	
	
	//f.createNewFile();
}


private static void removeFile(String path){
	
	    File f = new File("C:\\Temp\\vydya\\2.jpg");
	
	    f.delete();
}

/*public static void removeFileAndParentsIfEmpty(Path path)
        throws IOException {
    if(path == null || path.endsWith(BASEPATH)) return;

    if (Files.isRegularFile(path)) {
        Files.deleteIfExists(path);
    } else if(Files.isDirectory(path)) {
        try {
            Files.delete(path);
        } catch(DirectoryNotEmptyException e) {
            return;
        }
    }

    removeFileAndParentsIfEmpty(path.getParent());
}*/

public static void deleteEmptyFolders(String path){
	
	final String SRC_FOLDER = path;
	File directory = new File(SRC_FOLDER);
	//make sure directory exists
	if(!directory.exists()){
       System.out.println("Directory does not exist.");
       System.exit(0);
    }else{
       try{
    	   deleteFolder(directory);
    	//deleteFile(directory, "pa - Copy.jpg");
       }catch(IOException e){
           e.printStackTrace();
           System.exit(0);
       }
    }

	System.out.println("Done");
}

public static void deleteFolder(File file)
    	throws IOException{
 
    	if(file.isDirectory()){
    		//directory is empty, then delete it
    		if(file.list().length==0){
 
    		   file.delete();
    		   System.out.println("Directory is deleted : " + file.getAbsolutePath());
    		}else{
    		   //list all the directory contents
        	   String files[] = file.list();
        	   for (String temp : files) {
        	      //construct the file structure
        	      File fileDelete = new File(file, temp);
        	      //recursive delete
        	     delete(fileDelete);
        	   }
        	   //check the directory again, if empty then delete it
        	   if(file.list().length==0){
           	     file.delete();
        	     System.out.println("Directory is deleted : " + file.getAbsolutePath());
        	   }
    		}
 
    	}else{
    		//if file, then delete it
    		file.delete();
    		System.out.println("File can't  deleted It is a file or Not Empty folder: " + file.getAbsolutePath());
    	}
    }
public static void delete(File file)
    	throws IOException{
 
    	if(file.isDirectory()){
 
    		//directory is empty, then delete it
    		if(file.list().length==0){
 
    		   file.delete();
    		   System.out.println("Directory is deleted : " + file.getAbsolutePath());
    		}else{
    		   //list all the directory contents
        	   String files[] = file.list();
        	   for (String temp : files) {
        	      //construct the file structure
        	      File fileDelete = new File(file, temp);
        	      //recursive delete
        	     delete(fileDelete);
        	   }
        	   //check the directory again, if empty then delete it
        	   if(file.list().length==0){
           	     file.delete();
        	     System.out.println("Directory is deleted : " + file.getAbsolutePath());
        	   }
    		}
 
    	}else{
    		//if file, then delete it
    		file.delete();
    		System.out.println("File can't  deleted It is a file or Not Empty folder: " + file.getAbsolutePath());
    	}
    }

public static  void deleteMultipleWithSameName() throws IOException{
	
	String id = "1";
	File directory = new File("C:/Temp/d");
	deleteFile(directory,id);
}

public static void deleteFile(File directory,String fileName) 
    	throws IOException{
 
    	if(directory.isDirectory()){
 
    		//directory is empty, then delete it
    		if(directory.list().length!=0){
    			 //list all the directory contents
         	   String files[] = directory.list();
         	   for (String temp : files) {
         		   
         		   File fs = new File(directory,temp);
         		   if(fs.isDirectory()){
         			  deleteFile(fs,fileName);
         			 
         		   }
         	      //construct the file structure
         		   else if(temp.contains(fileName+".")){
         			   
         			   File fileDelete = new File(directory, temp);
              	      //recursive delete
         			   fileDelete.delete();
         			   System.out.println("File is deleted in : " + fileDelete.getAbsolutePath());
         		   }
         	     
         	   }
         	   
    		}
 
    	}
    	
    }


public static void deleteJunkImages(File directory,String fileName) 
    	throws IOException{
 
    	if(directory.isDirectory()){
 
    		//directory is empty, then delete it
    		if(directory.list().length!=0){
    			 //list all the directory contents
         	   String files[] = directory.list();
         	   for (String temp : files) {
         		   

// to do
         	     
         	   }
         	   
    		}
 
    	}
    	
    }
}