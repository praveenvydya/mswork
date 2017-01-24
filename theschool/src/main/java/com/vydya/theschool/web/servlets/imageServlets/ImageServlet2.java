package com.vydya.theschool.web.servlets.imageServlets;

import java.io.BufferedOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.HttpRequestHandler;

import com.vydya.theschool.common.dto.GalleryData;
import com.vydya.theschool.common.dto.GalleryImageData;
import com.vydya.theschool.common.dto.HomePageImageData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.dataaccess.entities.HomePageImage;
import com.vydya.theschool.services.api.home.EventGalleryService;
import com.vydya.theschool.services.api.home.HomePageImageService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;


//@Component("imageServlet")
public class ImageServlet2 implements HttpRequestHandler {

   
	private static final long serialVersionUID = 1L;

	private static final int DEFAULT_BUFFER_SIZE = 1048576; // 10KB.
	
	@Autowired
	private EventGalleryService eventService;
	
	@Autowired(required=true)
	public SchoolAdminProperties properties;
	
	@Autowired
	protected HomePageImageService homePageImageService;
	
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

		// Get ID from request.
      //String imageId = request.getParameter("id");
		String imagec=null;
      String url = request.getRequestURI();
      String imageName = url.substring(url.lastIndexOf("/")+1);
      
      if(null!=url){
    	  imagec = defineCat(url);
      }
      
		// Check if ID is supplied to the request.
		if (imageName == null) {
			// Do your thing if the ID is not supplied to the request.
			// Throw an exception, or send 404, or show default/warning image,
			// or just ignore it.
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			return;
		}

		if(checkfileInLocal(url)){
			
			loadImageFromLocal(url,imageName,response);
		}
		else{
			loadImage(url,imagec,response);
		}
		
		
	}
	
	private void loadImageFromLocal(String url, String imageName,
			HttpServletResponse response) {

		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		response.setContentType("image/jpeg");
		
		FileInputStream fileInputStream = null;
		String path = properties.getLocalPathForDBdata()+File.separator+url;
		File file = new File(path);
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

	private boolean checkfileInLocal(String url) {
		
		String path = properties.getLocalPathForDBdata()+url;
		File f = new File(path);
		if(f.exists()){
			return true;
		}
		else return false;
		
	}

	private void loadImage(String url, String imagec,HttpServletResponse response) {

		/*String imageName = url.substring(url.lastIndexOf("/")+1);
		 
		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		response.setContentType("image/jpeg");
		byte[] imageBlob = null;
		
		String subp = url.substring(0, url.lastIndexOf("/"));
		String path = properties.getLocalPathForDBdata()+subp+File.separator+imageName;
		
		
		try {
		if(imagec.equalsIgnoreCase("gallery-image-full")){
			GalleryImageData galleryImage = null;
			
				// content = cmsPageDao.findById(Integer.parseInt(imageId));
				//galleryImage = eventService.getGalleryImage(Integer.parseInt(imageId));
				galleryImage = eventService.getGalleryImageByName(imageName);
				if (galleryImage == null) {
					// Do your thing if the image does not exist in database.
					// Throw an exception, or send 404, or show default/warning image,
					// or just ignore it.
					response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
					return;
				}
			
				imageBlob = galleryImage.getImageBlob();
				
				createInLocal(path,imageBlob);
			}
		else if(imagec.equalsIgnoreCase("gallery-image-thumb")){
			GalleryImageData galleryImage = null;
			
				// content = cmsPageDao.findById(Integer.parseInt(imageId));
				//galleryImage = eventService.getGalleryImage(Integer.parseInt(imageId));
				galleryImage = eventService.getGalleryImageByName(imageName);
				if (galleryImage == null) {
					// Do your thing if the image does not exist in database.
					// Throw an exception, or send 404, or show default/warning image,
					// or just ignore it.
					response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
					return;
				}
				
				imageBlob = ImageUtil.resizeImageThumb(galleryImage.getImageBlob(), 125, 185);
				createInLocal(path,imageBlob);
			}
		else if(imagec.equalsIgnoreCase("gallery-header-full")){
			GalleryData galleryImage = null;
			
				// content = cmsPageDao.findById(Integer.parseInt(imageId));
				//galleryImage = eventService.getGalleryImage(Integer.parseInt(imageId));
			String name = imageName.substring(0, imageName.lastIndexOf("."));
				galleryImage = eventService.getGalleryByUrl(name);
				if (galleryImage == null) {
					// Do your thing if the image does not exist in database.
					// Throw an exception, or send 404, or show default/warning image,
					// or just ignore it.
					response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
					return;
				}
				imageBlob = galleryImage.getGalleryImage();
				createInLocal(path,imageBlob);
			}
		else if(imagec.equalsIgnoreCase("gallery-header-thumb")){
			GalleryData galleryImage = null;
			
			// content = cmsPageDao.findById(Integer.parseInt(imageId));
			//galleryImage = eventService.getGalleryImage(Integer.parseInt(imageId));
			String name = imageName.substring(0, imageName.lastIndexOf("."));
			galleryImage = eventService.getGalleryByUrl(name);
			if (galleryImage == null) {
				// Do your thing if the image does not exist in database.
				// Throw an exception, or send 404, or show default/warning image,
				// or just ignore it.
				response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
				return;
			}
				imageBlob = ImageUtil.resizeImageThumb(galleryImage.getGalleryImage(), 125, 185);
				createInLocal(path,imageBlob);
			}
		
		else if(imagec.equalsIgnoreCase("BHF")){
			HomePageImageData homeImage = null;
			
			homeImage = homePageImageService.getByName(imageName);
			if (homeImage == null) {
				// Do your thing if the image does not exist in database.
				// Throw an exception, or send 404, or show default/warning image,
				// or just ignore it.
				response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
				return;
			}
				imageBlob = homeImage.getImageBlob();
				createInLocal(path,imageBlob);
			}
		else if(imagec.equalsIgnoreCase("BHT")){
			HomePageImageData homeImage = null;
			
			homeImage = homePageImageService.getByName(imageName);
			if (homeImage == null) {
				// Do your thing if the image does not exist in database.
				// Throw an exception, or send 404, or show default/warning image,
				// or just ignore it.
				response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
				return;
			}
				imageBlob = ImageUtil.getFixedImageWidth(homeImage.getImageBlob(), 185);
				createInLocal(path,imageBlob);
			}
		
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
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
		}*/
	}

	private void createInLocal(String path, byte[] imageBlob) throws IOException {
		
		OutputStream out = null; 
		String fullDir = path.substring(0, path.lastIndexOf("\\"));
		File f = new File(fullDir);
		
		if(!f.exists()){
			f.mkdirs();
		}
		
		try {
		     out = new BufferedOutputStream(new FileOutputStream(path));
		    out.write(imageBlob);
		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
		    if (out != null) out.close();
		}
		
	}

	private static String defineCat(String url) {

		String cat = "";
		if(url.contains("/g/ht/")){
			cat = "gallery-header-thumb";
		}
		else if(url.contains("/g/at/")){
			cat = "gallery-image-thumb";
		}
		else if(url.contains("/g/hf/")){
			cat = "gallery-header-full";
		}
		else if(url.contains("/g/af/")){
			cat = "gallery-image-full";
		}
		else if(url.contains("/t/ht/")){
			cat = "THT"; //topper-header-thumb
		}
		else if(url.contains("/t/hf/")){
			cat = "THF";
		}
		else if(url.contains("/banners/home/af")){
			cat = "BHF";
		}
		else if(url.contains("/banners/home/at")){
			cat = "BHT";
		}
          
         return cat; 
}

}