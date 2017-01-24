package com.vydya.theschool.web.servlets.imageServlets;

import java.io.Closeable;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.HttpRequestHandler;

import com.vydya.theschool.common.dto.AttachmentData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.dataaccess.entities.Attachment;
import com.vydya.theschool.services.api.common.ContentService;
import com.vydya.theschool.services.api.common.MenuService;
import com.vydya.theschool.services.api.home.HomePageImageService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;
import com.vydya.theschool.web.constants.WebConstants;


@Component("fileServlet")
public class AttachmentServlet implements HttpRequestHandler {

   
	private static final long serialVersionUID = 1L;

	private final static Logger logger = Logger.getLogger(AttachmentServlet.class.getName());
	private static final int DEFAULT_BUFFER_SIZE = 1048576;
	private String STATIC_FILE_ORG = "stfile-org/";
	private String staticDataUrl = "/staticData";
	private String STATIC_FILE_MENU = "stfile-menu/";
	
	@Autowired
	protected ContentService attachService;
	
	@Autowired(required=true)
	public SchoolAdminProperties properties;
	
	@Autowired
	protected MenuService  menuService;
	
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
			downloadFile(url,response);
	}
	
	private void downloadFile(String url,
		HttpServletResponse response) throws IOException {
		AttachmentData at = null;
		InputStream in =null;
		
		String fileUrl = url.substring(url.lastIndexOf("/")+1);
		String[] f = fileUrl.split("\\.");
		try {
			if(url.contains("/m/"))
			{
					String path = properties.getLocalPathForDBdata()+staticDataUrl+"/"+STATIC_FILE_MENU+fileUrl;
					 in = new FileInputStream(path);
					at = menuService.getAttachmentsByUrl(fileUrl);
			}
			else if(url.contains("/c/"))
			{
				String path = properties.getLocalPathForDBdata()+staticDataUrl+"/"+STATIC_FILE_ORG+fileUrl;
				 in = new FileInputStream(path);
				at = attachService.getAttachmentsByUnid(f[0]);
		}
		} catch (ServiceException e) {
		} 
		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		response.setHeader("Content-Disposition", "attachment;filename=\""+at.getName()+"."+f[1]+"\"");
		response.setHeader("Content-Type", f[1]);
		//response.setContentType(at.getType());
		//response.setContentLength(at.getAttachementBlob().length);
		IOUtils.copy(in, response.getOutputStream());
		//FileCopyUtils.copy(in, response.getOutputStream());
		 in.close();
         response.getOutputStream().flush();
         response.getOutputStream().close();  
		
	}


	
	

}