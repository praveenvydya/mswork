package com.vydya.theschool.web.admin.controllers;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.vydya.theschool.common.dto.ClassData;
import com.vydya.theschool.common.dto.MarksData;
import com.vydya.theschool.common.dto.ReferenceData;
import com.vydya.theschool.common.dto.StudentData;
import com.vydya.theschool.common.dto.StudentMarksSearch;
import com.vydya.theschool.common.dto.SubjectData;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.api.common.ClassService;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.common.SubjectService;
import com.vydya.theschool.services.api.home.StudentMarksService;
import com.vydya.theschool.services.api.home.StudentService;
import com.vydya.theschool.web.constants.WebConstants;

@Controller
public class StudentMarksController {

	private final static Logger logger = Logger
			.getLogger(StudentController.class.getName());

	@Autowired
	protected ReferenceDataService referenceDataService;
	@Autowired
	protected StudentService studentService;
	
	@Autowired
	protected SubjectService subjectService;

	@Autowired
	protected ClassService classService;
	
	@Autowired
	protected StudentMarksService studentMarksService;
	
	
	
	/*@Autowired
	protected DataExportWebUtil exportUtil;*/
	
	public StudentMarksController() {
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
	
	@RequestMapping(value = WebConstants.SEARCH_VIEW_STUDENT_MARKS)
	public String searchStudentMarks(
			ModelMap model,
			@ModelAttribute(value = "marksSearch") StudentMarksSearch studentMarksSearch,HttpSession session,
			SessionStatus status) {

		try {
			populateStudentSeededData(model, session);
			model.addAttribute("marksSearch", studentMarksSearch);
			
			return WebConstants.VIEWNAME_STUDENT_MARKS_SEARCH;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_STUDENT_MARKS_SEARCH;
		}
	}
	
/*	@RequestMapping(value = WebConstants.VIEW_ALL_MARKS)
	public String viewStudentMarks(
			ModelMap model,
			@ModelAttribute(value = "classForm") ClassData classData,HttpSession session,ServletRequest request,
			SessionStatus status) {
		String classId = request.getParameter("c");
		try {

				
			model.addAttribute("classForm", classData);
			return WebConstants.VIEWNAME_STUDENT_MARKS_VIEWALL;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_STUDENT_MARKS_VIEWALL;
		}
	}*/
	
	@RequestMapping(value = WebConstants.SEARCH_VIEW_STUDENT_MARKS, method = RequestMethod.POST)
	public String searchAndViewAllStudentMarks(
			ModelMap model,
			@ModelAttribute(value = "marksSearch") StudentMarksSearch studentMarksSearch,HttpSession session,
			SessionStatus status,HttpServletResponse response) {

		try {
			
			List<StudentData> studentsList =  null;//studentMarksService.searchStudentMarks(studentMarksSearch);
			studentMarksSearch.setStudentList(studentsList);
			studentMarksSearch.setSubjectList(getSubjectList(studentsList));
			
			if(studentMarksSearch.isExport()){
				exportStudentMarksToCSV(studentMarksSearch,response);
				return null;
			}
			else{
				model.addAttribute("marksSearch", studentMarksSearch);
				populateStudentSeededData(model, session);
				return WebConstants.VIEWNAME_STUDENT_MARKS_SEARCH;
			}
			
			
			
		} catch (ServiceException e) {
			return WebConstants.VIEWNAME_STUDENT_MARKS_SEARCH;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_STUDENT_MARKS_SEARCH;
		}
	}

	private void exportStudentMarksToCSV(StudentMarksSearch sm,
			HttpServletResponse response) {

			
		BufferedWriter writer = null;
		try 
		{
			writer = new BufferedWriter(new OutputStreamWriter(response.getOutputStream(), "UTF-8"));			
			setResponseHeaderForDataExport(response,sm.getReportName());
			writer.write(sm.toFileHeader());
			for (StudentData st : sm.getStudentList()) 
			{
				writer.write(st.toFileRecord());
				writer.newLine();
			}
			writer.flush();
			writer.close();
		}
		catch (UnsupportedEncodingException e) 
		{
			logger.error("UnsupportedEncodingException : while exporting data to file ",e);
		} catch (IOException e) 
		{
			logger.error("IOException : while exporting data to file ",e);
		}
		finally
		{
			if(null != writer){
				try 
				{
					writer.flush();
					writer.close();
				} catch (IOException e) {}
			}
		}
	
	}

	public  void setResponseHeaderForDataExport(HttpServletResponse response,String fileName)
	{
		response.setHeader("Pragma", "public");
		response.setHeader("Expires", "0");
		response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
		response.setHeader("Content-Type", "text/csv");
		response.setHeader("Content-Disposition","attachment;filename=\""+fileName+".csv\"");
	}
	
	
	private List<SubjectData> getSubjectList(List<StudentData> studentsList) {
		
		List<SubjectData> subjectDataList = null;
		for(StudentData stdData:studentsList){
			if(null==subjectDataList){
				subjectDataList = new ArrayList(stdData.getStudentClassData().getSubjects());
				break;
			}
		}
		Collections.sort(subjectDataList);
		return subjectDataList;
	}

	/*@RequestMapping(value = WebConstants.UPDATE_MARKS)
	public  @ResponseBody List<SubjectMarksData> updateStudentMarks( @ModelAttribute(value = "marksSearch") StudentMarksSearch studentMarksSearch,
			ModelMap model,
			SessionStatus status) {
		List<SubjectMarksData> updatedMarksList = new ArrayList<SubjectMarksData>();
		try {
			
			for(StudentData stdData:studentMarksSearch.getStudentList()){
				
				if(studentMarksSearch.getSeletctedStudent().equals(stdData.getStudentId())){
					stdData.setSelectedExam(studentMarksSearch.getSelectedExam());
					updatedMarksList = studentService.updateStudentMarks(stdData);
					break;
				}
			}
			
			return updatedMarksList;
		} catch (Exception e) {
			return updatedMarksList;
		}
	}*/
	
	private void populateStudentSeededData(ModelMap model, HttpSession session) throws ServiceException {
		List<ReferenceData> classRefList =  referenceDataService.getReferenceData("STUDENTCLASS");
		model.addAttribute("classRefList", classRefList);
		List<ReferenceData> classSectionRefList =  referenceDataService.getReferenceTypeList("CLASSSECTION");
		model.addAttribute("classSectionRefList", classSectionRefList);
		List<ReferenceData> campusRefList =  referenceDataService.getReferenceTypeList("CAMPUS");
		model.addAttribute("campusRefList", campusRefList);
		List<ReferenceData> examRefList =  referenceDataService.getReferenceData("EXAM");
		model.addAttribute("examRefList", examRefList);
		
		
	}
	
	
	@RequestMapping(value = WebConstants.VIEW_ALL_MARKS, method = RequestMethod.GET)
	public String viewMarks(/*@ModelAttribute(value = "classForm") ClassData classData,*/
			ModelMap model, ServletRequest request,
			HttpSession session,
			SessionStatus status) {

		String classId = request.getParameter("c");
		try {
			 ClassData cl = classService.findById(Integer.parseInt(classId));
			model.addAttribute("classForm", cl);
			return WebConstants.VIEWNAME_STUDENT_MARKS_VIEWALL;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_STUDENT_MARKS_VIEWALL;
		}
	}
	
	@RequestMapping(value = "studentClass/getMarks.htm")
	public  @ResponseBody List<MarksData> getMarkss(
			ModelMap model,
			ServletRequest request,
			SessionStatus status) {
		List<MarksData>	markslist = new ArrayList<MarksData>();
		String classId = request.getParameter("c");
		String examId = request.getParameter("x");
		try{
			if(null!=classId&&null!=examId){
				markslist = studentMarksService.getMarks(Integer.parseInt(classId), Integer.parseInt(examId));
				return markslist;
			}
		} catch (ServiceException e) {
		} catch (Exception e) {
		}
		return markslist;
	}
	
	@RequestMapping(value = "students/getMarks.htm")
	public  @ResponseBody List<MarksData> getStudentMarks(
			ModelMap model,
			HttpServletRequest request,
			SessionStatus status) {
		List<MarksData>	markslist = new ArrayList<MarksData>();
		String stid = request.getParameter("st");
		Integer st = (Integer) ((stid !=null)?Integer.parseInt(stid):"");
		try{
			if(isValidStudent(request,st)){
			if(null!=st){
				markslist = studentMarksService.getByStudentId(st);
				return markslist;
			}
			}
		} catch (ServiceException e) {
		} catch (Exception e) {
		}
		return markslist;
	}
	
	@RequestMapping(value = "admin/manageMarks/update.htm")
	public  @ResponseBody AjaxResponse saveOrUpdate( @RequestBody String jsonString,HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		
		AjaxResponse aresponse = new AjaxResponse();
		
		List<MarksData> list = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			list = mapper.readValue(jsonString,  new TypeReference<List<MarksData>>(){});
			System.out.println(list);
			for(MarksData mk:list){
				
				//if(checkSubjectAuthority(user,subjectid)){
				if(false){
					
				}
				else{
					
					mk.setInsertedby(userName);
					mk.setLastmodifiedby(userName);
					studentMarksService.save(mk);
					
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

	@RequestMapping(value = "admin/manageMarks/view.htm",method = RequestMethod.GET)
	public String viewStudentMarks(
			ModelMap model,ServletRequest request,
			@ModelAttribute(value = "studentForm") StudentData studentData,HttpSession session,
			SessionStatus status) {
		String classId = request.getParameter("c");
		String examId = request.getParameter("x");
		List<SubjectData>	subjectslist = new ArrayList<SubjectData>();
		try {
			List<StudentData> students = studentService.getStudentsWithMarks(Integer.parseInt(classId), Integer.parseInt(examId));
			subjectslist = subjectService.loadAllSubjects(Integer.parseInt(classId));
			model.addAttribute("students", students);
			model.addAttribute("subjects", subjectslist);
			return WebConstants.VIEWNAME_STUDENT_MARKS_VIEW;
		} catch (Exception e) {
			return WebConstants.VIEWNAME_STUDENT_MARKS_VIEW;
		}
	}
	
	public boolean isValidStudent(HttpServletRequest request, Integer stuId) {
		boolean valid = false;
		HttpSession session = request.getSession();
		String idString = (String) session.getAttribute("childlist");
		String[] ids = idString.split(",");
		List<Integer> idlist = new ArrayList<Integer>();
		for (String id : ids) {
			idlist.add(Integer.parseInt(id));
		}
		if (idlist.contains(stuId)) {
			valid = true;
		} else {
			valid = false;
		}
		return valid;
	}
	
}