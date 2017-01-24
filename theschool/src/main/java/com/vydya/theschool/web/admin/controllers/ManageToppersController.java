package com.vydya.theschool.web.admin.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.CustomImage;
import com.vydya.theschool.common.dto.TopStudentData;
import com.vydya.theschool.common.dto.ToppersGroupData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.common.ColumnMenuContentsService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.home.ManageToppersService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.localstatic.StaticData;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.model.FileMeta;
import com.vydya.theschool.web.utils.UniqueIdGenerator;

@Controller
public class ManageToppersController {

	private final static Logger logger = Logger
			.getLogger(HomePageController.class.getName());

	@Autowired
	protected ManageToppersService toppersService;
	
	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	@Autowired
	protected ColumnMenuContentsService columnMenuContentsService;

	public ManageToppersController() {
		super();
		// TODO Auto-generated constructor stub
	}


	@Autowired
	protected ReferenceDataService referenceDataService;

	 LinkedList<FileMeta> files = new LinkedList<FileMeta>();
	 
	 LinkedHashMap<String, FileMeta> filesMap = new LinkedHashMap<String, FileMeta>();
	    FileMeta fileMeta = null;
	
	@RequestMapping(value = WebConstants.ADD_TOPPERS_GROUP , method = RequestMethod.GET)
	public String viewAddToppersGroup(
			@ModelAttribute(value = "toppersGroupForm") ToppersGroupData toppersGroupData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response,ServletRequest request) {
		
		try {
			model.addAttribute("toppersGroupForm",toppersGroupData);
			return WebConstants.VIEWNAME_TOPPERS_GROUP_ADD_OR_EDIT;
		}

		catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			model.addAttribute("toppersGroupForm",toppersGroupData);
			return WebConstants.VIEWNAME_TOPPERS_GROUP_ADD_OR_EDIT;
		}
	}

	@RequestMapping(value = WebConstants.ADD_TOPPERS_GROUP, method = RequestMethod.POST)
	public String addToppersGroup(
			@ModelAttribute(value = "toppersGroupForm") ToppersGroupData toppersGroupData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		StaticData sd = localStaticContainer.getStaticData();
		//ServletContext context = session.getServletContext();
		CustomImage image = new CustomImage();
		
		if (WebConstants.VIEW.equalsIgnoreCase(toppersGroupData.getActionType())) {
			try {
				
				String uid = ImageUtil.getARandomString();
				toppersGroupData.setUuid(uid);
				toppersGroupData.setActionType(WebConstants.ADD);
				//populateGallerySeededData(model);
				model.addAttribute("toppersGroupForm",toppersGroupData);
				
				image.setUuid(uid);
				model.addAttribute("imageForm",image);
				return WebConstants.VIEWNAME_TOPPERS_GROUP_ADD_OR_EDIT;
			}
			
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("toppersGroupForm", toppersGroupData);
				return WebConstants.VIEWNAME_TOPPERS_GROUP_ALL;
			}
		}
		else if (WebConstants.ADD.equalsIgnoreCase(toppersGroupData.getActionType())) {
			
			UniqueIdGenerator uid = new UniqueIdGenerator();
			String unid = uid.toString();
			
			//MultipartFile file = toppersGroupData.getFile();
			//String imageName = file.getOriginalFilename();
			//String newimageName =unid+imageName.substring(imageName.lastIndexOf("."));
			
			
		try {
			String url  = toppersGroupData.getName().toLowerCase().replaceAll(" ", "-").replaceAll("[^a-zA-Z0-9&&[^-]]", "");
				byte[] filebyte=null;
				String type = null;
				String uuid = toppersGroupData.getUuid();
				if(ss.isExistsImage(uuid+"_CRP")){
					 type = ss.getImageType(uuid+"_CRP");
					filebyte = ss.getImage(uuid+"_CRP");
				}
				else{
					model.addAttribute("toppersGroupForm",toppersGroupData);
					model.addAttribute("imageForm",image);
					result.rejectValue("file",ErrorConstants.TS_1050);			
					return WebConstants.VIEWNAME_TOPPERS_GROUP_ADD_OR_EDIT;
				}
			if(isExistedTopperGroupName(url,toppersGroupData.getId())){
				
				model.addAttribute("toppersGroupForm",toppersGroupData);
				result.rejectValue("name",ErrorConstants.TS_9005);	
				model.addAttribute("imageForm",image);
				
				return WebConstants.VIEWNAME_TOPPERS_GROUP_ADD_OR_EDIT;
			}
			
			String newimageName =unid+type;
			toppersGroupData.setInsertedby(userName);
			toppersGroupData.setUnid(unid);
			toppersGroupData.setUrl(url);
			toppersGroupData.setLastmodifiedby(userName);
			//toppersGroupData.setPhoto(filebyte);
			toppersGroupData.setActive(1);
			toppersGroupData.setImageName(newimageName);
			toppersService.saveToppersGroup(toppersGroupData);
			sd.saveImage(newimageName, filebyte,"T");
			//context.removeAttribute("cropedImage");
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9003);
			return "redirect:viewGroups.htm";

		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9004);
			model.addAttribute("toppersGroupForm", toppersGroupData);
			return WebConstants.VIEWNAME_TOPPERS_GROUP_ADD_OR_EDIT;
		}
		}
		return "redirect:viewGroups.htm";
	}
	
	
	@RequestMapping(value = WebConstants.VIEW_TOPPERS_GROUP, method = RequestMethod.GET)
	public  String viewToppersGroup(
			ModelMap model,ServletRequest request,
			@ModelAttribute(value = "toppersGroupForm") ToppersGroupData toppersGroupData,
			SessionStatus status) {
		List<ToppersGroupData> toppersGroupList = new ArrayList<ToppersGroupData>();
		try {
			
			String year = request.getParameter("y");
			if(year==null){
				year = TSDateUtil.getCurrentYear();
			}
			toppersGroupList = toppersService.fetchAllToppersGroups(year);
			model.addAttribute("toppersGroupForm", new ToppersGroupData());
			model.addAttribute("toppersGroupList", toppersGroupList);
			
			return WebConstants.VIEWNAME_TOPPERS_GROUP_ALL;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_TOPPERS_GROUP_ALL;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_TOPPERS_GROUP_ALL;
		}
	}

	@RequestMapping(value = WebConstants.EDIT_TOPPERS_GROUP)
	public String editTopperGroup(
			@ModelAttribute(value = "toppersGroupForm") ToppersGroupData tGroupData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		StaticData sd = localStaticContainer.getStaticData();
		CustomImage image = new CustomImage();
		//ServletContext context = session.getServletContext();
		if (WebConstants.VIEW.equalsIgnoreCase(tGroupData.getActionType())) {
			try {
				ToppersGroupData tgroupData2 = null;
				if(null!=tGroupData.getId()){
					tgroupData2=	toppersService.getToppersGroupById(tGroupData.getId());
				}
				String uuid = ImageUtil.getARandomString();
				tgroupData2.setActionType(WebConstants.UPDATE);
				tgroupData2.setUuid(uuid);
				image.setUrl(tgroupData2.getImageName());
				image.setUuid(uuid);
				model.addAttribute("imageForm",image);
				model.addAttribute("toppersGroupForm",tgroupData2);
				return WebConstants.VIEWNAME_TOPPERS_GROUP_ADD_OR_EDIT;
			}
			
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("toppersGroupForm", tGroupData);
				return WebConstants.VIEWNAME_TOPPERS_GROUP_ALL;
			}
		}
		else if (WebConstants.UPDATE.equalsIgnoreCase(tGroupData.getActionType())) {
			
		try {
			//MultipartFile file = tGroupData.getFile();
			//String imageName = file.getOriginalFilename();
			byte[] filebyte=null;
			String type = null;
			String uuid = tGroupData.getUuid();
			String url  = tGroupData.getName().toLowerCase().replaceAll(" ", "-").replaceAll("[^a-zA-Z0-9&&[^-]]", "");
			if(ss.isExistsImage(uuid+"_CRP")){
				 type = ss.getImageType(uuid+"_CRP");
				filebyte = ss.getImage(uuid+"_CRP");
			}
			if(isExistedTopperGroupName(url,tGroupData.getId())){
				model.addAttribute("toppersGroupForm",tGroupData);
				model.addAttribute("imageForm",image);
				result.rejectValue("name",ErrorConstants.TS_9005);			
				return WebConstants.VIEWNAME_TOPPERS_GROUP_ADD_OR_EDIT;
			}
			tGroupData.setUrl(url);
			tGroupData.setLastmodifiedby(userName);
			//tGroupData.setPhoto(filebyte);
			
			if(null!=filebyte){
				String newimageName =tGroupData.getUnid()+type;
				tGroupData.setImageName(newimageName);
				sd.saveImage(newimageName, filebyte, null);
			}
			toppersService.editToppersGroup(tGroupData);
			//context.removeAttribute("cropedImage");
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9006);
			return "redirect:viewGroups.htm";

		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9007);
			model.addAttribute("toppersGroupForm", tGroupData);
			/*ajaxRes.setSuccess(false);
			ajaxRes.setErrormsg("Unable to save Event Data");*/
			return WebConstants.VIEWNAME_TOPPERS_GROUP_ADD_OR_EDIT;
		}
		}
		return "redirect:viewGroups.htm";
	}
	
	@RequestMapping(value = WebConstants.VIEW_TOPPERS,method = RequestMethod.GET)
	public String viewTopStudents(
			ModelMap model,ServletRequest request,
			@ModelAttribute(value = "toppersGroupForm") ToppersGroupData data,
			SessionStatus status) {
		
		ToppersGroupData toppersGroupData  = null;
		try {
			int groupId= Integer.parseInt(request.getParameter("t"));
			List<TopStudentData> topStudentList = toppersService.getTopStudentsByToppersId(groupId,null);
			
			 toppersGroupData = toppersService.getToppersGroupById(groupId);
			
			CustomImage i  =new CustomImage();
			model.addAttribute("imageForm", i);
			model.addAttribute("topStudentsForm", new TopStudentData());
			model.addAttribute("topStudentsList", topStudentList);
			model.addAttribute("toppersGroup",toppersGroupData);
			model.addAttribute("imageTableForm", new TopStudentData() );
			return WebConstants.VIEW_NAME_VIEW_TOPPERS;
		} catch (ServiceException e) {
			return WebConstants.VIEW_NAME_VIEW_TOPPERS;
		} catch (Exception e) {
			model.addAttribute("toppersGroup",toppersGroupData);
			return WebConstants.VIEW_NAME_VIEW_TOPPERS;
		}
	}
	
	@RequestMapping(value = WebConstants.EDIT_TOPPERS , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse editTopper(
			ModelMap model,
			@ModelAttribute(value = "imageTableForm") TopStudentData imageData,HttpSession session,
			SessionStatus status) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse ajaxRes = new AjaxResponse();
		try {
			
			if(null!=imageData.getStudentId()){
				imageData.setLastmodifiedby(userName);
				toppersService.editTopStudent(imageData);
			}
			ajaxRes.setSuccess(true);
			ajaxRes.setMessage("Student Updated.");
			
		} catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to update Student");
		}
		return ajaxRes;
	}
	
	@RequestMapping(value = WebConstants.ADD_TOPPER)
	public String showAddTopStudents(
			@ModelAttribute(value = "topStudnetForm") TopStudentData topStudentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {

		try {
			topStudentData.setActionType(WebConstants.ADD);
			model.addAttribute("topStudnetForm", topStudentData);
			
			return WebConstants.VIEWNAME_ADD_OR_EDIT_TOPPER;
		}

		catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),
					e);
			logger.error(exp, e);
			model.addAttribute("topStudnetForm", topStudentData);
			return WebConstants.VIEWNAME_ADD_OR_EDIT_TOPPER;
		}
	}

	@RequestMapping(value = WebConstants.ADD_TOPPER, method = RequestMethod.POST)
	public  @ResponseBody TopStudentData addTopStudent(
			@ModelAttribute(value = "topStudnetForm") TopStudentData topStudentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {
		AjaxResponse ajaxRes = new AjaxResponse();
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);	
		ServletContext context = session.getServletContext();
		//byte[] filebyte = (byte[]) context.getAttribute("cropedImage");
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		TopStudentData st = new TopStudentData();
		StaticData sd = localStaticContainer.getStaticData();
		CustomImage image = new CustomImage();
		try{
			UniqueIdGenerator uid = new UniqueIdGenerator();
			String unid = uid.toString();
			
			String uuid = topStudentData.getUuid();
			String type = null;
			byte[] filebyte=null;
			if(ss.isExistsImage(uuid+"_CRP")){
				 type = ss.getImageType(uuid+"_CRP");
				filebyte = ss.getImage(uuid+"_CRP");
			}
			
			String newimageName =unid+type;
			topStudentData.setUnid(unid);
			topStudentData.setImageName(newimageName);
			topStudentData.setInsertedby(userName);
			topStudentData.setLastmodifiedby(userName);
			toppersService.saveTopStudent(topStudentData);
			sd.saveImage(newimageName, filebyte, type);
			model.addAttribute("topStudnetForm", new TopStudentData());
			ajaxRes.setSuccess(true);
				
			st = toppersService.loadUploadedTopperByGroupId(topStudentData.getToppersGroupId());
			if(!sd.isExistsOrginalImage(st.getImageName())){
				st.setImageName(null);
			}
			
			st.setSuccess(true);
			st.setMessage("Topper added Successfully.");

					return st;
				} catch (Exception e) {
					st.setSuccess(false);
					st.setMessage("Unable to add image");
				return st;
				} 
			}
	
	@RequestMapping(value = WebConstants.DELETE_TOPPERS_GROUP , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteTopperGroup(
			ModelMap model,
			@ModelAttribute(value = "toppersGroupForm") ToppersGroupData data,HttpServletRequest request,
			SessionStatus status) {
		
		AjaxResponse ajaxRes = new AjaxResponse();
		try {
			
			if(null!=data.getId()){
				toppersService.deleteToppersGroup(data);
				columnMenuContentsService.deleteContentExisted(data.getId(), "TOPPERS",request);
			}
			ajaxRes.setSuccess(true);
			ajaxRes.setMessage("Toppers Group Deleted.");
			
		} catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to delete Toppers Group");
		}
		return ajaxRes;
	}
	@RequestMapping(value = WebConstants.DELETE_TOPPER , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteTopper(
			ModelMap model,
			@ModelAttribute(value = "imageTableForm") TopStudentData data,
			SessionStatus status) {
		
		AjaxResponse ajaxRes = new AjaxResponse();
		try {
			
			if(null!=data.getStudentId()){
				toppersService.deleteTopStudent(data);
			}
			ajaxRes.setSuccess(true);
			ajaxRes.setMessage("Student Deleted.");
			
		} catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to delete Student");
		}
		return ajaxRes;
	}
	
	@RequestMapping(value="admin/manageToppers/upload.htm", method = RequestMethod.POST)
    public @ResponseBody LinkedList<FileMeta> upload(MultipartHttpServletRequest request, HttpSession session,
    		HttpServletResponse response) {
 
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
        //1. build an iterator
         Iterator<String> itr =  request.getFileNames();
         MultipartFile mpf = null;
 
         //2. get each file
         while(itr.hasNext()){
 
             //2.1 get next MultipartFile
             mpf = request.getFile(itr.next()); 
             System.out.println(mpf.getOriginalFilename() +" uploaded! "+files.size());
 
             //2.2 if files > 10 remove the first from the list
             if(files.size() >= 10)
                 files.pop();
 
             if(filesMap.size()>=10){
            	 filesMap.clear();
             }
             //2.3 create new fileMeta
             fileMeta = new FileMeta();
             fileMeta.setFileName(mpf.getOriginalFilename());
             fileMeta.setFileSize(mpf.getSize()/1024+" Kb");
             fileMeta.setFileType(mpf.getContentType());
 
             try {
                fileMeta.setBytes(mpf.getBytes());
                fileMeta.setImage(ImageUtil.getImageAsString(mpf.getBytes()));
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
             //2.4 add to files
             files.add(fileMeta);
             filesMap.put(userName, fileMeta);
         }
        // result will be like this
        // [{"fileName":"app_engine-85x77.png","fileSize":"8 Kb","fileType":"image/png"},...]
        return files;
    }

	
	/*@RequestMapping(value = WebConstants.UPLOAD_TOPPERIMAGE, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse uploadGalleryPhoto( @ModelAttribute(value = "topStudnetForm") CustomImage image,HttpSession session,
			ModelMap model,
			SessionStatus status) {
		AjaxResponse ajaxRes = new AjaxResponse();
		MultipartFile file = image.getImageFile();
		String unid = image.getUnid();
		 StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		try {
			if(null!=image.getActionType()&&WebConstants.CROP.equalsIgnoreCase(image.getActionType())){
				//CustomImage image = image;
				byte[] filebyte = ss.getImage(unid+"_ORG");
				image.setImageBytes(filebyte);
				byte[] cropedImage = ImageUtil.getFixedImageWidth(ImageUtil.cropImage(image), 177);
				ss.saveImage(unid+"_CRP", cropedImage);
				ajaxRes.setValid(true);
				ajaxRes.setImage(ImageUtil.getImageAsString(cropedImage));
			}
			else{
				if(file.getSize()!=0){
					byte[] filebyte = ImageUtil.getImageForCropByWidth(file.getBytes(),850); 
					ajaxRes.setValid(true);
					ajaxRes.setImage(ImageUtil.getImageAsString(filebyte));
					ss.saveImage(unid+"_ORG", filebyte);
					}
			}
			return ajaxRes;
		} catch (Exception e) {
		return ajaxRes;
		} 
	}
	*/
	
	
	@RequestMapping(value = WebConstants.UPLOAD_TOPPERIMAGE, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse uploadGroupImage( @ModelAttribute(value = "imageForm") CustomImage image,HttpSession session,
			ModelMap model,
			SessionStatus status) {
		AjaxResponse ajaxRes = new AjaxResponse();
		MultipartFile file = image.getImageFile();
		String uuid = image.getUuid();
		byte[] filebyte = null;
		 try {
				StaticSession ss = (StaticSession)session.getAttribute("staticSession");
				if(image.isDontCrop()){
					if(image.getPriority().equalsIgnoreCase("1")){
						filebyte = ImageUtil.getDontCropImage(file.getBytes(), 335, 848);
					}
					else if(image.getPriority().equalsIgnoreCase("2")){
						
						filebyte = ImageUtil.getDontCropImage(file.getBytes(), 200, 160);
					}
					
					ajaxRes.setValid(true);
					ajaxRes.setDontCrop(true);
					ajaxRes.setImage(ImageUtil.getImageAsString(filebyte));
					ss.saveImage(uuid+"_CRP", filebyte);
						
				}
				else{
					if(null!=image.getActionType()&&WebConstants.CROP.equalsIgnoreCase(image.getActionType())){
						
						if(image.getPriority().equalsIgnoreCase("1")){
							image.setFixedW(848);
						}
						else if(image.getPriority().equalsIgnoreCase("2")){
							image.setFixedW(160);
						}
						 filebyte = ss.getImage(uuid+"_ORG");
						image.setImageBytes(filebyte);
						byte[] cropedImage = ImageUtil.cropImage(image);
						ss.saveImage(uuid+"_CRP", cropedImage);
						ajaxRes.setValid(true);
						ajaxRes.setImage(ImageUtil.getImageAsString(cropedImage, 362));
					}
					else{
						
						if(file.getSize()!=0){
							filebyte = ImageUtil.getModerateImageForCrop(file.getBytes());
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
	
	
	private boolean isExistedTopperGroupName(String grName,Integer id) {
		boolean isExisted = false;
		try {
			isExisted =  toppersService.isToppersGroupAvailable(grName,id);
			} catch (Exception e) {
				 isExisted = true;
			}
			return isExisted;
	}
	
}