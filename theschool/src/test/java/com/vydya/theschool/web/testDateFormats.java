package com.vydya.theschool.web;

//File Name SendEmail.java

/*import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;*/
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class testDateFormats
{
	public final static String DATE_FORMAT1="dd/MM/yyyy";
	public final static String DATE_FORMAT2="yyyy-MM-dd";
	
	public static void main(String args[]) {

		 Calendar birthday = Calendar.getInstance();
		
		  Date date = birthday.getTime();
		  System.out.println(date.getYear());
		 birthday.set(1993, 06, 06, 01, 14, 10);
		
		  String s;
		  DateFormat formatter;
		   date = birthday.getTime();//new Date();

		
		  // 01/09/02
		  formatter = new SimpleDateFormat("MM/dd/yy");
		  s = formatter.format(date);
		  System.out.println(s);
		  
		// 01/09/02
		  formatter = new SimpleDateFormat("yyyy-MM-dd");
		  s = formatter.format(date);
		  System.out.println("yyyy-MM-dd : "+s);

		  // 01/09/02
		  formatter = new SimpleDateFormat("dd/MM/yy");
		  s = formatter.format(date);
		  System.out.println(s);

		  // 29-Jan-02
		  formatter = new SimpleDateFormat("dd-MMM-yyyy");
		  s = formatter.format(date);
		  System.out.println(s);

		  // 2002.01.29.08.36.33
		  formatter = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss");
		  s = formatter.format(date);
		  System.out.println(s);

		  // Tue, 09 Jan 2002 22:14:02 -0500
		  formatter = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss Z");
		  s = formatter.format(date);
		  System.out.println(s);
		  
		  // Tue, 09 Jan 2002 22:14:02 -0500
		  formatter = new SimpleDateFormat("dd MMM yyyy hh:mm aa");
		  s = formatter.format(date);
		  System.out.println(s);
		  
		  formatter = new SimpleDateFormat("dd/MM/yyyy hh:mm aa");
		  s = formatter.format(date);
		  System.out.println(s);
		  

		  // Tue, 09 Jan 2002 22:14:02 -0500
		  formatter = new SimpleDateFormat("E, dd MMM yyyy");
		  s = formatter.format(date);
		  System.out.println(s);

		  
		  formatter = new SimpleDateFormat("EEEE, dd MMMM yyyy HH:mm:ss zzzz");
		  s = formatter.format(date);
		  System.out.println(s);
		  Calendar cal = Calendar.getInstance();
		  Integer mo = cal.get(Calendar.MONTH);
		  System.out.println(mo);
		  
		  
		  }
}
