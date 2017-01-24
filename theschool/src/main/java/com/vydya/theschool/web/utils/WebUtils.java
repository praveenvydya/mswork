package com.vydya.theschool.web.utils;
import java.util.List;

import com.vydya.theschool.common.dto.Action;
import com.vydya.theschool.common.dto.Report;
import com.vydya.theschool.common.dto.Section;
import com.vydya.theschool.web.security.RequestData;

public final class WebUtils {

	 /** this method extracts Report/action details form request URI*/
	public static RequestData parseRequestURI(String requestURI)
	 {
		 RequestData request = null;
		 String arr[] = requestURI.split("/");	
		 if(arr.length == 5)
		 {
			 request = new RequestData();
		 	 int j = arr[4].lastIndexOf(".");
			 request.setActionName(arr[4].substring(0,j));	
			 request.setReportName(arr[3]);
			 if(arr[2].equalsIgnoreCase("admin")){
				 request.setAdmin(true);
			 }
			 else{
				 request.setAdmin(false);
			 }
		 }
		 else if(arr.length == 4)
		 {
			 request = new RequestData();
		 	 int j = arr[3].lastIndexOf(".");
			 request.setActionName(arr[3].substring(0,j));	
			 request.setReportName(arr[2]);
			 if(arr[1].equalsIgnoreCase("admin")){
				 request.setAdmin(true);
			 }
			 else{
				 request.setAdmin(false);
			 }
		 }
		return request;
	 }
	 
	public static RequestData parseUserRequestURI(String requestURI)
	 {
		 RequestData request = null;
		 String arr[] = requestURI.split("/");	
		 if(arr.length == 5)
		 {
			 request = new RequestData();
		 	 int j = arr[4].lastIndexOf(".");
			 request.setActionName(arr[4].substring(0,j));	
			 request.setReportName(arr[3]);
			 if(arr[2].equalsIgnoreCase("user")){
				 request.setAdmin(true);
			 }
			 else{
				 request.setAdmin(false);
			 }
		 }
		 else if(arr.length == 4)
		 {
			 request = new RequestData();
		 	 int j = arr[3].lastIndexOf(".");
			 request.setActionName(arr[3].substring(0,j));	
			 request.setReportName(arr[2]);
			 if(arr[2].equalsIgnoreCase("user")){
				 request.setAdmin(true);
			 }
			 else{
				 request.setAdmin(false);
			 }
		 }
		return request;
	 }
	 
	 /** this method extracts Report/action details form request action TAG*/
	 public static RequestData parseReportAction(String action)
	 {
		 RequestData request = null;
		 String arr[] = action.split("/");	
		 if(arr.length == 3)
		 {
			 request = new RequestData();
		 	 int j = arr[2].lastIndexOf(".");
			 request.setActionName(arr[2].substring(0,j));	
			 request.setReportName(arr[1]);
			 if(arr[0].equalsIgnoreCase("admin")){
				 request.setAdmin(true);
			 }
			 else{
				 request.setAdmin(false);
			 }
		 }
		return request;
	 }
	 
	 public static boolean hasPermissionOnReport(RequestData request,List<Section> permissionList)
	 {
		 boolean hasPermission = false; 
		 String actionName = request.getActionName();
		 String reportName = request.getReportName();
		 start: for (Section section : permissionList) 
		 {
			Report[] reports = section.getReports();
			for (int reportIndex = 0; reportIndex < reports.length; reportIndex++) 
			{
				Report report = reports[reportIndex];
				if(report.getReportName().equals(reportName))
				{
					Action [] actions = report.getActions();
					for (int actionIndex = 0; actionIndex < actions.length; actionIndex++) 
					{
						Action action = actions[actionIndex];
						if(action.getActionName().equals(actionName))
						{
							hasPermission = true;
							break start;
						}
					}
				}
				
			}
		 }
		 return hasPermission;
	 }
	 public static boolean isValidSearchField(String value){
			
			return (value != null && value.trim().length() != 0 );
		}
	 
	 public static boolean isValidSearchFieldSelection(Integer value){
			
			return (value != null && 0 != value);
		}
	 
	/* public static Map<String, String> crateKeyDescRefMap(
				List<ReferenceData> refDataList) {

			Map<String, String> refDataMap = new HashMap<String, String>();

			for (ReferenceData refData : refDataList) {

				refDataMap.put(refData.getId(), refData.getDescription());
			}
			return refDataMap;
		}*/
}
