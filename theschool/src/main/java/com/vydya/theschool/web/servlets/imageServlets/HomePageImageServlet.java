package com.vydya.theschool.web.servlets.imageServlets;

import java.io.BufferedOutputStream;
import java.io.Closeable;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.HttpRequestHandler;

import com.vydya.theschool.common.dto.HomePageImageData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.home.HomePageImageService;

@Component("homePageImageServlet")
public class HomePageImageServlet implements HttpRequestHandler {

	private static final long serialVersionUID = 1L;
	private static final int DEFAULT_BUFFER_SIZE = 1048576; 
	//private static final String SCHOOL_IMAGE = "SCL";

	@Autowired
	private HomePageImageService homePageImageService;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

	}

	private static void close(Closeable resource) {
		if (resource != null) {
			try {
				resource.close();
			} catch (IOException e) {
				// Do your thing with the exception. Print it, log it or mail
				// it.
				e.printStackTrace();
			}
		}
	}

	@Override
	public void handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String imageId = request.getParameter("id");

		// Check if ID is supplied to the request.
		if (imageId == null) {
			// Do your thing if the ID is not supplied to the request.
			// Throw an exception, or send 404, or show default/warning image,
			// or just ignore it.
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			return;
		}

		// Lookup Image by ImageId in database.
		// Do your "SELECT * FROM Image WHERE ImageID" thing.

		// Image image = imageDAO.find(imageId);
		HomePageImageData homePageImage = null;

		/*try {
			// content = cmsPageDao.findById(Integer.parseInt(imageId));
			homePageImage = homePageImageService.getImage(Integer.parseInt(imageId));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// Check if image is actually retrieved from database.
		if (homePageImage == null) {
			// Do your thing if the image does not exist in database.
			// Throw an exception, or send 404, or show default/warning image,
			// or just ignore it.
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			return;
		}

		// Init servlet response.
		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		response.setContentType("image/jpeg");
		response.setContentLength(homePageImage.getImageBlob().length);
		response.setHeader("Content-Disposition", "inline; filename=\""
				+ homePageImage.getImageName() + "\"");

		// Prepare streams.
		BufferedOutputStream output = null;

		try {
			// Open streams.
			output = new BufferedOutputStream(response.getOutputStream(),
					DEFAULT_BUFFER_SIZE);

			// Write file contents to response.
			output.write(homePageImage.getImageBlob());
		} finally {
			// Gently close streams.
			close(output);
		}*/

	}

}