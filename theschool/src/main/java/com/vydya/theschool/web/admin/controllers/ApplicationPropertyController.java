
package com.vydya.theschool.web.admin.controllers;

import java.util.List;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.vydya.theschool.common.dto.AdminProperty;
import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.Properties;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.AdminPropertiesService;
import com.vydya.theschool.web.constants.WebConstants;


@Controller 
public class ApplicationPropertyController {
	

	public ApplicationPropertyController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Autowired
	protected AdminPropertiesService applicationProperties;
	
	@RequestMapping(value = WebConstants.VIEW_PROPERTIES_ACTION)
	public String viewAll(ModelMap model,@ModelAttribute(value = "properties") Properties prop, SessionStatus status) {
		Properties properties = new Properties();
		try{
		
			//List<AdminProperty> propList = applicationProperties.getAllProperties();	
			//model.addAttribute("properties", propList);
		return WebConstants.VIEW_NAME_VIEW_PROPERTIES;
		}
		
		catch (Exception e) {
			model.addAttribute("properties", properties);
			return WebConstants.VIEW_NAME_VIEW_PROPERTIES;
		}
		 
	}
	
	
	@RequestMapping(value =  "admin/manageProperties/view.htm")
	public  @ResponseBody
	String view(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {
		Properties properties = new Properties();
		String response = "";
		ObjectMapper mapper = new ObjectMapper();
		
		try{
		List<AdminProperty> propList = applicationProperties.getAllProperties();		
		JSONObject jsonOb = new JSONObject(jsonString);
			response = mapper.writeValueAsString(propList);

		return response;
	} catch (ServiceException e) {
		
		return response;
	} catch (Exception e) {
		e.printStackTrace();
		return response;
	}
	}
	
	
	@RequestMapping(value = "admin/manageProperties/edit.htm")
	public  @ResponseBody AjaxResponse edit(@RequestBody String jsonString, HttpServletResponse response,HttpSession session, SessionStatus status){
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		AdminProperty prop = null;
	  try {
		  		prop = mapper.readValue(jsonString, AdminProperty.class);
		  		applicationProperties.save(prop, userName);
				aresponse.setSuccess(true);
				if(aresponse.isSuccess()){
					aresponse.setRespData(prop);
					aresponse.setMessage("Successfully Updated Property.");
				}
	 } catch (Exception e) {
	     e.printStackTrace();
	 }
	  return aresponse;
	  
	}
	
	/*@RequestMapping(value = WebConstants.SAVE_PROPERTIES_ACTION)
	public String saveAll(ModelMap model,@ModelAttribute(value = "properties") Properties prop,HttpSession session, SessionStatus status){
		try
		{
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		
		List<AdminProperty> propList = prop.getPropertyList();
		applicationProperties.saveAll(propList, userName);
		session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE, ErrorConstants.TS_4023);
		return WebConstants.FORWARD_VIEW_PROPERTIES;
		}
		catch (ServiceException e) {	
			return WebConstants.FORWARD_VIEW_PROPERTIES;
		}
		catch (Exception e) {
			return WebConstants.FORWARD_VIEW_PROPERTIES;
		}
	}
	*/
	@RequestMapping(value = WebConstants.RELOAD_PROPERTIES_ACTION)
	public @ResponseBody AjaxResponse add(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {     
		AjaxResponse aresponse = new AjaxResponse();
	  try {
		  		applicationProperties.reloadProperties();
				aresponse.setSuccess(true);
				if(aresponse.isSuccess()){
					aresponse.setMessage("All Properties reloaded.");
				}
				 return aresponse;
		}
		catch (ServiceException e) {
			aresponse.setSuccess(false);
			aresponse.setMessage(e.getErrorMessage());
			return aresponse;
		}
		catch (Exception e) {
			aresponse.setSuccess(false);
			aresponse.setMessage(e.getMessage());
			return aresponse;
		}
	 
	}
	
}