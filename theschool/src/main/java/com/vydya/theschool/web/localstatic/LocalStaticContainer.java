package com.vydya.theschool.web.localstatic;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.vydya.theschool.services.spring.common.SchoolAdminProperties;


public class LocalStaticContainer {

	
protected StaticSession staticSession;
protected String containserPath;
protected StaticData staticData;

@Autowired(required=true)
public SchoolAdminProperties properties;

	/**
	 * @param session
	 */
	public void loadStaticSession(HttpSession session) {
		
		StaticSession ss = new StaticSession();
		ss.setSessionPath(properties.getLocalPathForDBdata()+"/localSession/"+session.getId());
		ss.setSession(session);
		this.staticSession=ss;
		session.setAttribute("staticSession", ss);
	}

	public String getContainserPath() {
		return containserPath=properties.getLocalPathForDBdata();
	}

	

	public StaticSession getStaticSession() {
		return staticSession;
	}

public void loadStaticData(ServletContext context) {
		
		StaticData sd = new StaticData();
		sd.setStaticPath(properties.getLocalPathForDBdata()+"/staticData");
		this.staticData=sd;
		context.setAttribute("staticData", sd);
	}

public StaticData getStaticData() {
	return staticData;
}


	
}
