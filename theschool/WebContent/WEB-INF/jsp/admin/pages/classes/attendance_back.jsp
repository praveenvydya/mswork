<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.common.constants.TSConstants" %> 
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<style>

.attTable td{
	width: 50px;
}
.attTable td.rollno,.attTable td.stname{
	width: 200px;
}

#sectionsTable div {
width: auto;
min-height: 20px;
float: none;
margin: 0px;
padding: 0px 2px;
background-color: #EEE;
text-align: center;
}

#sectionsTable td {
border-left: 1px solid #e4e3e1;
border-right: 1px solid #e4e3e1;
text-align: center;
}

.holiday div,.holiday{
	background-color: #BDBDBD !important;
}

.dropdown-toggle {
  background: #fff;
  border-radius: .2em .2em 0 0;
 /*  border: 1px solid #E4E3E1;
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067); */
}
ul.dropdown {
  display:none;
  position: absolute;
  top: 100%;
 margin-top: 0px;
margin-left: 0px;
  background: #fff;
  padding: 0;
   border-radius: .2em .2em 0 0;
   border: 1px solid #E4E3E1;
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
  border-radius: 0 0 .2em .2em;
}
ul.dropdown li{
 padding: 5px;
  cursor: pointer;
}

ul.dropdown li:HOVER{
background: #E9EDFF;
}
ul.dropdown li a{

}
.dropdown-toggle.active{
background: #E9EDFF;
}
nav{position: relative;
height: 20px;
 }
[class*=" icon-"], [class^=icon-] {
padding:0px !important;
margin: 0px !important;
}
.infodiv{
	height: 100px;
	float: left
}
.attTable tr:HOVER {
	background-color: #F3F9FC;
}
</style>
<script defer="defer">
$(document).ready(function() {
	var dayNames = [ 'Sun','Mon','Tue','Wed','Thu','Fri','Sat' ]
	var thismonthHolidayList = [7,14,21,28];
	var dt=new Date(2015, 0);
		dt.setDate( 01);
	var weekDay = dt.getDay(); 
	var dlist =[];
	var sat = new Array();   //Declaring array for inserting Saturdays
	var sun = new Array();   //Declaring array for inserting Sundays

	var getTot = daysInMonth(dt.getMonth(),dt.getFullYear());
	for(var i=1;i<=getTot;i++){    //looping through days in month
	    var newDate = new Date(dt.getFullYear(),dt.getMonth(),i);
	    if(newDate.getDay()==0){   //if Sunday
	        sat.push(i);
	    }
	    if(newDate.getDay()==6){   //if Saturday
	        sun.push(i);
	    }
	}
	
	var daysOnTheMonth = 32 - new Date(dt.getFullYear(), dt.getMonth(), 32).getDate();
	
	var today = new Date();
		day = today.getDate();
	
	for (var dayCount = 1; dayCount <= daysOnTheMonth; dayCount++) {
			var dayClass = "";
			var hdy = "";
			var tod = false;
			var attDayName;
			if (day > 0 && dayCount === day && dt.getYear() === today.getYear() && dt.getMonth()===today.getMonth()) {
				dayClass = "today";
				tod = true;
			}
			if(jQuery.inArray(dayCount, thismonthHolidayList)!=-1){
				hdy = "holiday";
			}
			attDayName = dayNames[((dayCount+weekDay-1)%7)];
			$(".attheader").append('<td id="day_' + dayCount + '" rel="'+dayCount+'" class="attendance-day '+dayClass+' '+hdy+'"><div class="attDayName">'+attDayName+'</div><div class="attDay">'+dayCount+'</div></td>');
			
			var actionHtml = '<td><nav><a class="dropdown-toggle" title="Menu"><span class="icon-uniF419" ></span></a>'+
			'<ul class="dropdown"> <li class="addedit_dd"  id="addedit_'+dayCount+'">Add/Edit</li>'+
			  '<li class="save_dd" id="save_'+dayCount+'" >Save</li><li class="cancel_dd"  id="cancel_'+dayCount+'">Cancel</li></ul></nav></td>';
			  $(".actionrow").append(actionHtml);
			  
		} 
	createemptytd(daysOnTheMonth);
	function createemptytd(){
		$( ".student" ).each(function( index ) {
			for(var i=1;i<=daysOnTheMonth;i++){
				var stid = $(this).attr("id");
				var dayClass = "";
				var hdy = "";
				var tod = false;
				var attDayName;
				if (day > 0 && i === day && dt.getYear() === today.getYear() && dt.getMonth()===today.getMonth()) {
					dayClass = "today";
					tod = true;
				}
				
				if((jQuery.inArray(i, sun)!=-1)||(jQuery.inArray(i, sat)!=-1)){
					hdy = "holiday";
				}
				$(this).append('<td class="tdcheck '+dayClass+' '+hdy+' row'+i+'" id="td_'+stid+'_'+i+'"></td>');
			}
		});
	}
	
	loadAttendance();
	function loadAttendance(){
		
		$( ".student" ).each(function( index ) {
				var stid = $(this).attr("id");
				var subid = $(".subid").attr("id");
				var month = dt.getMonth();
				var year = dt.getYear();
				
				$.get('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/admin/manageClass/getAttendance.htm?b='+subid+'&s='+stid+'&y='+year+'&m='+month, function( data ) {
					$.each(data, function(ind, s) {
							var attdate = s.attdate;
							var attday = attdate.split('/');
							 var atd = parseInt(attday[0]);
							 var check;
							 if(s.present){
								check ='checked="checked"'; 
							 }
							 else{
								 check ="";
							 }
							 var htm ='<input type="checkbox" class="attelement" '+check+' id="'+stid+'_'+atd+'" disabled="true"/>';
							$('#td_'+stid+'_'+atd).html((htm));
					});
				});	
		});
		
	}
	
	
	function daysInMonth(month,year) {
	    return new Date(year, month, 0).getDate();
	}
	
	$('.attelement').on('change', function() {
		if($(this).is(':checked')){
			$(this).parent().css( "background-color", "#9FE09F" );
		}
		else{
			$(this).parent().css({"background-color":"#E09F9F"});
		}
	});
	
	$( ".attelement" ).each(function( index ) {
		if($(this).is(':checked')){
			$(this).parent().css( "background-color", "#9FE09F" );
		}
		else{
			$(this).parent().css({"background-color":"#E09F9F"});
		}
	});
	
	$(function() {
		$('.attelement').click(function(){
			if($(this).is(':checked')){
				$(this).parent().css( "background-color", "#9FE09F" );
			}
			else{
				$(this).parent().css({"background-color":"#E09F9F"});
			}
		});
	});	
		$( ".attelement" ).each(function( index ) {
			if($(this).is(':checked')){
				$(this).parent().css( "background-color", "#9FE09F" );
			}
			else{
				$(this).parent().css({"background-color":"#E09F9F"});
			}
		});
		
		
	 
	 $(function() {
			$('.addedit_dd').click(function(){
				var id = $(this).attr("id");
				var d = id.split('_');
			 var col = d[1];
			 $( ".row"+col ).each(function( index ) {
				 
				 var elm = $(this).attr("id");
				 var elmid = elm.split('_');
				 var stid = elmid[1];var atid = elmid[2];
				 
				 $(stid+'_'+atid).removeAttr('disabled');
				 
				 if ($(this).is(':empty')){
					 var htm ='<input type="checkbox" class="attelement" id="'+stid+'_'+atid+'"/>';
					 $('#td_'+stid+'_'+atid).html((htm));
					}
				 else{
					//alert("not empty"); //do nothing
				 }
			 });
			 $(this).hide();
			 $(this).siblings(".save_dd").show();
			});
		});
	 
	 $(function() {
			$('.save_dd').click(function(){
				var id = $(this).attr("id");
				var d = id.split('_');
			 var col = d[1];
			 var subid = $(".subid").attr("id");
			 var data = {sts: [],subid:subid};
			 $( ".row"+col ).each(function( index ) {
					 var elm = $(this).attr("id");
					 var elmid = elm.split('_');
					 var stid = elmid[1];var atid = elmid[2];
					 $(stid+'_'+atid).attr("disabled", true);
					 if(atid===col){

						 if ($(this).is(':empty')){
							//alert("empty"); //do nothing
							}
						 else{
							 if($("#"+stid+"_"+atid).is(':checked')){
									data.sts.push(
										    {studentId: stid, attdate: atid, present: 1,subjectId:subid}
										);
								}
								else{
									data.sts.push(
											{studentId: stid, attdate: atid, present: 0,subjectId:subid}
										);
								} 
						 }
					 }
			 });
			 $(".dropdown").hide();
			 $(this).hide();
			 $(this).siblings(".addedit_dd").show();
			 
			 var myString = JSON.stringify(data.sts);  //converts json to string and prepends the POST variable name
			 $.ajax({
			    type: "POST",
			    url: "<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/admin/manageClass/saveAttendance.htm", //the name and location of your php file
			    data: myString,      //add the converted json string to a document.
	            async: false,    //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
	            cache: false,    //This will force requested pages not to be cached by the browser  
	            processData:false,
			    success: function(data) {
			    	attendanceMessage(data);
										} //just to make sure it got to this point.
			 });
			 return false;
			
			});
		});
	 
	 function attendanceMessage(data){
		 
		 if(data.success){
			 $("#message_label").html('<div class="alert alert-success">'+data.message+'</div>').fadeIn().delay(5000).fadeOut();
		 }
		 else{
			 $("#mesage_label").html('<div class="alert alert-error">'+data.message+'</div>').fadeIn().delay(5000).fadeOut();
				
		 }
	 }
		$(function() {
			// Dropdown toggle
			$('.dropdown-toggle').click(function(){
				$('.dropdown').hide();
				// $('.dropdown-toggle').removeClass("active");
				 //$(this).addClass("active");
				 $("nav").css( "background-color", "#FFF" );
				 $(this).parent().css( "background-color", "#E9EDFF" );
			  $(this).next('.dropdown').toggle();
			});
			$(document).click(function(e) {
			  var target = e.target;
			  if (!$(target).is('.dropdown-toggle') && !$(target).parents().is('.dropdown-toggle')) {
				 // $('.dropdown-toggle').removeClass("active");
				  $("nav").css( "background-color", "#FFF" );
				  $('.dropdown').hide();
			   
			  }
			});
			});
	 
	//<td class="tdcheck"><input type="checkbox" class="attelement" checked="checked" id="studentid_dateid"/></td>
	
});
</script>
	
			
			<div id="tabularData">
					<div class="subid" id="${subjectid}"></div>
					<div class="span5" id="message_label"></div>
					<form:form name="teacherForm" method="POST" commandName="teacherForm" >
					<ts:button validateAction="true" action="<%=WebConstants.ADD_TEACHER%>" type="submit" value="ADD" cssClass="large clButton green" title="ADD" />
					
					<div>
					<table width="" border="0" cellspacing="0" cellpadding="0" id="sectionsTable" class="attTable">
						<tr class="attheader dates">
							<td></td> <td class="dheader"></td>
						</tr>
						
						 <c:forEach var="stu" items="${students}"> 
	                      <tr class="student" id="${stu.studentId}">
								<td class="rollno">${stu.rollNumber}</td><td class="stname">${stu.firstName} , ${stu.lastName}</td>
							</tr>
                     </c:forEach> 
						<tr class="actionrow">
							<td class="rollno" colspan="2" class="actions"> Actions</td>
						</tr>
						</table>
					</div>
					
					</form:form>
				</div>
				<div class="infodiv">
					Information
				</div>