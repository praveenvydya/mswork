/*package com.vydya.theschool.web.admin.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.EventData;
import com.vydya.theschool.common.dto.EventImageData;
import com.vydya.theschool.common.dto.EventImageSearch;
import com.vydya.theschool.common.dto.ReferenceData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.home.EventService;
import com.vydya.theschool.web.constants.WebConstants;

@Controller
public class AdminCommonController {

	private final static Logger logger = Logger
			.getLogger(HomePageController.class.getName());

	@Autowired
	protected EventService eventService;
	@Autowired
	protected ReferenceDataService referenceDataService;

	
	@RequestMapping(value = WebConstants.LOADALL_EVENTIMAGES)
	public  @ResponseBody List<EventImageData> loadAllEventImages(
			ModelMap model,
			@ModelAttribute(value = "eventForm") EventData eventData,
			SessionStatus status) {
		List<EventImageData> eventImageList = new ArrayList<EventImageData>();
		try {
			EventImageSearch event = new EventImageSearch();
			event.setEventId(eventData.getId());
			eventImageList = eventService.loadAllEventImagesByEventSearch(event);
			//model.addAttribute("eventImageForm", new EventImageData());
			//model.addAttribute("eventImageSearchForm", new EventImageSearch());
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
			return eventImageList;
		} catch (ServiceException e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
		return eventImageList;
		} catch (Exception e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
			return eventImageList;
		}
	}


	@RequestMapping(value = "uploadImage.htm", method = RequestMethod.POST)
	public String uploadImage(
			@ModelAttribute(value = "eventImageForm") EventImageData eventImageData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {
		
		try {
			MultipartFile file = eventImageData.getFiles()[0];
			String imageName = file.getOriginalFilename();
			
			byte[] filebyte = file.getBytes(); 


			eventImageData.setImageName(imageName);
			eventImageData.setInsertedby("vydya");
			eventImageData.setLastmodifiedby("vydya");

			eventImageData.setImageBlob(filebyte);
			eventImageData.setImageType(file.getContentType());
			//homePageImage.setSize(size);
			eventImageData.setSize("");
			eventImageData.setStatus(1);
			eventService.saveEventImage(eventImageData);
			
			EventImageSearch eventImageSearch = new EventImageSearch();
			eventImageSearch.setEventId(eventImageData.getEventId());
			EventData eventData = new EventData();
			eventData.setId(eventImageData.getEventId());
			model.addAttribute("eventForm", eventData);
			model.addAttribute("eventImageForm", eventImageData);
			model.addAttribute("eventImageSearchForm", eventImageSearch);
			
			//return WebConstants.REDIRECT_VIEW_EVENT_IMAGES;
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9001);
			return WebConstants.VIEW_NAME_ADD_EVENT_IMAGES;
			
		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			model.addAttribute("eventImageForm", eventImageData);
			//model.addAttribute("eventForm", eventData);
			try {
				
			} catch (ServiceException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9002);
			return WebConstants.VIEW_NAME_ADD_EVENT_IMAGES;
		}
	}
	

}*/