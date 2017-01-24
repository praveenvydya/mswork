package com.vydya.theschool.web.admin.controllers;

import java.util.List;
import java.util.Locale;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.CustomImage;
import com.vydya.theschool.common.dto.GalleryData;
import com.vydya.theschool.common.dto.HomePageImageData;
import com.vydya.theschool.common.dto.ReferenceData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.FileException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.FileUtil;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.home.HomePageImageService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.localstatic.StaticData;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.utils.UniqueIdGenerator;

@Controller
public class HomePageController {

	private final static Logger logger = Logger
			.getLogger(HomePageController.class.getName());

	@Autowired
	protected HomePageImageService homePageImageService;

	@Autowired
	protected ReferenceDataService referenceDataService;
	
	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	
	
	public HomePageController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@RequestMapping(value = WebConstants.VIEW_ALL_HOMEPAGE_IMAGES)
	public String viewAll(
			ModelMap model,
			@ModelAttribute(value = "homePageImageForm") HomePageImageData homePageImage,
			SessionStatus status) {

		try {
			
			return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ALL;


		} catch (Exception e) {
			return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ALL;
		}
	}
	
	@RequestMapping(value = "admin/manageHomePage/view.htm")
	public @ResponseBody
	String ajaxGet(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		String response = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			JSONObject jsonOb = new JSONObject(jsonString);
			List<HomePageImageData> homePageImagesList = homePageImageService
					.loadAllHomePageImages();
				response = mapper.writeValueAsString(homePageImagesList);


			return response;
		} catch (ServiceException e) {
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return response;
		}
	}
	

	/*@RequestMapping(value = WebConstants.ADD_HOMEPAGE_IMAGES, method = RequestMethod.POST)
	public String addNewHomePage(
			@ModelAttribute(value = "homePageImageForm") HomePageImageData homePageImage,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) throws ServiceException {

		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		StaticData sd = localStaticContainer.getStaticData();
		
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		if (WebConstants.VIEW.equalsIgnoreCase(homePageImage.getActionType())) {
			try {
				String uuid = ImageUtil.getARandomString();
				homePageImage.setUuid(uuid);
				CustomImage i = new CustomImage();
				i.setUuid(uuid);
				model.addAttribute("imageForm",i);
				homePageImage.setActionType(WebConstants.ADD);
				populateHomePageSeededData(model, session);
				model.addAttribute("homePageImage",homePageImage);
				return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ADD_OR_EDIT;
			}
			
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("homePageImage", homePageImage);
				return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ALL;
			}
		}
		else if (WebConstants.ADD.equalsIgnoreCase(homePageImage.getActionType())) {
			UniqueIdGenerator uid = new UniqueIdGenerator();
			String unid = uid.toString();
			try {
				byte[] filebyte=null;
				String type = null;
				//MultipartFile file = homePageImage.getFile();
				//String imageName = file.getOriginalFilename();
								
				if(ss.isExistsImage(homePageImage.getUuid()+"_CRP")){
					 type = ss.getImageType(homePageImage.getUuid()+"_CRP");
					filebyte = ss.getImage(homePageImage.getUuid()+"_CRP");
				}
				else{
					model.addAttribute("homePageImage",homePageImage);
					result.rejectValue("file",ErrorConstants.TS_9055);			
					return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ADD_OR_EDIT;
				}

				homePageImage.setImageName(unid+type);
				homePageImage.setUnid(unid);
				homePageImage.setImageCategory("SCHOOL");
				homePageImage.setInsertedby(userName);
				homePageImage.setLastmodifiedby(userName);
				
				homePageImageService.addImage(homePageImage);
				sd.saveImage(unid+type, filebyte, null);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE ,ErrorConstants.TS_9031);
				return WebConstants.REDIRECT_VIEWALL_HOMEPAGE_IMAGES;
				
			}
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("homePageImage", homePageImage);
				return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ADD_OR_EDIT;
			}
		}
		return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ALL;

	}
*/	
	
	@RequestMapping(value = WebConstants.EDIT_HOMEPAGE_IMAGES)
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
			 // JSONObject blobI=jsonOb.getJSONObject("imageBlob");
			  //jsonOb.remove("imageBlob");//imageBlob
					HomePageImageData hi = new HomePageImageData();
					byte[] filebyte =null;
					String imageType=null;
					if(jsonOb.has("fileToUpload")&&(!jsonOb.isNull("fileToUpload"))){
						filebyte=ImageUtil.getStringAsImage((String) jsonOb.get("fileToUpload"));
						hi.setImageName((String) jsonOb.get("unid")+"."+FileUtil.getImageMimeType(filebyte));
					}
					hi.setId((Integer) jsonOb.get("id"));
					hi.setUnid((String) jsonOb.get("unid"));
					hi.setTitle((String) jsonOb.get("title"));
					hi.setCaption((String) jsonOb.get("caption"));
					hi.setInsertedby(userName);
					hi.setLastmodifiedby(userName);
					hi.setTitlePosition((String) jsonOb.get("titlePosition"));
					homePageImageService.editImage(hi);
					if(null!=filebyte){
						sd.saveImage(hi.getImageName(), filebyte, null);
					}
					aresponse.setSuccess(true);
					aresponse.setMessage("Successfully Saved Home Page Image.");

		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9007);
			aresponse.setSuccess(false);
			aresponse.setErrormsg(e.getMessage());
		}
		return aresponse;
	}

	@RequestMapping(value = WebConstants.ADD_HOMEPAGE_IMAGES)
	public @ResponseBody AjaxResponse addHomePage(@RequestBody String jsonString,
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
			  UniqueIdGenerator uid = new UniqueIdGenerator();
				String unid = uid.toString();
			 // JSONObject blobI=jsonOb.getJSONObject("imageBlob");
					HomePageImageData hi = new HomePageImageData();
					String caption = (String) jsonOb.get("caption");
					String title = (String) jsonOb.get("title");
					String pos = (String) jsonOb.get("titlePosition");
					
					byte[] filebyte = ImageUtil.getStringAsImage((String) jsonOb.get("fileToUpload"));
					
					String imageType = FileUtil.getImageMimeType(filebyte);
					
					
					hi.setUnid(unid);
					hi.setImageName(unid+"."+FileUtil.getImageMimeType(filebyte));
					hi.setTitle(title);
					hi.setCaption(caption);
					hi.setInsertedby(userName);
					hi.setLastmodifiedby(userName);
					hi.setTitlePosition(pos);
					hi.setImageCategory("");
					homePageImageService.addImage(hi);
					//hi = homePageImageService.getByUnid(unid);
					if(null!=filebyte){
						sd.saveImage(hi.getImageName(), filebyte, null);
					}
					//aresponse.setRespData(hi);
					aresponse.setSuccess(true);
					aresponse.setMessage("Successfully Saved Home Page Image.");
					


		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9007);
			aresponse.setSuccess(false);
			aresponse.setErrormsg(e.getMessage());
		}
		return aresponse;
	}


	
	/*@RequestMapping(value = WebConstants.EDIT_HOMEPAGE_IMAGES, method = RequestMethod.POST)
	public String editHomePage(
			@ModelAttribute(value = "homePageImageForm") HomePageImageData homePageImage,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) throws ServiceException {
		//ServletContext context = session.getServletContext();
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		StaticData sd = localStaticContainer.getStaticData();
		CustomImage image = new CustomImage();
			if(WebConstants.VIEW.equalsIgnoreCase(homePageImage.getActionType())){
				try {	
					String uuid = ImageUtil.getARandomString();
					
				HomePageImageData homeimage = homePageImageService.getImage(homePageImage.getId());
				homeimage.setActionType(WebConstants.UPDATE);
				homeimage.setUuid(uuid);
				
				image.setUrl(homeimage.getImageName());
				image.setUuid(uuid);
				model.addAttribute("imageForm",image);
				populateHomePageSeededData(model, session);
				model.addAttribute("homePageImageForm", homeimage);
				return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ADD_OR_EDIT;
}
			
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("homePageImageForm",homePageImage);
				return WebConstants.VIEW_ALL_HOMEPAGE_IMAGES;
			}
			}
			
			else if(WebConstants.UPDATE.equalsIgnoreCase(homePageImage.getActionType())){
				byte[] filebyte=null;
				String type = null;
				try {
					if(ss.isExistsImage(homePageImage.getUuid()+"_CRP")){
						 type = ss.getImageType(homePageImage.getUuid()+"_CRP");
						filebyte = ss.getImage(homePageImage.getUuid()+"_CRP");
					}
				
				homePageImage.setLastmodifiedby(userName);
				if(null!=filebyte){
					String newimageName =homePageImage.getUnid()+type;
					homePageImage.setImageName(newimageName);	
					sd.saveImage(newimageName, filebyte, null);
				}
				
				homePageImage.setLastmodifiedby(userName);
				homePageImageService.editImage(homePageImage);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE ,ErrorConstants.TS_9032);
				return WebConstants.REDIRECT_VIEWALL_HOMEPAGE_IMAGES;
				}
				catch (Exception e) {
					ApplicationException exp = new ApplicationException(e.getMessage(),e);
					logger.error(exp, e);
					model.addAttribute("homePageImageForm", homePageImage);
					populateHomePageSeededData(model, session);
					return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ADD_OR_EDIT;
				
			}
			
		} 
		
		return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ALL;

	}

*/	
	@RequestMapping(value = WebConstants.DELETE_HOMEPAGE_IMAGES , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse delete(@RequestBody String jsonString,
			HttpServletRequest request,
			SessionStatus status) {

		logger.debug("deleting homepage image details");
		StaticData sd = localStaticContainer.getStaticData();
		AjaxResponse aresponse = new AjaxResponse();
		 try {
			  		JSONObject jsonOb = new JSONObject(jsonString);
					HomePageImageData hi = new HomePageImageData();
					Integer id = (Integer) jsonOb.get("id");
			homePageImageService.deleteImage(id);
			//model.addAttribute("homePageImageForm", new HomePageImageData());
			//session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE ,ErrorConstants.TS_9033);
			//return WebConstants.REDIRECT_VIEWALL_HOMEPAGE_IMAGES;
			aresponse.setSuccess(true);
			aresponse.setMessage("Deleted Home Page Image.");
			
		}
		catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),
					e);
			logger.error(exp, e);
			aresponse.setSuccess(false);
			aresponse.setMessage("Unable to delete Home Page Image.");
		//	model.addAttribute("homePageImageForm", new HomePageImageData());
		//	return WebConstants.VIEWNAME_HOMEPAGEIMAGES_ALL;
		}

		 return aresponse;
	}
	
	/*@RequestMapping(value = WebConstants.DELETE_GALLERY , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteGallery(@RequestBody String jsonString,
			ModelMap model,HttpServletRequest request,
			SessionStatus status) {
		
		AjaxResponse ajaxRes = new AjaxResponse();
			try {
				JSONObject jsonOb = new JSONObject(jsonString);
				String action = (String) jsonOb.get("a");
				if ("hi".equalsIgnoreCase(action)) {
					Integer id = (Integer) jsonOb.get("id");
					if(null!=id){
						homePageImageService.deleteImage(id);
						ajaxRes.setSuccess(true);
						ajaxRes.setMessage("Gallery Deleted.");
					}
				}
			}
		catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to delete HomePage");
		}
			return ajaxRes;
	}*/
	
	private void populateHomePageSeededData(ModelMap model, HttpSession session) throws ServiceException {
		List<ReferenceData> tpRefList =  referenceDataService.getReferenceTypeList("TITLEPOS");
		model.addAttribute("tpRefList", tpRefList);
	}
	
	/*@RequestMapping(value = WebConstants.UPLOAD_HOMEPAGEIMAGE, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse uploadStudentPhoto( @ModelAttribute(value = "homePageImage") HomePageImageData homePageImage,HttpSession session,
			ModelMap model,
			SessionStatus status) {
		AjaxResponse ajaxRes = new AjaxResponse();

		MultipartFile file = homePageImage.getFile();
		String imageName = file.getOriginalFilename();
		 ServletContext context = session.getServletContext();
		try {
			
			if(null!=homePageImage.getActionType()&&WebConstants.CROP.equalsIgnoreCase(homePageImage.getActionType())){
				
				CustomImage image = homePageImage;
				byte[] filebyte = (byte[]) context.getAttribute("orginalImage");
				image.setImageBytes(filebyte);
				byte[] cropedImage = ImageUtil.cropImage(image);
				context.setAttribute("cropedImage", ImageUtil.getFixedImageWidth(cropedImage, 762));
				ajaxRes.setValid(true);
				ajaxRes.setImage(ImageUtil.getImageAsString(cropedImage, 220));
				
			}
			else{
				
				if(file.getSize()!=0){
					//byte[] filebyte = ImageUtil.getImageForCrop(file.getBytes(),850,450); 
					byte[] filebyte = ImageUtil.getImageForCropByWidth(file.getBytes(),1050); 
					//byte[] thumbnail = createThumbnailImage(filebyte);
					ajaxRes.setValid(true);
					ajaxRes.setImage(ImageUtil.getImageAsString(filebyte));
					context.setAttribute("orginalImage", filebyte);
					}
			}
		

			return ajaxRes;
		} catch (Exception e) {
		return ajaxRes;
		} 
	}
	*/
	@RequestMapping(value = WebConstants.UPLOAD_HOMEPAGEIMAGE, method = RequestMethod.POST)
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
						ajaxRes.setImage(ImageUtil.getImageAsString(cropedImage, 354));
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
	
	/*@RequestMapping(value = WebConstants.UPLOAD_HOMEPAGEIMAGE, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse uploadStudentPhoto( @ModelAttribute(value = "homePageImage") HomePageImageData homePageImage,HttpSession session,
			ModelMap model,
			SessionStatus status) {
		AjaxResponse ajaxRes = new AjaxResponse();

		MultipartFile file = homePageImage.getFile();
		String imageName = file.getOriginalFilename();
		String unid = homePageImage.getUuid();
		try {
			StaticSession ss = (StaticSession)session.getAttribute("staticSession");
			if(homePageImage.isDontCrop()){
				byte[] filebyte = ImageUtil.getDontCropImage(file.getBytes(), 335, 848);
				ajaxRes.setValid(true);
				ajaxRes.setDontCrop(true);
				ajaxRes.setImage(ImageUtil.getImageAsString(filebyte));
				ss.saveImage(unid+"_CRP", filebyte);
					
			}
			else{
				
				if(null!=homePageImage.getActionType()&&WebConstants.CROP.equalsIgnoreCase(homePageImage.getActionType())){
					CustomImage image = homePageImage;
					image.setFixedW(848);
					byte[] filebyte = ss.getImage(unid+"_ORG");
					image.setImageBytes(filebyte);
					byte[] cropedImage = ImageUtil.cropImage(image);
					ss.saveImage(unid+"_CRP", cropedImage);
					ajaxRes.setValid(true);
					ajaxRes.setImage(ImageUtil.getImageAsString(cropedImage, 272));
				}
				else{
					if(file.getSize()!=0){
						//byte[] filebyte = ImageUtil.getImageForCrop(file.getBytes(),850,450); 
						//byte[] filebyte = ImageUtil.getImageForCropByWidth(file.getBytes(),1050); 
						byte[] filebyte = ImageUtil.getModerateImageForCrop(file.getBytes());
						//byte[] thumbnail = createThumbnailImage(filebyte);
						ajaxRes.setValid(true);
						ajaxRes.setImage(ImageUtil.getImageAsString(filebyte));
						ss.saveImage(unid+"_ORG", filebyte);
						}
				}
			}

			return ajaxRes;
		} catch (Exception e) {
		return ajaxRes;
		} 
	}*/
	

}