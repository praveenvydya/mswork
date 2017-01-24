package com.vydya.theschool.web.tstags.html;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;

import org.apache.log4j.Logger;

import com.vydya.theschool.common.dto.Section;
import com.vydya.theschool.web.constants.WebConstants;
import com.vydya.theschool.web.security.RequestData;
import com.vydya.theschool.web.utils.WebUtils;

public class ButtonTag extends BaseTag 
{
	private static Logger logger = Logger.getLogger(ButtonTag.class);
	
	
	public void doTag()throws JspException, IOException
	{
		StringBuilder buttonTag = new StringBuilder(INPUT_START_TAG);
		if(validateAction != null && validateAction)
		{
			try{
				if(action != null){
					RequestData request = WebUtils.parseReportAction(action);@SuppressWarnings("unchecked")
					List<Section> permissionList = (List<Section>)getJspContext().getAttribute(WebConstants.SESSION_USER_ROLE_PERMISSIONS,PageContext.SESSION_SCOPE);
					
					boolean hasPermission = WebUtils.hasPermissionOnReport(request,permissionList);					
					if(!hasPermission)
					{
						getJspContext().getOut().println(hideButtonTag);
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
		writeOptionalAttribute(TYPE_ATTRIBUTE, type, buttonTag);
		writeOptionalAttribute(NAME_ATTRIBUTE, name, buttonTag);
		writeOptionalAttribute(ID_ATTRIBUTE, id, buttonTag);
		writeOptionalAttribute(VALUE_ATTRIBUTE, value, buttonTag);
		writeOptionalAttribute(DISABLED_ATTRIBUTE, disabled, buttonTag);
		writeOptionalAttribute(TITLE_ATTRIBUTE, title, buttonTag);
		writeOptionalAttribute(ALT_ATTRIBUTE, alt, buttonTag);
		writeOptionalAttribute(STYLE_ATTRIBUTE, style, buttonTag);
		writeOptionalAttribute(CLASS_ATTRIBUTE, cssClass, buttonTag);
		writeOptionalAttribute(ONCLICK_ATTRIBUTE, onClick, buttonTag);
		writeOptionalAttribute(ONMOUSEDOWN_ATTRIBUTE, onMouseDown, buttonTag);
		writeOptionalAttribute(ONMOUSEUP_ATTRIBUTE, onMouseUp, buttonTag);
		writeOptionalAttribute(ONMOUSEMOVE_ATTRIBUTE, onMouseMove, buttonTag);		
		writeOptionalAttribute(ONMOUSEOUT_ATTRIBUTE, onMouseOut, buttonTag);
		writeOptionalAttribute(ONMOUSEOVER_ATTRIBUTE, onMouseOver, buttonTag);			
		
		buttonTag.append(INPUT_END_TAG);
		getJspContext().getOut().println(buttonTag);
	}
	
	
}
