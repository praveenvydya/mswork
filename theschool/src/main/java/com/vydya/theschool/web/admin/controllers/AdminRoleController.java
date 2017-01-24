
package com.vydya.theschool.web.admin.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.constants.TSConstants;
import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.Role;
import com.vydya.theschool.common.dto.Section;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.types.RoleType;
import com.vydya.theschool.common.util.Ignore;
import com.vydya.theschool.services.api.permisions.ManageRoleService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.validator.RoleValidator;

@Controller
public class AdminRoleController {
	private static final Logger log = Logger.getLogger(AdminRoleController.class.getName());

	RoleValidator roleValidator;

	@Autowired
	public AdminRoleController(RoleValidator roleValidator) {
		this.roleValidator = roleValidator;
	}

	@Autowired
	protected ManageRoleService manageRoleService;

	
	public AdminRoleController() {
		super();
		// TODO Auto-generated constructor stub
	}

	List<Section> sectionList = null;

	
	
	
	@RequestMapping(value = WebConstants.VIEW_ROLES_ACTION)
	public String viewAll(ModelMap model,SessionStatus status) {

		try {
			return WebConstants.VIEW_NAME_VIEW_ROLES;

		} catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_USERS;
		}
	}
	
	
	@RequestMapping(value = "admin/manageRoles/view.htm")
	public @ResponseBody AjaxResponse
	 view(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		String response = "";
		Role role = new Role();
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		JSONObject jo = new JSONObject();
		log.debug("Manage Roles initialised");
		Integer roleId = (Integer) session.getAttribute(WebConstants.SESSION_ADMIN_ROLE_ID);
		RoleType roleType = (RoleType) session.getAttribute(WebConstants.SESSION_USER_ROLE_TYPE);		
		try {
			role.setRoleType(roleType.toString());
			role.setRoleId(roleId);
			
			List<Role> entityList = manageRoleService.getEntitiesByCriteria(role);
			aresponse.setRespData(entityList);
			//jo.put("roles", mapper.writeValueAsString(entityList));
			//jo.put("roledto", mapper.writeValueAsString(role));
			
			aresponse.setRespData2(role);
			
			return aresponse ;
		} catch (ServiceException e) {
			return aresponse;
		} catch (Exception e) {
			e.printStackTrace();
			return aresponse;
		}
	}
	
	
	@RequestMapping(value = "admin/manageRoles/add.htm", method = RequestMethod.POST)
	public @ResponseBody AjaxResponse add(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {                 

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		Role role =  new Role();
		JSONObject jo= null;
	  try {
		  jo = new JSONObject(jsonString);
		  
		  List<Integer> selectedActions = new ArrayList<Integer>();
		 // JSONArray repA = (JSONArray) jo.get("reportActions");
		  				
		/*  for(int i=0;i<repA.length();i++){
			  JSONArray reports =  (JSONArray) repA.getJSONObject(i).get("children");
			  for(int j=0;j<reports.length();j++){
				  JSONArray actions =  (JSONArray) reports.getJSONObject(j).get("children");
				  for(int k=0;k<actions.length();k++){
					  boolean chekd = (Boolean) actions.getJSONObject(k).get("checked");
					  if(chekd)
					  {
						  //add selected report Actions 
						  selectedActions.add((Integer) actions.getJSONObject(k).get("reportActionId"));
					  }
				  }
			  }
			  
		  }*/
		
		 JSONArray actions =  (JSONArray) jo.getJSONArray("selectedReportActions");
		 for(int j=0;j<actions.length();j++){
			 Integer id = (Integer)actions.get(j);
			  selectedActions.add(id);
		  }
		  
		   /* jo.remove("reportActions");
		    jo.remove("selectedReportActions");
		    jo.remove("currentRole");
		    */
		   // role = mapper.readValue(jsonString, Role.class);
		 
		  		role.setSelectedActions(selectedActions);
		  		role.setRoleName((String) jo.get("roleName"));
		  		role.setRoleType((String) jo.get("roleType"));
		  		role.setRoleDescription((String) jo.get("roleDescription"));
		  		role.setStatus((String) jo.get("status"));
		  		
		  		
		  		/*roleValidator.validate(role, result);
				if (result.hasErrors()) {
					//populateData(jo, session, role);						
					log.debug("Role data having errors");
					aresponse.setSuccess(false);
					aresponse.setRespData(jo);
					return aresponse;
				}*/
		  		
		  		
			String roleName = manageRoleService.checkForDuplicateRole(role);
			if((null != roleName)&&(!roleName.isEmpty())){
				StringBuilder errMsg = new StringBuilder().append(roleName).append(TSConstants.DUPLICATE_ROLE_PERMISSION);
				aresponse.setSuccess(false);
				aresponse.setMessage(errMsg.toString());
				aresponse.setRespData(jo);
				return aresponse;
			}
			else{
				manageRoleService.createNewRole(role, userName);
				aresponse.setSuccess(true);
				aresponse.setMessage("Role added successfully");
				return aresponse;
			}
				//manageRoleService.createNewRole(role, userName);
				/*if(Boolean.parseBoolean(role.getUserRoleRequired())){
					role.setRoleName(TSConstants.EMPTY);					
					role.setAdminRoleFlag(TSConstants.IA_ROLE_CREATED);
					role.setUserRoleRequired(TSConstants.FALSE);
					role.setRoleDescription(TSConstants.EMPTY);
					role.setRoleType(RoleType.USER.toString());
					//populateData(jo, session, role);
					aresponse.setSuccess(true);
					aresponse.setMessage("Role added successfully");
					aresponse.setRespData(jo);
					return aresponse;
				}
				else{

				}*/
	 } catch (Exception e) {
	     e.printStackTrace();
	 }
	  return aresponse;
}
	
	
	@RequestMapping(value = "admin/manageRoles/edit.htm", method = RequestMethod.POST)
	public @ResponseBody AjaxResponse edit(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {                 

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		Role role =  new Role();
		JSONObject jo= null;
		  try {
			  jo = new JSONObject(jsonString);
		 
		  List<Integer> selectedActions = new ArrayList<Integer>();
			  JSONArray actions =  (JSONArray) jo.getJSONArray("selectedReportActions");
				 for(int j=0;j<actions.length();j++){
					 Integer id = (Integer)actions.get(j);
					  selectedActions.add(id);
				  }
				 
		  		role.setSelectedActions(selectedActions);
		  		role.setRoleId((Integer) jo.get("roleId"));
		  		role.setRoleName((String) jo.get("roleName"));
		  		role.setRoleType((String) jo.get("roleType"));
		  		role.setRoleDescription((String) jo.get("roleDescription"));
		  		role.setStatus((String) jo.get("status"));
		  //role = mapper.readValue(jsonString, Role.class);
		  		//roleValidator.validate(role, result);
				/*if (result.hasErrors()) {
					//role.setSelectedRoleId(String.valueOf(role.getRoleId()));
					populateData(session, role);
					log.debug("Role data having errors");
					aresponse.setSuccess(false);
					aresponse.setRespData(role);
					return aresponse;
				}*/
				String roleName = manageRoleService.checkForDuplicateRole(role);
				if((null != roleName)&&(!roleName.isEmpty())){
					StringBuilder errMsg = new StringBuilder().append(roleName).append(TSConstants.DUPLICATE_ROLE_PERMISSION);
					aresponse.setSuccess(false);
					aresponse.setMessage(errMsg.toString());
					aresponse.setRespData(role);
					return aresponse;
				}
				else{
					manageRoleService.updateRole(role, userName);	
					aresponse.setSuccess(true);
					aresponse.setMessage("Role updated successfully");
					return aresponse;
				}
				// log.debug("Edit Role getRoleId  "+role.getRoleId());
							
		  		
	 } catch (Exception e) {
	     e.printStackTrace();
	 }
	  return aresponse;
}
	
	/**Delete scenario
	 * This method gets the selected RoleId from the model and deletes the role 
	 *if errors occurs returns 
	 * to the same view	
	 * @param 
	 * @return 
	 */   	
	@RequestMapping(value = "admin/manageRoles/delete.htm")
	public @ResponseBody AjaxResponse delete(@RequestBody String jsonString,
			ModelMap model,HttpServletRequest request,HttpSession session,
			SessionStatus status) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		Role role = null;
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		try {
			role = mapper.readValue(jsonString, Role.class);
			log.debug("Delete Role getRoleId GET initialised "+ role.getRoleId());
			boolean assigned = manageRoleService.isRoleAssigned(role.getRoleId()+"");
			if(assigned){
				aresponse.setSuccess(false);
				aresponse.setMessage("Role can not be deleted as user(s) are assigned to it");
				return aresponse;
			}
			manageRoleService.deleteRole(role.getRoleId()+"",userName);
			aresponse.setSuccess(true);
			aresponse.setMessage("Role deleted");
			return aresponse;

		} catch (Exception e) {
			
			String msg = ctx.getMessage(ErrorConstants.TS_4010,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			log.error(exp,e);
			aresponse.setSuccess(false);
			aresponse.setMessage(msg);
			return aresponse;
		}
	}

	
	
	/**Search scenario
	 * This method to get all the Roles which matches the search criteria
	 *	adds them to the model
	 * @param 
	 * @return 
	 */   
	
	/*
	@RequestMapping(value = WebConstants.VIEW_ROLES_ACTION)
	public String initManageRoles(ModelMap model,@ModelAttribute(value = "role") Role role,
			BindingResult result,  HttpSession session,HttpServletResponse  response) {
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		
		log.debug("Manage Roles initialised");
		Integer roleId = (Integer) session.getAttribute(WebConstants.SESSION_ADMIN_ROLE_ID);
		RoleType roleType = (RoleType) session.getAttribute(WebConstants.SESSION_USER_ROLE_TYPE);		
		try {
			role.setRoleType(roleType.toString());
			role.setRoleId(roleId);
			if(exportUtil.isExportRequest(role))
			{
				exportUtil.genarateExportData(role, manageRoleService,response);	
				return null;
			}
			else
			{
				paginationUtil.genaratePagination(role,model,manageRoleService);
			}
			List<Role> entityList = manageRoleService.getEntitiesByCriteria(role);
			model.addAttribute("searchResults", entityList);		
			log.debug("Manage Roles initialised  ");			
			model.addAttribute("role", role);		
		} 
		catch (ServiceException e) {
			
			log.error(TSConstants.DATAACCESSERROR, e);		
			model.addAttribute("role", role);
			String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
			result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));			
			return WebConstants.VIEW_NAME_VIEW_ROLES;
		} 
		catch (Exception e) {
			
			String msg = ctx.getMessage(ErrorConstants.TS_4010,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			log.error(exp,e);
			model.addAttribute("role", role);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));	
			return WebConstants.VIEW_NAME_VIEW_ROLES;
		}
		return WebConstants.VIEW_NAME_VIEW_ROLES;
	}*/
	
	
	@RequestMapping(value = "admin/manageRoles/load.htm")
	public @ResponseBody
	String load(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		String response = "";
		ObjectMapper mapper = new ObjectMapper();
		Role role = null;
		try {
			JSONObject jsonOb = new JSONObject(jsonString);
			role = mapper.readValue(jsonString, Role.class);
			
			if(null!=role && role.getActionName().equalsIgnoreCase("add")){
				populateData(session, role);	
				return mapper.writeValueAsString(role);
			}
			if(null!=role && role.getActionName().equalsIgnoreCase("edit")){
				
				//role = mapper.readValue(jsonOb.getString("dto"), Role.class);
				populateEditData(session, role);	
				return mapper.writeValueAsString(role);
			}
			/*if(null!=role && role.getActionName().equalsIgnoreCase("ed")){
				role = mapper.readValue(jsonString, Role.class);
				populateEmptyTreeEditData(session, role);	
				return mapper.writeValueAsString(role);
			}
			*/
			
			return mapper.writeValueAsString(role);
		} catch (ServiceException e) {
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return response;
		}
	}
	
	private void populateEditData(HttpSession session,Role role) throws ServiceException 
	{
		Integer roleId = (Integer) session.getAttribute(WebConstants.SESSION_ADMIN_ROLE_ID);
		RoleType roleType = (RoleType) session.getAttribute(WebConstants.SESSION_USER_ROLE_TYPE);
		boolean assigned = manageRoleService.isRoleAssigned(role.getRoleId()+"");
		if(RoleType.PA == roleType){
			sectionList = manageRoleService.getPATreeDetails();
		}else{
			sectionList = manageRoleService.getIATreeOrMenuDetails(roleId,null,false);
		}
		role.setRoleAssigned(assigned);
		 role = manageRoleService.getActionsAssignedToRole(role);
		role.setSections(sectionList.toArray(new Section[sectionList.size()]));		
		if((null == sectionList)||(sectionList.size()==0))
			session.setAttribute(WebConstants.SESSION_ALERT_MESSAGE, ErrorConstants.TS_4026);
	}
	

	private void populateEmptyTreeEditData(HttpSession session,Role role) throws ServiceException 
	{
		Integer roleId = (Integer) session.getAttribute(WebConstants.SESSION_ADMIN_ROLE_ID);
		RoleType roleType = (RoleType) session.getAttribute(WebConstants.SESSION_USER_ROLE_TYPE);
		boolean assigned = manageRoleService.isRoleAssigned(role.getRoleId()+"");
		if(RoleType.PA == roleType){
			sectionList = manageRoleService.getPATreeDetails();
		}else{
			sectionList = manageRoleService.getIATreeOrMenuDetails(roleId,null,false);
		}
		role.setRoleAssigned(assigned);
		if((null == sectionList)||(sectionList.size()==0))
			session.setAttribute(WebConstants.SESSION_ALERT_MESSAGE, ErrorConstants.TS_4026);
		role.setSections(sectionList.toArray(new Section[sectionList.size()]));						
		//model.addAttribute("role", role);		
	}
	//JSONObject jo,
	private void populateData(HttpSession session,Role role) throws ServiceException, JSONException 
	{
		Integer roleId = (Integer) session.getAttribute(WebConstants.SESSION_ADMIN_ROLE_ID);
		RoleType roleType = (RoleType) session.getAttribute(WebConstants.SESSION_USER_ROLE_TYPE);
		
		if(RoleType.PA == roleType){
			sectionList = manageRoleService.getPATreeDetails();
		}else{
			sectionList = manageRoleService.getIATreeOrMenuDetails(roleId,null,false);
		}
		role.setSections(sectionList.toArray(new Section[sectionList.size()]));		
		role.setStatus(TSConstants.EMPTY);
		if((null == sectionList)||(sectionList.size()==0))
			session.setAttribute(WebConstants.SESSION_ALERT_MESSAGE, ErrorConstants.TS_4025);
		//jo.put("role", role);		
	}
	
	/**Add scenario
	 * This method binds the command object to the model
	 * This method is used to invoke validator with the  provided details if no errors occurs invokes 
	 * the service method after execution returns next tiles view to display,if errors occurs returns 
	 * to the same view	
	 * @param 
	 * @return 
	 */   
/*	@RequestMapping(value = WebConstants.ADD_ROLE_ACTION)
	public String addProcess(ModelMap model,
			@ModelAttribute(value = "role") Role role,
			BindingResult result, HttpSession session, SessionStatus status) {		
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);	
		
		if ((null != role) && (TSConstants.ADDVIEW.equals(role.getActionName()))) {

			log.debug("New Role initialised");			
			try {
				populateData(model, session,role);					
				return WebConstants.VIEW_NAME_ADD_ROLE;
			}
			catch (ServiceException e) {
				model.addAttribute("role", role);				
				String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
				result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));
				return WebConstants.VIEW_NAME_ADD_ROLE;							
					
			} 
			catch (Exception e) {
				
				String msg = ctx.getMessage(ErrorConstants.TS_4010,new Object[] { }, locale);
				ApplicationException exp = new ApplicationException( e.getMessage(),e);
				log.error(exp,e);
				model.addAttribute("role", role);				
				result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));			
				return WebConstants.VIEW_NAME_ADD_ROLE;
			}
		} 
		else {
			
			try {
				
				roleValidator.validate(role, result);
				if (result.hasErrors()) {
					populateData(model, session, role);						
					log.debug("Role data having errors");
					return WebConstants.VIEW_NAME_ADD_ROLE;
				}
			String roleName = manageRoleService.checkForDuplicateRole(role);
			if((null != roleName)&&(!roleName.isEmpty())){
				populateData(model, session, role);				
				StringBuilder errMsg = new StringBuilder().append(roleName).append(TSConstants.DUPLICATE_ROLE_PERMISSION);
				result.rejectValue("error",roleName+" "+ErrorConstants.TS_4019 ,errMsg.toString());				
				return WebConstants.VIEW_NAME_ADD_ROLE;
			}
				manageRoleService.createNewRole(role, userName);
				if(Boolean.parseBoolean(role.getUserRoleRequired())){
					role.setRoleName(TSConstants.EMPTY);					
					role.setAdminRoleFlag(TSConstants.IA_ROLE_CREATED);
					role.setUserRoleRequired(TSConstants.FALSE);
					role.setRoleDescription(TSConstants.EMPTY);
					role.setRoleType(RoleType.USER.toString());
					populateData(model, session, role);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE, ErrorConstants.TS_4014);				
				return WebConstants.VIEW_NAME_ADD_ROLE;
				}
				else{
					session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE, ErrorConstants.TS_4024);
				}
				
			} catch (ServiceException e) {	
				String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
				try{
				populateData(model, session, role);
				}
				catch(ServiceException e1){}
					if(ErrorConstants.TS_4003.equals(e.getErrorCode()))									
					result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));
					else
					result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));
					return WebConstants.VIEW_NAME_ADD_ROLE;
				
			} catch (Exception e) {
				try{
				populateData(model, session, role);
				}
				catch(ServiceException e1){}
				String msg = ctx.getMessage(ErrorConstants.TS_4010,new Object[] { }, locale);
				ApplicationException exp = new ApplicationException( e.getMessage(),e);
				log.error(exp,e);
				model.addAttribute("role", role);				
				result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));	
				return WebConstants.VIEW_NAME_ADD_ROLE;
			}			

			return WebConstants.REDIRECT_VIEW_ROLES;
		}
		
	}*/
	
	/**Edit scenario
	 * This method gets the selected Role from the model with respective Entitlements
	 * This method is used to invoke validator with the  provided details if no errors occurs invokes 
	 * the service method after execution returns next tiles view to display,if errors occurs returns 
	 * to the same view	
	 * @param 
	 * @return 
	 */
	/*@RequestMapping(value = WebConstants.EDIT_ROLE_ACTION)	
	public String editProcess(ModelMap model,
			@ModelAttribute(value = "role") Role role,
			BindingResult result, HttpSession session, SessionStatus status) {	
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
			
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		try {
			
			if ((null != role)&&  (TSConstants.EDITVIEW.equals(role.getActionName()))) {
				
				log.debug("editProcess Selected RoleID " + role.getSelectedRoleId());
				if ((null != role.getSelectedRoleId())&& (!role.getSelectedRoleId().isEmpty())){
					
					populateEditData(model, session, role);	
					
				}

				return WebConstants.VIEW_NAME_EDIT_ROLE;
				
			} 
			else {				
				roleValidator.validate(role, result);
				if (result.hasErrors()) {
					role.setSelectedRoleId(String.valueOf(role.getRoleId()));
					populateEmptyTreeEditData(model, session, role);					
					log.debug("Role data having errors");
					return WebConstants.VIEW_NAME_EDIT_ROLE;
				}
				String roleName = manageRoleService.checkForDuplicateRole(role);
				if((null != roleName)&&(!roleName.isEmpty())){
					role.setSelectedRoleId(String.valueOf(role.getRoleId()));
					populateEditData(model, session, role);
					StringBuilder errMsg = new StringBuilder().append(roleName).append(TSConstants.DUPLICATE_ROLE_PERMISSION);
					result.rejectValue("error",roleName+" "+ErrorConstants.TS_4019 ,errMsg.toString());				
					return WebConstants.VIEW_NAME_EDIT_ROLE;
				}
				log.debug("Edit Role getRoleId  "+role.getRoleId());
				manageRoleService.updateRole(role, userName);				
				
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE, ErrorConstants.TS_4015);
				return WebConstants.REDIRECT_VIEW_ROLES;
			}
		} 
		catch (ServiceException e) {
			String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
			try{
				role.setSelectedRoleId(String.valueOf(role.getRoleId()));
			populateEditData(model, session, role);
			}catch(ServiceException e1){}
				if(ErrorConstants.TS_4003.equals(e.getErrorCode()))									
					result.rejectValue("rolename","",msg.concat(String.valueOf(e.getUniqueId())));
				else
					result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));		
				return WebConstants.VIEW_NAME_EDIT_ROLE;
			
		} 
		catch (Exception e)
		{
			try{
				role.setSelectedRoleId(String.valueOf(role.getRoleId()));
				populateEditData(model, session, role);
			}catch(ServiceException e1){}
			String msg = ctx.getMessage(ErrorConstants.TS_4010,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			log.error(exp,e);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));
			return WebConstants.VIEW_NAME_EDIT_ROLE;
		}
	}
*/
	
	
}