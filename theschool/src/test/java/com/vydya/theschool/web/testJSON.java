package com.vydya.theschool.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.io.Writer;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import com.vydya.theschool.common.dto.EventAjaxData;
import com.vydya.theschool.common.dto.EventData;

//File Name SendEmail.java

/*import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;*/

public class testJSON
{
	 public static void main(String[] args)
	   {
		 
		// callUrl();
		 //createJSON2();
		 
		         System.out.println ("If you need to 'quote' in Java");
		         System.out.println ("you can use single \' or double \" quote");
		 
	   }
 
	 private static void createJSON(){
		 EventAjaxData a = new EventAjaxData();
			a.setId(123);
			a.setDescription("testDesc");
			a.setDate("12341324");
			a.setName("testName");
			a.setTitle("testTitle");
			a.setType("testType");
			a.setUrl("testUrl");
	       
	      ObjectMapper mapper = new ObjectMapper();
	      try
	      {
	         mapper.writeValue(new File("c://Temp/data.json"), a);
	      } catch (JsonGenerationException e)
	      {
	         e.printStackTrace();
	      } catch (JsonMappingException e)
	      {
	         e.printStackTrace();
	      } catch (IOException e)
	      {
	         e.printStackTrace();
	      }
	 }
	 private static void callUrl(){
		 URL url;
		try {
			url = new URL("http://localhost:8280/theschool/school/getevents.htm?year=2014&month=9&day=");
		
	        BufferedReader in = new BufferedReader(
	        new InputStreamReader(url.openStream()));

	        String inputLine;
	        while ((inputLine = in.readLine()) != null)
	            System.out.println(inputLine);
	        in.close();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 }
  
	 
	 private static void createJSON2(){
		
		 String userDataJSON;  
			Map<String,List<EventData>> map = new HashMap<String,List<EventData>>();
		      ObjectMapper mapper = new ObjectMapper();
		      
		for(int i=1;i<5;i++){
			
			List<EventData> list = new ArrayList<EventData>();
			for(int j=1;j<10;j++){
				
				 EventData ev = new EventData();
					ev.setId(123);
					ev.setEventDesc("Month"+i+"_testDesc_"+j);
					ev.setDate("Month"+i+"_date_"+j);
					ev.setName("Month"+i+"_desc_"+j);
					ev.setTitle("Month"+i+"_title_"+j);
					ev.setEventType("Month"+i+"_eventType_"+j);
					ev.setUrl("Month"+i+"_url_"+j); 
					list.add(ev);
			}	
				map.put("Month_"+i, list);
			
		}	
			
	    
	      try
	      {
	        // mapper.writeValue(new File("c://Temp/data.json"), a);
	         Writer strWriter = new StringWriter();
	    	  mapper.writeValue(strWriter, map);
	    	   userDataJSON = strWriter.toString();
	    	   System.out.println("JSON: "+userDataJSON);
	         
	      } catch (JsonGenerationException e)
	      {
	         e.printStackTrace();
	      } catch (JsonMappingException e)
	      {
	         e.printStackTrace();
	      } catch (IOException e)
	      {
	         e.printStackTrace();
	      }
	 }
}
