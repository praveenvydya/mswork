package com.vydya.theschool.web.controllers.home;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.vydya.theschool.common.dto.GalleryData;
import com.vydya.theschool.common.dto.GalleryImageData;
import com.vydya.theschool.common.dto.GalleryVideoData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.home.EventGalleryService;
import com.vydya.theschool.web.constants.WebConstants;

@Controller
public class EventGalleryController {

	private final static Logger logger = Logger
			.getLogger(EventGalleryController.class.getName());

	@Autowired
	protected EventGalleryService galleryService;

/*	@RequestMapping(value ="school/viewFirstGallery.htm")
	public @ResponseBody List<GalleryData>  viewFirstGallery(
			ModelMap model,
			SessionStatus status) {
		List<GalleryData> eventList = new ArrayList<GalleryData>();
		try {
			GallerySearch eventSearch = new GallerySearch() ;
			eventSearch.setMaxResults(3);
			eventList = galleryService.listAllGalleriesBySearch(eventSearch);
			return eventList; 
		} catch (ServiceException e) {
			return eventList;
		} catch (Exception e) {
			return eventList; 
		}
	}
*/
	

	@RequestMapping(value ="/gallery", method = RequestMethod.GET)
	public String viewAllEvents( 
			ModelMap model,ServletRequest request,
			SessionStatus status) {
		
		try {
			String year = request.getParameter("y");
			if(year==null){
				year = TSDateUtil.getCurrentYear();
			}
			List<GalleryData> galleryList = galleryService.loadAllGalleries(year);
			model.addAttribute("galleryList", galleryList);
			
			
			//model.addAttribute("galleryImageForm", new EventImageSearch());
			return WebConstants.VIEWNAME_GALLERY;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_GALLERY;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_GALLERY;
		}
	}
	
	@RequestMapping(value = "/gallery/{galleryName}", method = RequestMethod.GET)
	public String eventImages(@PathVariable("galleryName") String galleryName, ModelMap model,HttpServletResponse response) throws IOException {
		
		GalleryData gallery = new GalleryData();
		try {
			gallery  = galleryService.getGalleryByUrl(galleryName);
			List<GalleryImageData> galleryImageList = galleryService.getGalleryImagesByGalleryId(gallery.getId());
			model.addAttribute("galleryImageList", galleryImageList);
			
			List<GalleryVideoData> galleryVideosList = galleryService.getGalleryVideosByGalleryId(gallery.getId());
			model.addAttribute("galleryVideosList", galleryVideosList);
			
			model.addAttribute("gallery", gallery);
			return WebConstants.VIEWNAME_GALLERY_IMAGES;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_GALLERY;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_GALLERY;
		}
	
	}
	
	
/*	@RequestMapping(value ="school/viewEventImages.htm")
	public String viewEventsImages(@ModelAttribute(value = "galleryImageForm") GalleryImageSearch eventImageSearch,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {
		
		try {
			List<GalleryImageData> eventImageList = galleryService.loadAllGalleryImagesByGallerySearch(eventImageSearch);
			model.addAttribute("eventImageList", eventImageList);
			return WebConstants.VIEWNAME_GALLERY_IMAGES;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_GALLERY;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_GALLERY;
		}
	}
*/

}