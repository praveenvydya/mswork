package com.vydya.theschool.web.admin.controllers;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.AttendanceData;
import com.vydya.theschool.common.dto.ExamData;
import com.vydya.theschool.common.dto.ExamSubjectData;
import com.vydya.theschool.common.dto.MarksData;
import com.vydya.theschool.common.dto.StudentClassData;
import com.vydya.theschool.common.dto.StudentData;
import com.vydya.theschool.common.dto.SubjectData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.AttendanceService;
import com.vydya.theschool.services.api.common.ClassService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.common.SubjectService;
import com.vydya.theschool.services.api.home.StudentMarksService;
import com.vydya.theschool.services.api.home.StudentService;
import com.vydya.theschool.web.constants.WebConstants;

@Controller
public class AttendanceController {

	private final static Logger logger = Logger
			.getLogger(AttendanceController.class.getName());

	@Autowired
	protected ReferenceDataService referenceDataService;
	
	@Autowired
	protected SubjectService subjectService;

	@Autowired
	protected StudentService studentService;

	@Autowired
	protected StudentMarksService marksService;

	@Autowired
	protected ClassService classService;	
	@Autowired
	protected AttendanceService attService;

	
	public AttendanceController() {
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
	
	@RequestMapping(value = WebConstants.VIEW_ATTENDANCE, method = RequestMethod.GET)
	public String searchAndViewAll( @ModelAttribute(value = "subjectForm") SubjectData subjectData,
			ModelMap model,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		String subjectid = request.getParameter("s");
		SubjectData sd = null;
		StudentClassData sc= null;
		try{
			if(null!=subjectid){
				sd = subjectService.findById(Integer.parseInt(subjectid));
			}
			//model.addAttribute("subject", sd);
			model.addAttribute("subjectForm", sd);
			return WebConstants.VIEWNAME_ATTENDANCE;
		}catch (ServiceException e) {
			return WebConstants.VIEWNAME_ATTENDANCE;
		} 
			catch (Exception e) {
			return WebConstants.VIEWNAME_ATTENDANCE;
		}
	}
	
	@RequestMapping(value = "admin/manageClass/getAttendance.htm")
	public  @ResponseBody List<AttendanceData> loadUpdatedEventImage( 
			ModelMap model, 
			ServletRequest request,
			SessionStatus status) {
		List<AttendanceData> attList = new ArrayList<AttendanceData>();
		String subjectid = request.getParameter("b");
		String month = request.getParameter("m");
		String year = request.getParameter("y");
		try {
			attList =	attService.loadAttendace(Integer.parseInt(subjectid), Integer.parseInt(year), Integer.parseInt(month));
			return attList;
		} catch (ServiceException e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
		return attList;
		
		} catch (Exception e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
			return attList;
		}
	}
	
	@RequestMapping(value = "students/getStudents.htm")
	public  @ResponseBody List<StudentData> getStudents(
			ModelMap model,
			ServletRequest request,
			SessionStatus status) {
		List<StudentData>	studentlist = new ArrayList<StudentData>();
		String classId = request.getParameter("c");
		try{
			if(null!=classId){
				studentlist = studentService.getStudents(Integer.parseInt(classId));
				return studentlist;
			}
			
		} catch (ServiceException e) {
		} catch (Exception e) {
		}
		return studentlist;
	}
	
	
@RequestMapping(value = "students/getExams.htm")
	public  @ResponseBody List<ExamData> getExams(
			ModelMap model,
			ServletRequest request,
			SessionStatus status) {
		List<ExamData>	examsList = new ArrayList<ExamData>();
		String studenId = request.getParameter("st");
		try{
			if(null!=studenId){
				examsList = studentService.getExams(Integer.parseInt(studenId));
				return examsList;
			}
		} catch (ServiceException e) {
		} catch (Exception e) {
		}
		return examsList;
	}
	
	
	@RequestMapping(value = "students/getSubjects.htm")
	public  @ResponseBody List<SubjectData> getSubjects(
			ModelMap model,
			ServletRequest request,
			SessionStatus status) {
		List<SubjectData>	subjectslist = new ArrayList<SubjectData>();
		String classId = request.getParameter("c");
		try{
			if(null!=classId){
				subjectslist = subjectService.loadAllSubjects(Integer.parseInt(classId));
				//subjectslist = classService.findByClassId(Integer.parseInt(classId));
				return subjectslist;
			}
			
		} catch (ServiceException e) {
		} catch (Exception e) {
		}
		return subjectslist;
	}
	
	@RequestMapping(value = "admin/manageClass/saveAttendance.htm")
	public  @ResponseBody AjaxResponse saveOrUpdate( @RequestBody String jsonString,HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		
		AjaxResponse aresponse = new AjaxResponse();
		
		List<AttendanceData> list = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			list = mapper.readValue(jsonString,  new TypeReference<List<AttendanceData>>(){});
			System.out.println(list);
			for(AttendanceData at:list){
				
				//if(checkSubjectAuthority(user,subjectid)){
				if(false){
					
				}
				else{
					//at.setAttdate(at.getAttdate()+"/01/2015");
					at.setAttdate(at.getAttdate()+"/"+at.getMonth()+"/"+at.getYear());
					at.setInsertedby(userName);
					at.setLastmodifiedby(userName);
					attService.save(at);
					
					aresponse.setSuccess(true);
					
				}
			}
			
			if(aresponse.isSuccess()){
			
				aresponse.setMessage("Successfully Saved.");
			}
			else{
				
			}
			
			return aresponse;
			//return attList;
		//} catch (ServiceException e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
		//return attList;
		} catch (Exception e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
			//return attList;
			return aresponse;
		}
	}

}