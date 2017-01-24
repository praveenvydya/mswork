package com.vydya.theschool.web.admin.controllers;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.AttendanceData;
import com.vydya.theschool.common.dto.ClassData;
import com.vydya.theschool.common.dto.ParentData;
import com.vydya.theschool.common.dto.StudentData;
import com.vydya.theschool.common.dto.SubjectData;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.AttendanceService;
import com.vydya.theschool.services.api.common.ClassService;
import com.vydya.theschool.services.api.common.ParentService;
import com.vydya.theschool.services.api.common.SubjectService;
import com.vydya.theschool.services.api.home.StudentService;
import com.vydya.theschool.services.api.user.GenUserCredentialsService;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;
import com.vydya.theschool.web.localstatic.LocalStaticContainer;
import com.vydya.theschool.web.validator.LoginValidator;

@Controller  
public class ParentController {

	private final static Logger log = Logger.getLogger(ParentController.class.getName());
	
	@Autowired
	protected LoginValidator loginValidator;	
	
	@Autowired
	protected ParentService parentService;	
	
	@Autowired
	protected StudentService studentService;	
	
	@Autowired
	protected SubjectService subjectService;	
	
	@Autowired
	protected ClassService classService;	
	@Autowired
	protected AttendanceService attService;
	
	@Autowired
	protected GenUserCredentialsService credentialsService;
	
	@Autowired
	protected SchoolAdminProperties properties; 
	
	@Autowired
	protected LocalStaticContainer localStaticContainer; 
	
	
	Map<String, String> loginUsers = new HashMap<String, String>();
	
	@RequestMapping(value="user/parent/home.htm",method = RequestMethod.GET)
	public String initLoginForm(HttpServletRequest request,ModelMap model) 
	{
		HttpSession session = request.getSession();
		Integer userid = (Integer)session.getAttribute("user_type_id");
		try{
			
		ParentData parent = parentService.findById(userid);
		List<StudentData> students = studentService.findStudentsByParent(userid);

		String userType = (String)session.getAttribute("user_type");
		
		model.addAttribute("parent", parent);
		model.addAttribute("students", students);
		log.debug("Parent invoked");
		
		} catch (ServiceException e) {
			
		} catch (SecurityException e) {
			
		} catch (Exception e) {
			ApplicationException appExp = new ApplicationException(
					ErrorConstants.TS_1015, e.getMessage());
			log.error(appExp.toString(), e);
		}
		
		return "parent.home";
	}
	
	
	
	@RequestMapping(value="user/parent/attendance.htm",method = RequestMethod.GET)
	public String initStudentAttendance(HttpServletRequest request,ModelMap model) 
	{
		Integer studentId = Integer.parseInt(request.getParameter("st"));
		HttpSession session = request.getSession();
		Integer userid = (Integer)session.getAttribute("user_type_id");
		try{
			StudentData std = studentService.getStudentById(studentId);
			ClassData cd = classService.getByStudentId(studentId);
			
			String idString = (String) session.getAttribute("childlist");
			String[] ids = idString.split(",");
			List<Integer> idlist = new ArrayList<Integer>();
			for(String id :ids){
				idlist.add(Integer.parseInt(id));
			}
		if(idlist.contains(studentId)){
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
			log.error(appExp.toString(), e);
		}
		
		return "student.attendance";
	}


	@RequestMapping(value = "user/studentClass/getAttendance.htm")
	public  @ResponseBody List<AttendanceData> getAttendance(
			ModelMap model,
			HttpServletRequest request,
			SessionStatus status) {
		List<AttendanceData> attList = new ArrayList<AttendanceData>();
		HttpSession session = request.getSession();
		Integer subjectid = Integer.parseInt(request.getParameter("b"));
		Integer studentid = Integer.parseInt(request.getParameter("s"));
		Integer month = Integer.parseInt(request.getParameter("m"));
		Integer year = Integer.parseInt(request.getParameter("y"));
		
		Integer userid = (Integer)session.getAttribute("user_type_id");
		String userType = (String)session.getAttribute("user_type");
		List<Integer> idlist = new ArrayList<Integer>();
			
		String idString;String[] ids;
		if(!(userType.equalsIgnoreCase("Student"))){
			idString= (String) session.getAttribute("childlist");
			 ids = idString.split(",");
			 for(String id :ids){
					idlist.add(Integer.parseInt(id));
				}	
		}
		
		try {
			if((null!=idlist&&idlist.contains(studentid))||(userType.equalsIgnoreCase("Student") &&userid.equals(studentid))){
				attList =	attService.loadAttendace(subjectid, studentid, year, month);
			}
			else{
				String message="You are not allowed to view details of other student.";
				model.addAttribute("er_message", message);
				// Your are not authorised to access details of other student.
			}
			return attList;
		} catch (ServiceException e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
		return attList;
		} catch (Exception e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
			return attList;
		}
	}
	

	@RequestMapping(value = "user/studentClass/getMonths.htm")
	public  @ResponseBody List<String> getMonthsYear(
			ModelMap model,
			ServletRequest request,
			SessionStatus status) {
		List<String> mlist = new ArrayList<String>();
		String classId = request.getParameter("cl");
		try {

			mlist = getClassMonths(Integer.parseInt(classId));
		} catch (Exception e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
			return mlist;
		}
		return mlist;
	}

	@RequestMapping(value = "user/studentClass/getSubjects.htm")
	public  @ResponseBody List<SubjectData> getSubjects(
			ModelMap model,
			ServletRequest request,
			SessionStatus status) {
		List<SubjectData> subjects  = new ArrayList<SubjectData>();
		String classId = request.getParameter("cl");
		try {

			// subjects = classService.findByClassId(Integer.parseInt(classId));
			subjects = subjectService.loadAllSubjects(Integer.parseInt(classId));
		} catch (Exception e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
			return subjects;
		}
		return subjects;
	}
	
	private List<String> getClassMonths(Integer id) {
		// TODO Auto-generated method stub
		LinkedList<String> ms = new LinkedList<String>();
		ms.add("2014-4");
		ms.add("2014-5");
		ms.add("2014-6");
		ms.add("2014-7");
		ms.add("2014-8");
		ms.add("2014-9");
		ms.add("2014-10");
		ms.add("2014-11");
		ms.add("2014-12");
		ms.add("2015-01");
		ms.add("2015-02");
		ms.add("2015-03");
		return ms;
		
	}

}
