package com.vydya.theschool.web.admin.controllers;

import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.AttachmentData;
import com.vydya.theschool.common.dto.ContentData;
import com.vydya.theschool.common.dto.ContentSubCat;
import com.vydya.theschool.common.dto.CustomImage;
import com.vydya.theschool.common.dto.EventAjaxData;
import com.vydya.theschool.common.dto.EventData;
import com.vydya.theschool.common.dto.GalleryData;
import com.vydya.theschool.common.dto.GalleryImageData;
import com.vydya.theschool.common.dto.GalleryVideoData;
import com.vydya.theschool.common.dto.HomePageImageData;
import com.vydya.theschool.common.dto.MenuData;
import com.vydya.theschool.common.dto.User;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.FileUtil;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.common.ColumnMenuContentsService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.home.EventGalleryService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.localstatic.StaticData;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.utils.UniqueIdGenerator;

@Controller
public class AdminEventController {

	private final static Logger logger = Logger
			.getLogger(AdminEventController.class.getName());

	@Autowired
	protected EventGalleryService eventService;
	@Autowired
	protected ReferenceDataService referenceDataService;

	@Autowired
	protected ColumnMenuContentsService columnMenuContentsService;

	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	
	@RequestMapping(value = WebConstants.VIEW_EVENTS, method = RequestMethod.GET)
	public String viewAllEvents(
			ModelMap model, ServletRequest request,
			@ModelAttribute(value = "eventForm") EventData eventData,
			SessionStatus status) {
			
		try {
			/*String year = request.getParameter("y");
			if(year==null){
				year = TSDateUtil.getCurrentYear();
			}
			List<EventData> eventList =  eventService.loadAllEvents(Integer.parseInt(year));
			model.addAttribute("events", eventList);*/
			//model.addAttribute("eventForm", new EventData());
			
			return WebConstants.VIEW_NAME_VIEW_EVENTS;
		}  catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_EVENTS;
		}
	}
	
	@RequestMapping(value = WebConstants.VIEW_EVENT, method = RequestMethod.GET)
	public String viewEvent(
			ModelMap model, ServletRequest request,
			@ModelAttribute(value = "eventForm") EventData eventData,
			SessionStatus status) {
			
			
		try {
			int id= Integer.parseInt(request.getParameter("e"));
			EventData event =  eventService.getEvent(id);
			model.addAttribute("eventForm", event);
			
			return WebConstants.VIEW_NAME_VIEW_EVENT;
		} catch (ServiceException e) {
			return WebConstants.VIEW_NAME_VIEW_EVENTS;
		} catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_EVENTS;
		}
	}
	
	
	
	@RequestMapping(value = WebConstants.DELETE_EVENT , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse delete(@RequestBody String jsonString,
			HttpServletRequest request,
			SessionStatus status) {
		AjaxResponse ajaxRes = new AjaxResponse();
		try {
			JSONObject jsonOb = new JSONObject(jsonString);
			Integer id = (Integer) jsonOb.get("id");
			if(null!=id){
				eventService.deleteEvent(id);
				ajaxRes.setSuccess(true);
				ajaxRes.setMessage("Event Deleted.");
			}
		} 
		catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to Delete Event");
		}
		return ajaxRes;
	}
	
	
	/*
	@RequestMapping(value = WebConstants.EDIT_EVENT)
	public String editGallery(
			@ModelAttribute(value = "eventForm") EventData eventData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		CustomImage image = new CustomImage();
		StaticData sd = localStaticContainer.getStaticData();
//ServletContext context = session.getServletContext();

		if (WebConstants.VIEW.equalsIgnoreCase(eventData.getActionType())) {
			try {
				EventData eventData2 = null;
				if(null!=eventData.getId()){
					eventData2=	eventService.getEvent(eventData.getId());
				}
				
				String uuid= ImageUtil.getARandomString();
				eventData2.setUuid(uuid);
				
				image.setUrl(eventData2.getImageName());
				image.setUuid(uuid);
				model.addAttribute("imageForm",image);
				//eventData2.setEventDateS(TSDateUtil.dateStringToTimestampWithTimeAMPM(eventData2.getEventDate()));
				eventData2.setEventDateS(TSDateUtil.dateTimestampToStringWithTimeAMPM(eventData2.getEventDate()));
				eventData2.setActionType(WebConstants.UPDATE);
				model.addAttribute("eventForm",eventData2);
				return WebConstants.VIEWNAME_EVENT_ADD_OR_EDIT;
			}
			
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("eventForm", eventData);
				return WebConstants.VIEWNAME_EVENTS_ALL;
			}
		}
		else if (WebConstants.UPDATE.equalsIgnoreCase(eventData.getActionType())) {
			
		try {
			byte[] filebyte=null;
			String type = null;
			String uuid = eventData.getUuid();
			String url  = eventData.getName().toLowerCase().replaceAll(" ", "-").replaceAll("[^a-zA-Z0-9&&[^-]]", "");
			if(ss.isExistsImage(uuid+"_CRP")){
				 type = ss.getImageType(uuid+"_CRP");
				filebyte = ss.getImage(uuid+"_CRP");
			}
			
			eventData.setName(eventData.getName());
			eventData.setUrl(url);
			eventData.setLastmodifiedby(userName);
			
			if(null!=filebyte){
				String newimageName =eventData.getUnid()+type;
				eventData.setImageName(newimageName);
				sd.saveImage(newimageName, filebyte, null);
			}
			
			eventData.setEventDate(TSDateUtil.dateStringToTimestampWithTimeAMPM(eventData.getEventDateS()));
			eventService.editEvent(eventData);
		
			
			//context.removeAttribute("cropedImage");
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9072);
			return WebConstants.REDIRECT_VIEW_ALL;

		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9073);
			model.addAttribute("eventForm", eventData);
			model.addAttribute("eventForm", eventData);
			ajaxRes.setSuccess(false);
			ajaxRes.setErrormsg("Unable to save Event Data");
			return WebConstants.VIEWNAME_EVENT_ADD_OR_EDIT;
		}
		}
		return WebConstants.REDIRECT_VIEW_ALL;
	}*/

	@RequestMapping(value = WebConstants.ADD_EVENT, method = RequestMethod.POST)
	public @ResponseBody AjaxResponse add(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {                 

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		StaticData sd = localStaticContainer.getStaticData();
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		EventData eventData = new EventData();
	  try {
		  //JSONObject jsonOb = new JSONObject(jsonString);
		  eventData = mapper.readValue(jsonString, EventData.class);
		  
		  		byte[] filebyte = ImageUtil.getStringAsImage(eventData.getFileToUpload());
		  
		  		UniqueIdGenerator uid = new UniqueIdGenerator();
				String unid = uid.toString();
				eventData.setImageName(unid+"."+FileUtil.getImageMimeType(filebyte));
				eventData.setUrl(eventData.getName().toLowerCase().replaceAll(" ", "-").replaceAll("[^a-zA-Z0-9&&[^-]]", ""));
				eventData.setUnid(unid);
				eventData.setInsertedby(userName);
				eventData.setLastmodifiedby(userName);
				eventData.setEventDate(TSDateUtil.ST_ddMMyyyhhmmaaa(eventData.getEventDateS()));
				eventService.saveEvent(eventData);
				sd.saveImage(eventData.getImageName(), filebyte, null);
				
				aresponse.setSuccess(true);
				aresponse.setMessage("Successfully Saved Event.");
	 } catch (Exception e) {
	     e.printStackTrace();
	     aresponse.setSuccess(false);
		aresponse.setMessage("Unable to save Event.");
	 }
	  return aresponse;
}
	
	@RequestMapping(value = WebConstants.EDIT_EVENT)
	public @ResponseBody AjaxResponse editHomePage(@RequestBody String jsonString,
			HttpSession session,
			HttpServletResponse response) {

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		CustomImage image = new CustomImage();
		StaticData sd = localStaticContainer.getStaticData();
		
		AjaxResponse aresponse = new AjaxResponse();
		 try {
			  JSONObject jsonOb = new JSONObject(jsonString);
			  EventData eventData = new EventData();
					byte[] filebyte =null;
					if(jsonOb.has("fileToUpload")&&(!jsonOb.isNull("fileToUpload"))){
						filebyte=ImageUtil.getStringAsImage((String) jsonOb.get("fileToUpload"));
						eventData.setImageName((String) jsonOb.get("unid")+"."+FileUtil.getImageMimeType(filebyte));
					}
					eventData.setId((Integer) jsonOb.get("id"));
					eventData.setTitle((String) jsonOb.get("title"));
					eventData.setEventDesc((String) jsonOb.get("eventDesc"));
					eventData.setEventDateS((String) jsonOb.get("eventDateS"));
					eventData.setInsertedby(userName);
					eventData.setLastmodifiedby(userName);
					eventService.editEvent(eventData);
					if(null!=filebyte){
						sd.saveImage(eventData.getImageName(), filebyte, null);
					}
					aresponse.setSuccess(true);
					aresponse.setMessage("Successfully Saved Event");

		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9007);
			aresponse.setSuccess(false);
			aresponse.setErrormsg("Unable to update Event");
		}
		return aresponse;
	}


	/*@RequestMapping(value = WebConstants.ADD_EVENT, method = RequestMethod.POST)
	public String addGallery(
			@ModelAttribute(value = "eventForm") EventData eventData,
			BindingResult result, ModelMap model, HttpSession session,HttpServletRequest request,
			HttpServletResponse response) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
//ServletContext context = session.getServletContext();
StaticSession ss = (StaticSession)session.getAttribute("staticSession");
StaticData sd = localStaticContainer.getStaticData();
CustomImage image = new CustomImage();
		if (WebConstants.VIEW.equalsIgnoreCase(eventData.getActionType())) {
			try {
				
				String uuid = ImageUtil.getARandomString();
				eventData.setUuid(uuid);
				image.setUuid(uuid);
				model.addAttribute("imageForm",image);
				eventData.setActionType(WebConstants.ADD);
				model.addAttribute("eventForm",eventData);
				return WebConstants.VIEWNAME_EVENT_ADD_OR_EDIT;
			}
			
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("eventForm", eventData);
				return WebConstants.VIEWNAME_EVENTS_ALL;
			}
		}
		else if (WebConstants.ADD.equalsIgnoreCase(eventData.getActionType())) {
			
			
		try {

			UniqueIdGenerator uid = new UniqueIdGenerator();
			String unid = uid.toString();
			byte[] filebyte=null;
			String type = null;
			String uuid = eventData.getUuid();
			String url  = eventData.getName().toLowerCase().replaceAll(" ", "-").replaceAll("[^a-zA-Z0-9&&[^-]]", "");
			if(ss.isExistsImage(uuid+"_CRP")){
				 type = ss.getImageType(uuid+"_CRP");
				filebyte = ss.getImage(uuid+"_CRP");
			}
			else{
				model.addAttribute("eventForm",eventData);
				result.rejectValue("file",ErrorConstants.TS_1050);			
				return WebConstants.VIEWNAME_EVENT_ADD_OR_EDIT;
			}
		
		String newimageName =unid+type;
			eventData.setUrl(url);
			eventData.setUnid(unid);
			eventData.setImageName(newimageName);
			eventData.setInsertedby(userName);
			
			eventData.setLastmodifiedby(userName);
			eventData.setEventDate(TSDateUtil.dateStringToTimestampWithTimeAMPM(eventData.getEventDateS()));
			eventService.saveEvent(eventData);
			sd.saveImage(newimageName, filebyte, null);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9070);
			return WebConstants.REDIRECT_VIEW_ALL;

		} 
		
		catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9071);
			model.addAttribute("eventForm", eventData);

			return WebConstants.VIEWNAME_EVENT_ADD_OR_EDIT;
		}
		}
		return WebConstants.REDIRECT_VIEW_ALL;
	}
	*/
	@RequestMapping(value = WebConstants.LOAD_EVENTS, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse load(@RequestBody String jsonString,
			ModelMap model,
			HttpServletResponse response,HttpSession session,HttpServletRequest request,
			SessionStatus status) {
		
		AjaxResponse ajresp = new AjaxResponse();
			try{
				JSONObject jsonOb = new JSONObject(jsonString);

				List<EventData> eventList = new ArrayList<EventData>();
				String type = (String) jsonOb.get("t");
				String year = request.getParameter("y");
				if(year==null){
					year = TSDateUtil.getCurrentYear();
				}
				if("prev".equalsIgnoreCase(type)){
					eventList  =  eventService.getEvents("p", 0);
				}
				else if("new".equalsIgnoreCase(type)){
					eventList  =  eventService.getEvents("n", 0);
				}
				
				//List<EventData> eventList =  eventService.loadAllEvents(Integer.parseInt(year));
				
					ajresp.setRespData(eventList);
					return ajresp;
					
			} catch (ServiceException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		//	response.setHeader("Access-Control-Allow-Origin", "*");//Cross-Origin Resource Sharing (CORS)
			return ajresp;
	}


	/*@RequestMapping(value = "/events/{url}", method = RequestMethod.GET)
	public String eventImages(@PathVariable("url") String url, ModelMap model,HttpServletResponse response) throws IOException {
		
		EventData event = new EventData();
		try {
			event  = eventService.getEventByUrl(url);
			model.addAttribute("event", event);
			return WebConstants.VIEWNAME_SCHOOL_EVENT;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_SCHOOL_EVENTS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_EVENTS;
		}
	
	}
	*/
	
	private List<EventAjaxData> getEventsByName(List<EventData> evlist) throws ParseException {
		Map<String,List<EventData>> map = new HashMap<String,List<EventData>>();
		List<EventAjaxData> eventsAjaxList = new ArrayList<EventAjaxData>();
		for(EventData ev:evlist){
			
			if(map.containsKey(TSDateUtil.getMonthYearName(ev.getEventDate()))){
				map.get(TSDateUtil.getMonthYearName(ev.getEventDate())).add(ev);
			}
			else{
				List<EventData> eventSpecificlsit = new ArrayList<EventData>();
				eventSpecificlsit.add(ev);
				map.put(TSDateUtil.getMonthYearName(ev.getEventDate()), eventSpecificlsit);
			}
		}
		
		for(Entry<String, List<EventData>> entry:map.entrySet()){
			EventAjaxData ev = new EventAjaxData();
			ev.setName(entry.getKey());
			ev.setEventlist(entry.getValue());
			eventsAjaxList.add(ev);
		}
		
		return eventsAjaxList;
	}

	private String getJsonByName(List<EventData> evlist) throws ParseException, IOException {
		
		String userDataJSON = null;  
		Map<String,List<EventData>> map = new HashMap<String,List<EventData>>();
	    ObjectMapper mapper = new ObjectMapper();
	    Writer strWriter = new StringWriter();
		for(EventData ev:evlist){
			
			if(map.containsKey(TSDateUtil.getMonthYearName(ev.getEventDate()))){
				map.get(TSDateUtil.getMonthYearName(ev.getEventDate())).add(ev);
			}
			else{
				List<EventData> evlsit = new ArrayList<EventData>();
				evlsit.add(ev);
				map.put(TSDateUtil.getMonthYearName(ev.getEventDate()), evlist);
			}
			
		}
		
	      try
	      {
	    	 
	    	  mapper.writeValue(strWriter, map);
	    	   userDataJSON = strWriter.toString();
	      
	      } catch (JsonGenerationException e)
	      {
	         e.printStackTrace();
	      } catch (JsonMappingException e)
	      {
	         e.printStackTrace();
	      } catch (IOException e)
	      {
	         e.printStackTrace();
	      }
	      finally{
	    	  strWriter.close();
	      }
	      return userDataJSON;
	}
/*
	@RequestMapping(value = WebConstants.UPLOAD_EVENTIMAGE, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse uploadGroupImage( @ModelAttribute(value = "imageForm") CustomImage image,HttpSession session,
			ModelMap model,
			SessionStatus status) {
		AjaxResponse ajaxRes = new AjaxResponse();
		MultipartFile file = image.getImageFile();
		String uuid = image.getUuid();
		
		try {
			StaticSession ss = (StaticSession)session.getAttribute("staticSession");
			if(image.isDontCrop()){
				byte[] filebyte = ImageUtil.getDontCropImage(file.getBytes(), 335, 848);
				ajaxRes.setValid(true);
				ajaxRes.setDontCrop(true);
				ajaxRes.setImage(ImageUtil.getImageAsString(filebyte));
				ss.saveImage(uuid+"_CRP", filebyte);
			}
			else{
				if(null!=image.getActionType()&&WebConstants.CROP.equalsIgnoreCase(image.getActionType())){
					
					image.setFixedW(848);
					byte[] filebyte = ss.getImage(uuid+"_ORG");
					image.setImageBytes(filebyte);
					byte[] cropedImage = ImageUtil.cropImage(image);
					ss.saveImage(uuid+"_CRP", cropedImage);
					ajaxRes.setValid(true);
					ajaxRes.setImage(ImageUtil.getImageAsString(cropedImage, 272));
				}
				else{
					
					if(file.getSize()!=0){
						byte[] filebyte = ImageUtil.getModerateImageForCrop(file.getBytes());
						ajaxRes.setValid(true);
						ajaxRes.setImage(ImageUtil.getImageAsString(filebyte));
						ss.saveImage(uuid+"_ORG", filebyte);
						}
				}
			}

			return ajaxRes;
		} catch (Exception e) {
		return ajaxRes;
		} 
	}
	*/

	
	
}