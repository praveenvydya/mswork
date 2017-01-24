package com.vydya.theschool.web.admin.controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.constants.TSConstants;
import com.vydya.theschool.common.dto.Group;
import com.vydya.theschool.common.dto.Role;
import com.vydya.theschool.common.dto.Section;
import com.vydya.theschool.common.dto.User;
import com.vydya.theschool.common.dto.UserCredentials;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.types.AuthenticationStatus;
import com.vydya.theschool.common.types.ReportType;
import com.vydya.theschool.common.types.RoleType;
import com.vydya.theschool.services.api.user.ManageUserService;
import com.vydya.theschool.services.api.user.UserCredentialsService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.validator.LoginValidator;

@Controller  
public class AdminLoginController {

	private final static Logger log = Logger.getLogger(AdminLoginController.class.getName());
	
	@Autowired
	protected LoginValidator loginValidator;	
	@Autowired
	protected UserCredentialsService credentialsService;
	@Autowired
	protected SchoolAdminProperties properties; 
	
	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	@Autowired
	protected ManageUserService manageUserService;	
	
	Map<String, String> loginUsers = new HashMap<String, String>();
	
	
	@RequestMapping(value="admin/manage/home.htm",method = RequestMethod.GET)
	public String adminHome(ModelMap model,HttpServletRequest request) 
	{
		HttpSession session = request.getSession();
		session.invalidate();
		log.debug("login invoked");
		return "admin.home";
	}
	
	
	@RequestMapping(value="admin/loginModule/login.htm",method = RequestMethod.GET)
	public String initLoginForm(ModelMap model) 
	{
		log.debug("login invoked");
		model.addAttribute("credentials", new UserCredentials());
		return "admin.loginPage";
	}
	
	@RequestMapping(value="admin/loginModule/login.htm",method = RequestMethod.POST)
	public String processSubmit(@ModelAttribute("credentials") UserCredentials user,BindingResult result,HttpServletRequest request,ModelMap model) 
	{		
		try
		{
			HttpSession session = request.getSession();
			ServletContext application = request.getSession().getServletContext();
			
			String userName = user.getUserName().trim().toLowerCase();
			loginValidator.validate(user, result);
			if (result.hasErrors())
			{
				log.debug("login data having errors");
				return "admin.loginPage";
			}
			Integer attempts = getAttempts(session, userName);
			AuthenticationStatus status = credentialsService.authenticate(userName, user.getPassword(),attempts,null);
			log.debug("AuthenticationStatus : " + status);
			switch (status) 
			{
				case INVALID:
					result.rejectValue("error",ErrorConstants.TS_1011);
					break;
				case INACTIVE:
					result.rejectValue("error",ErrorConstants.TS_1011); // show same message due to security concerns don't provide details of reason 
					break;
				case LOCKED:
					session.removeAttribute(user.getUserName());
					result.rejectValue("error",ErrorConstants.TS_1013);
					break;
				case SECURITY_QA_LOCKED:
					session.removeAttribute(user.getUserName());
					result.rejectValue("error",ErrorConstants.TS_1013);
					break;					
				case UNKNOWN:
					result.rejectValue("error",ErrorConstants.TS_1011);
					break;
			}
		
			if (result.hasErrors())
			{
				log.debug("login data having errors");
				return "admin.loginPage";
			} 
			else 
			{
				//AuthenticationStatus VALID
				session.removeAttribute(user.getUserName());
				session.setAttribute(WebConstants.SESSION_USER_NAME, userName);			
				application.setAttribute(WebConstants.SESSION_BUILD_VERSION,properties.getBuildVersion());
				
				localStaticContainer.loadStaticSession(session);
				localStaticContainer.loadStaticData(application);
				switch (status) 
				{
					case FIRST_TIME_LOGIN:
						return "redirect:firstTimeLogin.htm";
						
					case PASSWORD_EXPIRED:
						model.addAttribute("credentials", user);
						return "redirect:changePassword.htm";					
				}	
				
				//load user session session
				Locale userLocale = request.getLocale();
				if(null == userLocale){
					userLocale = Locale.US;
				}
				session.setAttribute(WebConstants.SESSION_USER_LOCALE, userLocale);
				User userData = credentialsService.getUserSessionData(userName,userLocale);
				loginUsers.put(userData.getUserName(), session.getId());
				application.setAttribute("login_users", loginUsers);
				credentialsService.updateLoginStatusFlag(userName,TSConstants.STATUS_LOGIN_YES);
				
				List<Section> sectionList =  credentialsService.getUserPermissions(userData.getRoleType(),Integer.parseInt(userData.getUserRole()));
				Collections.sort(sectionList); 
				String displayName = userData.getUserName()+"&nbsp;("+userData.getFirstName()+"&nbsp;"+userData.getLastName()+")&nbsp;[" + userData.getRoleType() + "]";
				
				session.setAttribute(WebConstants.SESSION_USER_DISPLAY_NAME, displayName);
				session.setAttribute(WebConstants.SESSION_USER_LAST_LOGIN, userData.getLastAccessDate());
				session.setAttribute(WebConstants.SESSION_USER_GROUP_ID, Integer.parseInt(userData.getGroup()));
				session.setAttribute(WebConstants.SESSION_USER_ROLE_TYPE,userData.getRoleType());
				session.setAttribute(WebConstants.SESSION_USER_ROLE_ID, Integer.parseInt(userData.getUserRole()));
				session.setAttribute(WebConstants.SESSION_ADMIN_ROLE_ID, Integer.parseInt(userData.getAdminRole()));
				session.setAttribute(WebConstants.SESSION_USER_ROLE_PERMISSIONS, sectionList);
				populateUserScreenSeededData(session);
				String userHomePage = "admin/loginModule/noPermissions.htm";
				if(null != sectionList && sectionList.size() != 0)
				{
//					String url = "/"+sectionList.get(0).getReports()[0].getReportName();
					String url = "/admin/"+getHomePage(sectionList);
//					url += "/";
//					url += sectionList.get(0).getReports()[0].getActions()[0].getActionName();
//					url += ".htm";
					
					userHomePage = url;
				}
				//userHomePage = "/admin/manageHomePage/viewHomePageImages.htm";
				return "redirect:"+userHomePage;
			}
		}
		catch (ServiceException e) 
		{
			result.rejectValue("error",e.getErrorCode());
		} 
		catch (SecurityException e) 
		{
			result.rejectValue("error",ErrorConstants.TS_1016);
		}
		catch (Exception e) 
		{
			ApplicationException appExp = new ApplicationException(ErrorConstants.TS_1015, e.getMessage());
			result.rejectValue("error",ErrorConstants.TS_1015);
			log.error(appExp.toString(),e);
		}
		return "admin.loginPage";
	}
	
	
	private String getHomePage(List<Section> sectionList){
		 String url = "admin/loginModule/noPermissions.htm";
	a:	for(Section section:sectionList){
			for(int i=0;i<section.getReports().length;i++){
			if(ReportType.COMMON != ReportType.valueOf(section.getReports()[i].getReportType())){
				url = section.getReports()[i].getReportName();
				url += "/";
				url += section.getReports()[i].getActions()[0].getActionName();
				url += ".htm";
				log.debug("********* "+url);
				break a;
			}
			}
		}
		return url;
	}
	
	
	private void populateUserScreenSeededData(HttpSession session) throws ServiceException 
	{
		RoleType roleType = (RoleType)session.getAttribute(WebConstants.SESSION_USER_ROLE_TYPE);
		Integer roleId = (Integer)session.getAttribute(WebConstants.SESSION_ADMIN_ROLE_ID);		
		Integer groupId = (Integer)session.getAttribute(WebConstants.SESSION_USER_GROUP_ID);
		List<Group> groupList = manageUserService.getUserGroupsByAdminGroupId(roleType,groupId);
		
		List<Role> userRoleList = 0!=roleId? manageUserService.getUserRolesByAdminRole(roleType,roleId):new ArrayList<Role>();
		List<Role> adminRoleList = 0!=roleId ? manageUserService.getAdminRolesByAdminRole(roleType,roleId):new ArrayList<Role>();
		
		session.setAttribute("userGroups",groupList);
		session.setAttribute("userRoles",userRoleList);
		session.setAttribute("adminRoles",adminRoleList);
	
	}
	/**
	 * This method is used to get the count of attempts to that specific user from session
	 * 
	 * @param session,userName
	 * @return Integer
	 */ 
	private Integer getAttempts(HttpSession session,String userName){
		Integer count = 1;		
		if( null == session.getAttribute(userName))
		{
			session.setAttribute(userName,count);
		}
		else
		{
			count = (Integer)session.getAttribute(userName)+1;
			session.setAttribute(userName,count);
		}
		log.debug("user attempts********* "+count);
		return count;
	}
	
	
	/**
	 * This method is to return view related to firsttimeLogin 
	 * 
	 * @param session,userName
	 * @return Integer
	 * @throws ServiceException 
	 */ 
	@RequestMapping(value="admin/loginModule/firstTimeLogin.htm",method = RequestMethod.GET)
	public String initFirstTimeLogin(ModelMap model,HttpSession session,HttpServletRequest request) throws ServiceException
	{
		log.debug("initFirstTimeLogin is invoked");
		UserCredentials user = new UserCredentials();
		if(session.getAttribute(WebConstants.SESSION_USER_NAME) != null)
		{
			Locale userLocale = request.getLocale();
			if(null == userLocale){
				userLocale = Locale.US;
			}
			user.setUserName((String)session.getAttribute(WebConstants.SESSION_USER_NAME));
			model.addAttribute("credentials", user);
			return "admin.firstTimeLoginPage";
		}
		model.addAttribute("credentials", user);
		return "redirect:login.htm";
	}
	
	/**
	 * This method is for firsttimeLogin submit
	 * 
	 * @param 
	 * @return 
	 */ 
	@RequestMapping(value="admin/loginModule/firstTimeLogin.htm",method = RequestMethod.POST)
	public String submitFirstTimeLogin(@ModelAttribute("credentials") UserCredentials user,BindingResult result,ModelMap model,HttpSession session)
	{
		log.debug("submitFirstTimeLogin is  invoked");
		return changePassword(user, result, model, true,session);
	}
	
	/**
	 * This method is to return view related to ChangePassword 
	 * 
	 * @param session,userName
	 * @return Integer
	 */ 
	@RequestMapping(value="admin/loginModule/changePassword.htm",method = RequestMethod.GET)
	public String initChangePassword(ModelMap model,HttpSession session)
	{
		log.debug("initChangePassword is invoked");
		UserCredentials user = new UserCredentials();
		if(session.getAttribute(WebConstants.SESSION_USER_NAME) != null)
		{
			user.setUserName((String)session.getAttribute(WebConstants.SESSION_USER_NAME));
		}
		model.addAttribute("credentials", user);
		return "admin.changePasswordPage";
	}
	
	/**
	 * This method is for ChangePassword submit
	 * 
	 * @param 
	 * @return 
	 */	
	@RequestMapping(value="admin/loginModule/changePassword.htm",method = RequestMethod.POST)
	public String submitChangePassword(@ModelAttribute("credentials") UserCredentials user,BindingResult result,ModelMap model,HttpSession session)
	{
		log.debug("submitChangePassword  invoked");
		return changePassword(user, result, model, false,session);
	}
	
	/**
	 * This method is for ChangePassword 
	 * validating all depending upon user status
	 * @param 
	 * @return 
	 */	
	private String changePassword(UserCredentials user,BindingResult result,ModelMap model,boolean isFirstTimeLogin,HttpSession session)
	{
		try 
		{
			loginValidator.validateChangePassword(user,result,isFirstTimeLogin,(String)session.getAttribute("captcha_text"));
			if (result.hasErrors())
			{
				log.debug("Change Password data having errors");
				if(isFirstTimeLogin)
				{
					return "admin.firstTimeLoginPage";
				}
				else
				{
					return "admin.changePasswordPage";
				}
			}
			Integer attempts = getAttempts(session, user.getUserName());
			AuthenticationStatus status = credentialsService.authenticate(user.getUserName(), user.getPassword(),attempts,user.getNewPassword());

			log.debug("AuthenticationStatus : " + status);
			switch (status) 
			{
				case INVALID:
					result.rejectValue("error",ErrorConstants.TS_1011);
					break;
				case INACTIVE:
					result.rejectValue("error",ErrorConstants.TS_1012);
					break;
				case LOCKED:
					session.removeAttribute(user.getUserName());
					result.rejectValue("error",ErrorConstants.TS_1013);
					break;
				case SECURITY_QA_LOCKED:
					session.removeAttribute(user.getUserName());
					result.rejectValue("error",ErrorConstants.TS_1013);
					break;					
				case UNKNOWN:
					result.rejectValue("error",ErrorConstants.TS_1011);
					break;
				case FIRST_TIME_LOGIN:
					if(!isFirstTimeLogin)
						result.rejectValue("error",ErrorConstants.TS_1008);
					break;
				case PASSWORD_USED:
						result.rejectValue("newPassword",ErrorConstants.TS_1017);
					break;
			}
			if (result.hasErrors()) 
			{
				log.debug("Change Password data having errors");
				if(isFirstTimeLogin)
				{
					return "admin.firstTimeLoginPage";
				}
				else
				{
					return "admin.changePasswordPage";
				}
			} 
			else 
			{
				//AuthenticationStatus VALID
				credentialsService.changeUserCredentials(user,isFirstTimeLogin);				
			}
			
		} 
		catch (ServiceException e) 
		{
			log.debug("Change Password data having errors");
			result.rejectValue("error",e.getErrorCode());
			if(isFirstTimeLogin)
			{
				return "admin.firstTimeLoginPage";
			}
			else
			{
				return "admin.changePasswordPage";
			}
		}
		catch (Exception e) 
		{
			ApplicationException appExp = new ApplicationException(ErrorConstants.TS_1015, e.getMessage());
			log.debug("Change Password data having errors");
			log.error(appExp.toString(),e);
			result.rejectValue("error",ErrorConstants.TS_1015);
			if(isFirstTimeLogin)
			{
				return "admin.firstTimeLoginPage";
			}
			else
			{
				return "admin.changePasswordPage";
			}			
		}
		session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE ,ErrorConstants.TS_1018);
		session.removeAttribute(user.getUserName());
		return "redirect:login.htm";
	}
	
	/**
	 * This method is to return view related to ForgotPassword 
	 * 
	 * @param session,userName
	 * @return Integer
	 */ 
	@RequestMapping(value="admin/loginModule/forgotPassword.htm",method = RequestMethod.GET)
	public String initForgotPassword(ModelMap model)
	{
		log.debug("init ForgotPassword invoked");
		UserCredentials user = new UserCredentials();
		model.addAttribute("credentials", user);
		return "admin.forgotPassword";
	}
	
	/**
	 * This method is for getting SecurityQuestion
	 * 
	 * @param 
	 * @return 
	 */ 
	@RequestMapping(value="admin/loginModule/getSecurityQuestion.htm",method = RequestMethod.POST)
	public String getSecurityQuestion(@ModelAttribute("credentials") UserCredentials user,BindingResult result,ModelMap model)
	{
		log.debug("SecurityQuestion invoked");
		try 
		{
			UserCredentials securityDetails = new UserCredentials();
			securityDetails.setUserName(user.getUserName());
			securityDetails.setSecurityQuestion(credentialsService.getSecurityQuestion(user.getUserName()));
			model.addAttribute("credentials", securityDetails);
		} 
		catch (ServiceException e) 
		{
			result.rejectValue("error",e.getErrorCode());//first time login
		}
		catch (Exception e) 
		{
			ApplicationException appExp = new ApplicationException(ErrorConstants.TS_1010, e.getMessage());
			result.rejectValue("error",ErrorConstants.TS_1010);
			log.error(appExp.toString(),e);
		}
		return "admin.forgotPassword";
	}
	
	/**
	 * This method is for ForgotPassword submit
	 * 
	 * @param 
	 * @return 
	 */ 	
	@RequestMapping(value="admin/loginModule/forgotPassword.htm",method = RequestMethod.POST)
	public String submitForgotPassword(@ModelAttribute("credentials") UserCredentials user,BindingResult result,ModelMap model,HttpSession session){
		log.debug("ForgotPassword is invoked");
		try 
		{
			Integer attempts = getAttempts(session, user.getUserName());
			AuthenticationStatus status  = credentialsService.resetUserCredentials(user.getUserName(), user.getSecurityAnswer(), attempts);	
			log.debug("AuthenticationStatus : " + status);
			switch (status) 
			{
				case INVALID:
					result.rejectValue("securityAnswer",ErrorConstants.TS_1009);
					break;
				case INACTIVE:
					result.rejectValue("userName",ErrorConstants.TS_1012);
					break;
				case SECURITY_QA_LOCKED:
					session.removeAttribute(user.getUserName());
					result.rejectValue("userName",ErrorConstants.TS_1013);
					break;		
				case FIRST_TIME_LOGIN:
					session.removeAttribute(user.getUserName());
					result.rejectValue("userName",ErrorConstants.TS_1008);
					break;
				case UNKNOWN:
					result.rejectValue("securityAnswer",ErrorConstants.TS_1009);
					break;
			}
			if (result.hasErrors())
			{
				log.debug("submit forgot Password data having errors");
				return "admin.forgotPassword";
			} 
		} 
		catch (ServiceException e) 
		{
			result.rejectValue("error",e.getErrorCode());
			return "admin.forgotPassword";
		}
		catch (Exception e) 
		{
			ApplicationException appExp = new ApplicationException(ErrorConstants.TS_1010, e.getMessage());
			result.rejectValue("error",ErrorConstants.TS_1010);
			log.error(appExp.toString(),e);
		}
		session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE ,ErrorConstants.TS_1019);
		session.removeAttribute(user.getUserName());
		return "redirect:login.htm";
	}
	/**
	 * This method is for Logout submit
	 * 
	 * @param 
	 * @return 
	 */ 	
	@RequestMapping(value="admin/loginModule/logout.htm",method = RequestMethod.GET)
	public String initLogout(ModelMap model,HttpSession session)
	{
		log.debug("logout is invoked");
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		if(null!=ss){
			ss.invalidate();
		}
		session.invalidate();
		model.addAttribute("credentials", new UserCredentials());
		return "redirect:login.htm";
	}
	
	/**
	 * This method is for nopermissions screen
	 * 	 * @param 
	 * @return 
	 */ 	
	@RequestMapping(value="admin/loginModule/noPermissions.htm",method = RequestMethod.GET)
	public String noPermissionsRedirect(ModelMap model,HttpSession session)
	{
		return "admin.noPermissions";
	}
	
}
