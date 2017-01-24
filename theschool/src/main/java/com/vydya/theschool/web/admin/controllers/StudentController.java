package com.vydya.theschool.web.admin.controllers;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.AddressData;
import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.ClassData;
import com.vydya.theschool.common.dto.CustomImage;
import com.vydya.theschool.common.dto.ParentData;
import com.vydya.theschool.common.dto.ReferenceData;
import com.vydya.theschool.common.dto.StudentClassData;
import com.vydya.theschool.common.dto.StudentData;
import com.vydya.theschool.common.dto.StudentSearch;
import com.vydya.theschool.common.dto.SubjectMarksData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.common.AttendanceService;
import com.vydya.theschool.services.api.common.ClassService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.home.StudentService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.utils.UniqueIdGenerator;

@Controller
public class StudentController {

	private final static Logger logger = Logger
			.getLogger(StudentController.class.getName());

	@Autowired
	protected ReferenceDataService referenceDataService;
	
	@Autowired
	protected StudentService studentService;
	@Autowired
	protected ClassService classService;	
	@Autowired
	protected AttendanceService attService;
	
	
	public StudentController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@InitBinder 
    public void initBinder(WebDataBinder binder) { 
		 	String dateFmt = "yyyy-MM-dd";
            SimpleDateFormat dateFormat = new SimpleDateFormat(dateFmt); 
            dateFormat.setLenient(false); 
            binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
    } 
	
	@RequestMapping(value="user/student/home.htm",method = RequestMethod.GET)
	public String initLoginForm(HttpServletRequest request, ModelMap model) 
	{
		logger.debug("Student invoked");
		HttpSession session = request.getSession();
		Integer userid = (Integer)session.getAttribute("user_type_id");
		try{
		StudentData  student = studentService.getStudentById(userid);
		model.addAttribute("student", student);
		
		} catch (ServiceException e) {
			
		} catch (SecurityException e) {
			
		} catch (Exception e) {
			ApplicationException appExp = new ApplicationException(
					ErrorConstants.TS_1015, e.getMessage());
			logger.error(appExp.toString(), e);
		}
		
		return "student.home";
	}
	
	@RequestMapping(value="user/student/attendance.htm",method = RequestMethod.GET)
	public String initStudentAttendance(HttpServletRequest request,ModelMap model) 
	{
		Integer studentId = Integer.parseInt(request.getParameter("st"));
		HttpSession session = request.getSession();
		Integer userid = (Integer)session.getAttribute("user_type_id");
		
		try{
		if(userid.equals(studentId)){
			StudentData std = studentService.getStudentById(studentId);
			ClassData cd = classService.getByStudentId(studentId);
			model.addAttribute("cls", cd);
			model.addAttribute("student", std);
		}
		else{
			String message="You are not allowed to view details of other student.";
			model.addAttribute("er_message", message);
			// Your are not authorised to access details of other student.
		}
		
		} catch (ServiceException e) {
			
		} catch (SecurityException e) {
			
		} catch (Exception e) {
			ApplicationException appExp = new ApplicationException(
					ErrorConstants.TS_1015, e.getMessage());
			logger.error(appExp.toString(), e);
		}
		
		return "student.attendance";
	}

	
	@RequestMapping(value = WebConstants.SEARCH_VIEW_STUDENTS)
	public String searchStudent(
			ModelMap model,
			@ModelAttribute(value = "studentSearchForm") StudentSearch studentSearchForm,HttpSession session,
			SessionStatus status) {

		try {
			populateStudentSeededData(model, session);
			
			List<ClassData>  classes =  classService.loadAllClasses();
			
			model.addAttribute("studentSearchForm", studentSearchForm);
			model.addAttribute("classes", classes);
			
			return WebConstants.VIEWNAME_STUDENT_SEARCH;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_STUDENT_SEARCH;
		}
	}
	
	@RequestMapping(value = WebConstants.SEARCH_VIEW_STUDENTS, method = RequestMethod.POST)
	public String searchAndViewAll(
			ModelMap model,
			@ModelAttribute(value = "studentSearchForm") StudentSearch studentSearchForm,HttpSession session,
			SessionStatus status) {

		try {
			List<StudentData> studentsList = studentService.searchStudents(studentSearchForm);
			model.addAttribute("studentsList", studentsList);
			model.addAttribute("studentSearchForm", studentSearchForm);
			model.addAttribute("studentForm", new StudentData());
			populateStudentSeededData(model, session);
			return WebConstants.VIEWNAME_STUDENT_SEARCH;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_STUDENT_SEARCH;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_STUDENT_SEARCH;
		}
	}

	
	@RequestMapping(value = WebConstants.VIEW_ALL_STUDENTS)
	public String viewAllStudents(
			ModelMap model,ServletRequest request,
			HttpSession session,
			SessionStatus status) {
		List<StudentData>	studentlist = new ArrayList<StudentData>();
		String classId = request.getParameter("c");
		try {
			if(null!=classId){
				studentlist = studentService.getStudents(Integer.parseInt(classId));
			}
			model.addAttribute("studentlist", studentlist);
			return WebConstants.VIEWNAME_STUDENT_VIEWALL;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_STUDENT_VIEWALL;
		}
	}
	
	
	@RequestMapping(value = WebConstants.ADD_STUDENT)
	public String addStudentView(
			@ModelAttribute(value = "studentForm") StudentData studentForm,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) {

		try {
			model.addAttribute("studentForm", studentForm);
			model.addAttribute("studentSearchForm", new StudentSearch());
			populateStudentSeededData(model,session);
			String uuid = ImageUtil.getARandomString();
			CustomImage i  =new CustomImage();
			i.setUuid(uuid);
			model.addAttribute("imageForm", i);
			return WebConstants.VIEWNAME_STUDENT_ADD_OR_EDIT;
		}

		catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),
					e);
			logger.error(exp, e);
			model.addAttribute("studentSearchForm", new StudentSearch());
			return WebConstants.VIEWNAME_STUDENT_SEARCH;
		}
	}
	
	@RequestMapping(value = WebConstants.ADD_STUDENT, method = RequestMethod.POST)
	public String addStudent(
			@ModelAttribute(value = "studentSearchForm") StudentData studentData,
			BindingResult result, ModelMap model, HttpSession session,
			HttpServletResponse response) throws ServiceException {
		ServletContext context = session.getServletContext();
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		CustomImage image = new CustomImage();
		if (WebConstants.VIEW.equalsIgnoreCase(studentData.getActionType())) {
			
			try {
				populateStudentSeededData(model,session);
				String uid = ImageUtil.getARandomString();
				studentData.setUuid(uid);
				studentData.setActionType(WebConstants.ADD);
				//populateGallerySeededData(model);
				model.addAttribute("studentForm",studentData);
				
				image.setUuid(uid);
				model.addAttribute("imageForm",image);
				return WebConstants.VIEWNAME_STUDENT_ADD_OR_EDIT;
			}

			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				model.addAttribute("studentSearchForm", studentData);
				return WebConstants.VIEWNAME_STUDENT_ADD_OR_EDIT;
			}
			
		}
		else if (WebConstants.ADD.equalsIgnoreCase(studentData.getActionType())) {
			
			UniqueIdGenerator uid = new UniqueIdGenerator();
			String unid = uid.toString();
			
			try {
				//copyDataToStudentData(studentData,studentData);
				
				byte[] filebyte = (byte[]) context.getAttribute("cropedImage");
				
				byte[] thumbnail = ImageUtil.getFixedImageWidth(filebyte, 150);
				studentData.setStudentPhoto(thumbnail);
				/*MultipartFile file = studentSearchForm.getFile();
				if(file.getSize()!=0){
					String imageName = file.getOriginalFilename();
					//byte[] filebyte = file.getBytes(); 
					byte[] thumbnail = createThumbnailImage(filebyte);
					studentData.setStudentPhoto(filebyte);
				}*/
				
				studentData.setInsertedby(userName);
				studentData.setLastmodifiedby(userName);
				studentService.saveStudent(studentData);
				//ajaxRes.setSuccess(true);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_8001);
				model.addAttribute("studentSearchForm", new StudentSearch());
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_8001);
				context.removeAttribute("cropedImage");
				return WebConstants.VIEWNAME_STUDENT_ADD_OR_EDIT;
				
			}

			catch (Exception e) {
				ApplicationException exp = new ApplicationException(e.getMessage(),
						e);
				logger.error(exp, e);
				//ajaxRes.setSuccess(false);
				populateStudentSeededData(model,session);
				model.addAttribute("studentSearchForm", studentData);
				//return WebConstants.VIEWNAME_STUDENT_ADD;
			}
			
		}
		return WebConstants.VIEWNAME_STUDENT_ADD_OR_EDIT;
		//return ajaxRes;
		
	}

	
	@RequestMapping(value = WebConstants.VIEW_STUDENT, method = RequestMethod.GET)
	public String viewStudent(
			@ModelAttribute(value = "studentForm") StudentData studentData,
			BindingResult result, ModelMap model, HttpSession session,ServletRequest request,
			HttpServletResponse response) throws ServiceException {

		try {
			String studentId = request.getParameter("s");
			StudentData studentDataNew = studentService.getStudentById(Integer.parseInt(studentId));
			model.addAttribute("student", studentDataNew);
			//model.addAttribute("studentSearchForm", new StudentSearch());
			//List<ExamSubjectData>  examSubjectList = studentService.findStudentMarksByStudentId(studentData.getStudentId());
			return WebConstants.VIEWNAME_STUDENT_VIEW;

		} catch (Exception e) {
			ApplicationException exp = new ApplicationException(e.getMessage(),e);
			logger.error(exp, e);
			model.addAttribute("student", studentData);
			return WebConstants.VIEWNAME_STUDENT_VIEW;
		}

	}     

	
	/*@RequestMapping(value = WebConstants.LOAD_UPDATED_STUDENTS)
	public  @ResponseBody List<StudentData> loadUpdatedStudents(
			ModelMap model,
			SessionStatus status) {
		List<StudentData> updatedStudentList = new ArrayList<StudentData>();
		try {
			updatedStudentList = studentService.loadUpdatedStudents();
			return updatedStudentList;
		} catch (ServiceException e) {
		return updatedStudentList;
		} catch (Exception e) {
			return updatedStudentList;
		}
	}*/
	
	@RequestMapping(value = WebConstants.UPDATE_STUDENT_MARKS)
	public  @ResponseBody List<SubjectMarksData> updateStudentMarks( @ModelAttribute(value = "studentForm") StudentData studentData,
			ModelMap model,
			SessionStatus status) {
		List<SubjectMarksData> updatedMarksList = new ArrayList<SubjectMarksData>();
		try {
			updatedMarksList = studentService.updateStudentMarks(studentData);
			return updatedMarksList;
		} catch (Exception e) {
			return updatedMarksList;
		}
	}
	
	@RequestMapping(value = WebConstants.UPLOAD_STUDENT_PHOTO, method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse uploadStudentPhoto( @ModelAttribute(value = "imageForm") CustomImage image,HttpSession session,
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
	
	private void populateStudentSeededData(ModelMap model, HttpSession session) throws ServiceException {
		List<ReferenceData> classRefList =  referenceDataService.getReferenceTypeList("CLASS");
		model.addAttribute("classRefList", classRefList);
		List<ReferenceData> classSectionRefList =  referenceDataService.getReferenceTypeList("CLASSSECTION");
		model.addAttribute("classSectionRefList", classSectionRefList);
		List<ReferenceData> campusRefList =  referenceDataService.getReferenceTypeList("CAMPUS");
		model.addAttribute("campusRefList", campusRefList);
		
		
	}
	
	private byte[] createThumbnailImage(byte[] inputOrginalImage) throws IOException{
		
		InputStream in = new ByteArrayInputStream(inputOrginalImage);
		BufferedImage bImageFromConvert = ImageIO.read(in);
		
		Image scaledImg = bImageFromConvert.getScaledInstance(200, 250, Image.SCALE_SMOOTH);
		
		BufferedImage thumbnail = new BufferedImage(200, 250, BufferedImage.TYPE_INT_RGB);
		thumbnail.createGraphics().drawImage(scaledImg,0,0,null);
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write( thumbnail, "jpg", baos );
		byte[] imageInByte = baos.toByteArray();
		baos.close();
		in.close();
		return imageInByte;
	}

/*	private void copyxDataToStudentData(StudentData studentData,
			StudentSearch studentSearchForm) throws ParseException {
		studentData.setFirstName(studentSearchForm.getStudentName());
		studentData.setGender(studentSearchForm.getGender());
		studentData.setFatherName(studentSearchForm.getFatherName());
		studentData.setHallTiketNo(studentSearchForm.getHallTiketNo());
		studentData.setRollNumber(studentSearchForm.getRollNumber());
		studentData.setEmailId(studentSearchForm.getEmailId());
		studentData.setSectionOfClass(studentSearchForm.getSectionOfClass());
		
		StudentClassData scd = new StudentClassData();
		scd.setClassName(studentSearchForm.getStudentClass());
		studentData.setStudentClassData(scd);
		studentData.setYearOfClass(studentSearchForm.getYearOfClass());
		studentData.setCampus(studentSearchForm.getCampus());
		studentData.setDateOfJoin(TSDateUtil.dateStringToDate(studentSearchForm.getDateOfJoin())); 
		studentData.setDateOfBirth(TSDateUtil.dateStringToDate(studentSearchForm.getDateOfBirth()));
		studentData.setLastmodified(new Timestamp(System.currentTimeMillis()));
		studentData.setLastmodifiedby("Vydya");
		AddressData addr = studentData.getAddress();
		if(addr==null){
			addr = new AddressData();
		}
		addr.setId(studentSearchForm.getAddressId());
		addr.setAddress1(studentSearchForm.getAddressLine1());
		addr.setAddress2(studentSearchForm.getAddressLine2());
		addr.setCity(studentSearchForm.getDistrict());
		addr.setCountry(studentSearchForm.getCountry());
		addr.setZipCode(studentSearchForm.getZipcode());
		addr.setState(studentSearchForm.getState());
		studentData.setAddress(addr);
	}
*/
}