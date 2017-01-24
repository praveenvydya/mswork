/*package com.vydya.theschool.web.security;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
 
@Component("systemProperties")
@Scope("singleton")
public class SystemProperties {
 
    private static String applicationName;
    private static String staticApplicationName;
 
    @Autowired
    public SystemProperties(@Value("${application.name}") String applicationName, @Value("${static.application.name}") String staticApplicationName) {
        SystemProperties.applicationName = applicationName;
        SystemProperties.staticApplicationName = staticApplicationName;
 
    }
 

    public String getApplicationName(){
    	return applicationName;
    }
    
    public String getStaticApplicationName(){
    	return staticApplicationName;
    }
 
}
*/