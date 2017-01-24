
package com.vydya.theschool.web.security;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.vydya.theschool.common.dto.ClientData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.ClientService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;
import com.vydya.theschool.web.utils.WebUtils;

public final class WebInterceptor extends HandlerInterceptorAdapter 
{
	private static Logger logger = Logger.getLogger(WebInterceptor.class);

	@Autowired(required=true)
	public SchoolAdminProperties properties;
	
	 @Autowired
	 protected ClientService clientService;
	
	/**
	 * In this case intercept the request BEFORE it reaches the controller
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception 
	{

		logger.debug("Intercepting: " + request.getRequestURI());		
		try 
		{	
			 String query = request.getRequestURI();
			 logger.debug("POST Intercepting Query: " + query);    

			 updateClient(request);
			return true;
		} 
		catch (Exception e) 
		{
			logger.debug("Erorr in SecurityInterceptor : while validating user request");
			logger.error(new ApplicationException("UNKONOWN",e.getMessage()).toString(),e);
			return false;
		}
	}
		
	
	 private void updateClient(HttpServletRequest request) throws ServiceException {
		 
		String ip = getClientIpAddress(request);
		 if(isClientExisted(ip)){
			 ClientData  cd = clientService.findByIp(ip);
			Integer clicks =  cd.getNoclicks();
			cd.setNoclicks(clicks+1);
			clientService.UpdateClientData(cd);
			
		 }
		 else{
			 ClientData cldata = new ClientData();
			 	cldata.setComputerName(getComputerName(request));
			 	cldata.setHostName(request.getRemoteHost());
			 	cldata.setInetAddress(getClientInetAddress(request));
			 	cldata.setNoclicks(1);
			 	cldata.setRemoteAddress(ip);
			 	clientService.save(cldata);
		 }
	}

	private boolean isClientExisted(String ip) {
		ClientData data = null;
		 try {
			 data = clientService.findByIp(ip);
			
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 if(null!=data){
			 return true;
		 }
		 else{
			 return false; 
		 }
	}




	@Override
	 public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception 
	 {       
		 
		// getClient(request);
		/* String query = request.getRequestURI();
		 logger.debug("POST Intercepting Query: " + query);    
		 RequestData requestData = WebUtils.parseRequestURI(query);
		 if(modelAndView == null)
		 {
			 return;
		 }
		 if(requestData != null)
		 {
			 modelAndView.addObject("current_section",nameList[0]);
			 logger.debug("current_section : " + nameList[0]);
			 modelAndView.addObject("current_report",nameList[1]);
			 logger.debug("current_report : " + nameList[1]);
			 modelAndView.addObject("ipaddress",getClientIpAddress(request)); 
		 }*/
			 
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
		
		private String getClientInetAddress(HttpServletRequest request){
			
			 String remoteAddress = request.getRemoteAddr();
			 String inetAddr = null;
			 try {
			        InetAddress inetAddress = InetAddress.getByName(remoteAddress);
			       inetAddr =  inetAddress.toString();

			    } catch (UnknownHostException e) {

			    }
			 return inetAddr;
		}
		
		private String getComputerName(HttpServletRequest request){
			  String computerName = null;
			 String remoteAddress = request.getRemoteAddr();
			 try {
			        InetAddress inetAddress = InetAddress.getByName(remoteAddress);
			        computerName = inetAddress.getHostName();
			        if (computerName.equalsIgnoreCase("localhost")) {
			            computerName = java.net.InetAddress.getLocalHost().getCanonicalHostName();
			        } 
			    } catch (UnknownHostException e) {

			    }
			 return computerName;
		}
		
}