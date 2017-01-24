package com.vydya.theschool.web.controllers.home;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.vydya.theschool.common.dto.AjaxMenuData;
import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.EventAjaxData;
import com.vydya.theschool.common.dto.EventData;
import com.vydya.theschool.common.dto.GalleryData;
import com.vydya.theschool.common.dto.HomePageImageData;
import com.vydya.theschool.common.dto.MenuData;
import com.vydya.theschool.common.dto.MenuElement;
import com.vydya.theschool.common.dto.ToppersGroupData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.FileUtil;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.common.BookService;
import com.vydya.theschool.services.api.common.ContentService;
import com.vydya.theschool.services.api.common.GeneralService;
import com.vydya.theschool.services.api.common.MenuService;
import com.vydya.theschool.services.api.home.EventGalleryService;
import com.vydya.theschool.services.api.home.HomePageImageService;
import com.vydya.theschool.services.api.home.ManageToppersService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.localstatic.StaticData;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.utils.UniqueIdGenerator;

@Controller
public class HomeController {

	private final static Logger logger = Logger
			.getLogger(HomeController.class.getName());

	@Autowired
	protected HomePageImageService homePageImageService;
	
	@Autowired
	protected ContentService  contentService;
	
	@Autowired
	protected EventGalleryService  galleryService;
	
	@Autowired
	protected BookService  bookService;
	
	@Autowired
	protected ManageToppersService  toppersService;

	@Autowired
	protected GeneralService  generalService;

	@Autowired(required=true)
	public SchoolAdminProperties properties;
	
	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	@Autowired
	protected MenuService  menuService;
	
	private String STATIC_FILE_CONTENT = "stfile-content/";
	
	@RequestMapping({"/", "/home"})
	public String viewAll(
			ModelMap model,
			@ModelAttribute(value = "homePageImageForm") HomePageImageData homePageImage,
			SessionStatus status,HttpSession session) {
			
		try {
			List<HomePageImageData> homePageImagesList = homePageImageService
					.loadAllHomePageImages();
			populateSliderData(model);
			model.addAttribute("homePageImagesList", homePageImagesList);
			
			
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}
	

	@RequestMapping(value ="/aboutus")
	public String aboutusPage(ModelMap model,	SessionStatus status) {

		try {
			/*List<HomePageImageData> homePageImagesList = homePageImageService
					.loadAllHomePageImages();
			model.addAttribute("homePageImagesList", homePageImagesList);*/
			return WebConstants.VIEWNAME_SCHOOL_ABOUTUS;
		/*} catch (ServiceException e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		*/} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}
	
	@RequestMapping(value ="/page/{spage}", method = RequestMethod.GET)
	public String menu(@PathVariable("spage") String page,ModelMap model,	SessionStatus status) {
		MenuData menuData = null;
		try {
			if(null != page) {
				 menuData = menuService.getMenuByUrl(page);
				 menuData.setHtml(getContent(menuData.getUnid()));
			} else {
				menuData=new MenuData();
			}
			model.addAttribute("page", menuData);
			return "school.page";
		} catch (ServiceException e) {
			return "school.page";
		} catch (Exception e) {
			return "school.page";
		}
	}
	
	public String getContent(String name){
		
		String orginlpath = properties.getLocalPathForDBdata()+"/staticData"+"/"+STATIC_FILE_CONTENT+name+".html";
		BufferedReader br = null;
		StringBuffer bf = new StringBuffer();
		try {
			String sCurrentLine;
			br = new BufferedReader(new FileReader(orginlpath));
			while ((sCurrentLine = br.readLine()) != null) {
				bf.append(sCurrentLine);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null)br.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return bf.toString();
	}
	
	
	@RequestMapping(value ="/aboutus/{spage}")
	public String aboutusSubPages(@PathVariable("spage") String page,ModelMap model,	SessionStatus status) {

		try {

			if(page.equalsIgnoreCase("founder")){
				return "school.founder";
			}
			else if (page.equalsIgnoreCase("overview")){
				
				return "school.overview";
			}
			else if (page.equalsIgnoreCase("vission")){
				return "school.vission";			
							
			}
			else if (page.equalsIgnoreCase("management")){
				
				return "school.management";
			}
			else{
				return "chool.pagenotfound";
			}
			
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}
	
	@RequestMapping(value ="/contactus")
	public String contactusPage(ModelMap model,	SessionStatus status) {

		try {

			return WebConstants.VIEWNAME_SCHOOL_CONTACTUS;

		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}
	@RequestMapping(value ="/ranks")
	public String ranksPage(ModelMap model,	SessionStatus status) {

		try {
			/*List<HomePageImageData> homePageImagesList = homePageImageService
					.loadAllHomePageImages();
			model.addAttribute("homePageImagesList", homePageImagesList);*/
			return WebConstants.VIEWNAME_SCHOOL_RANKS;
		/*} catch (ServiceException e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		*/} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}


	@RequestMapping(value ="/infrastructure")
	public String infrastructurePage(ModelMap model,	SessionStatus status) {

		try {
			/*List<HomePageImageData> homePageImagesList = homePageImageService
					.loadAllHomePageImages();
			model.addAttribute("homePageImagesList", homePageImagesList);*/
			return WebConstants.VIEWNAME_SCHOOL_INFRASTRUCTURE;
		/*} catch (ServiceException e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		*/} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}
	/*@RequestMapping(value ="/attachments/{cat}/{attUrl}")
	public String attachements(@PathVariable("cat") String cat, @PathVariable("attUrl") String attUrl, 
			ModelMap model,SessionStatus status,HttpServletResponse response) {

		try {
			AttachmentData 	at = contentService.getAttachmentByCatAndUrl(cat, attUrl);
			downloadFile(at,response);
			return WebConstants.VIEWNAME_SCHOOL_ADMISSIONS;
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}*/

	
/*	private void downloadFile(AttachmentData at, HttpServletResponse response) throws IOException {


		
		response.reset();
		response.setBufferSize(WebConstants.DEFAULT_BUFFER_SIZE);
		response.setHeader("Content-Disposition", "attachment;filename=\""+at.getUrl()+"\"");
		response.setHeader("Content-Type", at.getType());
		//response.setContentType(at.getType());
		response.setContentLength(at.getAttachementBlob().length);
		FileCopyUtils.copy(at.getAttachementBlob(), response.getOutputStream());
		
		
	}*/
/*
	@RequestMapping(value ="/admissions")
	public String admissions(ModelMap model, SessionStatus status) {
		try {
			return WebConstants.VIEWNAME_SCHOOL_ADMISSIONS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}*/
	
	@RequestMapping(value ="/academics")
	public String academics(ModelMap model, SessionStatus status) {
		try {
			return WebConstants.VIEWNAME_SCHOOL_ACADEMICS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}

	@RequestMapping(value ="/administration")
	public String administration(ModelMap model, SessionStatus status) {
		try {
			return WebConstants.VIEWNAME_SCHOOL_ADMINISTRATION;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}	

	@RequestMapping(value ="/administration/{spage}")
	public String administrationSubPages(@PathVariable("spage") String page,ModelMap model,	SessionStatus status) {

		try {

			if(page.equalsIgnoreCase("admissions")){
				return "school.admissions";
			}
			else if (page.equalsIgnoreCase("examination")){
				
				return "school.examination";
			}

			else{
				return "chool.pagenotfound";
			}
			
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}
	
	@RequestMapping(value ="/fecilities")
	public String fecilities(ModelMap model, SessionStatus status) {
		try {
			return WebConstants.VIEWNAME_SCHOOL_FECILITIES;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}
	
	@RequestMapping(value ="/achievements")
	public String achievements(ModelMap model, SessionStatus status) {
		try {
			return WebConstants.VIEWNAME_SCHOOL_ACHIEVEMENTS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}
	
	@RequestMapping(value ="/events")
	public String events(ModelMap model, SessionStatus status) {
		try {
			return WebConstants.VIEWNAME_SCHOOL_EVENTS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SCHOOL_HOME;
		}
	}
	
	   @RequestMapping(value = "/ajaxGetValue.htm", method = RequestMethod.GET)
		public  @ResponseBody String ajaxGetValue(
				ModelMap model,
				HttpServletResponse response,HttpSession session,ServletRequest request,
				SessionStatus status) {
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
			AjaxResponse ajaxRes = new AjaxResponse();
			String key = request.getParameter("key");
				String value= null;
				try {
					if(key.equalsIgnoreCase("uuid")){
						
						value = ImageUtil.getARandomString();
					}
					else if(key.equalsIgnoreCase("unid")){
							
						UniqueIdGenerator uid = new UniqueIdGenerator();
							value = uid.toString();;
					}
				} catch (ServiceException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return value;
		}
	   
	   @RequestMapping(value = "/getYlist.htm", method = RequestMethod.GET)
		public  @ResponseBody List<Integer> years(
				ModelMap model,
				HttpServletResponse response,HttpSession session,ServletRequest request,
				SessionStatus status) {
			String type = request.getParameter("t");
			List<Integer> list = new ArrayList<Integer>();
				try {
						list = generalService.getYearsList(type);
					//list.removeIf(filter)(2);
					Integer cY =Integer.parseInt(TSDateUtil.getCurrentYear());
					list.removeAll(Arrays.asList(cY));
					
				} catch (ServiceException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (NumberFormatException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return list;
		}

	   
	  
	   
	  @RequestMapping(value = "/getlist.htm", method = RequestMethod.GET)
		public  @ResponseBody List<MenuElement> listForImages(
				ModelMap model,
				HttpServletResponse response,HttpSession session,ServletRequest request,
				SessionStatus status) {
			String type = request.getParameter("t");
			String year = request.getParameter("y");
			if(null==year){
				Calendar cal = Calendar.getInstance();
				DateFormat date = new SimpleDateFormat("yyyy");
				year = date.format(cal);
			}
			List<MenuElement> list = new ArrayList<MenuElement>();
				try {
					
					if(type.equalsIgnoreCase("G")){
						
						List<GalleryData> galleryList = galleryService.loadAllGalleries(year);
						list = 	copyToGList( galleryList);
					}
					else if(type.equalsIgnoreCase("T")){
						List<ToppersGroupData> toppersGList = toppersService.fetchAllToppersGroups(year);
						list = 	copyToTList( toppersGList);
						toppersGList = null;
					}
					
					else if(type.equalsIgnoreCase("L")){
						
					}
					
				} catch (ServiceException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return list;
		}

	  @RequestMapping(value = "/getdata.htm", method = RequestMethod.GET)
		public  @ResponseBody List<MenuElement> getData(
				ModelMap model,
				HttpServletResponse response,HttpSession session,ServletRequest request,
				SessionStatus status) {
			String type = request.getParameter("t");
			List<MenuElement> list = new ArrayList<MenuElement>();
				try {
					
					if(type.equalsIgnoreCase("G")){
						
						List<GalleryData> galleryList = galleryService.getLimitedGList();
						list = 	copyToGList( galleryList);
					}
					else if(type.equalsIgnoreCase("T")){
						List<ToppersGroupData> toppersGList = toppersService.getLimitedTList();
						list = 	copyToTList( toppersGList);
					}
					else if(type.equalsIgnoreCase("L")){
						
					}
					else if(type.equalsIgnoreCase("E")){
						List<EventData> eventsList = galleryService.getLimitedEList();
						list = 	copyToEList( eventsList);
						eventsList = null;
					}
					
				} catch (ServiceException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (Exception e) {

				}
				return list;
		}

	  
	  /*@RequestMapping(value = "/getMenu.htm", method = RequestMethod.GET)
		public  @ResponseBody List<AjaxMenuData> getMenu(
				ModelMap model,
				HttpServletResponse response,HttpSession session,HttpServletRequest request,
				SessionStatus status) {
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
					response.setHeader("Access-Control-Allow-Origin", "*");//Cross-Origin Resource Sharing (CORS)
					dmenuList=menuData.getSubMenu();
					context.setAttribute("dmenuList", dmenuList);
					
				}
				return menuData.getSubMenu();
		 
			  } catch (JAXBException e) {
				e.printStackTrace();
				return menuData.getSubMenu();
			  }
		}*/


	  @RequestMapping(value = "/getMenu.htm", method = RequestMethod.GET)
		public  @ResponseBody String getMenu(
				ModelMap model,
				HttpServletResponse response,HttpSession session,HttpServletRequest request,
				SessionStatus status) {
		  AjaxMenuData menuData = new AjaxMenuData();
		  ServletContext context = request.getSession().getServletContext();
				 String menuString = (String) context.getAttribute("menuString");
				return menuString;
		 
		}
	  
		@RequestMapping(value = "/getevents.htm", method = RequestMethod.GET)
		public  @ResponseBody List<EventAjaxData> getEvents(
					ModelMap model,
					HttpServletResponse response,HttpSession session,HttpServletRequest request,
					SessionStatus status) {
			  
			  StringBuffer requestURL = request.getRequestURL();
			    String queryString = request.getQueryString();
			  String url = request.getRequestURI();
			  String type=request.getParameter("t");
			  String limit = request.getParameter("limit");
			  String userDataJSON=null;
				String yearString = request.getParameter("year");
				Integer year = (yearString.equalsIgnoreCase("false")||yearString.equalsIgnoreCase(""))?null:Integer.parseInt(yearString);
						
				String monthString = request.getParameter("month");
				Integer month = (monthString.equalsIgnoreCase("false")||monthString.equalsIgnoreCase(""))?null:Integer.parseInt(monthString);
					
				String dayString = request.getParameter("day");
				Integer	day = (dayString.equalsIgnoreCase("false")||dayString.equalsIgnoreCase(""))?null:Integer.parseInt(dayString);
					
				String direction = request.getParameter("direction");
				
				List<EventAjaxData> list = new ArrayList<EventAjaxData>();
					try {

						List<EventData> evlist = galleryService.getEvents(year, month+1, day,direction);
						
						for(EventData ev :evlist){
							
							EventAjaxData a = new EventAjaxData();
							a.setId(ev.getId());
							a.setDescription(ev.getEventDesc());
							a.setDate(ev.getEventDate().getTime()+"");
							a.setName(ev.getName());
							a.setTitle(ev.getTitle());
							a.setType(ev.getEventType());
							a.setUrl("/events/"+ev.getUrl());
							list.add(a);
						}
						
						/* ObjectMapper mapper = new ObjectMapper();
					      try
					      {
					    	  Writer strWriter = new StringWriter();
					    	  mapper.writeValue(strWriter, list);
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
					      }*/
					    
					} catch (ServiceException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					//response.setHeader("Access-Control-Allow-Origin", "*");//Cross-Origin Resource Sharing (CORS)
					return list;
			}

		private void populateSliderData(ModelMap model) throws ServiceException, ParseException {
			List<MenuElement> list = new ArrayList<MenuElement>();
				
				List<GalleryData> galleryList = galleryService.getLimitedGList();
			
				List<ToppersGroupData> toppersGList = toppersService.getLimitedTList();
				
				List<EventData> eventsList = galleryService.getLimitedEList();
				
				model.addAttribute("glist", copyToGList( galleryList));
				model.addAttribute("elist", copyToEList( eventsList));
				model.addAttribute("tlist", copyToTList( toppersGList));
			
		}
		
	private List<MenuElement> copyToGList(List<GalleryData> galleryList) {
		
		List<MenuElement> l = new ArrayList<MenuElement>();
			for(GalleryData gal:galleryList){
				MenuElement m = new MenuElement();
				m.setName(gal.getName());
				m.setImage(gal.getImage());
				m.setUrl(gal.getImageName());
				m.setId(gal.getId());
				m.setDescription(gal.getTitle());
				l.add(m);
			}
			return l;
	}
	
	
private List<MenuElement> copyToTList(List<ToppersGroupData> tList) {
		
		List<MenuElement> l = new ArrayList<MenuElement>();
			for(ToppersGroupData t:tList){
				MenuElement m = new MenuElement();
				m.setName(t.getName());
				m.setUrl(t.getImageName());
				m.setId(t.getId());
				m.setDescription(t.getTitle());
				l.add(m);
			}
			return l;
	}

private List<MenuElement> copyToEList(List<EventData> eList) throws ParseException {
	
	List<MenuElement> l = new ArrayList<MenuElement>();
		for(EventData t:eList){
			MenuElement m = new MenuElement();
			m.setName(t.getName());
			m.setUrl(t.getImageName());
			m.setId(t.getId());
			m.setDescription(t.getTitle());
			m.setContent1(TSDateUtil.getDayNumber(t.getEventDate()));
			m.setContent2(TSDateUtil.getMonthName(t.getEventDate()));
			l.add(m);
		}
		return l;
}

@RequestMapping(value = "/upload.htm", method = RequestMethod.POST)
public @ResponseBody AjaxResponse upload(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {                 

	StaticSession ss = (StaticSession)session.getAttribute("staticSession");
	UniqueIdGenerator uid = new UniqueIdGenerator();
	String unid=null;
	AjaxResponse re = new AjaxResponse();
	StaticData sd = localStaticContainer.getStaticData();
  try {
	  JSONObject jsonOb = new JSONObject(jsonString);
	  //String action=(String) jsonOb.get("a");
	  unid=(String) jsonOb.get("unid");
		  byte[] filebyte = ImageUtil.getStringAsImage((String) jsonOb.get("image"));
		  if(FileUtil.validUnid(unid)){
			  sd.saveImage(unid, filebyte, null);
			 
		  }
		  else{
			  
				  unid = uid.toString();
				  ss.saveImage(unid, filebyte);
				  re.setSuccess(true);
				  re.setName(unid);
		  }
	  
	  
 } catch (Exception e) {
     e.printStackTrace();
 }

  return re;

}

}















