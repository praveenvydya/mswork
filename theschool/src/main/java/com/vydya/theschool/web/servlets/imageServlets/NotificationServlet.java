package com.vydya.theschool.web.servlets.imageServlets;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.Closeable;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.HttpRequestHandler;

import com.vydya.theschool.common.dto.AttachmentData;
import com.vydya.theschool.common.dto.NotificationData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.NotificationService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;


@Component("notificationServlet")
public class NotificationServlet implements HttpRequestHandler {

   
	private static final long serialVersionUID = 1L;

	private final static Logger logger = Logger.getLogger(NotificationServlet.class.getName());
	private static final int DEFAULT_BUFFER_SIZE = 1048576;
	
	
	@Autowired(required=true)
	public SchoolAdminProperties properties;
	
	@Autowired
	protected NotificationService  notificationService;
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
    	
    }


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
      String fileurl = url.substring(url.lastIndexOf("/")+1);
      
		if (fileurl == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			return;
		}
		
		try {
			NotificationData 	nt = notificationService.getNotificationByUrl(fileurl);
			downloadFile(nt,response);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		
		
	}
	
	private void downloadFile(NotificationData nt,
			HttpServletResponse response) throws IOException {

		
		 BufferedInputStream in = null;
         ByteArrayInputStream bis = new ByteArrayInputStream(nt.getData());
		 in = new BufferedInputStream(bis);
         
		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		response.setHeader("Content-Disposition", "inline;filename=\""+nt.getUrl()+"\"");
		response.setHeader("Content-Type", nt.getContentType());
		response.setContentLength(nt.getData().length);
		
		IOUtils.copy(in, response.getOutputStream());
		//FileCopyUtils.copy(in, response.getOutputStream());
		 in.close();
         response.getOutputStream().flush();
         response.getOutputStream().close();  

	}


	

}