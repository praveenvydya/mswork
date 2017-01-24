package com.vydya.theschool.web.tstags.html;

import java.io.IOException;
import java.io.StringWriter;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import org.apache.log4j.Logger;

import com.vydya.theschool.common.dto.Section;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.security.RequestData;
import com.vydya.theschool.web.utils.WebUtils;

public class HtmlTag extends BaseTag 
{
	private static Logger logger = Logger.getLogger(HtmlTag.class);
	
	
	public void doTag()throws JspException, IOException
	{
		//StringBuilder htmlTag = new StringBuilder(INPUT_START_TAG);
		if(validateAction != null && validateAction)
		{
			try{
				if(action != null){
					RequestData request = WebUtils.parseReportAction(action);@SuppressWarnings("unchecked")
					List<Section> permissionList = (List<Section>)getJspContext().getAttribute(WebConstants.SESSION_USER_ROLE_PERMISSIONS,PageContext.SESSION_SCOPE);
					 
					 	final JspWriter jspWriter = getJspContext().getOut();
				        final StringWriter sw = new StringWriter();
				        final StringBuffer bodyContent = new StringBuffer();
				        
				        
					boolean hasPermission = WebUtils.hasPermissionOnReport(request,permissionList);					
					if(hasPermission)
					{
						
						 getJspBody().invoke(sw);
					       
					        bodyContent.append("<div class='custom-html'>");
					        bodyContent.append(sw.getBuffer());
					        bodyContent.append("</div>");

					        jspWriter.write(bodyContent.toString());
					        
						//getJspContext().getOut().println(hideButtonTag);
						return ;
					}
				
				}
				else
				{
					getJspContext().getOut().println(hideButtonTag);
					return ;
				}
			}
			catch (Exception e) {
				logger.error("Exception in ButtonTag class while validation user permissions",e);
			}
		}
		/*writeOptionalAttribute(TYPE_ATTRIBUTE, type, htmlTag);
		writeOptionalAttribute(NAME_ATTRIBUTE, name, htmlTag);
		writeOptionalAttribute(ID_ATTRIBUTE, id, htmlTag);
		writeOptionalAttribute(VALUE_ATTRIBUTE, value, htmlTag);
		writeOptionalAttribute(DISABLED_ATTRIBUTE, disabled, htmlTag);
		writeOptionalAttribute(TITLE_ATTRIBUTE, title, htmlTag);
		writeOptionalAttribute(ALT_ATTRIBUTE, alt, htmlTag);
		writeOptionalAttribute(STYLE_ATTRIBUTE, style, htmlTag);
		writeOptionalAttribute(CLASS_ATTRIBUTE, cssClass, htmlTag);
		writeOptionalAttribute(ONCLICK_ATTRIBUTE, onClick, htmlTag);
		writeOptionalAttribute(ONMOUSEDOWN_ATTRIBUTE, onMouseDown, htmlTag);
		writeOptionalAttribute(ONMOUSEUP_ATTRIBUTE, onMouseUp, htmlTag);
		writeOptionalAttribute(ONMOUSEMOVE_ATTRIBUTE, onMouseMove, htmlTag);		
		writeOptionalAttribute(ONMOUSEOUT_ATTRIBUTE, onMouseOut, htmlTag);
		writeOptionalAttribute(ONMOUSEOVER_ATTRIBUTE, onMouseOver, htmlTag);		*/	
		
		//htmlTag.append(INPUT_END_TAG);
		//getJspContext().getOut().println(htmlTag);
	}
	
	
}
