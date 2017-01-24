package com.vydya.theschool.web.admin.controllers;

import java.util.ArrayList;
import java.util.Arrays;
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
import com.vydya.theschool.common.dto.GalleryImageData;
import com.vydya.theschool.common.dto.GalleryImageSearch;
import com.vydya.theschool.common.dto.GalleryVideoData;
import com.vydya.theschool.common.dto.ReferenceData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.FileException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.FileUtil;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.common.ColumnMenuContentsService;
import com.vydya.theschool.services.api.common.GeneralService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.home.EventGalleryService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.localstatic.StaticData;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.utils.UniqueIdGenerator;


//@Scope(value = "session",  proxyMode = ScopedProxyMode.TARGET_CLASS)
@Controller
public class AdminEventGalleryController {

	private final static Logger logger = Logger
			.getLogger(AdminEventGalleryController.class.getName());

	@Autowired
	protected EventGalleryService galleryService;
	@Autowired
	protected ReferenceDataService referenceDataService;

	@Autowired
	protected ColumnMenuContentsService columnMenuContentsService;

	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	@Autowired
	protected GeneralService  generalService;
	
	@RequestMapping(value = WebConstants.VIEW_GALLERY_IMAGES, method = RequestMethod.GET)
	public String viewAllEventImagesPost(
			ModelMap model, ServletRequest request,
			@ModelAttribute(value = "galleryForm") GalleryImageSearch galleryImageSearch,
			SessionStatus status) {
			
			
		try {
			int galId= Integer.parseInt(request.getParameter("g"));
			GalleryData galleryForm =  galleryService.getGallery(galId);
			
			/*
			List<GalleryImageData> galleryImageList = galleryService.getGalleryImagesByGalleryId(galId);
			//galleryForm.setGalleryImages(galleryImageList);
			populateGallerySeededData(model);
			model.addAttribute("galleryImageList", galleryImageList);*/
			model.addAttribute("galleryForm", galleryForm);
			/*model.addAttribute("galleryImageForm", new GalleryImageData() );
			model.addAttribute("imageTableForm", new GalleryImageData() );
			
			List<GalleryVideoData> galleryVideosList = galleryService.getGalleryVideosByGalleryId(galId);
			
			model.addAttribute("galleryVideosList", galleryVideosList);
			model.addAttribute("galleryVideoForm", new GalleryVideoData() );
			model.addAttribute("videoTableForm", new GalleryVideoData() );*/
			
			
			return WebConstants.VIEW_NAME_VIEW_GALLERY_IMAGES;
		} catch (ServiceException e) {
			return WebConstants.VIEW_NAME_VIEW_GALLERY;
		} catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_GALLERY;
		}
	}
	
	
	@RequestMapping(value = WebConstants.VIEW_GALLERY, method = RequestMethod.GET)
	public  String viewAllEvents(
			ModelMap model,ServletRequest request,
			@ModelAttribute(value = "galleryForm") GalleryData galleryData,
			SessionStatus status) {
		try {
			/*String year = request.getParameter("y");
			if(year==null){
				year = TSDateUtil.getCurrentYear();
			}
			galleryList = galleryService.loadAllGalleries(year);
			model.addAttribute("galleryList", galleryList);
			model.addAttribute("galleryImageForm", new GalleryImageData());
			model.addAttribute("galleryImageSearchForm", new GalleryImageSearch());
			
			*/
			return WebConstants.VIEW_NAME_VIEW_GALLERY;
			//return eventList; @ResponseBody
		/*} catch (ServiceException e) {
			return WebConstants.VIEW_NAME_VIEW_GALLERY;*/
			//return eventList;
		} catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_GALLERY;
			//return eventList;
		}
	}

	@RequestMapping(value = WebConstants.DELETE_GALLERY , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteGallery(@RequestBody String jsonString,
			HttpServletRequest request,
			SessionStatus status) {
		
		AjaxResponse ajaxRes = new AjaxResponse();
			try {
				JSONObject jsonOb = new JSONObject(jsonString);
				String action = (String) jsonOb.get("a");
				if ("gs".equalsIgnoreCase(action)) {
					Integer id = (Integer) jsonOb.get("id");
					if(null!=id){
						galleryService.deleteGallery(id);
						columnMenuContentsService.deleteContentExisted(id, "GALLERY",request);
						ajaxRes.setSuccess(true);
						ajaxRes.setMessage("Gallery Deleted.");
					}
				}
				else if("gi".equalsIgnoreCase(action)){
					Integer gid = (Integer) jsonOb.get("id");
					if(null!=gid){
						galleryService.deleteGalleryImage(gid);
						ajaxRes.setSuccess(true);
						ajaxRes.setMessage("Image Deleted.");
					}
				}
				else if("gv".equalsIgnoreCase(action)){
					Integer gvd = (Integer) jsonOb.get("id");
					if(null!=gvd){
						galleryService.deleteGalleryVideo(gvd);
						ajaxRes.setSuccess(true);
						ajaxRes.setMessage("Video Deleted.");
					}
				}
				
				
		} 
		catch (FileException e) 
		{			
			//throw new FileException(e.getErrorCode(), e.getErrorMessage());
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg(e.getMessage());
		}
		catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to delete Gallery");
		}
			return ajaxRes;
	}
	
	@RequestMapping(value = WebConstants.EDIT_GALLERY)
	public @ResponseBody AjaxResponse editGallery(@RequestBody String jsonString,
			 HttpSession session,
			HttpServletResponse response) {

		//ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		//Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		//StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		StaticData sd = localStaticContainer.getStaticData();
		
		AjaxResponse aresponse = new AjaxResponse();
		 try {
			  JSONObject jsonOb = new JSONObject(jsonString);
			 // JSONObject blobI=jsonOb.getJSONObject("imageBlob");
			  //jsonOb.remove("imageBlob");//imageBlob
			  String objType = (String) jsonOb.get("objectType");
				if ("g".equalsIgnoreCase(objType)) {
					
					GalleryData gd = new GalleryData();
					byte[] filebyte =null;
					if(jsonOb.has("fileToUpload")&&(!jsonOb.isNull("fileToUpload"))){
						filebyte=ImageUtil.getStringAsImage((String) jsonOb.get("fileToUpload"));
						gd.setImageName((String) jsonOb.get("unid")+"."+FileUtil.getImageMimeType(filebyte));
					}
					
					Integer id = (Integer) jsonOb.get("id");
					String unid = (String) jsonOb.get("unid");
					String eventDesc = (String) jsonOb.get("eventDesc");
					String title = (String) jsonOb.get("title");
					String name = (String) jsonOb.get("name");

					String url  =name.toLowerCase().replaceAll(" ", "-").replaceAll("[^a-zA-Z0-9&&[^-]]", "");
					if(isExistedGalleryName(url,id)){
						aresponse.setSuccess(false);
						aresponse.setMessage("Gallery Name is aleardy existed.");
						return aresponse;
					}
					gd.setId(id);
					gd.setUrl(url);
					gd.setTitle(title);
					gd.setName(name);
					gd.setEventDesc(eventDesc);
					gd.setInsertedby(userName);
					gd.setLastmodifiedby(userName);
					gd.setEventDate(TSDateUtil.getCurrentDateInTimeStamp());
					galleryService.editGallery(gd);
					if(null!=filebyte){
						sd.saveImage(gd.getImageName(), filebyte, null);
					}
					aresponse.setSuccess(true);
					aresponse.setMessage("Successfully Saved Gallery.");
			  }
			  else if("gi".equalsIgnoreCase(objType)){
				  
				  GalleryImageData gd = new GalleryImageData();
					byte[] filebyte =null;
					if(jsonOb.has("fileToUpload")&&(!jsonOb.isNull("fileToUpload"))){
						filebyte=ImageUtil.getStringAsImage((String) jsonOb.get("fileToUpload"));
						gd.setImageName((String) jsonOb.get("unid")+"."+FileUtil.getImageMimeType(filebyte));
					}
					Integer id = (Integer) jsonOb.get("id");
					gd.setDescription((String) jsonOb.get("description"));
					gd.setGalleryId((Integer)jsonOb.get("gid"));
					gd.setInsertedby(userName);
					gd.setLastmodifiedby(userName);
					galleryService.saveGalleryImage(gd);
					if(null!=filebyte){
						sd.saveImage(gd.getImageName(), filebyte, null);
					}
					//GalleryImageData gndta = galleryService.getGalleryImageByName(gdta.getImageName());
					aresponse.setSuccess(true);
					aresponse.setMessage("Successfully Saved Image.");
					
			  }

		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9007);
			aresponse.setSuccess(false);
			aresponse.setErrormsg("Unable to save Gallery");
			
		}
		return aresponse;
	}
	@RequestMapping(value = "admin/manageGallery/load.htm")
	public @ResponseBody
	String load(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		String response = "";
		AjaxResponse aresponse = new AjaxResponse();
		ObjectMapper mapper = new ObjectMapper();
		try {
			JSONObject jsonOb = new JSONObject(jsonString);
			
			String type = (String) jsonOb.get("t");
			
			if(null!=type && type.equalsIgnoreCase("v")){// tyep validation
				String param = (String) jsonOb.get("p");// parameter 
				String val = (String) jsonOb.get("val"); //value 
				boolean isExisted = false;
				String url  =val.toLowerCase().replaceAll(" ", "-").replaceAll("[^a-zA-Z0-9&&[^-]]", "");
				isExisted =	isExistedGalleryName(url,null);
					
					aresponse.setSuccess(true);
					aresponse.setValid(isExisted);
					response = mapper.writeValueAsString(aresponse);
					return response;
			}
			
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return response;
		}
	}
	
	
	@RequestMapping(value = WebConstants.UPLOAD_GALLERYIMAGE, method = RequestMethod.POST)
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
	


	private boolean isExistedGalleryName(String url, Integer id) {
		boolean isExisted = true;
		try {
			isExisted =  galleryService.isExistedGalleryAndId(url, id);
			//isExisted =  bookService.isExistedBookCategoryAndId(url, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isExisted;
	}

	private void populateGallerySeededData(ModelMap model) throws ServiceException {
		List<ReferenceData> galleryRefList =  referenceDataService.getReferenceData("GALLERY");
		model.addAttribute("galleryRefList", galleryRefList);
		
	}
	
	
	/**
	 *  EVENT VIDEO GALLERY
	 */

	@RequestMapping(value = WebConstants.ADD_GALLERY_VIDEO, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse addGalleryVideo( @ModelAttribute(value = "galleryVideoForm") GalleryVideoData galleryVideoData,HttpSession session,
			ModelMap model,
			SessionStatus status) {
		
		//ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		//Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);	
		AjaxResponse ajaxRes = new AjaxResponse();

		try {
					
					galleryVideoData.setInsertedby(userName);
					galleryVideoData.setLastmodifiedby(userName);
					UniqueIdGenerator uid = new UniqueIdGenerator();
					String unid = uid.toString();
					galleryVideoData.setUnid(unid);
					galleryService.saveGalleryVideo(galleryVideoData);
					
					GalleryVideoData v = galleryService.loadGalleryVideoByUrlAndGalId(galleryVideoData.getId(), galleryVideoData.getUrl());
					
					ajaxRes.setSuccess(true);
					ajaxRes.setId(v.getId());
					ajaxRes.setDescription(v.getDescription());
					ajaxRes.setName(v.getVideoName());
					
					ajaxRes.setType(v.getVideoType());
					ajaxRes.setImage(v.getVid());
					ajaxRes.setUrl(v.getUrl());
					String[] d = new String[4];
					d[0] = v.getInserted();
					d[1] = v.getInsertedby();
					d[2] = v.getLastmodified();
					d[3] = v.getLastmodifiedby();
					
					ajaxRes.setData(d);
					
					ajaxRes.setMessage("Video Uploaded Successfully.");
						
		
			return ajaxRes;
		} catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to add Video");
			
		return ajaxRes;
		} 
	}
	
	@RequestMapping(value = "admin/manageGallery/view.htm")
	public @ResponseBody
	String ajaxGet(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		String response = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			JSONObject jsonOb = new JSONObject(jsonString);
			String action = (String) jsonOb.get("a");
			if ("gs".equalsIgnoreCase(action)) {
				List<GalleryData> galleryList = new ArrayList<GalleryData>();
				String year = (String) jsonOb.get("y");
				if (year == null) {
					year = TSDateUtil.getCurrentYear();
				}
				galleryList = galleryService.loadAllGalleries(year);
				response = mapper.writeValueAsString(galleryList);
			}
			else if("gi".equalsIgnoreCase(action)){
				Integer gid = (Integer) jsonOb.get("id");
				List<GalleryImageData> galleryImageList = galleryService.getGalleryImagesByGalleryId(gid);
				response = mapper.writeValueAsString(galleryImageList);
			}
			else if("data".equalsIgnoreCase(action)){
				String type = (String) jsonOb.get("type");
				if("yearlist".equalsIgnoreCase(type)){
					List<Integer> list = generalService.getYearsList("g");
						Integer cY =Integer.parseInt(TSDateUtil.getCurrentYear());
						list.removeAll(Arrays.asList(cY));
						response = mapper.writeValueAsString(list);
				}
			}
			return response;
		} catch (ServiceException e) {
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return response;
		}
	}
	
	@RequestMapping(value = "admin/manageGallery/add.htm", method = RequestMethod.POST)
	public @ResponseBody AjaxResponse add(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {                 

		//StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		//ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		//Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		StaticData sd = localStaticContainer.getStaticData(); 
		AjaxResponse aresponse = new AjaxResponse();
		
	  try {
		  JSONObject jsonOb = new JSONObject(jsonString);
		  String objTyype = (String) jsonOb.get("objectType");
			if ("gi".equalsIgnoreCase(objTyype)) {
				UniqueIdGenerator uid1 = new UniqueIdGenerator();
				String unid = uid1.toString();
				byte[] filebyte = ImageUtil.getStringAsImage((String) jsonOb.get("fileToUpload"));
				String imageType = FileUtil.getImageMimeType(filebyte);
				GalleryImageData gdta = new GalleryImageData();
				gdta.setDescription((String) jsonOb.get("description"));
				gdta.setGalleryId((Integer)jsonOb.get("gid"));
				gdta.setImageName(unid+"."+FileUtil.getImageMimeType(filebyte));
				gdta.setInsertedby(userName);
				gdta.setLastmodifiedby(userName);
				//galleryImageData.setImageBlob(imageByte);
				gdta.setUnid(unid);
				galleryService.saveGalleryImage(gdta);
				sd.saveImage(gdta.getImageName(), filebyte, null);
				//GalleryImageData gndta = galleryService.getGalleryImageByName(gdta.getImageName());
				aresponse.setSuccess(true);
				aresponse.setMessage("Successfully Saved Gallery.");
		  }
		  else if ("g".equalsIgnoreCase(objTyype)) {
		  GalleryData reqData = new GalleryData();
			//ObjectMapper mapper = new ObjectMapper();
			//	reqData = mapper.readValue(jsonString,  GalleryData.class);
		 
			 reqData.setTitle((String) jsonOb.get("title"));
			 reqData.setEventDesc((String) jsonOb.get("eventDesc"));
			 reqData.setName((String) jsonOb.get("name"));
				byte[] filebyte = ImageUtil.getStringAsImage((String) jsonOb.get("fileToUpload"));
					UniqueIdGenerator uid1 = new UniqueIdGenerator();
					String unid = uid1.toString();
					reqData.setUnid(unid);
					
				String url  = reqData.getName().toLowerCase().replaceAll(" ", "-").replaceAll("[^a-zA-Z0-9&&[^-]]", "");
				if(isExistedGalleryName(url,reqData.getId())){
					aresponse.setSuccess(false);
					aresponse.setMessage("Gallery Name is aleardy existed.");
					return aresponse;
				}
			
				reqData.setUrl(url);
				reqData.setUnid(unid);
				reqData.setImageName(unid+"."+FileUtil.getImageMimeType(filebyte));
				reqData.setInsertedby(userName);
				reqData.setLastmodifiedby(userName);
				reqData.setEventDate(TSDateUtil.getCurrentDateInTimeStamp());
				//if(valid(reqData)){
				if(true){
					galleryService.saveGallery(reqData);
					reqData = galleryService.getGalleryByUnid(unid);
					
					if(null!=filebyte){
						sd.saveImage(reqData.getImageName(), filebyte, null);
					}
					aresponse.setRespData(reqData);
					aresponse.setSuccess(true);
					aresponse.setMessage("Successfully Saved Gallery.");
				}
				else{
					
					aresponse.setSuccess(false);
					aresponse.setMessage("Invalid details.");
				}
				
		  }
		  else if ("gv".equalsIgnoreCase(objTyype)) {
			  GalleryVideoData gv = new GalleryVideoData();
			  gv.setInsertedby(userName);
				gv.setLastmodifiedby(userName);
				UniqueIdGenerator uid = new UniqueIdGenerator();
				String unid = uid.toString();
				gv.setUnid(unid);
				galleryService.saveGalleryVideo(gv);
				
				//GalleryVideoData v = galleryService.loadGalleryVideoByUrlAndGalId(galleryVideoData.getId(), galleryVideoData.getUrl());
				
				aresponse.setSuccess(true);
				aresponse.setMessage("Video Uploaded Successfully.");
			  
		  }
		  
	 } catch (Exception e) {
	     e.printStackTrace();
	     aresponse.setSuccess(false);
	     aresponse.setMessage("Unable to add");
	 }
	  return aresponse;
	}
}