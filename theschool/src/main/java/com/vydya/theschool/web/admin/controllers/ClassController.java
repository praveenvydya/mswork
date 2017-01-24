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

import com.vydya.theschool.common.dto.ClassData;
import com.vydya.theschool.common.dto.SubjectData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.ClassService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.common.SubjectService;
import com.vydya.theschool.services.api.home.StudentService;
import com.vydya.theschool.web.constants.WebConstants;

@Controller
public class ClassController {

	private final static Logger logger = Logger
			.getLogger(ClassController.class.getName());

	@Autowired
	protected ReferenceDataService referenceDataService;
	@Autowired
	protected StudentService studentService;

	@Autowired
	protected ClassService classService;

	@Autowired
	protected SubjectService subjectService;
	
	public ClassController() {
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
	
	
	
	@RequestMapping(value = WebConstants.VIEW_CLASSES, method = RequestMethod.GET)
	public String searchAndViewAll(
			ModelMap model,
			HttpSession session,
			SessionStatus status,ServletRequest request) {

		try {
			
			List<ClassData> classesList = classService.loadAllClasses();
			model.addAttribute("classesList", classesList);
			model.addAttribute("classForm", new ClassData());
			return WebConstants.VIEWNAME_CLASSES;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_CLASSES;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_CLASSES;
		}
	}


	@RequestMapping(value = WebConstants.VIEW_CLASSES, method = RequestMethod.POST)
	public String updateAll(
			ModelMap model, @ModelAttribute(value = "classForm") ClassData classData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		/*try {
			
			
			return WebConstants.VIEWNAME_CLASSES;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_CLASSES;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_CLASSES;
		}*/
		return WebConstants.VIEWNAME_CLASSES;
	}

	
	@RequestMapping(value = WebConstants.ADD_CLASS, method = RequestMethod.GET)
	public String addClassGet(
			ModelMap model, @ModelAttribute(value = "classForm") ClassData classData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			model.addAttribute("classForm", new ClassData());
			return WebConstants.VIEWNAME_CLASS_ADD_OR_EDIT;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_CLASS_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.ADD_CLASS, method = RequestMethod.POST)
	public String addClassPost(
			ModelMap model, @ModelAttribute(value = "classForm") ClassData classData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			classService.save(classData);
			model.addAttribute("classForm", new ClassData());
			return WebConstants.VIEWNAME_CLASS_ADD_OR_EDIT;
		} catch (Exception e) {
			model.addAttribute("classForm", classData);
			return WebConstants.VIEWNAME_CLASS_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.EDIT_CLASS, method = RequestMethod.GET)
	public String editClassGet(
			ModelMap model, @ModelAttribute(value = "classForm") ClassData classData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			model.addAttribute("classForm", new ClassData());
			return WebConstants.VIEWNAME_CLASS_ADD_OR_EDIT;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_CLASS_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.EDIT_CLASS, method = RequestMethod.POST)
	public String update(
			ModelMap model, @ModelAttribute(value = "classForm") ClassData classData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			classService.UpdateClassData(classData);
			model.addAttribute("classForm", new ClassData());
			return WebConstants.REDIRECT_VIEWALL;
		} catch (Exception e) {
			model.addAttribute("classForm", classData);
			return WebConstants.VIEWNAME_CLASS_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.DELETE_CLASS, method = RequestMethod.POST)
	public String delete(
			ModelMap model, @ModelAttribute(value = "classForm") ClassData classData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			classService.deleteClass(classData.getId());
			model.addAttribute("classForm", new ClassData());
			return WebConstants.REDIRECT_VIEWALL;
		} catch (Exception e) {
			model.addAttribute("classForm", classData);
			return WebConstants.VIEWNAME_CLASS_ADD_OR_EDIT;
		}
	}
	
}