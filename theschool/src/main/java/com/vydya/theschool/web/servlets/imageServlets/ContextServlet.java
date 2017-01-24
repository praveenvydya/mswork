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


@Component("contextServlet")
public class ContextServlet implements HttpRequestHandler {

   
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
		//String imagec=null;
      String url = request.getRequestURI();
      //String imageName = url.substring(url.lastIndexOf("/")+1);
      
      String fileurl = url.substring(url.lastIndexOf("context/")+8);
      
      url = url.substring(url.lastIndexOf("/context/"));
      String[] u =  fileurl.split("/");
       String folder = u[0];
       String fileNmae = u[1];
       
      
		// Check if ID is supplied to the request.
		if (fileNmae == null||!checkfileInLocal(url)) {
			// Do your thing if the ID is not supplied to the request.
			// Throw an exception, or send 404, or show default/warning image,
			// or just ignore it.
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			return;
		}
		else
			loadImageFromLocal(url,fileNmae,folder,response);
		
	}
	
	private void loadImageFromLocal(String url, String imageName,String folder,
			HttpServletResponse response) {

		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		response.setContentType("image/jpeg");
		
		FileInputStream fileInputStream = null;
		String path = properties.getLocalPathForDBdata()+"/staticData"+File.separator+url;
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
		
		String path = properties.getLocalPathForDBdata()+"/staticData"+url;
		File f = new File(path);
		if(f.exists()){
			return true;
		}
		else return false;
		
	}


}