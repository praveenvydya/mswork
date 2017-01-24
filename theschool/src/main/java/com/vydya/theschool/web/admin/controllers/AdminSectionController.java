package com.vydya.theschool.web.admin.controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.constants.TSConstants;
import com.vydya.theschool.common.dto.GalleryData;
import com.vydya.theschool.common.dto.GalleryImageData;
import com.vydya.theschool.common.dto.Report;
import com.vydya.theschool.common.dto.Section;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.types.RoleType;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.permisions.ManageSectionService;
import com.vydya.theschool.services.api.user.UserCredentialsService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.validator.SectionValidator;

@Controller
public class AdminSectionController {
	private static final Logger log = Logger.getLogger(AdminSectionController.class.getName());

	SectionValidator sectionValidator;

	@Autowired
	public AdminSectionController(SectionValidator sectionValidator) {
		this.sectionValidator = sectionValidator;
	}

	@Autowired
	protected UserCredentialsService credentialsService;
	
	@Autowired
	protected ManageSectionService manageSectionService;

	

	public AdminSectionController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**Add scenario
	 * This method binds the command object to the model
	 * This method is used to invoke validator with the  provided details if no errors occurs invokes 
	 * the service method after execution returns next tiles view to display,if errors occurs returns 
	 * to the same view	
	 * @param 
	 * @return 
	 */   
	@RequestMapping(value = WebConstants.ADD_SECTION_ACTION)
	public String addProcess(ModelMap model,
			@ModelAttribute(value = "section") Section section,
			BindingResult result, HttpSession session, SessionStatus status) {
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		
		List<Report> reportsList = null;
		String userName = null;		
		if (null != session.getAttribute(WebConstants.SESSION_USER_NAME)){
			userName = (String) session
					.getAttribute(WebConstants.SESSION_USER_NAME);
		}
		if ((null != section) && (null != section.getActionName())
				&& (TSConstants.ADDVIEW.equals(section.getActionName()))) {

			log.debug("New Section initialised");
			Section sec = new Section();
			try {
				reportsList = manageSectionService.getAvailableReports();


				model.addAttribute("section", sec);
				model.addAttribute("reportsList", reportsList);

			}
			catch (ServiceException e) {
					model.addAttribute("reportsList", reportsList);
					model.addAttribute("section", sec);					
					String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
					result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));					
					return WebConstants.VIEW_NAME_ADD_SECTION;
			} 
			catch (Exception e) {
					String msg = ctx.getMessage(ErrorConstants.TS_2010,new Object[] { }, locale);
					ApplicationException exp = new ApplicationException( e.getMessage(),e);
					log.error(exp,e);
					model.addAttribute("reportsList", reportsList);
					model.addAttribute("section", sec);
					result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));				
				return WebConstants.VIEW_NAME_ADD_SECTION;
			}
			return WebConstants.VIEW_NAME_ADD_SECTION;
		} 
		else {
			

			try {
				reportsList = manageSectionService.getAvailableReports();
				model.addAttribute("reportsList", reportsList);
				sectionValidator.validate(section, result);
				if (result.hasErrors())
				{
					model.addAttribute("section", section);
					// if validator failed
					log.debug("section data having errors");
					return WebConstants.VIEW_NAME_ADD_SECTION;
				}
				
				manageSectionService.createSection(section, userName);
				updateSession(session);
				model.addAttribute("section", section);
				model.addAttribute(WebConstants.SESSION_SUCCESS_MESSAGE, ErrorConstants.TS_2012);
						
			} catch (ServiceException e) {	
				String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
				model.addAttribute("reportsList", reportsList);	
				log.error("******************************");
				log.error("Error Code :"+e.getErrorCode());
				if(ErrorConstants.TS_2003.equals(e.getErrorCode()))
				    result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));
				else
					result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));
				return WebConstants.VIEW_NAME_ADD_SECTION;
				
			} catch (Exception e) {
				String msg = ctx.getMessage(ErrorConstants.TS_2010,new Object[] { }, locale);
				ApplicationException exp = new ApplicationException( e.getMessage(),e);
				log.error(exp,e);
				model.addAttribute("reportsList", reportsList);
				result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));			
				return WebConstants.VIEW_NAME_ADD_SECTION;
			}			

			return WebConstants.FORWARD_VIEW_SECTIONS;
		}
	}
	
	private void updateSession(HttpSession session) throws ServiceException {
		List<Section> sectionList =  credentialsService.getUserPermissions((RoleType)session.getAttribute(WebConstants.SESSION_USER_ROLE_TYPE),(Integer)session.getAttribute(WebConstants.SESSION_USER_ROLE_ID));
		Collections.sort(sectionList);
		session.setAttribute(WebConstants.SESSION_USER_ROLE_PERMISSIONS, sectionList);
		
	}

	/**Search scenario
	 * This method to get all the Sectionos which matches the search criteria
	 *	adds them to the model
	 * @param 
	 * @return 
	 */   
	
	
	public @ResponseBody
	String ajaxGet(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		log.debug("Manage Section initialised");
		String response = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			JSONObject jsonOb = new JSONObject(jsonString);
			String action = (String) jsonOb.get("a");
			if ("A".equalsIgnoreCase(action)) {
				List<Section> sectionList = new ArrayList<Section>();
				sectionList = manageSectionService.getSectionList();
				response = mapper.writeValueAsString(sectionList);
			}
			else if("S".equalsIgnoreCase(action)){
				Integer sectionId = (Integer) jsonOb.get("SID");
			}
			return response;
		} catch (ServiceException e) {
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return response;
		}
	}
	

	
	@RequestMapping(value = WebConstants.VIEW_ALL_SECTIONS_ACTION)
	public String viewSections(ModelMap model,@ModelAttribute(value = "section") Section sec,
			BindingResult result,  HttpSession session) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		log.debug("Manage Section initialised");
		Section section = new Section();
		try {

			List<Section> sectionList = new ArrayList<Section>();
			sectionList = manageSectionService.getSectionList();
			model.addAttribute("section", section);
			model.addAttribute("sectionsList", sectionList);
		
		} 
		
		catch (Exception e) {
			String msg = ctx.getMessage(ErrorConstants.TS_2010,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			log.error(exp,e);
			model.addAttribute("section", section);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));
			return WebConstants.VIEW_NAME_VIEW_SECTIONS;
		}
		return WebConstants.VIEW_NAME_VIEW_SECTIONS;
	}

	
	
	
	public String initManageSection(ModelMap model,@ModelAttribute(value = "section") Section sec,
			BindingResult result,  HttpSession session) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		log.debug("Manage Section initialised");
		Section section = new Section();
		List<Section> sectionList = new ArrayList<Section>();
		try {

			sectionList = manageSectionService.getSectionList();
			
			log.debug("Manage Section initialised sectionList "
					+ sectionList.size());
			if(sectionList.size()==0)
				result.reject(ErrorConstants.TS_2016);
			model.addAttribute("sectionsList", sectionList);
			model.addAttribute("section", section);
		
		} 
		catch (ServiceException e) {			
			log.error(TSConstants.DATAACCESSERROR, e);
			model.addAttribute("sectionsList", sectionList);
			model.addAttribute("section", section);
			String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
			result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));			
			return WebConstants.VIEW_NAME_VIEW_SECTIONS;
		} 
		catch (Exception e) {
			String msg = ctx.getMessage(ErrorConstants.TS_2010,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			log.error(exp,e);
			model.addAttribute("sectionsList", sectionList);
			model.addAttribute("section", section);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));
			return WebConstants.VIEW_NAME_VIEW_SECTIONS;
		}
		return WebConstants.VIEW_NAME_VIEW_SECTIONS;
	}

	/**Edit scenario
	 * This method gets the selected sectionId from the model with respective reports
	 * This method is used to invoke validator with the  provided details if no errors occurs invokes 
	 * the service method after execution returns next tiles view to display,if errors occurs returns 
	 * to the same view	
	 * @param 
	 * @return 
	 */   
	@RequestMapping(value = WebConstants.EDIT_SECTION_ACTION)
	public String editProcess(ModelMap model,
			@ModelAttribute(value = "section") Section section,
			BindingResult result, HttpSession session, SessionStatus status) {
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		List<Report> reportsList = null;
		String userName = null;
	
		if (null != session.getAttribute(WebConstants.SESSION_USER_NAME))
			userName = (String) session
					.getAttribute(WebConstants.SESSION_USER_NAME);
		try {
			reportsList = manageSectionService.getAvailableReports();
			if ((null != section)
					&& (null != section.getActionName())
					&& (TSConstants.EDITVIEW.equals(section.getActionName()))) {
				log.debug("editProcess Selected SectionID " + section.getSelectedSectionId());
				if ((null != section.getSelectedSectionId())
						&& (!section.getSelectedSectionId().isEmpty()))
					section = manageSectionService.getSection(Integer.parseInt(section.getSelectedSectionId()));		
				model.addAttribute("section", section);
				model.addAttribute("reportsList", reportsList);
				model.addAttribute("reportsSelectedList",
						section.getReportsSelectedList());

				return WebConstants.VIEW_NAME_EDIT_SECTION;
				
			} 
			else {
				reportsList = manageSectionService.getAvailableReports();				
				sectionValidator.validate(section, result);
				if (result.hasErrors()) {
					populateEditData(section,model,reportsList);					
					log.debug("section data having errors");
					return WebConstants.VIEW_NAME_EDIT_SECTION;
				}
				log.debug("Edit Section getSectionId  " + section.getSectionId());
				manageSectionService.updateSection(section, userName);	
				updateSession(session);
				section.setActionName("");
				model.addAttribute(WebConstants.SESSION_SUCCESS_MESSAGE, ErrorConstants.TS_2013);
				return WebConstants.FORWARD_VIEW_SECTIONS;
			}
		} 
		catch (ServiceException e) {
			try{
				populateEditData(section,model,reportsList);	
			}catch (ServiceException e1) {}
			 String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
				if(ErrorConstants.TS_2003.equals(e.getErrorCode()))	
				    result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));
				else
					result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));		
				return WebConstants.VIEW_NAME_EDIT_SECTION;
			
		} 
		catch (Exception e)
		{
			String msg = ctx.getMessage(ErrorConstants.TS_2010,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			log.error(exp,e);
			try{
				populateEditData(section,model,reportsList);	
			}catch (ServiceException e1) {}
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));
			return WebConstants.VIEW_NAME_EDIT_SECTION;
		}
	}
	
	private void populateEditData(Section section,ModelMap model,List<Report> reportsList) throws  ServiceException{
		
		Section sec = manageSectionService.getSection(section.getSectionId());		
		model.addAttribute("section", section);
		model.addAttribute("reportsList", reportsList);
		model.addAttribute("reportsSelectedList",
				sec.getReportsSelectedList());
	}

	/**Delete scenario
	 * This method gets the selected sectionId from the model with respective reports
	 * This method is used to invoke validator with the  provided details if no errors occurs invokes 
	 * the service method after execution returns next tiles view to display,if errors occurs returns 
	 * to the same view	
	 * @param 
	 * @return 
	 */   	
	@RequestMapping(value = WebConstants.DELETE_SECTION_ACTION)
	public String initDeleteSection(
			@ModelAttribute(value = "section") Section section,
			BindingResult result, HttpSession session, SessionStatus status,
			ModelMap model) {
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);

		log.debug("Delete Section getSectionId GET initialised "
				+ section.getSelectedSectionId());
		String userName = null;
		if (null != session.getAttribute(WebConstants.SESSION_USER_NAME))
			userName = (String) session
					.getAttribute(WebConstants.SESSION_USER_NAME);
		try {

			manageSectionService.deleteSection(section.getSelectedSectionId(),
					userName);
			manageSectionService.reorderSection(section.getReorderedIds(),
					userName);
			updateSession(session);
			model.addAttribute(WebConstants.SESSION_SUCCESS_MESSAGE, ErrorConstants.TS_2014);

		} catch (ServiceException e) {
			String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
			result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));	
			 return WebConstants.FORWARD_VIEW_SECTIONS;
		} catch (Exception e) {
			String msg = ctx.getMessage(ErrorConstants.TS_2010,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			log.error(exp,e);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));	
			 return WebConstants.FORWARD_VIEW_SECTIONS;
		}
		return WebConstants.FORWARD_VIEW_SECTIONS;
	}

	/**Reorder scenario
	 * This method gets the selected sectionId with respective reports from the model 
	 * This method is used to invoke validator with the  provided details if no errors occurs invokes 
	 * the service method after execution returns next tiles view to display,if errors occurs returns 
	 * to the same view	
	 * @param 
	 * @return 
	 */   	
	@RequestMapping(value = WebConstants.REORDER_SECTION_ACTION)
	public String reOrderSection(
			@ModelAttribute(value = "section") Section section,
			BindingResult result, HttpSession session, SessionStatus status,
			ModelMap model) {
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);

		log.debug("Reorder Section getSectionId GET initialised "
				+ section.getReorderedIds());
		String userName = null;
		if (null != session.getAttribute(WebConstants.SESSION_USER_NAME))
			userName = (String) session
					.getAttribute(WebConstants.SESSION_USER_NAME);
		try
		{
			manageSectionService.reorderSection(section.getReorderedIds(),userName);	
			updateSession(session);
			model.addAttribute(WebConstants.SESSION_SUCCESS_MESSAGE, ErrorConstants.TS_2015);
		} 
		catch (ServiceException e)
		{
			String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
			result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));		
			return WebConstants.FORWARD_VIEW_SECTIONS;
		}
		catch (Exception e) {
			String msg = ctx.getMessage(ErrorConstants.TS_2010,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			log.error(exp,e);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));
			 return WebConstants.FORWARD_VIEW_SECTIONS;
		}
		return WebConstants.FORWARD_VIEW_SECTIONS;
	}

}