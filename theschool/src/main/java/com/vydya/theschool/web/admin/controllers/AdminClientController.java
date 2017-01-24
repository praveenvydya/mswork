package com.vydya.theschool.web.admin.controllers;

import java.util.List;

import javax.servlet.ServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.ClientData;
import com.vydya.theschool.common.dto.SessionBoxData;
import com.vydya.theschool.services.api.common.ClientService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;

@Controller
public class AdminClientController {

	private final static Logger logger = Logger
			.getLogger(AdminClientController.class.getName());

	@Autowired
	protected ClientService clientService;
	
	@Autowired
	protected ReferenceDataService referenceDataService;

	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	
	@RequestMapping(value = WebConstants.VIEW_CLIENTS, method = RequestMethod.GET)
	public String viewAllEvents(
			ModelMap model, ServletRequest request,
			@ModelAttribute(value = "clientForm") ClientData clientData,
			SessionStatus status) {
			
		try {
			
			List<ClientData> clients = clientService.loadAllClients();
			List<SessionBoxData> sessions = clientService.loadAllSessions();
			
			model.addAttribute("sessionslist", sessions);
			model.addAttribute("clientsList", clients);
			//model.addAttribute("clientForm", new ClientData());
			return WebConstants.VIEW_NAME_VIEW_CLIENTS;
		}  catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_CLIENTS;
		}
	}
	
	
	@RequestMapping(value = WebConstants.DELETE_CLIENT , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteClient(
			ModelMap model,
			@ModelAttribute(value = "clientForm") ClientData clientData,
			SessionStatus status) {
		AjaxResponse ajaxRes = new AjaxResponse();
		try {
			if(null!=clientData.getId()){
				clientService.deleteClient(clientData.getId());
				ajaxRes.setSuccess(true);
				ajaxRes.setMessage("Count Deleted.");
			}
		} 
		catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to Clear Clount");
		}
		return ajaxRes;
	}
	
	
	
	
	
	
}