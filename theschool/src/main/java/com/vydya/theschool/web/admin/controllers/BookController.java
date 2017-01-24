package com.vydya.theschool.web.admin.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.BookCategoryData;
import com.vydya.theschool.common.dto.BookData;
import com.vydya.theschool.common.dto.CustomImage;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.common.util.PDFUtil;
import com.vydya.theschool.services.api.common.BookService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.localstatic.StaticData;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.utils.UniqueIdGenerator;

@Controller
public class BookController {

	private final static Logger logger = Logger
			.getLogger(AdminEventGalleryController.class.getName());

	@Autowired
	protected BookService  bookService;

	@Autowired
	protected ReferenceDataService referenceDataService;

	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	public BookController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@RequestMapping(value = "/library/{category}", method = RequestMethod.GET)
	public String contentsByCategory(@PathVariable("category") String category,HttpSession session,
			ModelMap model,HttpServletResponse response) throws IOException {
		List<BookData> booksList = new ArrayList<BookData>();
		model.addAttribute("displayname",category);
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		try {
			//getLeftPageContentsList(model);
			booksList = bookService.getBooksByCategoryUrl(category);
			
		BookCategoryData cat = 	bookService.getBookCategoryByUrl(category);
			
				model.addAttribute("booksList",booksList);
				model.addAttribute("cat",cat);
				return  WebConstants.VIEWNAME_BOOKS;
			
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_BOOKS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_BOOKS;
		}
	
	}
	
	@RequestMapping(value = "/library", method = RequestMethod.GET)
	public String allnews(ModelMap model,HttpServletResponse response) throws IOException {
		List<BookCategoryData> catList = new ArrayList<BookCategoryData>();
		try {

			catList = bookService.getAllBookCategories();
			model.addAttribute("bookCatList", catList);
			return WebConstants.VIEWNAME_LIBRARY;
			
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_LIBRARY;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_LIBRARY;
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
	
	@RequestMapping(value = WebConstants.VIEW_BOOKS)
	public String viewAllBooks(
			ModelMap model,
			@ModelAttribute(value = "bookCatForm") BookCategoryData catData,HttpServletResponse response,ServletRequest request,
			SessionStatus status) {
		try {
			BookCategoryData cat =  bookService.getBookCategory(catData.getId());
			List<BookData> books = bookService.getBooksByCategoryId(catData.getId());
			
			BookData b = new BookData();
			b.setCategoryId(cat.getId());
			b.setCategoryUrl(cat.getUrl());
			model.addAttribute("books", books);
			model.addAttribute("bookForm", new BookData());
			model.addAttribute("addBookForm", b);
			model.addAttribute("imageForm",new CustomImage());
			model.addAttribute("cat", cat );
			
			
			return WebConstants.VIEW_NAME_VIEW_BOOKS;
		} catch (ServiceException e) {
			return WebConstants.VIEW_NAME_VIEW_LIBRARY;
		} catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_LIBRARY;
		}
	}
	
	@RequestMapping(value = WebConstants.DELETE_BOOK , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteBook(
			ModelMap model,
			@ModelAttribute(value = "bookForm") BookData bookData,
			SessionStatus status) {
		
		AjaxResponse ajaxRes = new AjaxResponse();
		try {
			
			if(null!=bookData.getId()){
				bookService.deleteBook(bookData.getBookId());
			}
			ajaxRes.setSuccess(true);
			ajaxRes.setMessage("Book Deleted.");
			
		} catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to Delete Book");
		}
		return ajaxRes;
	}
	


	@RequestMapping(value = WebConstants.ADD_BOOK, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse addBook( @ModelAttribute(value = "addBookForm") BookData bookData,HttpSession session,
			ModelMap model,
			SessionStatus status) {
		
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);	
		AjaxResponse ajaxRes = new AjaxResponse();
		StaticData sd = localStaticContainer.getStaticData();
		
		MultipartFile file = bookData.getFile();
		String filename = file.getOriginalFilename();
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		try{
			
			String uuid = bookData.getUuid();
			bookData.setLastmodifiedby(userName);
			bookData.setInsertedby(userName);
			
			byte[] filebyte=null;
			if(ss.isExistsImage(uuid+"_CRP")){
				filebyte = ss.getImage(uuid+"_CRP");
				
			}

					if(null!=filebyte){
						
						byte[] pimage = ImageUtil.getFixedImageWidth(filebyte, 119);
						bookData.setBookImageBlob(pimage);
					}
					else{
						bookData.setFileBlob(file.getBytes());
							PDFUtil.loadPdf(bookData);
							bookData.setBookImageBlob(bookData.getImageBlob());
							bookData.setNumberOfPages(bookData.getPages());
					}
					bookData.setInsertedby(userName);
					bookData.setLastmodifiedby(userName);
					bookData.setBookBlob(file.getBytes());
					bookData.setType(file.getContentType());
					
					String url = filename.toLowerCase().replaceAll("[^a-zA-Z0-9&&[^-.]]", "");
					
					bookData.setUrl(url);
					if(isBookExisted(bookData.getCategoryId(),url)){
						
						ajaxRes.setSuccess(false);
						ajaxRes.setMessage("Book Existed with same name under this category.");
						return ajaxRes;
					}
					else{
					bookService.addBook(bookData);
					BookData book = bookService.getBookByCatIdAndBookUrl(bookData.getCategoryId(),url);
					ajaxRes.setSuccess(true); 
					ajaxRes.setId(book.getId());
					ajaxRes.setUrl(bookData.getCategoryUrl()+"/"+book.getUrl());
					ajaxRes.setName(book.getName());
					ajaxRes.setImage(book.getImage());
					ajaxRes.setDescription(book.getDescription());
					String[] d = new String[4];
					d[0] = book.getInserted();
					d[1] = book.getInsertedby();
					d[2] = book.getLastmodified();
					d[3] = book.getLastmodifiedby();
					
					ajaxRes.setData(d);
					
					ajaxRes.setMessage("Book Uploaded Successfully.");
					}
		
			return ajaxRes;
		} catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to add Book");
			
		return ajaxRes;
		} 
	}
	
	@RequestMapping(value = WebConstants.VIEW_LIBRARY)
	public  String viewAllBooks(
			ModelMap model,
			@ModelAttribute(value = "bookCatForm") BookCategoryData catData,
			SessionStatus status) {
		List<BookCategoryData> catlist = new ArrayList<BookCategoryData>();
		try {
			catlist = bookService.getAllBookCategories();
			model.addAttribute("bookCatList", catlist);
			model.addAttribute("bookCatForm", new BookCategoryData());
			return WebConstants.VIEW_NAME_VIEW_LIBRARY;
		} catch (ServiceException e) {
			return WebConstants.VIEW_NAME_VIEW_LIBRARY;
		} catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_LIBRARY;
		}
	}

	@RequestMapping(value = WebConstants.DELETE_LIBRARY , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteCategory(
			ModelMap model,
			@ModelAttribute(value = "bookCatForm") BookCategoryData catData,
			SessionStatus status) {
		
		AjaxResponse ajaxRes = new AjaxResponse();
				try {
					if(null!=catData.getId()){
						bookService.deleteBookCategory(catData.getId());
					}
					ajaxRes.setSuccess(true);
					ajaxRes.setMessage("Books Deleted.");
				} catch (Exception e) {
					ajaxRes.setSuccess(false);
					ajaxRes.setException(e.getMessage());
					ajaxRes.setErrormsg("Unable to Delete Books");
				}
			
		return ajaxRes;
	}
	
	@RequestMapping(value = WebConstants.EDIT_LIBRARY)
	public String editLibrary(
			@ModelAttribute(value = "bookCatForm") BookCategoryData catData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		BookCategoryData bookcat = new BookCategoryData();
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		StaticData sd = localStaticContainer.getStaticData();
		CustomImage image = new CustomImage();
		if (WebConstants.VIEW.equalsIgnoreCase(catData.getActionType())) {
			try {
				 bookcat = bookService.getBookCategory(catData.getId());
				
				 String uuid = ImageUtil.getARandomString();
					bookcat.setUuid(uuid);
					image.setUrl(bookcat.getImageName());
					image.setUuid(uuid);
					model.addAttribute("imageForm",image);
				 bookcat.setActionType(WebConstants.UPDATE);
				model.addAttribute("bookCatForm",bookcat);
				return WebConstants.VIEWNAME_LIBRARY_EDIT;
			}
			
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("imageForm",image);
				model.addAttribute("bookCatForm",catData);
				return WebConstants.VIEWNAME_LIBRARY_EDIT;
			}
		}
		else if (WebConstants.UPDATE.equalsIgnoreCase(catData.getActionType())) {
			
		try {
			String type= null;
			String url  = catData.getName().toLowerCase().replaceAll(" ", "-").replaceAll("[^a-zA-Z0-9&&[^-]]", "");
			byte[] filebyte=null;
			
			if(ss.isExistsImage(catData.getUuid()+"_CRP")){
				filebyte = ss.getImage(catData.getUuid()+"_CRP");
				type = ss.getImageType(catData.getUuid()+"_CRP");
			}
			else{
				model.addAttribute("bookCat",catData);
					result.rejectValue("file",ErrorConstants.TS_1050);			
					return WebConstants.VIEWNAME_LIBRARY_EDIT;
			}
			
			if(isBookCatExisted(url,catData.getId())){
				catData.setImageString(ImageUtil.getImageAsString(filebyte));
				model.addAttribute("bookCat",catData);
				result.rejectValue("name",ErrorConstants.TS_9054);			
				return WebConstants.VIEWNAME_LIBRARY_EDIT;
			}
			String imageName = catData.getUnid()+type;
			catData.setName(catData.getName());
			catData.setUrl(url);
			catData.setInsertedby(userName);
			catData.setLastmodifiedby(userName);
			
			if(null!=imageName&&null!=filebyte){
				String newimageName =catData.getUnid()+imageName.substring(imageName.lastIndexOf("."));
				catData.setImageName(newimageName);
				sd.saveImage(newimageName, filebyte, "B");
			}
			bookService.updateBookCategory(catData);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9051);
			return WebConstants.REDIRECT_VIEW_ALL;

		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9053);
			model.addAttribute("bookCat", catData);


			return WebConstants.VIEWNAME_LIBRARY_EDIT;
		}
		}
		return WebConstants.REDIRECT_VIEW_ALL;
	}

	@RequestMapping(value = WebConstants.ADD_LIBRARY, method = RequestMethod.POST)
	public String addBookCategory(
			@ModelAttribute(value = "bookCatForm") BookCategoryData catData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		StaticData sd = localStaticContainer.getStaticData();
		//ServletContext context = session.getServletContext();
		if (WebConstants.VIEW.equalsIgnoreCase(catData.getActionType())) {
			try {
				String uuid = ImageUtil.getARandomString();
				catData.setUuid(uuid);
				catData.setActionType(WebConstants.ADD);
				model.addAttribute("bookCatForm",catData);
				
				CustomImage image = new CustomImage();
				image.setUuid(uuid);
				model.addAttribute("imageForm",image);
				
				return WebConstants.VIEWNAME_LIBRARY_EDIT;
			}
			
			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("bookCatForm", catData);
				return WebConstants.VIEWNAME_LIBRARY_EDIT;
			}
		}
		else if (WebConstants.ADD.equalsIgnoreCase(catData.getActionType())) {
			
		try {
			String type= null;
			byte[] filebyte = null;
			UniqueIdGenerator uid = new UniqueIdGenerator();
			String unid = uid.toString();
			String url  = catData.getName().toLowerCase().replaceAll(" ", "-").replaceAll("[^a-zA-Z0-9&&[^-]]", "");
			if(ss.isExistsImage(catData.getUuid()+"_CRP")){
				 type = ss.getImageType(catData.getUuid()+"_CRP");
					filebyte = ss.getImage(catData.getUuid()+"_CRP");
			}
			else{
				model.addAttribute("bookCatForm",catData);
				result.rejectValue("file",ErrorConstants.TS_9055);			
				return WebConstants.VIEWNAME_LIBRARY_EDIT;
			}
			
			if(isBookCatExisted(url)){
				catData.setImageString(ImageUtil.getImageAsString(filebyte));
				model.addAttribute("bookCatForm",catData);
				model.addAttribute("imageForm",new CustomImage());
				result.rejectValue("name",ErrorConstants.TS_9054);			
				return WebConstants.VIEWNAME_LIBRARY_EDIT;
			}
			String newimageName =unid+type;
			catData.setName(catData.getName());
			catData.setUrl(url);
			catData.setUnid(unid);
			catData.setImageName(newimageName);
			catData.setInsertedby(userName);
			catData.setLastmodifiedby(userName);
			bookService.addBookCategory(catData);
			sd.saveImage(newimageName, filebyte, "B");
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9050);
			return WebConstants.REDIRECT_VIEW_ALL;

		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
					ErrorConstants.TS_9052);
			model.addAttribute("bookCatForm", catData);
			model.addAttribute("imageForm",new CustomImage());
			return WebConstants.VIEWNAME_LIBRARY_EDIT;
		}
		}
		return WebConstants.REDIRECT_VIEW_ALL;
	}
	
	@RequestMapping(value = WebConstants.UPLOAD_LIBRARYIMAGE, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse uploadImage( @ModelAttribute(value = "imageForm") CustomImage image,HttpSession session,
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
					filebyte = ImageUtil.getDontCropImage(file.getBytes(), 194, 146);
				}
				else if(image.getPriority().equalsIgnoreCase("2")){
					
					filebyte = ImageUtil.getDontCropImage(file.getBytes(), 119, 168);
				}
				
				ajaxRes.setValid(true);
				ajaxRes.setDontCrop(true);
				ajaxRes.setImage(ImageUtil.getImageAsString(filebyte));
				ss.saveImage(uuid+"_CRP", filebyte);
					
			}
			else{
				if(null!=image.getActionType()&&WebConstants.CROP.equalsIgnoreCase(image.getActionType())){
					
					if(image.getPriority().equalsIgnoreCase("1")){
						image.setFixedW(146);
					}
					else if(image.getPriority().equalsIgnoreCase("2")){
						image.setFixedW(168);
					}
					 filebyte = ss.getImage(uuid+"_ORG");
					image.setImageBytes(filebyte);
					byte[] cropedImage = ImageUtil.cropImage(image);
					ss.saveImage(uuid+"_CRP", cropedImage);
					ajaxRes.setValid(true);
					ajaxRes.setImage(ImageUtil.getImageAsString(cropedImage));
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

	
	private boolean isBookExisted(Integer catId, String url) {
		boolean isExisted = true;
		try {
			
			isExisted =  bookService.isExistedBook(catId,url);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isExisted;
	}
	
	private boolean isBookCatExisted(String url) {
		boolean isExisted = true;
		try {
			
			isExisted =  bookService.isExistedBookCategory(url);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isExisted;
	}
	
	private boolean isBookCatExisted(String url,Integer id) {
		boolean isExisted = true;
		try {
			
			isExisted =  bookService.isExistedBookCategoryAndId(url, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isExisted;
	}
}