package com.vydya.theschool.web.security;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.vydya.theschool.common.dto.SessionBoxData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.ClientService;

public class SessionBox implements HttpSessionListener{

	private static int activeSessions =0;
	
	@Override
	public void sessionCreated(HttpSessionEvent sev) {

		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()) .getRequest();
		activeSessions = activeSessions+1;
		addSessionList(sev);
		addtoSessionBox(request,sev.getSession());
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {

		if(activeSessions>0){
			activeSessions = activeSessions-1;
		}
		removeSessionList(arg0);
	}
	
	public static int getActiveSessions(){
		
		return activeSessions;
	}
	
	private void addtoSessionBox(HttpServletRequest request,HttpSession session) {

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		ClientService clientService =  (ClientService) ctx.getBean("com.vydya.theschool.services.api.common.ClientService");
		
		String ip = getClientIpAddress(request);
			 SessionBoxData  sldata = new SessionBoxData();
			 
			 sldata.setSessionId(session.getId());
			 sldata.setComputerName(getComputerName(request));
			 sldata.setHostName(request.getRemoteHost());
			 sldata.setInetAddress(getClientInetAddress(request));
			 sldata.setRemoteAddress(ip);
			 sldata.setUser("unknown");
			 	try {
					clientService.saveSession(sldata);
					
				} catch (ServiceException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		
	}

	
	private void addSessionList(HttpSessionEvent s){
		HttpSession session = s.getSession();
		//String ipAddr = s.
		
		//String ipAddr = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes())
		           //.getRequest().getRemoteAddr();
		
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		ServletContext context = session.getServletContext();
		
		context.removeAttribute("sessionCount");
		context.setAttribute("sessionCount", activeSessions);
		
		
		//Map<String,String> allActiveSessions = (Map<String,String>) context.getAttribute("activeSessions");
		
		/*if(null!=allActiveSessions){
			allActiveSessions.put(session.getId(), (String)session.getAttribute(WebConstants.SESSION_USER_NAME));
			context.removeAttribute("activeSessions");
			context.setAttribute("activeSessions", allActiveSessions);
		}
		else{
			Map<String,String> as = new HashMap<String, String>();
			as.put(session.getId(), (String)session.getAttribute(WebConstants.SESSION_USER_NAME));
			context.setAttribute("activeSessions", as);
		}*/
	}

	private void removeSessionList(HttpSessionEvent s){
		
		HttpSession session = s.getSession();
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		ClientService clientService =  (ClientService) ctx.getBean("com.vydya.theschool.services.api.common.ClientService");
		//ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		ServletContext context = session.getServletContext();
		
		context.removeAttribute("sessionCount");
		context.setAttribute("sessionCount", activeSessions);
		
		try {
			clientService.deleteSession(session.getId());
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		/*Map<String,String> allActiveSessions = (Map<String,String>) context.getAttribute("activeSessions");
		if(null!=allActiveSessions){
			allActiveSessions.remove(session.getId());
			context.removeAttribute("activeSessions");
			context.setAttribute("activeSessions", allActiveSessions);
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
