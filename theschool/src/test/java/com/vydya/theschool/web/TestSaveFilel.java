package com.vydya.theschool.web;

//File Name SendEmail.java

/*import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;*/
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import javax.imageio.ImageIO;

import com.vydya.theschool.common.exceptions.FileException;


public class TestSaveFilel
{
   public static void main(String [] args) throws FileException
   {    
	   //cropImage();
	   //imageForCrop();
	  //ContentImg();
	   System.out.println("HI");
	   //isFileExisted("");
	   testPropertyFile();
	   
   }
   
   private static void testPropertyFile() {
	   Long l1 =System.currentTimeMillis();
		 //Resource resource = new ClassPathResource("C:/DBdata/theschool/data.properties");
	   FileInputStream fis = null;
		 Properties props = new Properties();;
		try {
			File f  = new File("C:/DBdata/theschool/data.properties");
			if(f.exists()){
				  fis   = new FileInputStream(f);
				 
			}
			if(null!=props){
				 props.load(fis);

				 Set<Object> keys = props.keySet();
			        for (Object key : keys) {

			        		System.out.println(" key ="+(String)key + "value = "+props.get(key));
			            
			        }
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 
		
}

private static void ContentImg() {
	   String c = "<p>Quiz contest 2013 Informaiton</p><p><x src=\"http://localhost:8280/theschool/attachments/egitim-1390853323880.jpg\"><span class='pedit-selection pedit-ignore' style='line-height: 0; display: none;' id='pedit-end-marker'> </span><span class='pedit-selection pedit-ignore' style='line-height: 0; display: none;' id='pedit-start-marker'> </span><br></p><p><img src=\"http://localhost:8280/theschool/attachments/ab.jpeg\"><br></p>";
	  String s;
	try {
		while(c.contains("http")){
			
			String csub = c.substring(c.indexOf("http"),c.indexOf("http")+68);
			c= c.substring(c.indexOf(csub)+68);
			System.out.println(csub);
		}
		
		
	 }catch (Exception mex) {
		    mex.printStackTrace();
		 }
	 
	   
   }
   private static void cropImage(){
		
		String URLString = "C:/Temp/pizza.jpg";
	    try{
	   	 
	   	 BufferedImage img2=ImageIO.read(new File(URLString));
	   	 
	   	BufferedImage dest = img2.getSubimage(240, 200, 100, 500);
	   	//dest.createGraphics().drawImage(ImageIO.read(new File("D:/Gmail/imagesT.jpeg")).getScaledInstance(x, y, Image.SCALE_SMOOTH),0,0,null);
	
		ImageIO.write(dest, "jpg", new File("C:/Temp/pizza_new.jpg"));
	    	
	    	
	   
	 }catch (Exception mex) {
	    mex.printStackTrace();
	 }
	}
private static void method1(){
	
	String URLString = "D:/Gmail/imagesT.jpeg";
    try{
   	 
   	/*BufferedImage img = new BufferedImage(135, 100, BufferedImage.TYPE_INT_RGB);
   	img.createGraphics().drawImage(ImageIO.read(new File("D:/Gmail/paiinting.jpg")).getScaledInstance(135, 100, Image.SCALE_SMOOTH),0,0,null);
   	ImageIO.write(img, "jpg", new File("D:/Gmail/test1_thumb.jpg"));
   	 */
   	// URL url=new URL("D:/Gmail/test1.jpg");
   	 BufferedImage img2=ImageIO.read(new File(URLString));
   	 
   	 
   	 
   	 int h = img2.getHeight();
   	 int w= img2.getWidth();
   	 int x;
   	 int y;
   	 
   	 if(h>w){
   		y=135;
   		x=(w*135)/h;
   	 }
   	 else{
   		 x=100;
   		 y=(h*100)/w;
   	 }
   	 BufferedImage imgC = new BufferedImage(x, y, BufferedImage.TYPE_INT_RGB);
   	String fileName = findFileName(URLString);
   	 
   	 imgC.createGraphics().drawImage(ImageIO.read(new File("D:/Gmail/imagesT.jpeg")).getScaledInstance(x, y, Image.SCALE_SMOOTH),0,0,null);
    		ImageIO.write(imgC, "jpg", new File("D:/Gmail/testThumb2_"+x+"X"+y+".jpg"));
    	
    	
    	
   	 System.out.println(" ht "+img2.getWidth()+" width "+img2.getHeight());
   	 
   	 /*BufferedImage src = ImageIO.read(new ByteArrayInputStream(file.getBytes()));
		 File destination = new File("D:/Gmail/image1.jpeg"); // something like C:/Users/tom/Documents/nameBasedOnSomeId.png
		 ImageIO.write(src, "jpeg", destination);*/
		 
   	/* MultipartFile file = cmsPageData.getFile(); 
   	 * InputStream is = file.getInputStream();
   	 * InputStream is = item.getInputStream();  
   	  
   	  try  
   	  {      
   	    Image image = ImageIO.read ( is );  
   	    int w = image.getWidth ();  
   	    int h = image.getHeight ();  
   	  } */ 
   	// File forDlete = new File("D:/Gmail/test1_thumb.jpg");
   	// boolean x = forDlete.delete();
   	 //System.out.println(" Deleted selected file "+x);
   	 
   	 
   	 
   	/* for(int i=1;i<100;i++){
   		 ImageIO.write(img, "jpg", new File("D:/Gmail/ts/Thumb"+i+".jpg")); 
   	 }
   	 */
   	 
   	/* File[] faFiles = new File("D:/Gmail").listFiles();
   	  for(File file: faFiles){
   	    if(file.getName().matches("^(.*?)")){
   	      System.out.println(file.getAbsolutePath());
   	    }
   	    if(file.isDirectory()){
   	    	System.out.println("x "+file.getAbsolutePath());
   	    }
   	  }*/
   	 
   	 
   	 
   	/* File sourceImageFile = new File("bigfile.jpg");
   	 BufferedImage img = ImageIO.read(sourceImageFile);
   	 Image scaledImg = img.getScaledInstance(100, 50, Image.SCALE_SMOOTH);
   	 BufferedImage thumbnail = new BufferedImage(100, 50, BufferedImage.TYPE_INT_RGB);
   	 thumbnail.createGraphics().drawImage(scaledImg,0,0,null);
   	 ImageIO.write(thumbnail, "jpg", new File("thumbnail.jpg"));
   	 ByteArrayOutputStream baos = new ByteArrayOutputStream();
   	 ImageIO.write(thumbnail, "jpg", baos);
   	 baos.flush();
   	 byte[] imageBytes = baos.toByteArray();*/

   	 
 }catch (Exception mex) {
    mex.printStackTrace();
 }
}

private static String findFileName(String url) {
	// 
	 String arr[] = url.split("/");	
	 int ln = arr.length-1;
	 String fname = arr[ln];
	 String name[] = fname.split("\\.");
	return name[0];
	
}

private static void imageForCrop(){
	Integer maxHeight = 450;
	Integer maxWidth = 850;
	String URLString = "C:/Temp/images/v.jpg";
    try{
   	 
   
   	 BufferedImage img2=ImageIO.read(new File(URLString));

   	 int h = img2.getHeight();
  	 int w= img2.getWidth();
  	int x;
  	 int y;
  	 
  	 
  	 if(h>w){
  		y=maxHeight;
		 x=(w*maxHeight)/h;  
  	 }
  	
  	 else if(w>h&&h<maxHeight){
  		x=maxWidth;
		 y=(h*maxWidth)/w; 
	   	 }
  	 else if(w>h&&h>maxHeight&&w<maxWidth){
  		y=maxHeight;
		 x=(w*maxHeight)/h;  
 	   	 }
  	else if(w>h&&h>maxHeight&&w>maxWidth){
  		x=maxWidth;
		 y=(h*maxWidth)/w; 
 	   	 }
  	else if(w>h&&w>maxWidth){
  		x=maxWidth;
		 y=(h*maxWidth)/w; 
 	   	 }
  	 else{
  		 
  		y= x = (w*maxHeight)/h; 
  	 }
   	 BufferedImage imgC = new BufferedImage(x, y, BufferedImage.TYPE_INT_RGB);
   	String fileName = findFileName(URLString);
   	 
   	 imgC.createGraphics().drawImage(ImageIO.read(new File("C:/Temp/images/v.jpg")).getScaledInstance(x, y, Image.SCALE_SMOOTH),0,0,null);
    		ImageIO.write(imgC, "jpg", new File("C:/Temp/images/v_"+x+"X"+y+".jpg"));
    	
    	
    	
   	 System.out.println(" ht "+img2.getWidth()+" width "+img2.getHeight());
   	 
   	 /*BufferedImage src = ImageIO.read(new ByteArrayInputStream(file.getBytes()));
		 File destination = new File("D:/Gmail/image1.jpeg"); // something like C:/Users/tom/Documents/nameBasedOnSomeId.png
		 ImageIO.write(src, "jpeg", destination);*/
		 
   	/* MultipartFile file = cmsPageData.getFile(); 
   	 * InputStream is = file.getInputStream();
   	 * InputStream is = item.getInputStream();  
   	  
   	  try  
   	  {      
   	    Image image = ImageIO.read ( is );  
   	    int w = image.getWidth ();  
   	    int h = image.getHeight ();  
   	  } */ 
   	// File forDlete = new File("D:/Gmail/test1_thumb.jpg");
   	// boolean x = forDlete.delete();
   	 //System.out.println(" Deleted selected file "+x);
   	 
   	 
   	 
   	/* for(int i=1;i<100;i++){
   		 ImageIO.write(img, "jpg", new File("D:/Gmail/ts/Thumb"+i+".jpg")); 
   	 }
   	 */
   	 
   	/* File[] faFiles = new File("D:/Gmail").listFiles();
   	  for(File file: faFiles){
   	    if(file.getName().matches("^(.*?)")){
   	      System.out.println(file.getAbsolutePath());
   	    }
   	    if(file.isDirectory()){
   	    	System.out.println("x "+file.getAbsolutePath());
   	    }
   	  }*/
   	 
   	 
   	 
   	/* File sourceImageFile = new File("bigfile.jpg");
   	 BufferedImage img = ImageIO.read(sourceImageFile);
   	 Image scaledImg = img.getScaledInstance(100, 50, Image.SCALE_SMOOTH);
   	 BufferedImage thumbnail = new BufferedImage(100, 50, BufferedImage.TYPE_INT_RGB);
   	 thumbnail.createGraphics().drawImage(scaledImg,0,0,null);
   	 ImageIO.write(thumbnail, "jpg", new File("thumbnail.jpg"));
   	 ByteArrayOutputStream baos = new ByteArrayOutputStream();
   	 ImageIO.write(thumbnail, "jpg", baos);
   	 baos.flush();
   	 byte[] imageBytes = baos.toByteArray();*/

   	 
 }catch (Exception mex) {
    mex.printStackTrace();
 }
}


public static boolean isFileExisted(String path) throws FileException{
	final String SRC_FOLDER = path;
	File directory = new File(SRC_FOLDER);
	//make sure directory exists
	if(!directory.exists()){
		return false;
    }else{

    	return true;
    }
}


}
