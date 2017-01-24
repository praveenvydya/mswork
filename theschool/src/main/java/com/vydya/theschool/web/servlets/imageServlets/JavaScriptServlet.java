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

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.HttpRequestHandler;

import com.vydya.theschool.web.servlets.imageServlets.ImageServlet.Utype;

@Component("javaScriptServlet")
public class JavaScriptServlet implements HttpRequestHandler {

	private static final int DEFAULT_BUFFER_SIZE = 1048576; // 10KB.
	private static final String JS_PATH = "D:/myschool/mysys/jboss-5.1.0.GA/server/school/deploy/stvydya.war/javascript";
	
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
		Utype utype=null;
      String url = request.getRequestURI();
      String f = request.getParameter("f");
      String fileName = url.substring(url.lastIndexOf("/")+1);
      loadJS(f,response);
		
		
	}
	
	private void loadJS(String fileName,
			HttpServletResponse response) throws IOException {

		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		response.setContentType("image/jpeg");
		
		FileInputStream fileInputStream = null;
		String path = JS_PATH+File.separator+fileName;
		File file = new File(path);
		String data = FileUtils.readFileToString(file, "UTF-8");
		byte[] fbyte = new byte[(int) file.length()];
		try {
            //convert file into array of bytes
	    fileInputStream = new FileInputStream(file);
	    fileInputStream.read(fbyte);
	    fileInputStream.close();
 
        }catch(Exception e){
        	e.printStackTrace();
        }
        
        response.setContentLength(fbyte.length);
		response.setHeader("Content-Disposition", "inline; filename=\""
				+ fileName + "\"");

		// Prepare streams.
		BufferedOutputStream output = null;

		try {
			// Open streams.
			output = new BufferedOutputStream(response.getOutputStream(),
					DEFAULT_BUFFER_SIZE);
			// Write file contents to response.
			output.write(fbyte);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// Gently close streams.
			close(output);
		}
		
	}

	private boolean checkfileInLocal(String url) {
		String path = JS_PATH;
		File f = new File(path);
		if(f.exists()){
			return true;
		}
		else return false;
	}


}