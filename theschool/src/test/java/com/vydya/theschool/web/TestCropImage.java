package com.vydya.theschool.web;

//File Name SendEmail.java

/*import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;*/
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.common.util.Scale;
import com.vydya.theschool.web.utils.UniqueIdGenerator;



public class TestCropImage
{
   public static void main(String [] args)
   {    
	  //cropingImage2();
	   //cropingTestUtil();
	   //resizeImage();
	   //imageForCrop();
	   cropingImage();
	   System.out.println(new UniqueIdGenerator().toString());
	   //testFileName();
	   
	   
   }
   
   
   private static void testFileName(){
		
		String x = "abc.jpg";
			String name = x.substring(0, x.lastIndexOf("."));
			String filename = x.substring(x.lastIndexOf("."));
			System.out.println(filename+"/"+name);
	}
   
   private static void cropingImage(){
		
		String x = "C:/Temp/n/c/h.jpg";
			String name = x.substring(0, x.lastIndexOf("."));
	    try{
	   	 //185x125
	    	
	   	 BufferedImage image=ImageIO.read(new File(x));
	   	 
	   	 
	   	 
	   	//BufferedImage dest = resizeImage(img2, 130,213);
	   	//BufferedImage dest1 = Scalr.resize(image, Scalr.Method.SPEED, Scalr.Mode.FIT_TO_WIDTH,	185, Scalr.OP_ANTIALIAS);
	   	//ImageIOUtil.
	   //	BufferedImage dest1=	Scalr.resize(img2, 150, 100);
	   	//
	   	
	   	//BufferedImage dest = Scalr.crop(dest1,0,40,213, 130);
	   	
	   	BufferedImage dest = resizeImage(image, 100,100);
	   	
	   	BufferedImage newImage = cropMyImage(dest,0,50,100, 100);
	   	//BufferedImage dest = Scale.crop(image, 3,100,890, 401);
	   	
	   //	BufferedImage dest1 = 	Scale.resize(image, Scale.Method.QUALITY, Scale.Mode.FIT_TO_WIDTH, 848, Scale.THRESHOLD_QUALITY_BALANCED);
	   	//Scale.resize(img, Scale.Method.QUALITY, w, h, Scale.OP_ANTIALIAS);
	   	//BufferedImage dest1 = Scale.resize(image, Scale.Method.QUALITY, Scale.Mode.FIT_EXACT, 753, 300, Scale.OP_ANTIALIAS);
	   	
	   //	BufferedImage dest2 = 	Scale.resize(image, Scale.Method.SPEED, Scale.Mode.FIT_TO_WIDTH, 848, Scale.OP_ANTIALIAS);
	   	//BufferedImage  	newImage = Scale.resize(image, Scale.Method.QUALITY, Scale.Mode.FIT_TO_HEIGHT,600, Scale.OP_ANTIALIAS);
	   	ImageIO.write(newImage, "jpg", new File(name+"_"+newImage.getWidth()+"QA_A_OP"+newImage.getHeight()+".jpg"));
	   	//dest.get
	   //	MyImage img = new My
	   	
	   //	ImageIO.write(dest1, "jpg", new File(name+"_"+dest1.getWidth()+"QUALITY_A_OP"+dest1.getHeight()+".jpg"));
	  	//ImageIO.write(dest2, "jpg", new File(name+"_"+dest2.getWidth()+"SPEED_OP"+dest2.getHeight()+".jpg"));
	   	 
	 }catch (Exception mex) {
	    mex.printStackTrace();
	 }
	}
   
   
   private static void cropingImage2(){
		
		String x = "C:/Temp/n/st.jpg";
			String name = x.substring(0, x.lastIndexOf("."));
	    try{
	    	BufferedImage image=ImageIO.read(new File(x));
	 	   	ByteArrayOutputStream baos = new ByteArrayOutputStream();
	 		ImageIO.write( image, "jpg", baos );
	 		baos.flush();
	 		byte[] orginalImage = baos.toByteArray();
	   	
	   	byte[] imageInByte2= ImageUtil.resizeImage(orginalImage, 125, 185);

	   	ByteArrayInputStream  in = new ByteArrayInputStream(imageInByte2);
 		BufferedImage dest = ImageIO.read(in);
 	   	
 	   	ImageIO.write(dest, "jpg", new File(name+"_"+dest.getWidth()+"RESIZE"+dest.getHeight()+".jpg"));

	   	 
	 }catch (Exception mex) {
	    mex.printStackTrace();
	 }
	}
   
   private static void cropingTestUtil(){
		
 		String x = "C:/Temp/n/c/ip.jpg";
 			String name = x.substring(0, x.lastIndexOf("."));
 	    try{
 	   	 //185x125
 	    	
 	   	 BufferedImage image=ImageIO.read(new File(x));
 	   	ByteArrayOutputStream baos = new ByteArrayOutputStream();
 		ImageIO.write( image, "jpg", baos );
 		baos.flush();
 		byte[] imageInByte = baos.toByteArray();

 		byte[] imageInByte2 =	ImageUtil.resizeImage(imageInByte, 125, 185);
 	   	
 		ByteArrayInputStream  in = new ByteArrayInputStream(imageInByte2);
 		BufferedImage dest = ImageIO.read(in);
 	   	
 	   	ImageIO.write(dest, "jpg", new File(name+"_"+dest.getWidth()+"bl"+dest.getHeight()+".jpg"));
 	   	 
 	 }catch (Exception mex) {
 	    mex.printStackTrace();
 	 }
 	}
   
   private static void resizeImage(){
		
		String x = "C:/Temp/n/c/rs.jpg";
			String name = x.substring(0, x.lastIndexOf("."));
	    try{
	   	 //185x125
	    	 BufferedImage image=ImageIO.read(new File(x));
	    	 
	    	BufferedImage dest = Scale.resize(image, Scale.Method.SPEED, Scale.Mode.FIT_TO_WIDTH,
		   			485, Scale.OP_ANTIALIAS);
	   	
	   	
	   	ImageIO.write(dest, "jpg", new File(name+"_"+dest.getWidth()+"rs"+dest.getHeight()+".jpg"));
	   	 
	 }catch (Exception mex) {
	    mex.printStackTrace();
	 }
	}
   private static BufferedImage cropMyImage(BufferedImage src, int x, int y,
			int width, int height) throws IOException{
	   
	   
	   
	   long t = System.currentTimeMillis();

		if (src == null)
			throw new IllegalArgumentException("src cannot be null");
		if (x < 0 || y < 0 || width < 0 || height < 0)
			throw new IllegalArgumentException("Invalid crop bounds: x [" + x
					+ "], y [" + y + "], width [" + width + "] and height ["
					+ height + "] must all be >= 0");

		int srcWidth = src.getWidth();
		int srcHeight = src.getHeight();

		if ((x + width) > srcWidth)
			throw new IllegalArgumentException(
					"Invalid crop bounds: x + width [" + (x + width)
							+ "] must be <= src.getWidth() [" + srcWidth + "]");
		if ((y + height) > srcHeight)
			throw new IllegalArgumentException(
					"Invalid crop bounds: y + height [" + (y + height)
							+ "] must be <= src.getHeight() [" + srcHeight
							+ "]");



		// Create a target image of an optimal type to render into.
		BufferedImage result = createOptimalImage(src, width, height);
		Graphics g = result.getGraphics();

		/*
		 * Render the region specified by our crop bounds from the src image
		 * directly into our result image (which is the exact size of the crop
		 * region).
		 */
		g.drawImage(src, 0, 0, width, height, x, y, (x + width), (y + height),
				null);
		g.dispose();

		
		
		return result;
   }
	
	private static BufferedImage createOptimalImage(BufferedImage src,
			int width, int height) throws IllegalArgumentException {
		if (width < 0 || height < 0)
			throw new IllegalArgumentException("width [" + width
					+ "] and height [" + height + "] must be >= 0");

		return new BufferedImage(
				width,
				height,
				(src.getTransparency() == Transparency.OPAQUE ? BufferedImage.TYPE_INT_RGB
						: BufferedImage.TYPE_INT_ARGB));
	}

   
   
   private static BufferedImage resizeImage(BufferedImage img,Integer h, Integer w) throws IOException{
	   
	   Long l1 =System.currentTimeMillis();
	   
	   ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write( img, "jpg", baos );
		baos.flush();
		byte[] orginalImage = baos.toByteArray();
		
	   	Integer height = img.getHeight();
	   	 Integer width = img.getWidth();
	   	 Integer x= null;
	   	 Integer y = null;
	   	 
	   	byte[] newImageBytes;
	   	BufferedImage newImage = null;
	   	ByteArrayInputStream inNew = null;
	   	 
	   	 if(width>height){
	   		 
	   		newImageBytes = getFixedImageHeight(orginalImage, h);
	   		inNew = new ByteArrayInputStream(newImageBytes);
			 newImage = ImageIO.read(inNew);
			 Integer nW =newImage.getWidth();
			 if(nW>w){
				 x=(nW-w)/2;
			   		y=0; 
			 }
			 else if(nW<w){
				 newImageBytes = getFixedImageWidth(orginalImage, w);
				 inNew = new ByteArrayInputStream(newImageBytes);
				 newImage = ImageIO.read(inNew);
				 Integer nH =newImage.getHeight();
				 x=0;
				 y=(nH-h)/2;
			 }
	   		
	   	 }
	   	 else if(width<height){
	   		 
	   		newImageBytes = getFixedImageWidth(orginalImage, w);
	   		inNew = new ByteArrayInputStream(newImageBytes);
			 newImage = ImageIO.read(inNew);
			 Integer nH =newImage.getHeight();
			 if(nH>h){
				 y=((3*nH)-(4*h))/8;
			   		x=0; 
			 }
			 else if(nH<h){
				 newImageBytes = getFixedImageHeight(orginalImage, h);
				 inNew = new ByteArrayInputStream(newImageBytes);
				 newImage = ImageIO.read(inNew);
				 Integer nW =newImage.getHeight();
				 y=0;
				 x=(nW-w)/2;
			 }
	   	 }
	   	 else{
	   		newImageBytes = getFixedImageWidth(orginalImage, w);
	   		inNew = new ByteArrayInputStream(newImageBytes);
			 newImage = ImageIO.read(inNew);
	   		x=0;
	   		y=(newImage.getHeight()-h)/2;
	   	 }
	   	 
	 /*	BufferedImage dest = newImage.getSubimage(x, y, w, h);
	 	ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write( dest, "jpg", baos );
		baos.flush();
		byte[] imageInByte = baos.toByteArray();
		
		return imageInByte;*/
	   	 
	 	BufferedImage dest = newImage.getSubimage(x, y, w, h);
	 	
	 	//BufferedImage dest = Scalr.crop(newImage,x,y, 150, 100);
	 	
	 	Long l2 = System.currentTimeMillis();
	 	System.out.println(" TIME: "+(l2-l1)/1000);
	   return dest;
   }
   
   
   public static byte[] getFixedImageHeight(byte[] orginalImage,Integer height) throws IOException{
		
		ByteArrayInputStream  in = new ByteArrayInputStream(orginalImage);
		BufferedImage img = ImageIO.read(in);
		
			 int h = img.getHeight();
		   	 int w= img.getWidth();
		   	 int x;
		   	 int y;
	   		 /*y=175;
	   		 x=(w*175)/h;*/
		   		 y=height;
		   		 x=(w*height)/h;
		   	 
		Image scaledImg = img.getScaledInstance(x, y, Image.SCALE_SMOOTH);
		
		BufferedImage thumbnail = new BufferedImage(x, y, BufferedImage.TYPE_INT_RGB);
		thumbnail.createGraphics().drawImage(scaledImg,0,0,null);
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write( thumbnail, "jpg", baos );
		baos.flush();
		byte[] imageInByte = baos.toByteArray();
		
		return imageInByte;
	}
	
	public static byte[] getFixedImageWidth(byte[] orginalImage,Integer width) throws IOException{
		
		ByteArrayInputStream in = new ByteArrayInputStream(orginalImage);
		BufferedImage img = ImageIO.read(in);
		
			 int h = img.getHeight();
		   	 int w= img.getWidth();
		   	 int x;
		   	 int y;
	   		 /*y=175;
	   		 x=(w*175)/h;*/
		   	 		x=width;
		   		 y=(h*width)/w;
		   		
		   	 
		Image scaledImg = img.getScaledInstance(x, y, Image.SCALE_SMOOTH);
		
		BufferedImage thumbnail = new BufferedImage(x, y, BufferedImage.TYPE_INT_RGB);
		thumbnail.createGraphics().drawImage(scaledImg,0,0,null);
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write( thumbnail, "jpg", baos );
		baos.flush();
		byte[] imageInByte = baos.toByteArray();
		
		return imageInByte;
	}

}
