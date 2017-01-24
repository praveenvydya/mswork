package com.vydya.theschool.web.servlets.imageServlets;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.Closeable;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.HttpRequestHandler;

import com.vydya.theschool.common.dto.AttachmentData;
import com.vydya.theschool.common.dto.BookData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.BookService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;

//@WebServlet("/captcha-generator")
@Component("bookServlet")
public class BookServlet implements HttpRequestHandler {

   
	private static final long serialVersionUID = 1L;

	private static final int DEFAULT_BUFFER_SIZE = 1048576; // 10KB.
	
	@Autowired
	private BookService bookService;
	
	@Autowired(required=true)
	public SchoolAdminProperties properties;
	
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
      String fileurl = url.substring(url.indexOf("books/")+6);
      
     String[] u =  fileurl.split("/");
      String bookUrl = u[2];
      String cat = u[1];
      String type =u[0];
      
		if (fileurl == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			return;
		}
		
		try {
			BookData book = bookService.getBookByCatAndUrl(cat, bookUrl);
			downloadFile(book,response,type);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		
		
	}
	
	private void downloadFile(BookData at,
			HttpServletResponse response,String type) throws IOException {

		/*OutputStream out = null;
		InputStream input = null;
		PrintWriter writer = null;
		BufferedOutputStream bout = null;*/
		
		//try{
		
		 BufferedInputStream in = null;
         ByteArrayInputStream bis = new ByteArrayInputStream(at.getBookBlob());
		 in = new BufferedInputStream(bis);
         
		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		
		if(type.equalsIgnoreCase("r")){
			response.setHeader("Content-Disposition", "inline;filename=\""+at.getUrl()+"\"");
		}
		else{
			response.setHeader("Content-Disposition", "attachment;filename=\""+at.getUrl()+"\"");
		}
		
		
		response.setHeader("Content-Type", at.getType());
		//response.setContentType(at.getType());
		response.setContentLength(at.getBookBlob().length);
		
		IOUtils.copy(in, response.getOutputStream());
		//FileCopyUtils.copy(in, response.getOutputStream());
		 in.close();
         response.getOutputStream().flush();
         response.getOutputStream().close();  
		
	}

}