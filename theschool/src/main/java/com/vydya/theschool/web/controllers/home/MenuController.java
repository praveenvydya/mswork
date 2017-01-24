package com.vydya.theschool.web.controllers.home;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.vydya.theschool.common.dto.CustomImage;
import com.vydya.theschool.common.dto.MenuData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.FileException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.FileUtil;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.services.api.common.MenuService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.localstatic.StaticData;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.utils.UniqueIdGenerator;



@Controller
public class MenuController {

	private final static Logger logger = Logger
			.getLogger(MenuController.class.getName());
	
	@Autowired
	protected MenuService  menuService;
	
	@Autowired(required=true)
	public SchoolAdminProperties properties;
	
	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	@RequestMapping(value = WebConstants.VIEW_ALL_MENUS)
	public String  viewAllContents(@ModelAttribute(value = "menuForm") MenuData menudata,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		List<MenuData> menusList = new ArrayList<MenuData>();
		
		try {	
		
	
			return WebConstants.VIEWNAME_MENU_ALL;
		
		} catch (Exception e) {
			return WebConstants.VIEWNAME_MENU_ALL;
		}
}
		
		
		
	/*	
		String type = request.getParameter("type");
		try {
			
				if(null!=type&&type.equalsIgnoreCase("reload")){
					reloadMenu(request);
					session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
							ErrorConstants.TS_9088);
				}
				
				
			//populateMenuData(model);
			menusList = menuService.getAllMenus();
			model.addAttribute("menusList",menusList);
			model.addAttribute("menuForm",new MenuData());
			   
			return WebConstants.VIEWNAME_MENU_ALL;
			
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_MENU_ALL;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_MENU_ALL;
		}
	}
	*/
	
	@RequestMapping(value = WebConstants.LOAD_MENU, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse load(@RequestBody String jsonString,
				ModelMap model,
				HttpServletResponse response,HttpSession session,HttpServletRequest request,
				SessionStatus status) {
			
			AjaxResponse ajresp = new AjaxResponse();
				try{
					JSONObject jsonOb = new JSONObject(jsonString);
						String type= (String) jsonOb.get("type");
					if(null!=type&&type.equalsIgnoreCase("m")){
						List<MenuData> menulist = null;
						//menulist= menuService.getListForMenu();
						menulist= menuService.getAllMenus();
						ajresp.setRespData(menulist);
						return ajresp;
					}
					
					//all attachments of menu 
					if(null!=type&&type.equalsIgnoreCase("at")){
						List<AttachmentData> attachmentList = new ArrayList<AttachmentData>();
						Integer menuId= (Integer) jsonOb.get("menuId");
						if(null!=menuId){
							attachmentList = menuService.getAttachmentsByMenuId(menuId);
						}
						ajresp.setRespData(attachmentList);
						return ajresp;
					}
						
				} catch (ServiceException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			//	response.setHeader("Access-Control-Allow-Origin", "*");//Cross-Origin Resource Sharing (CORS)
				return ajresp;
		}
	
	
	
	
	/*private void reloadMenu(HttpServletRequest request) {
		  
		AjaxMenuData menuData = new AjaxMenuData();
		  ServletContext context = request.getSession().getServletContext();
			try {
				 
				 
				 //System.out.println( request.getServerName() +" - "+ request.getServerPort());
				 List<AjaxMenuData> dmenuList = (List<AjaxMenuData>) context.getAttribute("dmenuList");
				if(null==dmenuList){

					String path = properties.getLocalPathForDBdata()+"/staticData/xmls/schoolMenu.xml";
					File file = new File(path);
					if(!file.exists()){
						file.mkdirs();
					}
					JAXBContext jaxbContext = JAXBContext.newInstance(AjaxMenuData.class);
					Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
					menuData = (AjaxMenuData) jaxbUnmarshaller.unmarshal(file);
					dmenuList=menuData.getSubMenu();
					context.removeAttribute("menuString");
					String menu = formMenu(dmenuList);
					context.setAttribute("menuString",menu);
				}
		 
			  } catch (JAXBException e) {
				e.printStackTrace();
			  }
				
		}
	*/
	private void reloadMenu(HttpServletRequest request) {
		 
		 ServletContext context = request.getSession().getServletContext();

		 String appName = (String) context.getAttribute("application.name");
		 String contextPath = request.getContextPath();
		 
			try {
					
				String menuString= 	menuService.loadorReloadXmlMenu(appName,contextPath);
				context.removeAttribute("menuString");
				context.setAttribute("menuString", menuString);
					
				} catch (ServiceException e) {
					//return WebConstants.VIEWNAME_MENU_ALL;
				} 

			}
	
	 /* private String formMenu(List<AjaxMenuData> dmenuList){
		  StringBuffer ms= new StringBuffer();
		  for(AjaxMenuData menu:dmenuList){
			  ms.append("<li class='cl"+menu.getMenuId()+"' id='menuli'><a href='/theschool/school/page/"+menu.getPath()+"'>"+menu.getName()+"</a>");
			  if(null!=menu.getSubMenu()){
				  ms.append("<ul class='ul-menu'");
				  formSubMenu(menu,ms);
				  ms.append("</ul>");
			  }
			  ms.append("</li>");
		  }
		  
		  return ms.toString();
	  }
	   
	  private void formSubMenu(AjaxMenuData menuSub,StringBuffer ms){
		  
		  //StringBuffer ms = new StringBuffer();
		  List<AjaxMenuData> dmenuList = menuSub.getSubMenu();
		  
		  for(AjaxMenuData menu:dmenuList){
			 
			  ms.append("<li class='cl"+menu.getMenuId()+"' id='menuli'><a href='/theschool/school/page/"+menu.getPath()+"'>"+menu.getName()+"</a>");
			  if(null!=menu.getSubMenu()){
				  ms.append("<ul class='ul-menu'");
				  formSubMenu(menu,ms);
				  ms.append("</ul>");
			  }
		  }
		  
	  }*/
	  
	
	
	  
	  
	@RequestMapping(value = WebConstants.VIEW_MENU, method = RequestMethod.GET)
	public String  viewContent(@ModelAttribute(value = "menuForm") MenuData menuData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		String menuId = request.getParameter("id");
		StaticData sd = localStaticContainer.getStaticData();
		try {
			//populateMenuData(model);
			if(null!=menuId){
				 menuData = menuService.getMenu(Integer.parseInt(menuId));
			}
			menuData.setHtml(sd.getContent(menuData.getUnid()));
			model.addAttribute("menuForm",menuData);
		return WebConstants.VIEWNAME_MENU_VIEW;	
		} catch (ServiceException e) {
			model.addAttribute("menuForm",menuData);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9016);
			return WebConstants.VIEWNAME_MENU_VIEW;
		} catch (Exception e) {
			model.addAttribute("menuForm",menuData);
			return WebConstants.VIEWNAME_MENU_VIEW;
		}
	}
	
	
	
	@RequestMapping(value = WebConstants.ADD_MENU, method = RequestMethod.POST)
	@ResponseBody AjaxResponse add(@RequestBody String jsonString,
			HttpSession session,HttpServletResponse response,HttpServletRequest request) {
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		StaticData sd = localStaticContainer.getStaticData();
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		MenuData menu = new MenuData();
		AjaxResponse aresponse = new AjaxResponse();
			  try {
				  JSONObject jsonOb = new JSONObject(jsonString);
				  UniqueIdGenerator uid1 = new UniqueIdGenerator();
					String unid = uid1.toString();
					byte[] filebyte = ImageUtil.getStringAsImage((String) jsonOb.get("image"));
					String imageType = FileUtil.getImageMimeType(filebyte);

					menu.setInsertedby(userName);
					menu.setLastmodifiedby(userName);
					menu.setActive(1);
					menu.setImageName(unid+"."+imageType);
				
				
				if(isMenuExisted(menu.getPath(),menu.getMenuId())){
					
					
				}
				else{
					
					if(menu.getMenuType().equalsIgnoreCase("new")||(!menu.getMenuType().equalsIgnoreCase("child"))){
						menu.setParentId(0);
					}
					menuService.addMenu(menu);
					sd.saveImage(menu.getImageName(), filebyte, null);
					sd.saveContent(unid, menu.getHtml(), null);
					aresponse.setSuccess(true);
					if(aresponse.isSuccess()){
						aresponse.setRespData(menu);
						aresponse.setMessage("Successfully Saved Menu Page.");
						return aresponse;
					}
					else{
						
						aresponse.setSuccess(false);
						aresponse.setMessage("Unable to add Menu Page.");
						return aresponse;
					}
				}
				
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
			}
			  return aresponse;
	}
	
	

	@RequestMapping(value = WebConstants.ADD_MENU, method = RequestMethod.POST)
	@ResponseBody AjaxResponse update(@RequestBody String jsonString,
			HttpSession session,HttpServletResponse response,HttpServletRequest request) {

		//MenuData menu = menuService.getMenu(menuData.getMenuId());
		
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		StaticData sd = localStaticContainer.getStaticData();
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		MenuData menu = new MenuData();
		AjaxResponse aresponse = new AjaxResponse();
			  try {
				  JSONObject jsonOb = new JSONObject(jsonString);
				  
				  // convert json to MenuData 
				  
				//  MenuData menu = menuService.getMenu(menuData.getMenuId());
				  
					byte[] filebyte = ImageUtil.getStringAsImage((String) jsonOb.get("image"));
					String imageType = FileUtil.getImageMimeType(filebyte);

					menu.setInsertedby(userName);
					menu.setLastmodifiedby(userName);
					menu.setActive(1);
					menu.setImageName(menu.getUnid()+"."+imageType);
				
				
				if(isMenuExisted(menu.getPath(),menu.getMenuId())){
					
					
				}
				else{
					
					if(menu.getMenuType().equalsIgnoreCase("new")||(!menu.getMenuType().equalsIgnoreCase("child"))){
						menu.setParentId(0);
					}
					menuService.updateMenu(menu);
					sd.saveImage(menu.getImageName(), filebyte, null);
					sd.saveContent(menu.getUnid(), menu.getHtml(), null);
					aresponse.setSuccess(true);
					if(aresponse.isSuccess()){
						aresponse.setRespData(menu);
						aresponse.setMessage("Successfully Saved Menu Page.");
						return aresponse;
					}
					else{
						
						aresponse.setSuccess(false);
						aresponse.setMessage("Unable to add Menu Page.");
						return aresponse;
					}
				}
				
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				
			}
			  return aresponse;
		}
	

	
	@RequestMapping(value = WebConstants.DELETE_MENU)
	public  @ResponseBody AjaxResponse delete(@RequestBody String jsonString,
			ModelMap model,HttpServletRequest request,
			SessionStatus status) {
		
		AjaxResponse ajaxRes = new AjaxResponse();
		try{
			JSONObject jsonOb = new JSONObject(jsonString);
				String type= (String) jsonOb.get("type");
				Integer id = (Integer) jsonOb.get("id");
				
			if(null!=type&&type.equalsIgnoreCase("m")&&null!=id){
				menuService.deleteMenu(id);
				ajaxRes.setSuccess(true);
				ajaxRes.setMessage("Menu Deleted");
				return ajaxRes;
			}
			
			//all attachments of menu 
			if(null!=type&&type.equalsIgnoreCase("at")&&null!=id){
				menuService.deleteAttachment(id);
				ajaxRes.setSuccess(true);
				ajaxRes.setMessage("Menu Attachment");
				return ajaxRes;
			
			}
		}
			catch (Exception e) {
				
				ajaxRes.setSuccess(false);
				ajaxRes.setException(e.getMessage());
				ajaxRes.setErrormsg("Unable to delete Any Item");
			}
				return ajaxRes;
		}


	/*@RequestMapping(value = WebConstants.UPLOAD_MENU_IMAGE, method = RequestMethod.POST)
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
	
	/*private void populateMenuData(ModelMap model) throws ServiceException {
		
		model.addAttribute("menulist",menuService.getAllMenus());
		
	}*/
	
	
	private boolean isMenuExisted(String url,Integer menuId) {
		boolean isExisted = true;
		try {
			
			isExisted =  menuService.isExistedMenu(url,menuId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isExisted;
	}

	/*@RequestMapping(value = WebConstants.VIEW_MENU_ATTACHMENTS)
	public @ResponseBody List<AttachmentData> viewAllAttachments(
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		List<AttachmentData> attachmentList = new ArrayList<AttachmentData>();
		String menuId = request.getParameter("mid");
		try {
			
			//populateContentSeededData(model);
			//populateListData(model);
			if(null!=menuId){
				attachmentList = menuService.getAttachmentsByMenuId(Integer.parseInt(menuId));
			}
			else{
				attachmentList = menuService.getAllAttachments();
			}
			
			model.addAttribute("attachmentList",attachmentList);
			model.addAttribute("attachment",new AttachmentData());
			model.addAttribute("attmt",new AttachmentData());
			model.addAttribute("menuId",menuId);
			
			
		} catch (ServiceException e) {
			model.addAttribute("attachmentList",attachmentList);
		} catch (Exception e) {
			model.addAttribute("attachmentList",attachmentList);
		}
		return attachmentList;
	}
	*/
	/*@RequestMapping(value = WebConstants.VIEW_MENU_ATTACHMENTS, method = RequestMethod.POST)
	public @ResponseBody AjaxResponse  addAttachments(@ModelAttribute(value = "attachment") AttachmentData attachmentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,HttpServletRequest request) {
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);	
		StaticData sd = localStaticContainer.getStaticData();
		AjaxResponse ajaxRes = new AjaxResponse();
		try {
			//populateListData(model);
		//if(WebConstants.ADD.equalsIgnoreCase(attachmentData.getActionType())){
			
				MultipartFile file = attachmentData.getFile();
				
				String unid = attachmentData.getUnid();// unid of menu
				String uuid = ImageUtil.getARandomString();
						byte[] bytes = file.getBytes();
						String fileName = file.getOriginalFilename();
						attachmentData.setName(attachmentData.getName());
						attachmentData.setInsertedby(userName);
						attachmentData.setLastmodifiedby(userName);
						attachmentData.setType(file.getContentType());
						
						String name = fileName.toLowerCase().replaceAll("[^a-zA-Z0-9&&[^-.]]", "");

						String fileFullName = unid+"_"+uuid+"_"+name;
									
						attachmentData.setUrl(fileFullName);
						menuService.addAttachment(attachmentData);
						sd.saveMenuAttachment(fileFullName, bytes, null);
						
						AttachmentData at = menuService.getAttachmentsByUrl(fileFullName);
					ajaxRes.setSuccess(true);
					ajaxRes.setId(at.getId());
					ajaxRes.setUrl(fileFullName);
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
			
		} catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to add image");
			return ajaxRes;
		}
		return ajaxRes;
	}*/
	
	/*@RequestMapping(value = WebConstants.DELETE_MENU_ATTACHMENT , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteAttachment(
			ModelMap model,
			@ModelAttribute(value = "attachment") AttachmentData attachmentData,
			SessionStatus status) {
		
		AjaxResponse ajaxRes = new AjaxResponse();
		try {
			
			if(null!=attachmentData.getId()){
				menuService.deleteAttachment(attachmentData.getId());
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
	*/
}