package com.vydya.theschool.web.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.log4j.Logger;

public class ValidationFilter implements Filter  {
	
	 static class FilteredRequest extends HttpServletRequestWrapper 
	 {
		 private static Logger logger = Logger.getLogger(FilteredRequest.class);
		 /* These are the characters not allowed by the validation */        
		 static final String notAllowedChars = "<>\"\';|%&+)(";
		 
		 public FilteredRequest(ServletRequest request) 
		 {                 
			 super((HttpServletRequest)request);         
		 }          
		 public String sanitizeSpecialChars(String input) 
		 {        
			 if(null != input)
			 {
				 input = input.trim();
			 }
			 else 
				 return null;
			 String result = "";   
			 logger.debug("RequestWrapper Input Value:"+input);
			 for (int i = 0; i < input.length(); i++) 
			 {                         
				 if (!(notAllowedChars.indexOf(input.charAt(i)) >= 0))
				 {                                 
					 result += input.charAt(i);                         
				 }                 
			 }         
			 logger.debug("RequestWrapper Result Value:"+result);
			 return result;         
		 }          
		 public String getParameter(String paramName) 
		 {         
			 String value = super.getParameter(paramName);  
			//TO BE changed propname
			 if(!(paramName.startsWith("propertyList") || "password".equals(paramName)||"securityAnswer".equals(paramName)||"newPassword".equals(paramName)||"confirmPassword".equals(paramName)))
			 {			                     
				 value = sanitizeSpecialChars(value);   
			 }
			 return value;         
		 }          
		 public String[] getParameterValues(String paramName) {
			 String values[] = super.getParameterValues(paramName);       
			 if(values!=null){
				 //TO BE changed propname
				 if(!(paramName.startsWith("propertyList") ||"password".equals(paramName)||"securityAnswer".equals(paramName)||"newPassword".equals(paramName)||"confirmPassword".equals(paramName)))
				 {
					 for (int index = 0; index < values.length; index++) 
					 {                                 
						 values[index] = sanitizeSpecialChars(values[index]);                         
					 }     
				 }
			 }
			 
			                 
			 return values;         
		 }    
	 }     
	 public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) throws IOException, ServletException 
	 {         chain.doFilter(new FilteredRequest(request), response);     
	 }     
	 public void destroy() {  }      
	 public void init(FilterConfig filterConfig) {  } 
	 
}
