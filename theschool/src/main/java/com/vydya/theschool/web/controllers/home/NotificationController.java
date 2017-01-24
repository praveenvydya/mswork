package com.vydya.theschool.web.controllers.home;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.HomePageImageData;
import com.vydya.theschool.common.dto.NotificationData;
import com.vydya.theschool.common.dto.ReferenceData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.ColumnMenuContentsService;
import com.vydya.theschool.services.api.common.NotificationService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.utils.UniqueIdGenerator;



@Controller
public class NotificationController {

	private final static Logger logger = Logger
			.getLogger(NotificationController.class.getName());
	
	private static final int DEFAULT_BUFFER_SIZE = 1048576;
	
	@Autowired
	protected ColumnMenuContentsService columnMenuContentsService;
	
	@Autowired
	protected NotificationService  notificationService;

	@Autowired
	protected ReferenceDataService referenceDataService;
	
	
	@RequestMapping(value = WebConstants.VIEW_ALL_NOTIFICATIONS)
	public String  viewAllNotifications(@ModelAttribute(value = "notification") NotificationData notificationData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {
		List<NotificationData> notificationsList = new ArrayList<NotificationData>();
		try {
			/*notificationsList = notificationService.getAllNotifications();
			model.addAttribute("notificationList",notificationsList);
			model.addAttribute("notification",notificationData);*/
			
			return WebConstants.VIEWNAME_NOTIFICATIONS_ALL;

		} catch (Exception e) {
			model.addAttribute("columnMenuContentForm",notificationData);
			return WebConstants.VIEWNAME_NOTIFICATIONS_ALL;
		}
	}
	
	@RequestMapping(value = "admin/manageNotifications/view.htm")
	public @ResponseBody
	String ajaxGet(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		String response = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			JSONObject jsonOb = new JSONObject(jsonString);
			List<NotificationData> notificationsList = notificationService.getAllNotifications();
				response = mapper.writeValueAsString(notificationsList);

			return response;
		} catch (ServiceException e) {
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return response;
		}
	}
	
	@RequestMapping(value = WebConstants.ADD_NOTIFICATION, method = RequestMethod.POST)
	public String  addOrEditNotification(@ModelAttribute(value = "notification") NotificationData notificationData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		if (WebConstants.VIEW.equalsIgnoreCase(notificationData.getActionType())) {
			
			try {
				populateCCSeededData(model,session);
				NotificationData notfnData = new NotificationData();
				notfnData.setActionType(WebConstants.ADD);
				model.addAttribute("notification",notfnData);
				return WebConstants.VIEWNAME_NOTIFICATIONS_VIEW;
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("notification", notificationData);
				return WebConstants.VIEWNAME_NOTIFICATIONS_ALL;
			}
		}
		else if (WebConstants.ADD.equalsIgnoreCase(notificationData.getActionType())) {
			
			try {
				
				
					MultipartFile file = notificationData.getFile();
					if(file.getSize()!=0){
						byte[] filebytes = file.getBytes(); 
						notificationData.setData(filebytes);
					}
					notificationData.setContentType(file.getContentType());
					UniqueIdGenerator uid = new UniqueIdGenerator();
					String unid = uid.toString();
					
					String name = file.getOriginalFilename().toLowerCase().replaceAll("[^a-zA-Z0-9&&[^-.]]", "");
					String n = name.substring(0, name.lastIndexOf("."));
					String t = name.substring(name.lastIndexOf("."));
					String u = n+"-"+unid+t;
					notificationData.setUrl(u);
				notificationData.setCategory("SCHOOL");
				notificationData.setInsertedby(userName);
				notificationData.setLastmodifiedby(userName);
				notificationData.setActive(notificationData.getActive());
				
				notificationService.addNotification(notificationData);
				
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9025);
				model.addAttribute("notification", new NotificationData());
				return WebConstants.REDIRECT_NOTIFICATION;
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9026);
				model.addAttribute("notification", notificationData);
				return WebConstants.VIEWNAME_NOTIFICATIONS_VIEW;
			}
		}
		return WebConstants.VIEWNAME_NOTIFICATIONS_ADD;
	}
	
	
	
	@RequestMapping(value = WebConstants.EDIT_NOTIFICATION, method = RequestMethod.POST)
	public String editNotification(@ModelAttribute(value = "notification") NotificationData notificationData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {

		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
if (WebConstants.VIEW.equalsIgnoreCase(notificationData.getActionType())) {
			
			try {
				populateCCSeededData(model,session);
				NotificationData notification = notificationService.getNotification(notificationData.getId());
				notification.setActionType(WebConstants.UPDATE);
				model.addAttribute("notification", notification);
				
				return WebConstants.VIEWNAME_NOTIFICATIONS_VIEW;
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("notification", notificationData);
				return WebConstants.VIEWNAME_NOTIFICATIONS_ALL;
			}
		}
		else if (WebConstants.UPDATE.equalsIgnoreCase(notificationData.getActionType())) {
			
			try {
				
				/*MultipartFile file = notificationData.getFile();
				if(file.getSize()!=0){
					byte[] filebytes = file.getBytes(); 
					notificationData.setData(filebytes);
				}
				notificationData.setContentType(file.getContentType());*/
				
				//String name = file.getOriginalFilename().toLowerCase().replaceAll("[^a-zA-Z0-9&&[^-.]]", "");
				//String n = name.substring(0, name.lastIndexOf("."));
				//String t = name.substring(name.lastIndexOf("."));
				//String u = n+"-"+System.currentTimeMillis()+t;
				//notificationData.setUrl(u);
			notificationData.setCategory("SCHOOL");
			notificationData.setInsertedby(userName);
			notificationData.setLastmodifiedby(userName);
			notificationData.setActive(notificationData.getActive());
				notificationService.updateNotification(notificationData);
				
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9027);
				model.addAttribute("notification", new NotificationData());
				return WebConstants.REDIRECT_NOTIFICATION;
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9028);
				model.addAttribute("notificationData", notificationData);
				return WebConstants.VIEWNAME_NOTIFICATIONS_VIEW;
			}
		}
		return WebConstants.REDIRECT_NOTIFICATION;
	

	}
	
	@RequestMapping(value = WebConstants.DELETE_NOTIFICATION)
	public String  deleteNotification(@ModelAttribute(value = "notification") NotificationData notificationData,HttpServletRequest request,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {
		try {
			notificationService.deleteNotification(notificationData);
			columnMenuContentsService.deleteContentExisted(notificationData.getId(), "NOTIFICATIONS",request);
			model.addAttribute("notification",notificationData);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9029);
			return WebConstants.REDIRECT_VIEWALL;
		} catch (ServiceException e) {
			model.addAttribute("columnMenuContentForm",notificationData);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9030);
			return WebConstants.VIEWNAME_NOTIFICATIONS_ALL;
		} catch (Exception e) {
			model.addAttribute("columnMenuContentForm",notificationData);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9030);
			return WebConstants.VIEWNAME_NOTIFICATIONS_ALL;
		}
	}
	
	
	private void populateCCSeededData(ModelMap model, HttpSession session) throws ServiceException {
		List<ReferenceData> cTypeRefList =  referenceDataService.getReferenceTypeList("CONTENTTYPE");
		model.addAttribute("cTypeRefList", cTypeRefList);
		
		
	}
	
	@RequestMapping(value ="/notifications")
	public String viewNotifications( 
			ModelMap model,
			SessionStatus status) {
		List<NotificationData> notificationsList = new ArrayList<NotificationData>();
		try {
			
			notificationsList = notificationService.getActiveNotifications();
			model.addAttribute("notificationList",notificationsList);
			
			return WebConstants.VIEWNAME_NOTIFICATIONS;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_NOTIFICATIONS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_NOTIFICATIONS;
		}
	}
	
	


}