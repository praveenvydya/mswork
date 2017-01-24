
package com.vydya.theschool.web.security;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.vydya.theschool.common.constants.TSConstants;
import com.vydya.theschool.common.dto.Section;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.DataException;
import com.vydya.theschool.dataaccess.api.permisions.ManageSectionDAO;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.utils.WebUtils;

public final class GenUserSecurityInterceptor extends HandlerInterceptorAdapter 
{
	private static Logger logger = Logger.getLogger(GenUserSecurityInterceptor.class);

	@Autowired(required=true)
	public SchoolAdminProperties properties;
	
	 @Autowired
	 protected ManageSectionDAO sectionDAO;
	
	/**
	 * In this case intercept the request BEFORE it reaches the controller
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception 
	{

		logger.debug("Intercepting: " + request.getRequestURI());		
		try 
		{	
			RequestData requestData = WebUtils.parseUserRequestURI(request.getRequestURI());	
			
			if(null == requestData)
			{
				String loginPage = request.getContextPath()+ "/home";
				response.sendRedirect(loginPage);
				return false;
			}
			
			String actionName = requestData.getActionName();
			if("login".equals(actionName))
			{
				//login report is accessible to all users
				return true;
			}
			
			HttpSession session = request.getSession();						
			String userName = (String)session.getAttribute(WebConstants.SESSION_USER_NAME);
			
			if(null!=requestData&&requestData.isAdmin()&&null == userName)
			{
				String loginPage = request.getContextPath()+ "/user/login.htm";
				response.sendRedirect(loginPage);
				return false;
			}
			
			
			if(!singleSignOn(request,session)){
				String loginPage = request.getContextPath()+ "/user/login.htm";
				response.sendRedirect(loginPage);
				return false;
			}
			//you come here in Valid scenario - user have all permissions to do the current action
			return true;
		} 
		catch (Exception e) 
		{
			logger.debug("Erorr in SecurityInterceptor : while validating user request");
			logger.error(new ApplicationException("UNKONOWN",e.getMessage()).toString(),e);
			return false;
		}
	}

	private boolean singleSignOn(HttpServletRequest request, HttpSession session) {

		ServletContext context = request.getSession().getServletContext();
		Map<String, String> loginUsers = (Map<String, String>) context.getAttribute("gen_login_users");
		if(null==loginUsers){
			return true;
		}
		String validSessionId = loginUsers.get((String)session.getAttribute(WebConstants.SESSION_USER_NAME));
		String presendSessionId = session.getId();
		if(presendSessionId.equalsIgnoreCase(validSessionId)){
			
			return true;
		}
		else return false;
	}

	/** This could check user has permission to access the Action of a Report
	 * //checks userId's user role has permission on action of a report
	 * */
	private boolean hasPermission(RequestData requestData,HttpSession session)
	{
		//check userId's user role has permission on action of a report
		@SuppressWarnings("unchecked")
		List<Section> permissionList = (List<Section>)session.getAttribute(WebConstants.SESSION_USER_ROLE_PERMISSIONS);
		logger.debug("checking user have permission to access Action: "+requestData.getActionName());
		if(null!=permissionList){
			return WebUtils.hasPermissionOnReport(requestData,permissionList);
		}
		else return false;
	}
	
	
	
	
	 @Override
	 public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception 
	 {       
		 
		/* String ipAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
			if (ipAddress == null) {
			    ipAddress = request.getRemoteAddr();
			}*/
			//request.setAttribute("ipaddress", ipAddress);
		// getClient(request);
		 String query = request.getRequestURI();
		 logger.debug("POST Intercepting Query: " + query);    
		 RequestData requestData = WebUtils.parseRequestURI(query);
		 if(modelAndView == null)
		 {
			 return;
		 }
		 if(requestData != null)
		 {
			 String reportName = requestData.getReportName();		
			 if(TSConstants.REPORT_LOGIN.equals(reportName))
			 {
				 //login report does not have any  breadcrumbs
			 }
			 else
			 {
				 try
				 {
					//String names =  sectionDAO.findSectionByReportName(reportName);
					// String nameList[]=names.split(TSConstants.SEPERATOR);
					 /*if((null != nameList)&&(nameList.length>0))
					 {
						 modelAndView.addObject("current_section",nameList[0]);
						 logger.debug("current_section : " + nameList[0]);
						 modelAndView.addObject("current_report",nameList[1]);
						 logger.debug("current_report : " + nameList[1]);
						 
						// modelAndView.addObject("ipaddress",ipAddress);
						 modelAndView.addObject("ipaddress",getClientIpAddress(request));
						 
					 }*/
						
				 }
				 /*catch (Exception e) 
				 {
					 logger.error(e.toString(),e);
				 }*/
				 catch (Exception e)
				 {
					 logger.error(e.toString(),e);
				 }
			 }
		 }
	 }
	 
	 
	 private static final String[] HEADERS_TO_TRY = { 
		    "X-Forwarded-For",
		    "Proxy-Client-IP",
		    "WL-Proxy-Client-IP",
		    "HTTP_X_FORWARDED_FOR",
		    "HTTP_X_FORWARDED",
		    "HTTP_X_CLUSTER_CLIENT_IP",
		    "HTTP_CLIENT_IP",
		    "HTTP_FORWARDED_FOR",
		    "HTTP_FORWARDED",
		    "HTTP_VIA",
		    "REMOTE_ADDR" };

		public String getClientIpAddress(HttpServletRequest request) {
		    for (String header : HEADERS_TO_TRY) {
		        String ip = request.getHeader(header);
		        if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
		            return ip;
		        }
		    }
		    return request.getRemoteAddr();
		}
		
		/*private String getClient(HttpServletRequest request){
		    String hostname = request.getRemoteHost(); // hostname
		    System.out.println("hostname"+hostname);

		    String computerName = null;
		    String remoteAddress = request.getRemoteAddr();
		    System.out.println("remoteAddress: " + remoteAddress);
		    try {
		        InetAddress inetAddress = InetAddress.getByName(remoteAddress);
		        System.out.println("inetAddress: " + inetAddress);
		        computerName = inetAddress.getHostName();

		        System.out.println("computerName: " + computerName);


		        if (computerName.equalsIgnoreCase("localhost")) {
		            computerName = java.net.InetAddress.getLocalHost().getCanonicalHostName();
		        } 
		    } catch (UnknownHostException e) {

		        }

		    System.out.println("computerName: " + computerName);
		    
		    return null;
		}*/
}