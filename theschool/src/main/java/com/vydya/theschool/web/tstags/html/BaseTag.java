package com.vydya.theschool.web.tstags.html;

import javax.servlet.jsp.tagext.SimpleTagSupport;

public class BaseTag extends SimpleTagSupport
{
	protected Boolean validateAction;
	protected String action;
	protected String type;
	protected String href;
	protected String name;
	protected String id;
	protected String value;
	protected String disabled;
	protected String title;
	protected String alt;
	protected String style;
	protected String cssClass;
	protected String onClick;
	protected String onMouseDown;
	protected String onMouseUp;
	protected String onMouseMove;
	protected String onMouseOut;
	protected String onMouseOver;
		
	
	public void setValidateAction(Boolean validateAction)
	{
		this.validateAction = validateAction;
	}

	public void setAction(String action)
	{
		this.action = action;
	}

	public void setType(String type)
	{
		this.type = type;
	}

	public void setHref(String href)
	{
		this.href = href;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}

	public void setId(String id) 
	{
		this.id = id;
	}

	public void setValue(String value) 
	{
		this.value = value;
	}

	public void setDisabled(String disabled)
	{
		this.disabled = disabled;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public void setAlt(String alt)
	{
		this.alt = alt;
	}

	public void setStyle(String style)
	{
		this.style = style;
	}

	public void setCssClass(String cssClass)
	{
		this.cssClass = cssClass;
	}

	public void setOnClick(String onClick)
	{
		this.onClick = onClick;
	}

	public void setOnMouseDown(String onMouseDown)
	{
		this.onMouseDown = onMouseDown;
	}

	public void setOnMouseUp(String onMouseUp)
	{
		this.onMouseUp = onMouseUp;
	}

	public void setOnMouseMove(String onMouseMove)
	{
		this.onMouseMove = onMouseMove;
	}

	public void setOnMouseOut(String onMouseOut)
	{
		this.onMouseOut = onMouseOut;
	}

	public void setOnMouseOver(String onMouseOver)
	{
		this.onMouseOver = onMouseOver;
	}

	protected static final String hideButtonTag = "";
	protected static final String SPACE = " ";
	protected static final String EQUALS = "=";
	protected static final String QUOTE = "\"";
	protected static final String INPUT_START_TAG = "<input";
	protected static final String INPUT_END_TAG = "/>";
	protected static final String ANCHOR_START_TAG = "<a";
	protected static final String ANCHOR_CLOSE= "</a>";
	protected static final String ANCHOR_END_TAG = ">";
	protected static final String TYPE_ATTRIBUTE = "type";
	protected static final String HREF_ATTRIBUTE = "href";
	protected static final String NAME_ATTRIBUTE = "name";
	protected static final String ID_ATTRIBUTE = "id";
	protected static final String VALUE_ATTRIBUTE = "value";
	protected static final String DISABLED_ATTRIBUTE = "disabled";
	protected static final String TITLE_ATTRIBUTE = "title";
	protected static final String ALT_ATTRIBUTE = "alt";
	protected static final String STYLE_ATTRIBUTE = "style";
	protected static final String CLASS_ATTRIBUTE = "class";
	protected static final String ONCLICK_ATTRIBUTE = "onClick";
	protected static final String ONMOUSEDOWN_ATTRIBUTE = "onMouseDown";
	protected static final String ONMOUSEUP_ATTRIBUTE = "onMouseUp";
	protected static final String ONMOUSEMOVE_ATTRIBUTE = "onMouseMove";
	protected static final String ONMOUSEOUT_ATTRIBUTE = "onMouseOut";
	protected static final String ONMOUSEOVER_ATTRIBUTE = "onMouseOver";
	
	protected void writeOptionalAttribute(String name,String value,StringBuilder buttonTag)
	{
		if(value != null)
		{
			buttonTag.append(SPACE);
			buttonTag.append(name);
			buttonTag.append(EQUALS);
			buttonTag.append(QUOTE);
			buttonTag.append(value);
			buttonTag.append(QUOTE);
		}
	}
}
