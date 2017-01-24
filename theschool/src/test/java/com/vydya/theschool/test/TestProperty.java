package com.vydya.theschool.test;


import java.io.IOException;
import java.util.Properties;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;

import com.vydya.theschool.common.dto.GalleryData;
import com.vydya.theschool.common.exceptions.FileException;




public class TestProperty 
{
	
	public static void main(String [] args) throws FileException, IOException, JSONException
	   {    
		
		//testone();
		test2();
	   }

	private static void test2() throws JSONException {

		String json = "{\"name\":\"fasd f\",\"title\":\"f asdfafasd fasd\",\"eventDesc\":\"fasd fsadfadsfasdfasdf\",\"image\":\"iVBO\"}"; 
		
		JSONObject jsonsOb = new JSONObject(json);
		jsonsOb.remove("title");
		//JSONObject childobject=jsonsOb.getJSONObject("name");
		System.out.println("val "+jsonsOb.toString());
		GalleryData reqData = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			reqData = mapper.readValue(json,  new TypeReference<GalleryData>(){});
			System.out.println(reqData.getName());


		} catch (Exception e) {
			//return WebConstants.VIEW_NAME_VIEW_EVENTS;
			//return attList;
			//return aresponse;
			System.out.println(e.getLocalizedMessage());
		}
				
	}

	private static void testone() throws IOException {
		 Resource resource = new ClassPathResource("properties/System.properties");
		 Properties props = PropertiesLoaderUtils.loadProperties(resource);
		 
			String s  =  props.getProperty("application.name");
			
		 System.out.println(s);
	}
	
	
}

