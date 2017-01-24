package com.vydya.theschool.web.servlets.imageServlets;

import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.HttpRequestHandler;

import com.vydya.theschool.common.dto.GalleryData;
import com.vydya.theschool.common.dto.GalleryImageData;
import com.vydya.theschool.common.dto.HomePageImageData;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.services.api.home.EventGalleryService;
import com.vydya.theschool.services.api.home.HomePageImageService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;

@Component("staticImageServlet")
public class staticImagesServlet implements HttpRequestHandler {

	private static final int DEFAULT_BUFFER_SIZE = 1048576; // 10KB.
	
	@Autowired
	private EventGalleryService eventService;
	
	@Autowired(required=true)
	public SchoolAdminProperties properties;
	
	@Autowired
	protected HomePageImageService homePageImageService;
	
	private String STATIC_ORG = "simg-org/";
	/*private String STATIC_FIT = "simg-fit/";
	private String[] AllowedSizes= {"185x125","107x72"};*/
	private static byte[] orginalImage =null;
	private String staticDataUrl = "/staticData";
	
	private String[] staticUrlData ={"simg-fit","simg-fix","185x125","107x72","213x130","96x68","117x155","352x140","262x140","203x137","96x120","302x180"};
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
    	
    }

    // Helpers (can be refactored to public utility class) ----------------------------------------

    private static void close(Closeable resource) {
        if (resource != null) {
            try {
                resource.close();
            } catch (IOException e) {
                // Do your thing with the exception. Print it, log it or mail it.
                e.printStackTrace();
            }
        }
    }

    
	@Override
	public void handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

      String url = request.getRequestURI();
      String imageName = url.substring(url.lastIndexOf("/")+1);
      
		if (imageName == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			return;
		}
		String file = properties.getLocalPathForDBdata()+staticDataUrl+"/"+url.substring(url.indexOf("/static/")+8);
		if(checkfile(file)){
			
			load(file,imageName,response);
		}
		else{
			if(orginalExists(imageName)){
				create(url,file,imageName,response);
			}
			else{
				response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			}
			
		}
		
	}
	
	private void load(String filepath, String imageName,
			HttpServletResponse response) {

		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		response.setContentType("image/jpeg");
		
		FileInputStream fileInputStream = null;
		
		File file = new File(filepath);
		byte[] imageBlob = new byte[(int) file.length()];
		try {
            //convert file into array of bytes
	    fileInputStream = new FileInputStream(file);
	    fileInputStream.read(imageBlob);
	    fileInputStream.close();
 
        }catch(Exception e){
        	e.printStackTrace();
        }
        
        
        response.setContentLength(imageBlob.length);
		response.setHeader("Content-Disposition", "inline; filename=\""
				+ imageName + "\"");

		// Prepare streams.
		BufferedOutputStream output = null;

		try {
			// Open streams.
			output = new BufferedOutputStream(response.getOutputStream(),
					DEFAULT_BUFFER_SIZE);
			// Write file contents to response.
			output.write(imageBlob);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// Gently close streams.
			close(output);
		}
		
	}

	private static boolean checkfile(String url) {
		String path = url;
		File f = new File(path);
		if(f.exists()){
			return true;
		}
		else return false;
	}
	
	private boolean orginalExists(String imageName) {
		String path = properties.getLocalPathForDBdata()+staticDataUrl+"/"+STATIC_ORG+imageName;
		String path2 = properties.getLocalPathForDBdata()+staticDataUrl+"/stfile-org/"+imageName;
		
		ByteArrayOutputStream baos = null;
		File f = new File(path);
		File f2 = new File(path2);
		boolean existed =false;
		try{
		if(f.exists()){
			
			 BufferedImage image=ImageIO.read(f);
		 	   	 baos = new ByteArrayOutputStream();
		 		ImageIO.write( image, "jpg", baos );
		 		baos.flush();
		 		orginalImage = baos.toByteArray();
		 		existed = true;
		}
		else if(f2.exists()){
			
			 BufferedImage image=ImageIO.read(f2);
		 	   	 baos = new ByteArrayOutputStream();
		 		ImageIO.write( image, "jpg", baos );
		 		baos.flush();
		 		orginalImage = baos.toByteArray();
		 		existed = true;
		}
		else existed = false;
		
	 }catch (Exception mex) {
	 	    mex.printStackTrace();
	 	 }
		close(baos);
		return existed;
	}

	private void create(String url, String file, String imageName,HttpServletResponse response) throws IOException {
		
		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		response.setContentType("image/jpeg");
		byte[] imageBlob = orginalImage;
		String suburl =  url.substring(url.indexOf("/static/")+8);
		String subf = suburl.substring(0, suburl.lastIndexOf("/"));
		//String path =  file.substring(0, file.lastIndexOf("/"));
		try{
			String[] folders = subf.split("/");
			boolean validFolder = false;
			if(folders.length==2){
				for(String f:folders){
					if(Arrays.asList(staticUrlData).contains(f)){
						validFolder = true;
					}
					else {
						validFolder = false;
						break;
					}
				}
			}
			else{
				//not allowed to create new folder
			}
			if(validFolder){
				//if(subf.contains("/t")){
					String[] size = folders[1].split("x");//subf.substring(url.indexOf("/t")+2).split("x");
					imageBlob = ImageUtil.resizeImageThumb(imageBlob,Integer.parseInt(size[1]) , Integer.parseInt(size[0]));
					createInLocal(file,imageBlob);
					response.setContentLength(imageBlob.length);
					response.setHeader("Content-Disposition", "inline; filename=\""+ imageName + "\"");
					BufferedOutputStream output = null;
					try {
						// Open streams.
						output = new BufferedOutputStream(response.getOutputStream(),
								DEFAULT_BUFFER_SIZE);
						// Write file contents to response.
						output.write(imageBlob);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} finally {
						// Gently close streams.
						close(output);
					}
			}
		
		
		
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			e.printStackTrace();
		} catch (IOException e) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			e.printStackTrace();
		}
		
		
	}

	private static void createInLocal(String file, byte[] imageBlob) throws IOException {
		OutputStream out = null; 
		String path =  file.substring(0, file.lastIndexOf("/"));
		//String fullDir = path.substring(0, path.lastIndexOf("\\"));
		File f = new File(path);
		if(!f.exists()){
			f.mkdirs();
		}
		try {
		     out = new BufferedOutputStream(new FileOutputStream(file));
		    out.write(imageBlob);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(out);
		    //if (out != null) out.close();
		}
	}

	

}