package com.vydya.theschool.web.admin.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.vydya.theschool.common.dto.TeacherData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.common.TeacherService;
import com.vydya.theschool.web.constants.WebConstants;

@Controller
public class TeacherController {

	private final static Logger logger = Logger
			.getLogger(TeacherController.class.getName());

	@Autowired
	protected ReferenceDataService referenceDataService;
	@Autowired
	protected TeacherService teacherService;

	
	
	public TeacherController() {
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
	
	
	
	@RequestMapping(value = WebConstants.VIEW_TEACHERS, method = RequestMethod.GET)
	public String searchAndViewAll(
			ModelMap model,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		String classid = request.getParameter("class");
		try {
			List<TeacherData> teachersList = teacherService.loadAllTeacherss();
			model.addAttribute("teachersList", teachersList);
			
			model.addAttribute("teacherForm", new TeacherData());
			return WebConstants.VIEWNAME_TEACHERS;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_TEACHERS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_TEACHERS;
		}
	}


	@RequestMapping(value = WebConstants.VIEW_TEACHERS, method = RequestMethod.POST)
	public String updateAll(
			ModelMap model, @ModelAttribute(value = "teacherForm") TeacherData teacherData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		/*try {
			
			
			return WebConstants.VIEWNAME_TEACHERS;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_TEACHERS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_TEACHERS;
		}*/
		return WebConstants.VIEWNAME_TEACHERS;
	}

	
	@RequestMapping(value = WebConstants.ADD_TEACHER, method = RequestMethod.GET)
	public String addClassGet(
			ModelMap model, @ModelAttribute(value = "teacherForm") TeacherData teacherData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			model.addAttribute("teacherForm", new TeacherData());
			return WebConstants.VIEWNAME_TEACHER_ADD_OR_EDIT;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_TEACHER_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.ADD_TEACHER, method = RequestMethod.POST)
	public String addClassPost(
			ModelMap model, @ModelAttribute(value = "teacherForm") TeacherData teacherData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
			
		try {
			teacherService.save(teacherData);
			model.addAttribute("teacherForm", new TeacherData());
			return WebConstants.VIEWNAME_TEACHER_ADD_OR_EDIT;
		} catch (Exception e) {
			model.addAttribute("teacherForm", teacherData);
			return WebConstants.VIEWNAME_TEACHER_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.EDIT_TEACHER, method = RequestMethod.GET)
	public String editClassGet(
			ModelMap model, @ModelAttribute(value = "teacherForm") TeacherData teacherData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			model.addAttribute("teacherForm", new TeacherData());
			return WebConstants.VIEWNAME_TEACHER_ADD_OR_EDIT;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_TEACHER_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.EDIT_TEACHER, method = RequestMethod.POST)
	public String update(
			ModelMap model, @ModelAttribute(value = "teacherForm") TeacherData teacherData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			teacherService.UpdateTeacher(teacherData);
			model.addAttribute("teacherForm", new TeacherData());
			return WebConstants.REDIRECT_VIEWALL;
		} catch (Exception e) {
			model.addAttribute("teacherForm", teacherData);
			return WebConstants.VIEWNAME_TEACHER_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.DELETE_TEACHER, method = RequestMethod.POST)
	public String delete(
			ModelMap model, @ModelAttribute(value = "teacherForm") TeacherData teacherData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			teacherService.deleteTeacher(teacherData.getId());
			model.addAttribute("teacherForm", new TeacherData());
			return WebConstants.REDIRECT_VIEWALL;
		} catch (Exception e) {
			model.addAttribute("teacherForm", teacherData);
			return WebConstants.VIEWNAME_TEACHER_ADD_OR_EDIT;
		}
	}

}