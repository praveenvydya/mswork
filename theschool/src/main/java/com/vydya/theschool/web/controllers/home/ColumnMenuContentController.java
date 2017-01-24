package com.vydya.theschool.web.controllers.home;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.ColumnMenuContentsData;
import com.vydya.theschool.common.dto.MenuContent;
import com.vydya.theschool.common.dto.MenuData;
import com.vydya.theschool.common.dto.ReferenceData;
import com.vydya.theschool.common.dto.Section;
import com.vydya.theschool.common.dto.SubjectMarksData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.ColumnMenuContentsService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.spring.common.ColumnMenuContainers;
import com.vydya.theschool.web.constants.WebConstants;



@Controller
public class ColumnMenuContentController {

	private final static Logger logger = Logger
			.getLogger(ColumnMenuContentController.class.getName());
	
	@Autowired
	protected ColumnMenuContentsService  columnMenuContentsService;

	@Autowired
	protected ReferenceDataService referenceDataService;
	
	 @Autowired(required=true)
	 protected ColumnMenuContainers columnMenuContainers;
	 
	 
	@RequestMapping(value = "/home/leftmenu")
	public  @ResponseBody MenuData getColumn( ModelMap model,
			SessionStatus status) {
		
		MenuData menuData = null;
		try {
			 
			File file = new File("C:/xmls/leftMenu.xml");
			JAXBContext jaxbContext = JAXBContext.newInstance(MenuData.class);
			Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
			menuData = (MenuData) jaxbUnmarshaller.unmarshal(file);
			
			return menuData;
	 
		  } catch (JAXBException e) {
			e.printStackTrace();
			return menuData;
		  }
	}
	
	
	@RequestMapping(value = WebConstants.VIEW_ALL_COLUMNCONTENTS)
	public String  viewAllColumnContents(@ModelAttribute(value = "columnMenuContent") ColumnMenuContentsData columnContentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {
		List<ColumnMenuContentsData> columnContentList = new ArrayList<ColumnMenuContentsData>();
		try {
			columnContentList = columnMenuContentsService.getAllColumnMenuContents();
			model.addAttribute("columnContentList",columnContentList);
			model.addAttribute("columnMenuContent",columnContentData);
			
			return WebConstants.VIEWNAME_COLUMNCONTENTS_ALL;
		} catch (ServiceException e) {
			model.addAttribute("columnMenuContent",columnContentData);
			return WebConstants.VIEWNAME_COLUMNCONTENTS_ALL;
		} catch (Exception e) {
			model.addAttribute("columnMenuContent",columnContentData);
			return WebConstants.VIEWNAME_COLUMNCONTENTS_ALL;
		}
	}
	
	
	@RequestMapping(value = WebConstants.ADD_COLUMNCONTENT, method = RequestMethod.POST)
	public String  addColumnContent(@ModelAttribute(value = "columnMenuContent") ColumnMenuContentsData columnContentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) throws ServiceException {
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		
		if (WebConstants.VIEW.equalsIgnoreCase(columnContentData.getActionType())) {
			try {
				populateCCSeededData(model,session);
				ColumnMenuContentsData data = new ColumnMenuContentsData();
				data.setActionType(WebConstants.ADD);
				model.addAttribute("columnMenuContent",data);
				return WebConstants.VIEWNAME_COLUMNCONTENTS_VIEW;
			}
			
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("columnMenuContent", columnContentData);
				return WebConstants.VIEWNAME_COLUMNCONTENTS_ALL;
			}
		}
		else if (WebConstants.ADD.equalsIgnoreCase(columnContentData.getActionType())) {
			
			try {
				
				columnContentData.setInsertedby(userName);
				columnContentData.setLastmodifiedby(userName);
				columnContentData.setActive(new Integer(1));
				columnMenuContentsService.addColumnMenuContent(columnContentData);
				columnMenuContentsService.reloadColumnContents(request);
				
				model.addAttribute("columnMenuContent", new ColumnMenuContentsData());
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9009);
				return WebConstants.REDIRECT_COLUMNCONTENTS;
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				//ajaxRes.setSuccess(false);
				populateCCSeededData(model,session);
				model.addAttribute("columnMenuContent", columnContentData);
				return WebConstants.VIEWNAME_COLUMNCONTENTS_VIEW;
			}
		}
		return WebConstants.VIEWNAME_COLUMNCONTENTS_ALL;
	}
	
	
	
	@RequestMapping(value = WebConstants.EDIT_COLUMNCONTENT, method = RequestMethod.POST)
	public String editColumnContent(@ModelAttribute(value = "columnMenuContent") ColumnMenuContentsData columnContentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {

		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
if (WebConstants.VIEW.equalsIgnoreCase(columnContentData.getActionType())) {
	List<MenuContent> cclist = new ArrayList<MenuContent>();
			try {
				populateCCSeededData(model,session);
				ColumnMenuContentsData columnMenuContent = columnMenuContentsService.getColumnMenuContent(columnContentData.getId());
				columnMenuContent.setActionType(WebConstants.UPDATE);
				cclist = columnMenuContentsService.getCCList(columnMenuContent.getContentType());
				model.addAttribute("columnMenuContent", columnMenuContent);
				model.addAttribute("cclist", cclist);
				
				return WebConstants.VIEWNAME_COLUMNCONTENTS_VIEW;
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("columnMenuContent", columnContentData);
				return WebConstants.VIEWNAME_COLUMNCONTENTS_ALL;
			}
		}
		else if (WebConstants.UPDATE.equalsIgnoreCase(columnContentData.getActionType())) {
			
			try {
				
				columnContentData.setLastmodifiedby(userName);
				columnMenuContentsService.updateColumnMenuContent(columnContentData);
				//update column content 
				columnMenuContentsService.reloadColumnContents(request);
				
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9010);
				model.addAttribute("columnMenuContent", new ColumnMenuContentsData());
				
				return WebConstants.REDIRECT_COLUMNCONTENTS;
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				//ajaxRes.setSuccess(false);
				model.addAttribute("columnContentData", columnContentData);
				return WebConstants.VIEWNAME_COLUMNCONTENTS_VIEW;
			}
		}
		return WebConstants.VIEWNAME_COLUMNCONTENTS_VIEW;
	

	}
	
	@RequestMapping(value = WebConstants.DELETE_COLUMNCONTENT)
	public String  deleteColumnContent(@ModelAttribute(value = "columnMenuContent") ColumnMenuContentsData columnContentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		try {
			columnMenuContentsService.deleteColumnMenuContent(columnContentData);
			model.addAttribute("columnMenuContent",columnContentData);
			// update column content 
			columnMenuContentsService.reloadColumnContents(request);
			
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9011);
			return WebConstants.REDIRECT_VIEWALL;
		} catch (ServiceException e) {
			model.addAttribute("columnMenuContent",columnContentData);
			return WebConstants.VIEWNAME_COLUMNCONTENTS_ALL;
		} catch (Exception e) {
			model.addAttribute("columnMenuContent",columnContentData);
			return WebConstants.VIEWNAME_COLUMNCONTENTS_ALL;
		}
	}
	


	@RequestMapping(value = WebConstants.GET_COLUMNCONTENTS_LIST)
	public  @ResponseBody List<MenuContent> getSelectedCCList( @ModelAttribute(value = "columnMenuContent") ColumnMenuContentsData columnContentData,
			ModelMap model,
			SessionStatus status) {
		List<MenuContent> cclist = new ArrayList<MenuContent>();
		try {
			
			String contentType = columnContentData.getContentType();
			if(null!=contentType&&contentType.length()>0){
				
				cclist = columnMenuContentsService.getCCList(contentType);
			}
			return cclist;
		} catch (Exception e) {
			return cclist;
		}
	}
	
	
	private void populateCCSeededData(ModelMap model, HttpSession session) throws ServiceException {
		List<ReferenceData> ccRefList =  referenceDataService.getReferenceTypeList("CCTYPE");
		model.addAttribute("ccRefList", ccRefList);
	}
	
	
	
	@RequestMapping(value = WebConstants.REORDER_COLUMNCONTENTS_ACTION)
	public String reOrderColumnContents(
			@ModelAttribute(value = "columnMenuContent") ColumnMenuContentsData columnMenuContentsData,
			BindingResult result, HttpSession session, SessionStatus status,HttpServletRequest request,
			ModelMap model) {
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);

		logger.debug("Reorder columnMenuContent ReorderedIds GET initialised "
				+ columnMenuContentsData.getReorderedIds());
		String userName = null;
		if (null != session.getAttribute(WebConstants.SESSION_USER_NAME))
			userName = (String) session
					.getAttribute(WebConstants.SESSION_USER_NAME);
		try
		{
			columnMenuContentsService.reOrderColumnContents(columnMenuContentsData.getReorderedIds(),userName);	
			//updateSession(session);
			columnMenuContentsService.reloadColumnContents(request);
			model.addAttribute(WebConstants.SESSION_SUCCESS_MESSAGE, ErrorConstants.TS_9013);
		} 
		catch (ServiceException e)
		{
			String msg = ctx.getMessage(e.getErrorCode(),new Object[] { }, locale);
			result.rejectValue("error","",msg.concat(String.valueOf(e.getUniqueId())));		
			return WebConstants.REDIRECT_VIEWALL;
		}
		catch (Exception e) {
			String msg = ctx.getMessage(ErrorConstants.TS_2010,new Object[] { }, locale);
			ApplicationException exp = new ApplicationException( e.getMessage(),e);
			logger.error(exp,e);
			result.rejectValue("error","",msg.concat(String.valueOf(exp.getUniqueId())));
			 return WebConstants.REDIRECT_VIEWALL;
		}
		return WebConstants.REDIRECT_VIEWALL;
	}

	
	@RequestMapping(value = WebConstants.RELOAD_COLUMNCONTENTS)
	public String  reloadColumnContents(@ModelAttribute(value = "columnMenuContent") ColumnMenuContentsData columnContentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		try {
			columnMenuContentsService.reloadColumnContents(request);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9012);
			return WebConstants.REDIRECT_VIEWALL;
		
		} catch (Exception e) {
			model.addAttribute("columnMenuContent",columnContentData);
			return WebConstants.VIEWNAME_COLUMNCONTENTS_ALL;
		}
	}
	
}