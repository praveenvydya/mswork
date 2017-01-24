package com.vydya.theschool.web.validator;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.util.StringUtils;

public final class ValidatorUtil 
{

	protected static final Pattern alphaNumericPatternWithSpace = Pattern.compile("^[a-zA-Z0-9\\s]+$");
	protected static final Pattern userNamePattern = Pattern.compile("^[a-zA-Z0-9][a-zA-Z0-9_.]*[a-zA-Z0-9]+$");
	protected static final Pattern numberPattern = Pattern.compile("^[0-9]+$");
	protected static final String EMAIL_PATTERN = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	protected static final Pattern emailPattern = Pattern.compile(EMAIL_PATTERN);
	
	
	public static boolean rejectIfEmptyOrWhitespace(String value) 
	{
		if (value == null || !StringUtils.hasText(value)) 
		{
			return true;
		}
		return false;
	}
	
	public static boolean rejectIfNull(Object value) 
	{
		if (value == null) 
		{
			return true;
		}
		return false;
	}	
	
	public static boolean rejectIfEmptyIndex(String value) 
	{
		if (value == null || !StringUtils.hasText(value)) 
		{
			return true;
		}
		if ("0".equals(value)) 
		{
			return true;
		}
		return false;
	}
	
	
	public static boolean rejectIfNotAlphaNumericSpace(String value) 
	{
		Matcher matcher = alphaNumericPatternWithSpace.matcher(value);		
		if(!matcher.matches())
		{
			return true;
		}
		return false;
	}
	public static boolean rejectIfNotAlphaNumericUserName(String value) 
	{
		Matcher matcher = userNamePattern.matcher(value);		
		if(!matcher.matches())
		{
			return true;
		}
		return false;
	}
	
	public static boolean rejectIfNotNumeric(String value) 
	{
		Matcher matcher = numberPattern.matcher(value);		
		if(!matcher.matches())
		{
			return true;
		}
		return false;
	}
	
	public static boolean rejectIfNotNumeric(Integer value) 
	{
		if(value != null){
			Matcher matcher = numberPattern.matcher(value.toString());		
			if(!matcher.matches())
			{
				return true;
			}
		}
		
		return false;
	}
	

	public static boolean rejectIfNotEqual(String value1,String value2) 
	{
		if (value1 == null || value2 == null || !StringUtils.hasText(value1) || !StringUtils.hasText(value2)) 
		{
			return true;
		}
		else if (!value1.equals(value2)) 
		{
			return true;
		}
		return false;
	}
	
	
	public static boolean rejectIfNotTrue(String value) {
		if (value == null || !StringUtils.hasText(value)) 
		{
			return true;
		}
		if (!"Y".equals(value)) 
		{
			return true;
		}
		return false;
	}	
	
	public static boolean rejectIfPasswordInvalid(String password,Pattern pattern) 
	{
		Matcher matcher = pattern.matcher(password);
		if (password == null || !StringUtils.hasText(password)) 
		{
			return true;
		}
		if(!matcher.matches())
		{
			return true;
		}
		return false;
	}
	
	
	public static boolean rejectIfEmailInvalid(String email)
	{
		Matcher matcher = emailPattern.matcher(email);       
		return !matcher.matches();    
	} 
	
	public static boolean rejectIfEqual(String value1,String value2) 
	{
		if (value1 == null || value2 == null || !StringUtils.hasText(value1) || !StringUtils.hasText(value2)) 
		{
			return true;
		}
		else if (value1.equals(value2)) 
		{
			return true;
		}
		return false;
	}
	
	public static boolean rejectIfFromDateEmpty(String fromDate, String toDate)
	{
		if( ((toDate!=null && StringUtils.hasText(toDate)) && (fromDate==null || !StringUtils.hasText(fromDate))))
		{
			return true; // reject
		}
		else
			return false;
	}
	
	public static boolean rejectIfFromDateAfterTo(String fromDate, String toDate) throws ParseException
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date from = sdf.parse(fromDate);
    	Date to =   sdf.parse(toDate);
    	
		if(from.after(to))
		{
			return true;
		}
		else
			return false;
	}
	
	public static boolean rejectIfToDateEmpty(String fromDate, String toDate)
	{
		if( ((fromDate!=null && StringUtils.hasText(fromDate)) && (toDate==null || !StringUtils.hasText(toDate))))
		{
			return true; // reject
		}
		else
			return false;
	}
	
	public static boolean rejectIfToDateBeforeFrom(String fromDate, String toDate) throws ParseException
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date from = sdf.parse(fromDate);
    	Date to =   sdf.parse(toDate);
    	
		if(to.before(from))
		{
			return true;
		}
		else
			return false;
	}
	
}
