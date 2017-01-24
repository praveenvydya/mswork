package com.vydya.theschool.web.controllers.home;

import java.io.IOException;
import java.util.ArrayList;
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

import com.vydya.theschool.common.dto.TopStudentData;
import com.vydya.theschool.common.dto.ToppersGroupData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.home.ManageToppersService;
import com.vydya.theschool.web.constants.WebConstants;

@Controller
public class ToppersController {

	private final static Logger logger = Logger
			.getLogger(ToppersController.class.getName());

	@Autowired
	protected ManageToppersService toppersService;

	

	@RequestMapping(value ="/toppers", method = RequestMethod.GET)
	public String viewAllToppersGroups( 
			ModelMap model,ServletRequest request,
			SessionStatus status) {
		List<ToppersGroupData> toppersGroupList = new ArrayList<ToppersGroupData>();
		try {
			String year = request.getParameter("y");
			if(year==null){
				year = TSDateUtil.getCurrentYear();
			}
			toppersGroupList = toppersService.fetchAllToppersGroups(year);
			model.addAttribute("toppersGroupList", toppersGroupList);
			
			return WebConstants.VIEWNAME_TOPPERS;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_TOPPERS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_TOPPERS;
		}
	}
	
	@RequestMapping(value = "/toppers/{groupName}", method = RequestMethod.GET)
	public String topStudents(@PathVariable("groupName") String groupName, ModelMap model,HttpServletResponse response) throws IOException {
		
		ToppersGroupData group = new ToppersGroupData();
		try {
			group  = toppersService.getToppersGroupByName(groupName);
			List<TopStudentData> toppersList = toppersService.getTopStudentsByToppersId(group.getId(),null);
			model.addAttribute("topStudentsList", toppersList);
			model.addAttribute("group", group);
			return WebConstants.VIEWNAME_TOPPERS_STUDENTS;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_TOPPERS_STUDENTS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_TOPPERS_STUDENTS;
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