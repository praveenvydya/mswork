package com.vydya.theschool.web.servlets.imageServlets;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/app/*")
public class HtmlFilesServlet extends  HttpServlet {

	private static final int DEFAULT_BUFFER_SIZE = 1048576; // 10KB.
	
			
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
    	 String filename = URLDecoder.decode(request.getPathInfo().substring(1), "UTF-8");
         File file = new File("D:/schoolWeb/html", filename);
         response.setHeader("Content-Type", getServletContext().getMimeType(filename));
         response.setHeader("Content-Length", String.valueOf(file.length()));
         response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");
         Files.copy(file.toPath(), response.getOutputStream());
    }

	
}