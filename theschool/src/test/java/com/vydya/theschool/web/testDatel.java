package com.vydya.theschool.web;

//File Name SendEmail.java

/*import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;*/
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import com.vydya.theschool.common.util.TSDateUtil;
import com.vydya.theschool.dataaccess.utils.DAOUtils;

public class testDatel
{
	public final static String DATE_FORMAT1="dd/MM/yyyy";
	public final static String DATE_FORMAT2="yyyy-MM-dd";
	
   public static void main(String [] args) throws Exception
   {    
	   //System.out.println(" Time "+displayTime());
	   
	   //Timestamp t = new Timestamp(1337594400000);
	  List<Timestamp> tlist = TSDateUtil.getStartEndDates(2015);
   System.out.println(TSDateUtil.getDisplayDateTime(tlist.get(0)));
	  System.out.println(TSDateUtil.getDisplayDateTime(tlist.get(1)).toString());
	  System.out.println(tlist.get(0).getTime()+"");
	   System.out.println(DAOUtils.isValidDate(null, null, null));
	   
	   System.out.println(TSDateUtil.dateStringToTimestampWithTime("09/22/2014 09:00"));
	   
	   System.out.println(TSDateUtil.dateStringToTimestampWithTimeAMPM("03 Sep 2014 11:12 pm"));
	     
	   System.out.println(TSDateUtil.isFutereDate(TSDateUtil.dateStringToTimestampWithTimeAMPM("05 Sep 2014 11:12 pm")));
	   
	   System.out.println(TSDateUtil.getMonthYearName(TSDateUtil.dateStringToTimestampWithTimeAMPM("05 Sep 2014 11:12 pm")));
	   System.out.println("with AM PM "+TSDateUtil.isFutereDate(TSDateUtil.ST_ddMMyyyhhmmaaa("18-01-2017 08:00 am")));//18-01-2017 08:00 am
	  // timestampDates();
	   
		 /*  Locale l = new Locale("ENGLISH");
		   Date d = new Date();
		   getMonthYear();
		   
		   DateFormat formatter = new SimpleDateFormat("MMMM-yyyy-dd");
			Calendar cal = Calendar.getInstance();
			cal.set(2012, 0, 1,0,0,0);
			String[]  s = formatter.format(cal.getTimeInMillis()).split("-");
			getMonthYear();*/
			
			 /*	System.out.println(s[0]+" "+s[1]);
		String toDt = "2013-10-20 15:22:25.353";
		DateFormat formatterx = new SimpleDateFormat(DATE_FORMAT2);
		Date date = formatterx.parse(toDt);
		 getAge(date);
		
	   System.out.println("date ="+date.toString());*/
	  // String s = TSDateUtil.getDateAsString(DATE_FORMAT1, l, date) ;
	   
	  // System.out.println(" string from date  "+s);
	  // String formated = formatDate(s);
	  // System.out.println("formated date  "+formated);
	   System.out.println(" ##########");
	   getMonthYear();
	   
	   getStartendofmonth();
   }   
   
   /*private String formatDate(Date date) throws Exception {
	    DateFormat inputFormat = new SimpleDateFormat("yyyyMMdd'T'HHmmss.SSS Z");
	    DateFormat outputFormat = new SimpleDateFormat("EEEEE', 'MMMMM' 'dd', 'yyyy' 'h:mm:a");
	    Date dat = inputFormat.parse(date);
	    return outputFormat.format(dat);
	}*/
   
   private static void timestampDates() throws Exception {
	
	   String d = "08/28/2014 15:42";
	   System.out.println(TSDateUtil.dateStringToTimestampWithTime(d).getTime());
	   Calendar cal = Calendar.getInstance();
		cal.set(2014, 7, 25,21,12,12);
	   System.out.println(cal.getTimeInMillis());
	   cal.set(2014, 7, 25,12,12,12);
	   System.out.println(cal.getTimeInMillis());
	   
	   
	   System.out.println("Timestamp="+TSDateUtil.dateStringToTimestamp("2014-08-11").getTime());
	   
	}
  
   
   private static String formatDate(String s) throws Exception {
	    DateFormat inputFormat = new SimpleDateFormat("dd/MM/yyyy");
	    DateFormat outputFormat = new SimpleDateFormat("EEEEE', 'MMMMM' 'dd', 'yyyy");
	    Date dat = inputFormat.parse(s);
	    return outputFormat.format(dat);
	}
   
   private static void getAge(Date date){
	   Calendar birthday = Calendar.getInstance();
	   Calendar today = Calendar.getInstance();
	   System.out.println("today =");

	   birthday.set(1986, 01, 20, 01, 14, 10);
	   
	   Integer mo = birthday.get(Calendar.MONTH);
		  System.out.println(mo);
	  // birthday.set(1985,1,20); // note that calendar is array,
	   long milis1 = birthday.getTimeInMillis();
	   long milis2 = today.getTimeInMillis();

	   // Calculate difference in milliseconds
	   long diff = milis2 - milis1;

	   // Calculate difference in seconds
	   long diffSeconds = diff / 1000;

	   // Calculate difference in minutes
	   long diffMinutes = diff / (60 * 1000);

	   // Calculate difference in hours
	   long diffHours = diff / (60 * 60 * 1000);

	   // Calculate difference in days
	   long diffDays = diff / (24 * 60 * 60 * 1000);

	   System.out.println("In milliseconds: " + diff + " milliseconds.");
	   System.out.println("In seconds: " + diffSeconds + " seconds.");
	   System.out.println("In minutes: " + diffMinutes + " minutes.");
	   System.out.println("In hours: " + diffHours + " hours.");
	   System.out.println("In days: " + diffDays + " days.");


	   Calendar calDOB = Calendar.getInstance();  
	   calDOB.setTime(date);  
	   //setup calNow as today.  
	   Calendar calNow = Calendar.getInstance();  
	   calNow.setTime(new java.util.Date());  
	   //calculate age in years.  
	   int ageYr = (calNow.get(Calendar.YEAR) - calDOB.get(Calendar.YEAR));  
	   // calculate additional age in months, possibly adjust years.  
	   int ageMo = (calNow.get(Calendar.MONTH) - calDOB.get(Calendar.MONTH));  
	   if (ageMo < 0)  
	   {  
	   //adjust years by subtracting one  
	   ageYr--;  
	   } 
	   
	   
	   System.out.println("age "+ageYr );
	   
	   }
	   
   private static String displayTime(){
	   Calendar birthday = Calendar.getInstance();
	   Calendar today = Calendar.getInstance();
	   String displayDate = null;
	   DateFormat formatter;
	   DateFormat formatter2;
	   birthday.set(2013, 10, 2, 13, 9, 10);
	   
	   long milis1 = birthday.getTimeInMillis();
	   long milis2 = today.getTimeInMillis();

	   // Calculate difference in milliseconds
	   long diff =  milis2-milis1 ;

	   // Calculate difference in seconds
	   long ds = diff / 1000;

	   if(ds<60){
		   return displayDate =ds+((ds>1)? "secs":"sec"+" ago");
	   }
	   
	   // Calculate difference in minutes
	   long dm = diff / (60 * 1000);
	   
	   if(dm<60){
		   return displayDate =dm+((dm>1)? "mins":"min"+" ago");
	   }

	   // Calculate difference in hours
	   long dh = diff / (60 * 60 * 1000);

	   if(dh<24){
		   return displayDate = dh+((dh>1)? "hours":"hour"+" ago");
	   }

	   // Calculate difference in days
	   long dd = diff / (24 * 60 * 60 * 1000);

	   
	   if(dd<7){
		   
		   displayDate = dd+((dd>1)? "days":"day"+" ago");
		   return displayDate;
	   }
	   
	   else{
		   
		   formatter = new SimpleDateFormat("E, dd MMM yyyy hh:mm a");
			 String  s = formatter.format(birthday.getTime());
		   return s;
	   }
		   
	 
	   /*formatter = new SimpleDateFormat("E, dd MMM yyyy");
		 String  s = formatter.format(birthday.getTime());
		  System.out.println(s);
		  //date to timestamp
		  Timestamp ts = new Timestamp(birthday.getTime().getTime());
		  
		  System.out.println(" ts time"+ts.getTime() +" milis1 = "+milis1);*/
		  	   
	   }
   
   private static void getMonthYear(){
	   
	   Calendar birthday = Calendar.getInstance();
	   DateFormat formatter;
	   birthday.set(2013, 10, 2, 13, 9, 10);
	   
	   Date d =birthday.getTime();
	   formatter = new SimpleDateFormat("dd MMM yyyy");
		 String  s[] = formatter.format(birthday.getTime()).split(" ");
		 
		 System.out.println(s[1]);
   }
   
 private static void getStartendofmonth(){
	   
	 //Calendar mycal = new GregorianCalendar(2015,1, 1);
	 //  startDate = mycal.getTimeInMillis();
	   
		 Integer year = 2015;
		 Integer month = 1;
		 List<Timestamp> tlist = new ArrayList<Timestamp>();
			Calendar cal = new GregorianCalendar(2015,month-1, 1);
			Calendar cal2 = null;
			cal.set(2015, 0, 1,0,0,0);
			Integer numDays = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			if(month!=null&&month<=12){
				cal2 = new GregorianCalendar(year,month-1, numDays,23,59,59); 
			}
			
			tlist.add(0,new Timestamp(cal.getTimeInMillis()));
			tlist.add(1,new Timestamp(cal2.getTimeInMillis()));
   }
  

}
