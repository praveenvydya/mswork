package com.vydya.theschool.web.security;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.vydya.theschool.common.dto.MenuContent;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.MenuService;
import com.vydya.theschool.services.spring.common.ColumnMenuContainers;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;

public final class ColumnContainerInterceptor extends HandlerInterceptorAdapter 
{
	private static Logger logger = Logger.getLogger(ColumnContainerInterceptor.class);

	@Autowired(required=true)
	public SchoolAdminProperties properties;
	
	 @Autowired(required=true)
	 protected ColumnMenuContainers columnMenuContainers;
	 
	@Autowired(required=true)
	public MenuService menuservice;
	
	
	/**
	 * In this case intercept the request BEFORE it reaches the controller
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception 
	{

		logger.debug("Intercepting: " + request.getRequestURI());		
		try 
		{	
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

	
	
	 @Override
	 public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception 
	 {       
		 ServletContext context = request.getSession().getServletContext();
		/* String query = request.getRequestURI();
		 logger.debug("POST Intercepting Query: " + query);    
		 RequestData requestData = WebUtils.parseRequestURI(query);
		 if(modelAndView == null)
		 {
			 return;
		 }
		 if(requestData != null)
		 {
			 
		 }
		 else{
			 
			 
		 }*/
		 
		 loadPopups(modelAndView);
		loadSystemProperties(modelAndView, request);
		 
		 if(null==(String)context.getAttribute("menuString")){
			 loadNavigationMenu(modelAndView, request);
		}
		 
		 
		List<MenuContent> leftMenuList = (List<MenuContent>) context.getAttribute("leftContentList");
		 if(null==leftMenuList||leftMenuList.size()==0){
			 	columnMenuContainers.loadColumnMenuContents();
			 	List<MenuContent> leftContentListNew = new ArrayList<MenuContent>();
			 	leftContentListNew  = columnMenuContainers.getColumnMenuContentList();
			 	context.setAttribute("leftContentList", leftContentListNew);
		 }
		 
		List<MenuContent> newsList = (List<MenuContent>) context.getAttribute("newslist");
		 if(null==newsList||newsList.size()==0){
			 	columnMenuContainers.loadNewsContentList();
			 	List<MenuContent> newsListNew = new ArrayList<MenuContent>();
			 	newsListNew  = columnMenuContainers.getNewsList();
			 	context.setAttribute("newslist", newsListNew);
		}

	 }

	 

	private void loadPopups(ModelAndView modelAndView) {

		
	}
	
	private void loadNavigationMenu(ModelAndView modelAndView,HttpServletRequest request) {
		 ServletContext context = request.getSession().getServletContext();
		try {

			 String appName = (String) context.getAttribute("application.name");
			 String contextPath = request.getContextPath();
			String menuString= 	menuservice.loadorReloadXmlMenu(appName,contextPath);
			context.removeAttribute("menuString");
			context.setAttribute("menuString", menuString);
			
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void loadSystemProperties(ModelAndView modelAndView,HttpServletRequest request) {
	
		ServletContext context = request.getSession().getServletContext();
		 
		 
		try {
			
			String appName = (String) context.getAttribute("application.name");
			if(null==appName){
				Resource resource = new ClassPathResource("properties/System.properties");
				Properties props = PropertiesLoaderUtils.loadProperties(resource);
				context.setAttribute("application.name", props.getProperty("application.name"));
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}

}