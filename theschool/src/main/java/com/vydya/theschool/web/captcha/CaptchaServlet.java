
package com.vydya.theschool.web.captcha;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.vydya.theschool.web.constants.WebConstants;


public abstract class CaptchaServlet extends HttpServlet {
	private static Logger log = Logger.getLogger(CaptchaServlet.class.getName());
	private static final long serialVersionUID = 1L;
	protected abstract String getType();

	protected abstract String getContentType();

	protected abstract byte[] generate(CaptchaImage image) throws Exception;

	public void init(ServletConfig servletConfig) throws ServletException {
		log.debug("Calling init method");
		super.init(servletConfig);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			log.debug("Calling doGet method");
            CaptchaImage image = new CaptchaImage(); 
            byte[] bytes = generate(image);
        	HttpSession session = request.getSession();
        	session.setAttribute(WebConstants.SESSION_CAPTCHA_TEXT, image.getCaptchaText());
        	writeBytes(response, bytes);

		} catch (Throwable cause) {
			log("error generating " + getType() + " CAPTCHA: " + cause, cause);
		    sendNoCache(response);
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}

	
	protected void writeBytes(HttpServletResponse response, byte[] bytes) throws IOException {
		try {
			response.setContentType(getContentType());
			response.setContentLength(bytes.length);
			log.debug("Lenth before writing to response" + bytes.length);
			OutputStream out = response.getOutputStream();
			log.debug("contentType" + response.getContentType());
			out.write(bytes);
			out.flush();
		}
		finally
		{
		}
	}

	private void sendNoCache(HttpServletResponse response) {
		if (getType().equalsIgnoreCase("image")) {
			response.setHeader("Cache-Control", "no-store");
			response.setHeader("Pragma", "no-cache");
		}
		response.setDateHeader("Expires", 0);
	}
	
	



}
