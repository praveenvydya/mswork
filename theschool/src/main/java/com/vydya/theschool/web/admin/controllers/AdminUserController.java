package com.vydya.theschool.web.admin.controllers;

import java.util.List;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.Group;
import com.vydya.theschool.common.dto.Role;
import com.vydya.theschool.common.dto.User;
import com.vydya.theschool.common.dto.UserSearch;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.types.RoleType;
import com.vydya.theschool.services.api.user.ManageUserService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.validator.UserValidator;


@Controller 
public class AdminUserController
{
	
	private final static Logger logger = Logger.getLogger(AdminUserController.class.getName());
	
	@Autowired
	protected UserValidator userValidator;	
	@Autowired
	protected ManageUserService manageUsersService;
	
	
	public AdminUserController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@RequestMapping(value = WebConstants.VIEW_USERS_ACTION)
	public String viewAll(ModelMap model,SessionStatus status) {

		try {
			return WebConstants.VIEW_NAME_VIEW_USERS;

		} catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_USERS;
		}
	}
	
	
	@RequestMapping(value = "admin/manageUsers/load.htm")
	public @ResponseBody
	String load(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		String response = "";
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		try {
			RoleType roleType = (RoleType)session.getAttribute(WebConstants.SESSION_USER_ROLE_TYPE);
			Integer roleId = (Integer)session.getAttribute(WebConstants.SESSION_ADMIN_ROLE_ID);		
			Integer groupId = (Integer)session.getAttribute(WebConstants.SESSION_USER_GROUP_ID);
			JSONObject jsonOb = new JSONObject(jsonString);
			
			String type = (String) jsonOb.get("t");
			
			if(null!=type && type.equalsIgnoreCase("v")){// tyep validation
				String param = (String) jsonOb.get("p");// parameter 
				String val = (String) jsonOb.get("val"); //value 
				boolean isExisted = false;
				isExisted =	manageUsersService.isUserAvailable(val, param);
				aresponse.setSuccess(true);
				aresponse.setValid(isExisted);
				response = mapper.writeValueAsString(aresponse);
				return response;
			}
			
			if(null!=type && type.equalsIgnoreCase("g")){
				List<Group> groupList = (List<Group>)session.getAttribute("userGroups");
				if(null==groupList || groupList.size()==0){
					groupList = manageUsersService.getUserGroupsByAdminGroupId(roleType,groupId);
				}
				response = mapper.writeValueAsString(groupList);
			}
			else if(null!=type && type.equalsIgnoreCase("ur")){
				List<Role> userRoleList= (List<Role>)session.getAttribute("userRoles");
				if(null==userRoleList || userRoleList.size()==0){
					userRoleList = manageUsersService.getUserRolesByAdminRole(roleType,roleId);
				}
				response = mapper.writeValueAsString(userRoleList);
			}
			if(null!=type && type.equalsIgnoreCase("ar")){
				List<Role> adminRoleList= (List<Role>)session.getAttribute("adminRoles");
				if(null==adminRoleList || adminRoleList.size()==0){
					 adminRoleList = manageUsersService.getAdminRolesByAdminRole(roleType,roleId);
				}
				response = mapper.writeValueAsString(adminRoleList);
			}
			return response;
		} catch (ServiceException e) {
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return response;
		}
	}
	
	
	@RequestMapping(value = "admin/manageUsers/view.htm")
	public @ResponseBody
	String view(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		String response = "";
		ObjectMapper mapper = new ObjectMapper();
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		try
		{	UserSearch userSearch = new UserSearch(); 	
			RoleType roleType = (RoleType)session.getAttribute(WebConstants.SESSION_USER_ROLE_TYPE);
			Integer roleId = (Integer)session.getAttribute(WebConstants.SESSION_ADMIN_ROLE_ID);
			Integer groupId = (Integer)session.getAttribute(WebConstants.SESSION_USER_GROUP_ID);
			String loginUserName = (String)session.getAttribute(WebConstants.SESSION_USER_NAME);
			userSearch.setLocale(locale);
			userSearch.setLoginUserName(loginUserName);
			userSearch.setLoginUserGroupId(groupId);
			userSearch.setLoginUserAdminRoleId(roleId);
			userSearch.setLoginUserRoleType(roleType);
			
			JSONObject jsonOb = new JSONObject(jsonString);
			List<User> userList = manageUsersService.getEntitiesByCriteria(userSearch);
				response = mapper.writeValueAsString(userList);

			return response;
		} catch (ServiceException e) {
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return response;
		}
	}
	
	
	@RequestMapping(value = "admin/manageUsers/add.htm", method = RequestMethod.POST)
	public @ResponseBody AjaxResponse add(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {                 

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		User user = null;
	  try {
		  		JSONObject jsonOb = new JSONObject(jsonString);
		  		user = mapper.readValue(jsonString, User.class);
				manageUsersService.createUser(user,userName);
		  		
				aresponse.setSuccess(true);
				if(aresponse.isSuccess()){
					aresponse.setRespData(user);
					aresponse.setMessage("Successfully added User.");
				}
	 } catch (Exception e) {
	     e.printStackTrace();
	 }
	  return aresponse;
}
	
	@RequestMapping(value = "admin/manageUsers/edit.htm", method = RequestMethod.POST)
	public @ResponseBody AjaxResponse edit(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {                 

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		User user = null;
	  try {
		  //JSONObject jsonOb = new JSONObject(jsonString);
		  		user = mapper.readValue(jsonString, User.class);
		  		//userValidator.validate(user, result);
		  		
		  		User ud = new User();
		  		ud.setFirstName(user.getFirstName());
		  		ud.setLastName(user.getLastName());
		  		ud.setStatus(user.getStatus());
		  		ud.setGroupId(user.getGroupId());
		  		ud.setRoleId(user.getRoleId());
		  		ud.setEmail(user.getEmail());
		  		ud.setAdminRoleId(user.getAdminRoleId());
		  		
		  		hasPermissionOnUser(session,user);
				if(user.isDisabled())
				{
					aresponse.setSuccess(false);
					aresponse.setRespData(user);
					aresponse.setMessage("You cannot perform edit on this user.");
				}
				else{
					manageUsersService.updateUser(user,userName);
					aresponse.setSuccess(true);
					aresponse.setRespData(user);
					aresponse.setMessage("Successfully added User.");
				}
				
				
	 } catch (Exception e) {
		 aresponse.setSuccess(false);
			aresponse.setMessage(e.getMessage());
	     e.printStackTrace();
	     
	 }
	  return aresponse;
}
	

	@RequestMapping(value = "admin/manageUsers/resetPassword.htm", method = RequestMethod.POST)
	public @ResponseBody AjaxResponse resetPassword(@RequestBody String jsonString, HttpServletResponse response,HttpSession session,BindingResult result) {                 

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		User user = null;
	  try {
		  //JSONObject jsonOb = new JSONObject(jsonString);
		  		user = mapper.readValue(jsonString, User.class);
		  		hasPermissionOnUser(session,user);
		  		if(user.isDisabled())
				{
					aresponse.setSuccess(false);
					aresponse.setRespData(user);
					aresponse.setMessage("You cannot reset this user.");
				}
				else{
					manageUsersService.resetUserPassword(user,userName);
				}
				//manageUsersService.updateUser(user,userName);
				
				
				aresponse.setSuccess(true);
				if(aresponse.isSuccess()){
					aresponse.setRespData(user);
					aresponse.setMessage("Successfully Saved Gallery.");
				}
	 } catch (Exception e) {
	     e.printStackTrace();
	 }
	  return aresponse;
}
	
	
	
	@RequestMapping(value = WebConstants.DELETE_USER_ACTION , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteGallery(@RequestBody String jsonString,
			ModelMap model,HttpServletRequest request,HttpSession session,
			SessionStatus status) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse ajaxRes = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
			try {
				JSONObject jsonOb = new JSONObject(jsonString);
				User user = null;
				user = mapper.readValue(jsonString, User.class);
				hasPermissionOnUser(session,user);
		  		if(user.isDisabled())
				{
		  			ajaxRes.setSuccess(false);
		  			ajaxRes.setRespData(user);
		  			ajaxRes.setMessage("You cannot reset this user.");
				}
		  		else{
		  			manageUsersService.deleteUserDeatils(user,userName);
					ajaxRes.setSuccess(true);
					ajaxRes.setMessage("User Deleted.");
		  		}
				
		} 
		catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to delete Group");
		}
			return ajaxRes;
	}
/*
	@RequestMapping(value=WebConstants.VIEW_USERS_ACTION)
	public String showUserList(@ModelAttribute(value = "userSearch")UserSearch userSearch,BindingResult result,ModelMap model,HttpSession session,HttpServletResponse  response) 
	{
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		try
		{		
			RoleType roleType = (RoleType)session.getAttribute(WebConstants.SESSION_USER_ROLE_TYPE);
			Integer roleId = (Integer)session.getAttribute(WebConstants.SESSION_ADMIN_ROLE_ID);
			Integer groupId = (Integer)session.getAttribute(WebConstants.SESSION_USER_GROUP_ID);
			String loginUserName = (String)session.getAttribute(WebConstants.SESSION_USER_NAME);
			userSearch.setLocale(locale);
			userSearch.setLoginUserName(loginUserName);
			userSearch.setLoginUserGroupId(groupId);
			userSearch.setLoginUserAdminRoleId(roleId);
			userSearch.setLoginUserRoleType(roleType);
			if(exportUtil.isExportRequest(userSearch))
			{
				exportUtil.genarateExportData(userSearch, manageUsersService,response);		
				return null;
			}
			else
			{
				paginationUtil.genaratePagination(userSearch,model,manageUsersService);
			}
			List<User> userList = manageUsersService.getEntitiesByCriteria(userSearch);
			model.addAttribute("searchResults", userList);		
			model.addAttribute("userSearch", userSearch);
			model.addAttribute("user", new User());
			return WebConstants.VIEW_NAME_VIEW_USERS;
		}
		catch(ServiceException e)
		{
			model.addAttribute("userSearch", userSearch);
			String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
			result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));			
			return WebConstants.VIEW_NAME_VIEW_USERS;
		}
		catch (Exception e) 
		{
			String msg = ctx.getMessage(ErrorConstants.TS_5013,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			logger.error(exp,e);
			model.addAttribute("userSearch", userSearch);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));			
			return WebConstants.VIEW_NAME_VIEW_USERS;
		}
	}
	
	*/
	
	/*@RequestMapping(value=WebConstants.ADD_USER_ACTION)
	public String addUser(@ModelAttribute("user")User user,BindingResult result,ModelMap model,HttpSession session) 
	{
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		try
		{
			logger.debug("add user screen");
			populateUserScreenSeededData(model,session);
			model.addAttribute("user", user);
			return WebConstants.VIEW_NAME_ADD_USER;
		}
		catch (ServiceException e) 
		{	
			String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
			result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));					
			return WebConstants.VIEW_NAME_ADD_USER;
		}  
		catch (Exception e)
		{
			String msg = ctx.getMessage(ErrorConstants.TS_5013,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			logger.error(exp,e);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));
			return WebConstants.VIEW_NAME_ADD_USER;
		}
	}


	@RequestMapping(value=WebConstants.ADD_USER_ACTION,method = RequestMethod.POST)
	public String saveUser(@ModelAttribute("user")User user,BindingResult result,HttpSession session,ModelMap model)
	{
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		logger.debug("Saving user details");
		try 
		{
			userValidator.validate(user, result);
			if (result.hasErrors()) 
			{
				logger.debug("user data having errors");
				populateUserScreenSeededData(model,session);
				return WebConstants.VIEW_NAME_ADD_USER;
			}
			String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
			manageUsersService.createUser(user,userName);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE ,ErrorConstants.TS_5015);
			return WebConstants.REDIRECT_VIEW_USERS;
		} 
		catch (ServiceException e) 
		{
			try 
			{
				populateUserScreenSeededData(model,session);
			}catch (ServiceException e1) {}
			if(ErrorConstants.TS_5009.equals(e.getErrorCode()))
			{
				String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
				result.rejectValue("userName","",msg);
			}
			else if(ErrorConstants.TS_5020.equals(e.getErrorCode()))
			{
				String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
				result.rejectValue("email","",msg);
			}
			else
			{
				String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
				result.rejectValue("error","",msg);	
			}
			return WebConstants.VIEW_NAME_ADD_USER;
		} 
		catch (Exception e) 
		{
			try 
			{
				populateUserScreenSeededData(model,session);
			} catch (ServiceException e1) {}
			String msg = ctx.getMessage(ErrorConstants.TS_5013,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			logger.error(exp,e);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));				
			return WebConstants.VIEW_NAME_ADD_USER;
		}		
	}

	*/
/*
	@RequestMapping(value=WebConstants.EDIT_USER_ACTION,method = RequestMethod.POST)
	public String updateUser(@ModelAttribute("user")User user,BindingResult result,HttpSession session,ModelMap model,ServletRequest request)
	{
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String action  = request.getParameter("actionName");
		if("view".equals(action))
		{
			logger.debug("loading user details");
			try
			{
				user = manageUsersService.getUserDetails(user.getUserId());
				populateUserScreenSeededData(model,session);
				hasPermissionOnUser(model,user);
				if(user.isDisabled())
				{
					session.setAttribute(WebConstants.SESSION_ALERT_MESSAGE ,ErrorConstants.TS_5019);
				}
				user.setAction("Edit");
				model.addAttribute("user", user);
				return WebConstants.VIEW_NAME_EDIT_USER;
			}
			catch (ServiceException e) 
			{	
				String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
				result.rejectValue("error","",msg);				
				return WebConstants.VIEW_NAME_EDIT_USER;
			}
			catch (Exception e)
			{
				String msg = ctx.getMessage(ErrorConstants.TS_5013,new Object[] { }, locale);
				ApplicationException exp = new ApplicationException( e.getMessage(),e);
				logger.error(exp,e);
				result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));
				return WebConstants.VIEW_NAME_EDIT_USER;
			}
		}
		else
		{
			String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
			logger.debug("Saving user details");
			try 
			{
				userValidator.validate(user, result);
				if (result.hasErrors())
				{
					populateUserScreenSeededData(model,session);
					logger.debug("user data having errors");
					return WebConstants.VIEW_NAME_EDIT_USER;
				}
				manageUsersService.updateUser(user,userName);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE ,ErrorConstants.TS_5016);
				return WebConstants.REDIRECT_VIEW_USERS;
			} 
			catch (ServiceException e) 
			{				
				try 
				{
					populateUserScreenSeededData(model,session);
				} catch (ServiceException e1) {}
				if(ErrorConstants.TS_5009.equals(e.getErrorCode()))
				{
					String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
					result.rejectValue("userName","",msg);
				}
				else if(ErrorConstants.TS_5020.equals(e.getErrorCode()))
				{
					String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
					result.rejectValue("email","",msg);
				}
				else
				{
					String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
					result.rejectValue("error","",msg);
				}
				
				return WebConstants.VIEW_NAME_EDIT_USER;
			} 
			catch (Exception e)
			{
				try 
				{
					populateUserScreenSeededData(model,session);
				} catch (ServiceException e1) {}
				String msg = ctx.getMessage(ErrorConstants.TS_5013,new Object[] { }, locale);
				ApplicationException exp = new ApplicationException( e.getMessage(),e);
				logger.error(exp,e);
				result.rejectValue("error","",msg);			
				return WebConstants.VIEW_NAME_EDIT_USER;
			}
		}
	}
	
	

	@RequestMapping(value=WebConstants.DELETE_USER_ACTION)
	public String deactivateUser(@ModelAttribute("user")User user,BindingResult result,HttpSession session,ModelMap model) 
	{
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		try
		{
			String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
			manageUsersService.deleteUserDeatils(user,userName);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE ,ErrorConstants.TS_5017);
			logger.debug("deleting user details");
			return WebConstants.REDIRECT_VIEW_USERS;
		}	 
		catch (ServiceException e) 
		{	
			String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
			result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));					
			return WebConstants.REDIRECT_VIEW_USERS;
		} 
		catch (Exception e) 
		{
			String msg = ctx.getMessage(ErrorConstants.TS_5013,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			logger.error(exp,e);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));				
			return WebConstants.REDIRECT_VIEW_USERS;
		}
	}
	
	@RequestMapping(value=WebConstants.RESET_PASSWORD_ACTION)
	public String resetUserPassword(@ModelAttribute("user")User user,BindingResult result,HttpSession session,ModelMap model) 
	{
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		try
		{
			String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
			manageUsersService.resetUserPassword(user,userName);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE ,ErrorConstants.TS_5018);
			logger.debug("resting user password");
			return WebConstants.REDIRECT_VIEW_USERS;
		}
	 
		catch (ServiceException e)
		{			
			String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
			result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));				
			return WebConstants.REDIRECT_VIEW_USERS;
		} 
		catch (Exception e)
		{
			String msg = ctx.getMessage(ErrorConstants.TS_5013,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			logger.error(exp,e);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));					
			return WebConstants.REDIRECT_VIEW_USERS;
		}
	}*/
	
	
	private void hasPermissionOnUser(HttpSession session, User user)
	{
		boolean isDisabled = true;
		user.setDisabled(true);
		@SuppressWarnings("unchecked")
		List<Role> userRoleList = (List<Role>)session.getAttribute("userRoles");
		for (Role role : userRoleList)
		{			
			if(user.getRoleId() ==role.getRoleId())
			{
				isDisabled = false;
				break;
			}
		}
		@SuppressWarnings("unchecked")
		List<Role> adminRoleList = (List<Role>)session.getAttribute("adminRoles");
		for (Role role : adminRoleList)
		{
			if(Integer.parseInt(user.getAdminRole())==role.getRoleId())
			{
				isDisabled = false;
				break;
			}
		}		
		user.setDisabled(isDisabled);		
	}
}