package com.vydya.theschool.web;

//File Name SendEmail.java

/*import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;*/
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import com.vydya.theschool.common.util.Scale;


public class TestCombineImage
{
   public static void main(String [] args) throws IOException
   {    
	 //  test();
	   testImage();
   }
   
   
   private static void test() throws IOException{
		
	   

			// load source images
			BufferedImage image = ImageIO.read(new File("D:/Beetin.png"));
			BufferedImage overlay = ImageIO.read(new File("D:/images.jpg"));

			// create the new image, canvas size is the max. of both image sizes
			int w = Math.max(image.getWidth(), overlay.getWidth());
			int h = Math.max(image.getHeight(), overlay.getHeight());
			BufferedImage combined = new BufferedImage(w, h, BufferedImage.TYPE_INT_ARGB);

			// paint both images, preserving the alpha channels
			Graphics g = combined.getGraphics();
			g.drawImage(image, 0, 0, null);
			g.drawImage(overlay, 50, 50, null);

			// Save as new image
			ImageIO.write(combined, "PNG", new File("D:/combined.png"));
			System.out.println("Done!");
	}
   
   private static void testImage() throws IOException{
		
	   
	   String x = "C:/Temp/n/c/h.jpg";
		String name = x.substring(0, x.lastIndexOf("."));
   try{
  	 
  	 BufferedImage img2=ImageIO.read(new File(x));
  	 

	   ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write( img2, "jpg", baos );
		baos.flush();

		//BufferedImage scaledImg = Scalr.resize(img2, Method.QUALITY, 150, 100);
		
		BufferedImage thumbnail = Scale.crop(img2, 150, 100);

		//BufferedImage scaledImg2 = Scalr.crop(src, width, height, ops);

		//BufferedImage thumbnail = Scalr.resize(img2, Scalr.Method.SPEED, Scalr.Mode.FIT_TO_WIDTH, 150, 100, Scalr.OP_ANTIALIAS);
		
    // ByteArrayInputStream  out = .new ByteArrayInputStream(newImageData);
     
  	ImageIO.write(thumbnail, "jpg", new File(name+"_"+"scalr1"+".jpg"));
  	System.out.println("Done!");
  	 
}catch (Exception mex) {
   mex.printStackTrace();
}
}
       

   
   
}
