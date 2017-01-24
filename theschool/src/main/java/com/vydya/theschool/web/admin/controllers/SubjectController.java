package com.vydya.theschool.web.admin.controllers;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.vydya.theschool.common.dto.ReferenceData;
import com.vydya.theschool.common.dto.SubjectData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.common.SubjectService;
import com.vydya.theschool.web.constants.WebConstants;

@Controller
public class SubjectController {

	private final static Logger logger = Logger
			.getLogger(SubjectController.class.getName());

	@Autowired
	protected ReferenceDataService referenceDataService;
	@Autowired
	protected SubjectService subjectService;

	
	
	public SubjectController() {
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
	
	
	
	@RequestMapping(value = WebConstants.VIEW_SUBJECTS, method = RequestMethod.GET)
	public String searchAndViewAll(
			ModelMap model,
			HttpSession session,
			SessionStatus status,ServletRequest request) {

		String classid = request.getParameter("class");
		List<SubjectData> subjectList= new ArrayList<SubjectData>();
		try {
			if(null!=classid){
				 subjectList = subjectService.loadAllSubjects(Integer.parseInt(classid));
			}
			model.addAttribute("subjectList", subjectList);
			SubjectData sub = new SubjectData();
			sub.setClassId(Integer.parseInt(classid));
			model.addAttribute("subjectForm",sub );
			return WebConstants.VIEWNAME_SUBJECTS;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_SUBJECTS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SUBJECTS;
		}
	}


	@RequestMapping(value = WebConstants.VIEW_SUBJECTS, method = RequestMethod.POST)
	public String updateAll(
			ModelMap model, @ModelAttribute(value = "subjectForm") SubjectData subjectData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		/*try {
			
			
			return WebConstants.VIEWNAME_SUBJECTS;
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_SUBJECTS;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SUBJECTS;
		}*/
		return WebConstants.VIEWNAME_SUBJECTS;
	}

	
/*	@RequestMapping(value = WebConstants.ADD_SUBJECT, method = RequestMethod.GET)
	public String addClassGet(
			ModelMap model, @ModelAttribute(value = "subjectForm") SubjectData subjectData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			model.addAttribute("subjectForm", subjectData);
			return WebConstants.VIEWNAME_SUBJECT_ADD_OR_EDIT;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SUBJECT_ADD_OR_EDIT;
		}
	}*/
	
	@RequestMapping(value = WebConstants.ADD_SUBJECT, method = RequestMethod.POST)
	public String addClassPost(
			ModelMap model, @ModelAttribute(value = "subjectForm") SubjectData subjectData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		try {
			
			if (WebConstants.VIEW.equalsIgnoreCase(subjectData.getActionType())) {
				subjectData.setActionType(WebConstants.ADD);
				model.addAttribute("subjectForm", subjectData);
				populateSeededData(model);
				return WebConstants.VIEWNAME_SUBJECT_ADD_OR_EDIT;
			}
			else{
				//subjectData.setInsertedby(userName);
				//subjectData.setLastmodifiedby(userName);
				subjectService.save(subjectData);
				model.addAttribute("subjectForm", new SubjectData());
				
				return "redirect:viewAll.htm?class="+subjectData.getClassId();
			}
			
		} catch (Exception e) {
			model.addAttribute("subjectForm", subjectData);
			return WebConstants.VIEWNAME_SUBJECT_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.EDIT_SUBJECT, method = RequestMethod.GET)
	public String editClassGet(
			ModelMap model, @ModelAttribute(value = "subjectForm") SubjectData subjectData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			model.addAttribute("subjectForm", new SubjectData());
			return WebConstants.VIEWNAME_SUBJECT_ADD_OR_EDIT;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_SUBJECT_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.EDIT_SUBJECT, method = RequestMethod.POST)
	public String update(
			ModelMap model, @ModelAttribute(value = "subjectForm") SubjectData subjectData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			subjectService.UpdateSubjectData(subjectData);
			model.addAttribute("subjectForm", new SubjectData());
			return WebConstants.REDIRECT_VIEWALL;
		} catch (Exception e) {
			model.addAttribute("subjectForm", subjectData);
			return WebConstants.VIEWNAME_SUBJECT_ADD_OR_EDIT;
		}
	}
	
	@RequestMapping(value = WebConstants.DELETE_SUBJECT, method = RequestMethod.POST)
	public String delete(
			ModelMap model, @ModelAttribute(value = "subjectForm") SubjectData subjectData,
			HttpSession session,
			SessionStatus status,ServletRequest request) {
		try {
			subjectService.deleteSubject(subjectData.getId());
			model.addAttribute("subjectForm", new SubjectData());
			return WebConstants.REDIRECT_VIEWALL;
		} catch (Exception e) {
			model.addAttribute("subjectForm", subjectData);
			return WebConstants.VIEWNAME_SUBJECT_ADD_OR_EDIT;
		}
	}

	private void populateSeededData(ModelMap model) throws ServiceException {
		List<ReferenceData> subjectTpLilst =  referenceDataService.getReferenceData("SUBJECTTYPE");
		model.addAttribute("subjectTpLilst", subjectTpLilst);
		
	}
}