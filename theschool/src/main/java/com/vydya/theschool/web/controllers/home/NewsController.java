package com.vydya.theschool.web.controllers.home;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
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
import com.vydya.theschool.common.dto.CommonObj;
import com.vydya.theschool.common.dto.ContentCategoryData;
import com.vydya.theschool.common.dto.ContentData;
import com.vydya.theschool.common.dto.MenuContent;
import com.vydya.theschool.common.dto.ReferenceData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.common.ContentService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.spring.common.ColumnMenuContainers;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.localstatic.StaticData;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.utils.UniqueIdGenerator;



@Controller
public class NewsController {

	private final static Logger logger = Logger
			.getLogger(NewsController.class.getName());
	
	@Autowired
	protected ContentService  contentService;

	@Autowired
	protected ReferenceDataService referenceDataService;
	
	@Autowired(required=true)
	 protected ColumnMenuContainers columnMenuContainers;
	
	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	
	@RequestMapping(value = "admin/manageContents/viewAll.htm")
	public String viewAll(HttpSession session,
			 ServletRequest request, SessionStatus status,ModelMap model) {

		try {
			Integer cid= Integer.parseInt(request.getParameter("c"));
			if(null!=cid){
				
				ContentCategoryData ccdata = contentService.getContentCategory(cid);
				model.addAttribute("ccdta", ccdata);
				return WebConstants.VIEW_NAME_VIEW_NEWSN; 
			}
			else
			return WebConstants.VIEW_NAME_VIEW_NEWS;

		} catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_NEWS;
		}
	}
	
	@RequestMapping(value = "admin/manageContents/view.htm")
	public @ResponseBody
	String view(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		String response = "";
		ObjectMapper mapper = new ObjectMapper();
		List<ContentData> clist = null;
		List<ContentCategoryData> cglist = null;
		try {
			JSONObject jsonOb = new JSONObject(jsonString);
			String type = (String) jsonOb.get("type");
			
			//get all contents
			if(null!=type&&type.equalsIgnoreCase("al")){
				clist = contentService.getAllContents();
				response = mapper.writeValueAsString(clist);
			}
			
			//get single content data
			if(null!=type&&type.equalsIgnoreCase("c")){
				String item = (String) jsonOb.get("item");
				ContentData content = contentService.getContent(Integer.parseInt(item));
				response = mapper.writeValueAsString(content);
			}
			
			// get all contents by category
			if(null!=type&&type.equalsIgnoreCase("cc")){
				String item = (String) jsonOb.get("item");
				  clist = contentService.getContentsByCategoryId(Integer.parseInt(item));
				response = mapper.writeValueAsString(clist);
			}
			
			// get all categories
			if(null!=type&&type.equalsIgnoreCase("cg")){
				  cglist = contentService.getAllContentCategories();
				response = mapper.writeValueAsString(cglist);
			}
			


			return response;
		} catch (ServiceException e) {
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return response;
		}
	}
	
	@RequestMapping(value = "admin/manageContents/add.htm", method = RequestMethod.POST)
	public @ResponseBody AjaxResponse add(@RequestBody String jsonString, HttpServletResponse response,HttpSession session,HttpServletRequest request) {                 

		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		//String unid=null;
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		ContentCategoryData ccdta = null;
		ContentData cdta = null;
		
	  try {
		  	JSONObject jsonOb = new JSONObject(jsonString);
		  	String type = (String) jsonOb.get("type");
			
			//add contents
			if(null!=type&&type.equalsIgnoreCase("ct")){

				cdta = mapper.readValue(jsonOb.getString("dto"), ContentData.class);
				cdta.setInsertedby(userName);
				cdta.setLastmodifiedby(userName);
				cdta.setActive(1);
				
				ContentCategoryData catData = contentService.getContentCategory(cdta.getCategoryId());
				
				if(isContentExisted(catData.getName(),cdta.getName(),null)){
					
					aresponse.setSuccess(false);
					aresponse.setErrormsg("Content Name is alredy existed");
					return aresponse;
				}
				else{
					contentService.addContent(cdta);
					//reloadColumnContents(request);
					aresponse.setSuccess(true);
					aresponse.setRespData(cdta);
					aresponse.setErrormsg("Content Added");
					return aresponse;
				}
			}
			if(null!=type&&type.equalsIgnoreCase("cg")){

				ccdta = mapper.readValue(jsonOb.getString("dto"), ContentCategoryData.class);
				ccdta.setInsertedby(userName);
				ccdta.setLastmodifiedby(userName);
				
				if(isContentCategoryExisted(ccdta.getName(), null)){
					aresponse.setSuccess(false);
					aresponse.setErrormsg("Content Category Name is alredy existed");
					return aresponse;
				}
				else{
					contentService.addContentCategory(ccdta);
					aresponse.setSuccess(true);
					aresponse.setRespData(ccdta);
					aresponse.setErrormsg("ContentCategory Added");
					return aresponse;
				}
			}
				/*roleValidator.validate(role, result);
				if (result.hasErrors()) {
					populateData(model, session, role);						
					log.debug("Role data having errors");
					return WebConstants.VIEW_NAME_ADD_ROLE;
				}*/
				
				
	 } catch (Exception e) {
	     e.printStackTrace();
	 }
	  return aresponse;
}

	

	
	
	@RequestMapping(value = "admin/manageContents/edit.htm", method = RequestMethod.POST)
	public @ResponseBody AjaxResponse edit(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {                 

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		ContentCategoryData ccdta = null;
		ContentData cdta = null;
	  try {
		  JSONObject jsonOb = new JSONObject(jsonString);
		  	String type = (String) jsonOb.get("type");
			
			//update contents
			if(null!=type&&type.equalsIgnoreCase("ct")){
				
				cdta = mapper.readValue(jsonOb.getString("dto"), ContentData.class);
				cdta.setLastmodifiedby(userName);
				contentService.updateContent(cdta);
				
				if(isContentExisted(cdta.getName(),cdta.getName(),cdta.getId())){
					aresponse.setSuccess(false);
					aresponse.setErrormsg("Content Name is alredy existed");
					return aresponse;
				}
				else{
					contentService.updateContent(cdta);
					//reloadColumnContents(request);
					aresponse.setSuccess(true);
					aresponse.setRespData(cdta);
					aresponse.setErrormsg("Content updated");
					return aresponse;
				}
				
			}
			
			if(null!=type&&type.equalsIgnoreCase("cg")){

				ccdta = mapper.readValue(jsonOb.getString("dto"), ContentCategoryData.class);
				ccdta.setLastmodifiedby(userName);
				
				if(isContentCategoryExisted(ccdta.getName(),ccdta.getId())){
					aresponse.setSuccess(false);
					aresponse.setErrormsg("Content Category Name is alredy existed");
					return aresponse;
				}
				else{
					contentService.addContentCategory(ccdta);
					aresponse.setSuccess(true);
					aresponse.setRespData(ccdta);
					aresponse.setErrormsg("ContentCategory updated");
					return aresponse;
				}
			}
	 } catch (Exception e) {
	     e.printStackTrace();
	 }
	  return aresponse;
}

	
	
	public String  viewAllContents(@ModelAttribute(value = "contentCategory") ContentCategoryData contentcatData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		List<ContentData> contentsList = new ArrayList<ContentData>();
		List<ContentCategoryData> catList = new ArrayList<ContentCategoryData>();
		String contentId = request.getParameter("contentId");
		
		try {
			populateListData(model);
		
			//contentsList = contentService.getAllContents();
			catList =contentService.getAllContentCategories();
			//model.addAttribute("contentList",contentsList);
			model.addAttribute("cattList",catList);
			model.addAttribute("contentCategory",contentcatData);
			model.addAttribute("content",new ContentData());
			   
			return WebConstants.VIEWNAME_CONTENTS_ALL;
			
		} catch (ServiceException e) {
			model.addAttribute("contentCategory",contentcatData);
			return WebConstants.VIEWNAME_CONTENTS_ALL;
		} catch (Exception e) {
			model.addAttribute("contentCategory",contentcatData);
			return WebConstants.VIEWNAME_CONTENTS_ALL;
		}
	}
	
	@RequestMapping(value = "admin/manageContents/view.htm")
	public String  viewContent(@ModelAttribute(value = "content") ContentData contentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		List<ContentData> contentsList = new ArrayList<ContentData>();
		String contentId = request.getParameter("contentId");
		ContentData contentDataNew = new ContentData();
		try {
			//populateListData(model);
			if(null!=contentId){
				 contentDataNew = contentService.getContent(Integer.parseInt(contentId));
				contentsList  = contentService.getContentsByCategoryId(contentDataNew.getCategoryId());
			}
			model.addAttribute("contentsList",contentsList);
			model.addAttribute("content",contentDataNew);
		return WebConstants.VIEWNAME_CONTENT_VIEW;	
		} catch (ServiceException e) {
			model.addAttribute("contentForm",contentData);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9016);
			return WebConstants.VIEWNAME_CONTENT_VIEW;
		} catch (Exception e) {
			model.addAttribute("contentForm",contentData);
			return WebConstants.VIEWNAME_CONTENT_VIEW;
		}
	}
	
	
	
	@RequestMapping(value = WebConstants.ADD_CONTENT, method = RequestMethod.POST)
	public String  addOrEditContent(@ModelAttribute(value = "content") ContentData contentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		if (WebConstants.VIEW.equalsIgnoreCase(contentData.getActionType())) {
			
			try {
				populateContentSeededData(model);
				ContentData content = new ContentData();
				content.setActionType(WebConstants.ADD);
				model.addAttribute("content",content);
				
				return WebConstants.VIEWNAME_CONTENT_ADD_OR_EDIT;
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("content", contentData);
				return WebConstants.VIEWNAME_CONTENTS_ALL;
			}
		}
		else if (WebConstants.ADD.equalsIgnoreCase(contentData.getActionType())) {
			
			try {
				
				contentData.setInsertedby(userName);
				contentData.setLastmodifiedby(userName);
				contentData.setActive(1);
				
				ContentCategoryData catData = contentService.getContentCategory(contentData.getCategoryId());
				
				if(isContentExisted(catData.getName(),contentData.getName(),null)){
					
					session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
							ErrorConstants.TS_9021);
					model.addAttribute("content", contentData);
					return WebConstants.VIEWNAME_CONTENT_ADD_OR_EDIT;
				}
				else{
					contentService.addContent(contentData);
					reloadColumnContents(request);
					session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
							ErrorConstants.TS_9015);
					model.addAttribute("content", new ContentData());
					return WebConstants.REDIRECT_CONTENT;
				}
				
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9016);
				model.addAttribute("content", contentData);
				return WebConstants.VIEWNAME_CONTENT_ADD_OR_EDIT;
			}
		}
		return WebConstants.VIEWNAME_CONTENT_ADD;
	}
	
	
	@RequestMapping(value = WebConstants.EDIT_CONTENT_CAT, method = RequestMethod.POST)
	public String editContentCategory(@ModelAttribute(value = "contentCategory") ContentCategoryData contentCategoryData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) { 

		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		if (WebConstants.VIEW.equalsIgnoreCase(contentCategoryData.getActionType())) {
			
			try {
				ContentCategoryData contentc = contentService.getContentCategory(contentCategoryData.getId());
				contentc.setActionType(WebConstants.UPDATE);
				model.addAttribute("contentCategory", contentc);
				return WebConstants.VIEWNAME_CONTENT_CAT_ADD_OR_EDIT;
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("content", contentCategoryData);
				return WebConstants.REDIRECT_VIEW_ALL;
			}
		}
		else if (WebConstants.UPDATE.equalsIgnoreCase(contentCategoryData.getActionType())) {
			
			try {
				
				contentCategoryData.setLastmodifiedby(userName);
				contentService.updateContentCategory(contentCategoryData);
				
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9017);
				model.addAttribute("content", new ContentData());
				return WebConstants.REDIRECT_VIEW_ALL;
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9018);
				model.addAttribute("contentData", contentCategoryData);
				return WebConstants.VIEWNAME_CONTENT_CAT_ADD_OR_EDIT;
			}
		}
		else if (WebConstants.DELETE.equalsIgnoreCase(contentCategoryData.getActionType())) {
			
			try {
				contentService.deleteContentCategory(contentCategoryData.getId());
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9019);
				return WebConstants.REDIRECT_VIEW_ALL;
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9020);
				model.addAttribute("content", contentCategoryData);
				return WebConstants.REDIRECT_VIEW_ALL;
			}
		}
		return WebConstants.VIEWNAME_CONTENT_CAT_ADD_OR_EDIT;
	

	}
	
	@RequestMapping(value = WebConstants.ADD_CONTENT_CAT, method = RequestMethod.POST)
	public String  addOrEditContentCategory(@ModelAttribute(value = "contentCategory") ContentCategoryData contentCategoryData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		if (WebConstants.VIEW.equalsIgnoreCase(contentCategoryData.getActionType())) {
			
			try {
				//populateContentSeededData(model);
				ContentCategoryData contentc = new ContentCategoryData();
				contentc.setActionType(WebConstants.ADD);
				model.addAttribute("contentCategory",contentc);
				
				return WebConstants.VIEWNAME_CONTENT_CAT_ADD_OR_EDIT;
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("contentCategory", contentCategoryData);
				return WebConstants.VIEWNAME_CONTENTS_ALL;
			}
		}
		else if (WebConstants.ADD.equalsIgnoreCase(contentCategoryData.getActionType())) {
			
			try {
				
				contentCategoryData.setInsertedby(userName);
				contentCategoryData.setLastmodifiedby(userName);
				//contentCategoryData.setActive(1);
				
				//ContentCategoryData catData = contentService.getContentCategory(contentData.getCategoryId());
				
				if(isContentCategoryExisted(contentCategoryData.getName(),null)){
					
					session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
							ErrorConstants.TS_9021);
					model.addAttribute("contentCategory", contentCategoryData);
					return WebConstants.VIEWNAME_CONTENT_CAT_ADD_OR_EDIT;
				}
				else{
					contentService.addContentCategory(contentCategoryData);
					//reloadColumnContents(request);
					session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
							ErrorConstants.TS_9015);
					
					
					return WebConstants.REDIRECT_CONTENT;
				}
				
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9016);
				model.addAttribute("contentCategory", contentCategoryData);
				return WebConstants.VIEWNAME_CONTENT_ADD_OR_EDIT;
			}
		}
		return WebConstants.VIEWNAME_CONTENTS_ALL;
	}
	
	
	private boolean isContentExisted(String catName, String contName,Integer id) {
		boolean isExisted = true;
		try {
			
			isExisted =  contentService.isExistedContent(catName,contName,id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isExisted;
	}

	private boolean isAttachmentExisted(Integer catId, String attName) {
		boolean isExisted = true;
		try {
			
			isExisted =  contentService.isExistedAttachment(catId,attName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isExisted;
	}
	
	private boolean isContentCategoryExisted(String catName,Integer id) {

		boolean isExisted = true;
		try {
			
			isExisted =  contentService.isExistedContentCategory(catName,id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isExisted;
	}

	
	@RequestMapping(value = WebConstants.EDIT_CONTENT, method = RequestMethod.POST)
	public String editContent(@ModelAttribute(value = "content") ContentData contentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) { 

		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		if (WebConstants.VIEW.equalsIgnoreCase(contentData.getActionType())) {
			
			try {
				populateContentSeededData(model);
				ContentData content = contentService.getContent(contentData.getId());
				content.setActionType(WebConstants.UPDATE);
				model.addAttribute("content", content);
				return WebConstants.VIEWNAME_CONTENT_ADD_OR_EDIT;
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("content", contentData);
				return WebConstants.VIEWNAME_CONTENTS_ALL;
			}
		}
		else if (WebConstants.UPDATE.equalsIgnoreCase(contentData.getActionType())) {
			
			try {
				
				contentData.setLastmodifiedby(userName);
				contentService.updateContent(contentData);
				reloadColumnContents(request);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9017);
				model.addAttribute("content", new ContentData());
				return WebConstants.REDIRECT_CONTENT;
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_9018);
				model.addAttribute("contentData", contentData);
				return WebConstants.VIEWNAME_CONTENT_ADD_OR_EDIT;
			}
		}
		return WebConstants.VIEWNAME_CONTENT_ADD_OR_EDIT;
	

	}
	
	@RequestMapping(value = WebConstants.DELETE_CONTENT)
	public String  deleteContent(@ModelAttribute(value = "content") ContentData contentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		try {
			contentService.deleteContent(contentData);
			reloadColumnContents(request);
			model.addAttribute("content",contentData);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9019);
			return WebConstants.REDIRECT_VIEWALL;
		} catch (ServiceException e) {
			model.addAttribute("contentForm",contentData);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9020);
			return WebConstants.VIEWNAME_CONTENTS_ALL;
		} catch (Exception e) {
			model.addAttribute("contentForm",contentData);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9020);
			return WebConstants.VIEWNAME_CONTENTS_ALL;
		}
	}
	
	private void populateContentSeededData(ModelMap model) throws ServiceException {
		List<ReferenceData> catRefList =  referenceDataService.getReferenceData("CONTENTCATEGORY");
		model.addAttribute("catRefList", catRefList);
		
		List<ContentData>  contentsList = contentService.getAllContents();
		model.addAttribute("contentsList", contentsList);
		
	}
	
	private void populateListData(ModelMap model) throws ServiceException {
		
		model.addAttribute("contentYrList",contentService.getAllContentsByYrMonth());
		model.addAttribute("contentCatList",contentService.getAllContentsByCategory());
		
	}


	/*@RequestMapping(value = "/news/{category}/{contentUrl}", method = RequestMethod.GET)
	public String information(@PathVariable("category") String l1,@PathVariable("contentUrl") String l2,
			ModelMap model,HttpServletResponse response) throws IOException {
		List<ContentData> contentList = new ArrayList<ContentData>();
		ContentData content = new ContentData();
		try {
			if(null!=l1&null!=l2){
				content  = contentService.getContentByCatAndUrl(l1, l2);
				
				getLeftPageContentsList(model);
				contentList  = contentService.getContentsByCategoryUrl(l1);
				if(contentList.size()>0){
					model.addAttribute("contentList",contentList);
					model.addAttribute("category",l1);
					if(null!=content){
						model.addAttribute("content",content);
					}
					return "school.content";
				}
				else{
					return WebConstants.VIEWNAME_ERROR;
				}
				
			}
			else if (l2==null){
				contentList  = contentService.getContentsByCategoryUrl(l1);
				if(contentList.size()>0){
					model.addAttribute("contentList",contentList);
					return "school.contentcat";
				}
				else{
					return WebConstants.VIEWNAME_ERROR;
				}
			}
			else{
				return WebConstants.VIEWNAME_ERROR;
			}
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_CONTENT_VIEW;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_CONTENT_VIEW;
		}
	
	}*/

	
	@RequestMapping(value = "/news/{l1}/{l2}/{l3}", method = RequestMethod.GET)
	public String archiveinfo(@PathVariable("l1") String l1,@PathVariable("l2") String l2,@PathVariable("l3") String l3,
			ModelMap model,HttpServletResponse response) throws IOException {
		List<ContentData> contentList = new ArrayList<ContentData>();
		ContentData content = new ContentData();
		try {
			getLeftPageContentsList(model);
			if(null!=l1&&null!=l2){
				
				if(isInteger(l1)&&isInteger(l2)){
					content  = contentService.getContentsListByYearMonthAndUrl(l1.concat(l2), l3);
					if(null!=content){
						model.addAttribute("content",content);
					}
					return "school.content";
				}	
				else{
					return WebConstants.VIEWNAME_ERROR;
				}
			}
			return WebConstants.VIEWNAME_ERROR;
		}
	 catch (ServiceException e) {
		return WebConstants.VIEWNAME_CONTENT_VIEW;
	} catch (Exception e) {
		return WebConstants.VIEWNAME_CONTENT_VIEW;
	}

}

	@RequestMapping(value = "/news/{l1}/{l2}", method = RequestMethod.GET)
	public String information(@PathVariable("l1") String l1,@PathVariable("l2") String l2,
			ModelMap model,HttpServletResponse response) throws IOException {
		List<ContentData> contentsList = new ArrayList<ContentData>();
		ContentData content = new ContentData();
		
		try {
			getLeftPageContentsList(model);
			if(null!=l1&&null!=l2){
			
				if(isInteger(l1)&&isInteger(l2)){
					//year month 
					String displayname = TSDateUtil.getYearMonthName(Integer.parseInt(l1), Integer.parseInt(l2));
					model.addAttribute("displayname",displayname);
					contentsList  = contentService.getContentsListByYearAndMonth(l1, l2);	
					if(contentsList.size()>0){
						model.addAttribute("contentsList",contentsList);
						return "school.contents";
					}
				}	
				else{
					content  = contentService.getContentByCatAndUrl(l1, l2);
					
					contentsList  = contentService.getContentsByCategoryUrl(l1);
					if(contentsList.size()>0){
						model.addAttribute("contentList",contentsList);
						model.addAttribute("category",l1);
						if(null!=content){
							model.addAttribute("content",content);
						}
						return "school.content";
					}
					else{
						return WebConstants.VIEWNAME_ERROR;
					}
				}
			}
			else if (l2==null&&(!isInteger(l1))){
				contentsList  = contentService.getContentsByCategoryUrl(l1);
					if(contentsList.size()>0){
						model.addAttribute("contentList",contentsList);
						return "school.contentcat";
					}
					else{
						return WebConstants.VIEWNAME_ERROR;
					}
				}
			
			return WebConstants.VIEWNAME_ERROR;
			
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_CONTENT_VIEW;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_CONTENT_VIEW;
		}
	
	}

	@RequestMapping(value = "/news/{category}", method = RequestMethod.GET)
	public String contentsByCategory(@PathVariable("category") String category,
			ModelMap model,HttpServletResponse response) throws IOException {
		List<ContentData> contentsList = new ArrayList<ContentData>();
		model.addAttribute("displayname",category);
		try {
			getLeftPageContentsList(model);
			contentsList = contentService.getContentsByCategoryUrl(category);
			
			//if(contentsList.size()>0){
				model.addAttribute("contentsList",contentsList);
				return "school.contents";
			//}
			
			
			
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_CONTENT_VIEW;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_CONTENT_VIEW;
		}
	
	}
	
	@RequestMapping(value = "/news", method = RequestMethod.GET)
	public String allnews(ModelMap model,HttpServletResponse response) throws IOException {
		List<ContentData> contentsList = new ArrayList<ContentData>();
		try {
			getLeftPageContentsList(model);
			contentsList = contentService.getAllContents();
			
			//if(contentsList.size()>0){
				model.addAttribute("contentsList",contentsList);
				return "school.contents";
			//}
			
			
			
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_CONTENT_VIEW;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_CONTENT_VIEW;
		}
	
	}
	
	
	public  boolean isInteger(String str) {
        int size = str.length();

        for (int i = 0; i < size; i++) {
            if (!Character.isDigit(str.charAt(i))) {
                return false;
            }
        }

        return size > 0;
    }


	private void getLeftPageContentsList(ModelMap model) throws ServiceException {

		//get Recent Updates Of Contents
		model.addAttribute("contentRecList",contentService.getActiveContents(5));
		
		//get category List
		//populateContentSeededData(model);
		
		//get Year wise contents list
		model.addAttribute("contentYrList",contentService.getAllContentsByYrMonth());
		model.addAttribute("contentYrMonthList",contentService.getAllYearMonthList());
		model.addAttribute("catList",contentService.getAllContentCategories());
		
	}
	
	private void reloadColumnContents(HttpServletRequest request) {
		ServletContext context = request.getSession().getServletContext();
		 
		 
			 	columnMenuContainers.loadNewsContentList();
			 	List<MenuContent> newsListNew = new ArrayList<MenuContent>();
			 	newsListNew  = columnMenuContainers.getNewsList();
			 	context.setAttribute("newslist", newsListNew);
	}
	
	
	@RequestMapping(value = WebConstants.VIEW_ALL_ATTACHMENTS)
	public String  viewAllAttachments(@ModelAttribute(value = "attachment") AttachmentData attachmentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		List<AttachmentData> attachmentList = new ArrayList<AttachmentData>();
		String categoryId = request.getParameter("cat");
		String contentId = request.getParameter("cont");
		String action = request.getParameter("action");
		try {
			
			populateContentSeededData(model);
			populateListData(model);
			if(null!=categoryId){
				attachmentList = contentService.getAttachmentsByCategoryId(Integer.parseInt(categoryId));
			}
			else if (null!=contentId){
				attachmentList = contentService.getAttachmentsByContentId(Integer.parseInt(contentId));
			}
			else{
				attachmentList = contentService.getAllAttachments();
			}
			
			model.addAttribute("attachmentList",attachmentList);
			model.addAttribute("attachment",new AttachmentData());
			model.addAttribute("attmt",new AttachmentData());
			model.addAttribute("catid",categoryId);
			model.addAttribute("contid",contentId);
			
			if(action.equalsIgnoreCase("attach")){
				return WebConstants.VIEWNAME_ATTACH;
			}
			else {
				return WebConstants.VIEWNAME_ATTACHMENTS;
			}
			
			
			
			
		} catch (ServiceException e) {
			model.addAttribute("attachmentList",attachmentList);
			return WebConstants.VIEWNAME_ATTACHMENTS;
		} catch (Exception e) {
			model.addAttribute("attachmentList",attachmentList);
			return WebConstants.VIEWNAME_ATTACHMENTS;
		}
	}
	
	@RequestMapping(value = WebConstants.VIEW_ALL_ATTACHMENTS, method = RequestMethod.POST)
	public @ResponseBody AjaxResponse  addAttachments(@ModelAttribute(value = "attachment") AttachmentData attachmentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);	
		StaticData sd = localStaticContainer.getStaticData();
		List<AttachmentData> attachmentList = new ArrayList<AttachmentData>();
		AjaxResponse ajaxRes = new AjaxResponse();
		List<CommonObj> ol = new ArrayList<CommonObj>();
		try {
			populateListData(model);
		if(WebConstants.SEARCH.equalsIgnoreCase(attachmentData.getActionType())){
			if(null!=attachmentData.getContentId()){
				
				attachmentList = contentService.getAttachmentsByContentId(attachmentData.getContentId());
			}
			else if(null!=attachmentData.getCategoryId()){
				
				attachmentList = contentService.getAttachmentsByCategoryId(attachmentData.getCategoryId());
			}
			else{
				
			}
			for(AttachmentData a:attachmentList){
				
				CommonObj o = new CommonObj();
				o.setS1(a.getName());
				o.setS2(a.getType());
				o.setS3(a.getUrl());
				o.setS4(a.getSize());
				o.setS5(a.getCategoryUrl());
				ol.add(o);
			}
		}
		
		else{
				MultipartFile file = attachmentData.getFile();
				String imageName = file.getOriginalFilename();
				UniqueIdGenerator uid = new UniqueIdGenerator();
				String unid = uid.toString();
						 byte[] bytes = ImageUtil.getFixedImageWidth(file.getBytes(), 848);
						String fileFullName = file.getOriginalFilename();
						attachmentData.setName(attachmentData.getName());
						attachmentData.setInsertedby(userName);
						attachmentData.setLastmodifiedby(userName);
						//attachmentData.setAttachementBlob(bytes);
						attachmentData.setType(file.getContentType());
						
						String name = file.getOriginalFilename().toLowerCase().replaceAll("[^a-zA-Z0-9&&[^-.]]", "");
						String n = name.substring(0, name.lastIndexOf("."));
						String t = name.substring(name.lastIndexOf("."));
						String u = n+"-"+System.currentTimeMillis()+t;
						attachmentData.setUnid(unid);
						/*if(isAttachmentExisted(attachmentData.getContentId(),u)){
							ajaxRes.setSuccess(false);
							ajaxRes.setMessage("File Existed with same name under this category.");
							return ajaxRes;
						}
						else{*/
						
						String type = fileFullName.substring(fileFullName.indexOf("."));
						attachmentData.setUrl(unid+type);
						contentService.addAttachment(attachmentData);
						sd.saveFile(unid+type, bytes, type);
						AttachmentData at = contentService.getAttachmentsByName(unid+type);
					ajaxRes.setSuccess(true);
					ajaxRes.setId(at.getId());
					ajaxRes.setUrl(unid+type);
					ajaxRes.setName(at.getName());
					//ajaxRes.setSubName(at.getContent().toLowerCase());
					ajaxRes.setSize(at.getSize());
					String[] f = at.getUrl().split("\\.");
					ajaxRes.setType(f[f.length-1]);
					String[] d = new String[4];
					d[0] = at.getInserted();
					d[1] = at.getInsertedby();
					d[2] = at.getLastmodified();
					d[3] = at.getLastmodifiedby();
					ajaxRes.setData(d);
					
					ajaxRes.setMessage("File Uploaded Successfully.");
						//}
			
				}
		} catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to add image");
			return ajaxRes;
		}
		return ajaxRes;
	}
	
	@RequestMapping(value = WebConstants.DELETE_ATTACHMENT , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteAttachment(
			ModelMap model,
			@ModelAttribute(value = "attmt") AttachmentData attachmentData,
			SessionStatus status) {
		
		AjaxResponse ajaxRes = new AjaxResponse();
		try {
			
			if(null!=attachmentData.getId()){
				contentService.deleteAttachment(attachmentData.getId());
				ajaxRes.setSuccess(true);
				ajaxRes.setMessage("Attachement Deleted.");
			}
			else{
				ajaxRes.setErrormsg("Cannot be deleted.");
			}
			
			
		} catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to Delete Attachment");
		}
		return ajaxRes;
	}
}