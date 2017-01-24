
package com.vydya.theschool.web.admin.controllers;

import java.util.List;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.constants.TSConstants;
import com.vydya.theschool.common.dto.AjaxResponse;
import com.vydya.theschool.common.dto.GalleryData;
import com.vydya.theschool.common.dto.GalleryImageData;
import com.vydya.theschool.common.dto.GalleryVideoData;
import com.vydya.theschool.common.dto.Group;
import com.vydya.theschool.common.exceptions.ApplicationException;
import com.vydya.theschool.common.exceptions.FileException;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.util.FileUtil;
import com.vydya.theschool.common.util.ImageUtil;
import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.services.api.common.ReferenceDataService;
import com.vydya.theschool.services.api.permisions.ManageGroupService;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.localstatic.StaticData;
import com.vydya.theschool.web.localstatic.StaticSession;
import com.vydya.theschool.web.utils.UniqueIdGenerator;
import com.vydya.theschool.web.validator.GroupValidator;

@Controller
public class AdminGroupController {
	private static Logger log = Logger.getLogger(AdminGroupController.class
			.getName());

	GroupValidator groupValidator;

	@Autowired
	public AdminGroupController(GroupValidator groupValidator) {
		this.groupValidator = groupValidator;
	}

	
	public AdminGroupController() {
		super();
		// TODO Auto-generated constructor stub
	}


	@Autowired
	protected ManageGroupService manageGroupService;

	

	@Autowired
	protected ReferenceDataService referenceDataService;

	
	
	@RequestMapping(value = WebConstants.VIEW_GROUPS_ACTION)
	public String viewAll(ModelMap model,SessionStatus status) {

		try {
			return WebConstants.VIEW_NAME_VIEW_GROUPS;

		} catch (Exception e) {
			return WebConstants.VIEW_NAME_VIEW_GROUPS;
		}
	}
	
	@RequestMapping(value = "admin/manageGroups/view.htm")
	public @ResponseBody
	String ajaxGet(@RequestBody String jsonString, HttpSession session,
			ModelMap model, ServletRequest request, SessionStatus status) {

		String response = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			JSONObject jsonOb = new JSONObject(jsonString);
			List<Group> groupsList = manageGroupService.loadAllGroups();
				response = mapper.writeValueAsString(groupsList);


			return response;
		} catch (ServiceException e) {
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return response;
		}
	}
	
	
	@RequestMapping(value = "admin/manageGroups/add.htm", method = RequestMethod.POST)
	public @ResponseBody AjaxResponse add(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {                 

		StaticSession ss = (StaticSession)session.getAttribute("staticSession");
		//String unid=null;
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse aresponse = new AjaxResponse();
	  try {
		  JSONObject jsonOb = new JSONObject(jsonString);
		 // JSONObject blobI=jsonOb.getJSONObject("imageBlob");
		  //jsonOb.remove("imageBlob");//imageBlob
				
				Group gdta = new Group();
				gdta.setGroupName((String) jsonOb.get("groupName"));
				gdta.setGroupDesc((String) jsonOb.get("groupDesc"));
				gdta.setGroupStatus((Integer) jsonOb.get("groupStatus"));
				manageGroupService.createGroup(userName, gdta);
				
				aresponse.setSuccess(true);
				if(aresponse.isSuccess()){
					aresponse.setRespData(gdta);
					aresponse.setMessage("Successfully Saved Gallery.");
				}//
	 } catch (ServiceException se) {
		 
		 aresponse.setSuccess(false);
			if(aresponse.isSuccess()){
				aresponse.setMessage(se.getErrorMessage());
			}//
	     se.printStackTrace();
	 }
	  catch (Exception e) {
			 
		     e.printStackTrace();
		 }
	  return aresponse;
}

	
	@RequestMapping(value = "admin/manageGroups/edit.htm", method = RequestMethod.POST)
	public @ResponseBody AjaxResponse edit(@RequestBody String jsonString, HttpServletResponse response,HttpSession session) {                 

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse aresponse = new AjaxResponse();
	  try {
		  JSONObject jsonOb = new JSONObject(jsonString);
				Group gdta = new Group();
				gdta.setGroupId((Integer) jsonOb.get("groupId"));
				gdta.setGroupName((String) jsonOb.get("groupName"));
				gdta.setGroupDesc((String) jsonOb.get("groupDesc"));
				gdta.setGroupStatus((Integer) jsonOb.get("groupStatus"));
				manageGroupService.updateGroup(userName, gdta);
				
				aresponse.setSuccess(true);
				if(aresponse.isSuccess()){
					aresponse.setRespData(gdta);
					aresponse.setMessage("Successfully Saved Gallery.");
				}
	 } catch (Exception e) {
	     e.printStackTrace();
	 }
	  return aresponse;
}


	/**
	 * Add scenario This method binds the command object to the model This
	 * method is used to invoke validator with the provided details if no errors
	 * occurs invokes the service method after execution returns next tiles view
	 * to display,if errors occurs returns to the same view
	 * 
	 * @param
	 * @return
	 */
	/*@RequestMapping(value = WebConstants.ADD_GROUP_ACTION)
	public String addGroupProcess(ModelMap model,
			@ModelAttribute(value = "group") Group group, BindingResult result,
			SessionStatus status, HttpSession session) {
		log.debug("addGroupProcess is invoked");
		ApplicationContext ctx = WebApplicationContextUtils
				.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale) session
				.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = "";
		if (null != session.getAttribute(WebConstants.SESSION_USER_NAME))
			userName = (String) session
					.getAttribute(WebConstants.SESSION_USER_NAME);
		if ((null != group) && (null != group.getActionName())
				&& (group.getActionName().equals("AddView"))) {
			try {
				Group groupmodel = new Group();
				model.addAttribute("group", groupmodel);
				populateDefaultFields(model);
			} catch (ServiceException e) {
				String msg = ctx.getMessage(e.getErrorCode(), new Object[] {},
						locale);
				result.rejectValue("error", "",
						msg.concat(String.valueOf(e.getUniqueId())));
			}
			return WebConstants.VIEW_NAME_ADD_GROUP;
		} else {
			log.debug("addGroupProcess Save mode");
			groupValidator.validate(group, result);
			log.debug("In else2 addGroupProcess");
			if (result.hasErrors()) {
				return WebConstants.VIEW_NAME_ADD_GROUP;
			}
			try {				
				group = getMerchantIdCheck(group.getMerchantIdChecked(), group);
				manageGroupService.createGroup(userName, group);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_3014);
				log.debug("Before Exception");
			} catch (ServiceException e) {
				String msg = ctx.getMessage(e.getErrorCode(), new Object[] {},
						locale);

				if (ErrorConstants.TS_3003.equals(e.getErrorCode()))
					result.rejectValue("error", "",
							msg.concat(String.valueOf(e.getUniqueId())));
				else
					result.rejectValue("error", "",
							msg.concat(String.valueOf(e.getUniqueId())));
				return WebConstants.VIEW_NAME_ADD_GROUP;

			} catch (Exception e) {
				String msg = ctx.getMessage(ErrorConstants.TS_3010,
						new Object[] {}, locale);
				ApplicationException exp = new ApplicationException(
						e.getMessage(), e);
				log.error(exp, e);
				result.rejectValue("error", "",
						msg.concat(String.valueOf(exp.getUniqueId())));
				return WebConstants.VIEW_NAME_ADD_GROUP;
			}
			return WebConstants.REDIRECT_VIEW_GROUPS;
		}
	}
*/
	/**
	 * Edit scenario This method gets the selected groupId from the model This
	 * method is used to invoke validator with the provided details if no errors
	 * occurs invokes the service method after execution returns next tiles view
	 * to display,if errors occurs returns to the same view
	 * 
	 * @param
	 * @return
	 *//*
	@RequestMapping(value = WebConstants.EDIT_GROUP_ACTION)
	public String initEditGroup(@ModelAttribute(value = "group") Group group,
			BindingResult result, ModelMap model, HttpSession session) {
		ApplicationContext ctx = WebApplicationContextUtils
				.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale) session
				.getAttribute(WebConstants.SESSION_USER_LOCALE);
		try {
			String userName = "";
			if (null != session.getAttribute(WebConstants.SESSION_USER_NAME))
				userName = (String) session
						.getAttribute(WebConstants.SESSION_USER_NAME);
			if ((null != group) && (null != group.getActionName())
					&& (group.getActionName().equals("EditView"))) {
				log.debug("Edit Group initialised");
				log.debug("Selected GroupId $$$$$$$$  "
						+ group.getSelectedGroupId());
				try {
					if (null != group.getSelectedGroupId())
						group = manageGroupService.getGroupData(group
								.getSelectedGroupId());
					log.debug("$$$$$$$$In if $$$$$$$$$$$$ "
							+ group.getGroupName());
					group.setActionName("EditView");
					populateDefaultFields(model);
					model.addAttribute("group", group);
					return WebConstants.VIEW_NAME_EDIT_GROUP;
				} catch (ServiceException e) {
					String msg = ctx.getMessage(e.getErrorCode(),
							new Object[] {}, locale);
					result.rejectValue("error", "",
							msg.concat(String.valueOf(e.getUniqueId())));

					return WebConstants.VIEW_NAME_EDIT_GROUP;
				} catch (Exception e) {
					String msg = ctx.getMessage(ErrorConstants.TS_3010,
							new Object[] {}, locale);
					ApplicationException exp = new ApplicationException(
							e.getMessage(), e);
					log.error(exp, e);
					result.rejectValue("error", "",
							msg.concat(String.valueOf(exp.getUniqueId())));
					return WebConstants.VIEW_NAME_EDIT_GROUP;
				}
			} else {
				log.debug("Edit Group Save Mode");
				groupValidator.validate(group, result);
				if (result.hasErrors()) {
					group.setActionName("EditView");
					return WebConstants.VIEW_NAME_EDIT_GROUP;
				}

				log.debug("Edit Group getSectionId B4 update "
						+ group.getGroupId());
				if (Integer.valueOf(TSConstants.STATUS_INACTIVE_CODE)
						.equals(group.getGroupStatus()))
					group.setGroupStatus(Integer
							.valueOf(TSConstants.STATUS_INACTIVE_CODE));
				else
					group.setGroupStatus(Integer
							.valueOf(TSConstants.STATUS_ACTIVE_CODE));
				group.setActionName("EditView");				
				group = getMerchantIdCheck(group.getMerchantIdChecked(), group);
				manageGroupService.updateGroup(userName, group);
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_3015);

				return WebConstants.REDIRECT_VIEW_GROUPS;
			}
		} catch (ServiceException e) {
			String msg = ctx.getMessage(e.getErrorCode(), new Object[] {},
					locale);

			if (ErrorConstants.TS_3003.equals(e.getErrorCode()))
				result.rejectValue("error", "",
						msg.concat(String.valueOf(e.getUniqueId())));
			else
				result.rejectValue("error", "",
						msg.concat(String.valueOf(e.getUniqueId())));

			return WebConstants.VIEW_NAME_EDIT_GROUP;
		} catch (Exception e) {
			String msg = ctx.getMessage(ErrorConstants.TS_3010,
					new Object[] {}, locale);
			ApplicationException exp = new ApplicationException(e.getMessage(),
					e);
			log.error(exp, e);
			result.rejectValue("error", "",
					msg.concat(String.valueOf(exp.getUniqueId())));
			return WebConstants.VIEW_NAME_EDIT_GROUP;
		}

	}
*/
	
	
	@RequestMapping(value = WebConstants.DELETE_GROUP_ACTION , method = RequestMethod.POST)
	public  @ResponseBody AjaxResponse deleteGallery(@RequestBody String jsonString,
			ModelMap model,HttpServletRequest request,HttpSession session,
			SessionStatus status) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale)session.getAttribute(WebConstants.SESSION_USER_LOCALE);
		String userName = (String) session.getAttribute(WebConstants.SESSION_USER_NAME);
		AjaxResponse ajaxRes = new AjaxResponse();
			try {
				JSONObject jsonOb = new JSONObject(jsonString);
				Group gdta = new Group();
				gdta.setGroupId((Integer) jsonOb.get("groupId"));
				gdta.setSelectedGroupId(jsonOb.get("groupId").toString());
				boolean isGroupAssigned = manageGroupService.isUserGroupAssigned(gdta.getSelectedGroupId());
						//.isUserGroupAssigned(gdta.getSelectedGroupId());

				if (isGroupAssigned) {


				} else {
					
					manageGroupService.deleteGroup(userName,
							gdta.getSelectedGroupId());
						ajaxRes.setSuccess(true);
						ajaxRes.setMessage("Group Deleted.");
					}
				
				
				
		} 
		catch (Exception e) {
			
			ajaxRes.setSuccess(false);
			ajaxRes.setException(e.getMessage());
			ajaxRes.setErrormsg("Unable to delete Group");
		}
			return ajaxRes;
	}
	/**
	 * Delete scenario This method gets the selected groupId from the model and
	 * checks if userGroup is assigned to any users This method is used to
	 * invoke validator with the provided details if no errors occurs invokes
	 * the service method after execution returns next tiles view to display,if
	 * errors occurs returns to the same view
	 * 
	 * @param
	 * @return
	 */
	/*@RequestMapping(value = WebConstants.DELETE_GROUP_ACTION)
	public String deleteSubmit(
			@ModelAttribute(value = "GroupForm") Group group,
			BindingResult result, ModelMap model, SessionStatus status,
			HttpSession session) {
		log.debug("Deleting Group id " + group.getSelectedGroupId());
		ApplicationContext ctx = WebApplicationContextUtils
				.getWebApplicationContext(session.getServletContext());
		Locale locale = (Locale) session
				.getAttribute(WebConstants.SESSION_USER_LOCALE);
		try {

			boolean isGroupAssigned = manageGroupService
					.isUserGroupAssigned(group.getSelectedGroupId());

			if (isGroupAssigned) {
				session.setAttribute(WebConstants.SESSION_ALERT_MESSAGE,
						ErrorConstants.TS_3017);
			} else {
				String userName = (String) session
						.getAttribute(WebConstants.SESSION_USER_NAME);
				log.debug("  isGroupAssigned" + isGroupAssigned);
				manageGroupService.deleteGroup(userName,
						group.getSelectedGroupId());
				session.setAttribute(WebConstants.SESSION_SUCCESS_MESSAGE,
						ErrorConstants.TS_3016);
			}

			return WebConstants.REDIRECT_VIEW_GROUPS;
		} catch (ServiceException e) {
			String msg = ctx.getMessage(e.getErrorCode(), new Object[] {},
					locale);
			result.rejectValue("error", "",
					msg.concat(String.valueOf(e.getUniqueId())));
			return WebConstants.REDIRECT_VIEW_GROUPS;
		} catch (Exception e) {
			log.error(
					new ApplicationException(ErrorConstants.TS_3010, e
							.getMessage()).toString(), e);
			result.rejectValue("error", ErrorConstants.TS_3010);
			return WebConstants.REDIRECT_VIEW_GROUPS;
		}
	}

	private void populateDefaultFields(ModelMap model) throws ServiceException {
		List<ReferenceData> merchantRefList = referenceDataService
				.getReferenceData(TSConstants.MERCHANT);
		model.addAttribute("merchantRefList", merchantRefList);

		List<ReferenceData> payeeRefList = referenceDataService
				.getReferenceData(TSConstants.PAYEE);
		model.addAttribute("payeeRefList", payeeRefList);
	}

	private Group getMerchantIdCheck(String merchantIdChecked, Group group) {

		if (merchantIdChecked != null) {
			group.setMerchantIdChecked("1");
		} else {
			group.setMerchantIdChecked("0");
			group.setMerchantId(null);
			group.setPayeeId(null);
		}
		return group;
	}*/

}