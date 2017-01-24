package com.vydya.theschool.web.admin.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.StringUtils;
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
import com.vydya.theschool.common.dto.StudentData;
import com.vydya.theschool.common.dto.User;
import com.vydya.theschool.common.dto.UserCredentials;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.types.AuthenticationStatus;
import com.vydya.theschool.common.types.UserType;
import com.vydya.theschool.services.api.common.ParentService;
import com.vydya.theschool.services.api.home.StudentService;
import com.vydya.theschool.services.api.user.GenUserCredentialsService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.validator.LoginValidator;

@Controller  
public class UserLoginController {

	private final static Logger log = Logger.getLogger(UserLoginController.class.getName());
	
	@Autowired
	protected LoginValidator loginValidator;	
	
	@Autowired
	protected ParentService parentService;	
	
	@Autowired
	protected StudentService studentService;	
	
	@Autowired
	protected GenUserCredentialsService credentialsService;
	
	@Autowired
	protected SchoolAdminProperties properties; 
	
	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	
	Map<String, String> loginUsers = new HashMap<String, String>();
	
	@RequestMapping(value="user/login.htm",method = RequestMethod.GET)
	public String initLoginForm(ModelMap model) 
	{
		log.debug("login invoked");
		model.addAttribute("credentials", new UserCredentials());
		return "login.loginPage";
	}
	
	
	@RequestMapping(value="user/login.htm",method = RequestMethod.POST)
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
				return "login.loginPage";
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
				return "login.loginPage";
			} 
			else 
			{
				//AuthenticationStatus VALID
				session.removeAttribute(user.getUserName());
				session.setAttribute(WebConstants.SESSION_USER_NAME, userName);			
				application.setAttribute(WebConstants.SESSION_BUILD_VERSION,properties.getBuildVersion());
				
				//localStaticContainer.loadStaticSession(session);
				//localStaticContainer.loadStaticData(application);
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
				application.setAttribute("gen_login_users", loginUsers);
				credentialsService.updateLoginStatusFlag(userName,TSConstants.STATUS_LOGIN_YES);
				
				String displayName = userData.getUserName()+"&nbsp;("+userData.getFirstName()+"&nbsp;"+userData.getLastName()+")";
				
				session.setAttribute(WebConstants.SESSION_USER_DISPLAY_NAME, displayName);
				session.setAttribute(WebConstants.SESSION_USER_LAST_LOGIN, userData.getLastAccessDate());
				//session.setAttribute(WebConstants.SESSION_USER_GROUP_ID, Integer.parseInt(userData.getGroup()));
				//session.setAttribute(WebConstants.SESSION_USER_ROLE_TYPE,userData.getRoleType());
				//session.setAttribute(WebConstants.SESSION_USER_ROLE_ID, Integer.parseInt(userData.getUserRole()));
				//session.setAttribute(WebConstants.SESSION_ADMIN_ROLE_ID, Integer.parseInt(userData.getAdminRole()));
				session.setAttribute(WebConstants.SESSION_USER_TYPE, userData.getUserType());
				session.setAttribute("user_type_id", (int)userData.getUserId());
				String hompage = getHomePage(userData,session,model,userData);
				//String userHomePage = "user/home.htm";
				return "redirect:"+hompage;
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
		return "login.loginPage";
	}
	
	
	
	private String getHomePage(User user, HttpSession session, ModelMap model, User userData) {

		UserType uType = UserType.fromString(user.getUserType());
		String homepage = null;
		
		try{
			switch (uType) 
			{
				case PT: 
					homepage= "parent/home.htm";
					List<StudentData> students = studentService.findStudentsByParent((int)userData.getUserId());
					List<Integer> idlist = new ArrayList<Integer>();
					StringBuffer clist =new StringBuffer();
						for(StudentData st : students){
							//idlist.add(st.getStudentId());
							clist.append(st.getId()).append(",");
						}
						session.setAttribute("childlist", clist.toString());
					break;
				case ST:
					homepage= "student/home.htm";
					break;
				case SF:
					homepage= "teacher/home.htm";
					break;
			}
		}
		catch (ServiceException e) 
		{
		} 
		catch (SecurityException e) 
		{
		}
		catch (Exception e) 
		{
			ApplicationException appExp = new ApplicationException(ErrorConstants.TS_1015, e.getMessage());
			log.error(appExp.toString(),e);
		}
		return homepage;
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
	 */ 
	@RequestMapping(value="user/firstTimeLogin.htm",method = RequestMethod.GET)
	public String initFirstTimeLogin(ModelMap model,HttpSession session)
	{
		log.debug("initFirstTimeLogin is invoked");
		UserCredentials user = new UserCredentials();
		if(session.getAttribute(WebConstants.SESSION_USER_NAME) != null)
		{
			user.setUserName((String)session.getAttribute(WebConstants.SESSION_USER_NAME));
			model.addAttribute("credentials", user);
			return "login.firstTimeLoginPage";
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
	@RequestMapping(value="user/firstTimeLogin.htm",method = RequestMethod.POST)
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
	@RequestMapping(value="user/changePassword.htm",method = RequestMethod.GET)
	public String initChangePassword(ModelMap model,HttpSession session)
	{
		log.debug("initChangePassword is invoked");
		UserCredentials user = new UserCredentials();
		if(session.getAttribute(WebConstants.SESSION_USER_NAME) != null)
		{
			user.setUserName((String)session.getAttribute(WebConstants.SESSION_USER_NAME));
		}
		model.addAttribute("credentials", user);
		return "login.changePasswordPage";
	}
	
	/**
	 * This method is for ChangePassword submit
	 * 
	 * @param 
	 * @return 
	 */	
	@RequestMapping(value="user/changePassword.htm",method = RequestMethod.POST)
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
					return "login.firstTimeLoginPage";
				}
				else
				{
					return "login.changePasswordPage";
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
					return "login.firstTimeLoginPage";
				}
				else
				{
					return "login.changePasswordPage";
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
				return "login.firstTimeLoginPage";
			}
			else
			{
				return "login.changePasswordPage";
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
				return "login.firstTimeLoginPage";
			}
			else
			{
				return "login.changePasswordPage";
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
	@RequestMapping(value="user/forgotPassword.htm",method = RequestMethod.GET)
	public String initForgotPassword(ModelMap model)
	{
		log.debug("init ForgotPassword invoked");
		UserCredentials user = new UserCredentials();
		model.addAttribute("credentials", user);
		return "login.forgotPassword";
	}
	
	/**
	 * This method is for getting SecurityQuestion
	 * 
	 * @param 
	 * @return 
	 */ 
	@RequestMapping(value="user/getSecurityQuestion.htm",method = RequestMethod.POST)
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
		return "login.forgotPassword";
	}
	
	/**
	 * This method is for ForgotPassword submit
	 * 
	 * @param 
	 * @return 
	 */ 	
	@RequestMapping(value="user/forgotPassword.htm",method = RequestMethod.POST)
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
				return "login.forgotPassword";
			} 
		} 
		catch (ServiceException e) 
		{
			result.rejectValue("error",e.getErrorCode());
			return "login.forgotPassword";
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
	@RequestMapping(value="user/logout.htm",method = RequestMethod.GET)
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
	@RequestMapping(value="user/noPermissions.htm",method = RequestMethod.GET)
	public String noPermissionsRedirect(ModelMap model,HttpSession session)
	{
		return "login.noPermissions";
	}
	
	
	@RequestMapping(value="user/home.htm",method = RequestMethod.GET)
	public String userLoginHome(ModelMap model) 
	{
		log.debug("login invoked");
		model.addAttribute("credentials", new UserCredentials());
		return "user.homePage";
	}
}
