package com.vydya.theschool.web.admin.controllers;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.vydya.theschool.common.dto.MenuContent;
import com.vydya.theschool.common.dto.ReferenceData;
import com.vydya.theschool.common.dto.SubjectData;
import com.vydya.theschool.common.dto.TeacherData;
import com.vydya.theschool.services.api.common.ClassService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.common.TeacherService;
import com.vydya.theschool.services.api.home.StudentMarksService;
import com.vydya.theschool.services.api.home.StudentService;

@Controller
public class GeneralController {

	private final static Logger logger = Logger
			.getLogger(StudentController.class.getName());

	@Autowired
	protected ReferenceDataService referenceDataService;
	@Autowired
	protected StudentService studentService;
	
	@Autowired
	protected TeacherService teacherService;
	
	@Autowired
	protected ClassService classService;
	
	@Autowired
	protected StudentMarksService studentMarksService;
	
	
	
	/*@Autowired
	protected DataExportWebUtil exportUtil;*/
	
	public GeneralController() {
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
	
	
	@RequestMapping(value = "school/getData.htm")
	public  @ResponseBody List<MenuContent> getSubjects(
			ModelMap model,
			ServletRequest request,
			SessionStatus status) {
		String type = request.getParameter("t");
		List<MenuContent> cclist = new ArrayList<MenuContent>();
		try {
			
			if("TC".equalsIgnoreCase(type)){
				String id = request.getParameter("id");
				
				cclist = getTeacherList(Integer.parseInt(id));
			}
				
			
		} catch (Exception e) {
			
		}
		return cclist;
	}

	private List<MenuContent> getTeacherList(Integer id) {
		List<MenuContent> cclist = new ArrayList<MenuContent>();
		try {
			
		List<TeacherData> teacList =  teacherService.getTeacherBySubjectType(id);
		 for(TeacherData rd:teacList){
			 MenuContent mc = new MenuContent();
			 mc.setId(rd.getId());
			 mc.setName(rd.getFirstName()+", "+rd.getLastName());
			 cclist.add(mc);
		 }
		
		} catch (Exception e) {
			
		}
		return cclist;
	}

}