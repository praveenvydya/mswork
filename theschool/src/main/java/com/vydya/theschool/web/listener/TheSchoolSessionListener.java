package com.vydya.theschool.web.listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.vydya.theschool.common.constants.TSConstants;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.user.GenUserCredentialsService;
import com.vydya.theschool.services.api.user.UserCredentialsService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.StaticSession;

public class TheSchoolSessionListener implements HttpSessionListener{
	public final static String USER_CREDENTIALS_SERVICE= "com.vydya.theschool.services.api.user.UserCredentialsService";
	public final static String PROPERTIES_SERVICE= "com.vydya.theschool.services.spring.common.SchoolAdminProperties";
	public final static String GEN_USER_CREDENTIALS_SERVICE= "com.vydya.theschool.services.api.user.GenUserCredentialsService";
	
	
	private static Logger log = Logger.getLogger(TheSchoolSessionListener.class.getName());
	
	
	
	@Override
    public void sessionCreated(HttpSessionEvent event) {
		
		getPopups(event);
	}
 

	@Override
    public void sessionDestroyed(HttpSessionEvent event) {
    	log.debug("Session Expired");
    	HttpSession session = event.getSession();
    	StaticSession ss = (StaticSession)session.getAttribute("staticSession");
    	if(null!=ss){
    		ss.invalidate();
    	}
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());

		String userName = (String)session.getAttribute(WebConstants.SESSION_USER_NAME);
		String userType = (String)session.getAttribute("user_type");
		try {
			if(null!=userType){
				 Integer userid = (Integer)session.getAttribute("user_type_id");
				 GenUserCredentialsService genuserService =(GenUserCredentialsService) ctx.getBean(GEN_USER_CREDENTIALS_SERVICE);
				 genuserService.updateLoginStatusFlag(userName, TSConstants.STATUS_LOGIN_NO);
			}
			else{

	        	
	        	UserCredentialsService userService =(UserCredentialsService) ctx.getBean(USER_CREDENTIALS_SERVICE);
	        	if(userName != null)
	        		userService.updateLoginStatusFlag(userName,TSConstants.STATUS_LOGIN_NO);
			} 
		}
        catch (ServiceException e) 
        {
			log.error("ServiceException occured while closing session" + e.toString(),e);
		}
    }	

	
	 private void getPopups(HttpSessionEvent event) {
		 log.debug("Popup loading");
		 HttpSession session = event.getSession();
		 ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());

		 SchoolAdminProperties properties =(SchoolAdminProperties) ctx.getBean(PROPERTIES_SERVICE);	
	      String popup =  properties.getPopupHome();
		 session.setAttribute("popuphome",popup);
		}

}
