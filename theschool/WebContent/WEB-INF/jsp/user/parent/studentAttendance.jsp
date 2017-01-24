<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type='text/javascript' src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type='text/javascript' src='<spring:message code="static.application.name"/>/javascript/jquery.attMks.js'></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-finetabs.js"></script>
<link href="<spring:message code="static.application.name"/>/css/tables.css" rel="stylesheet" type="text/css" />

<style>

/* .secTable{
width: 100%;

}

.secTable .sec .el{
float: left;
}
.secTable .sec .eld{
}

.secTable th {
	background: #f1f1f1;
	color: #272626;
	padding: 4px 10px;
	border-bottom: 1px solid #e4e3e1;
	text-align: left;
	white-space: pre-wrap;
	font-weight: bold;
}

.secTable div {
	padding: 2px;
	background-color: #EEE;
}
.secTable {
width:100%;
	background: #fff;
border-left: 1px solid #E4E3E1;
border-top: 1px solid #E4E3E1;
border-right: 1px solid #E4E3E1;
box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
}
.secTable td {
	border-bottom: 1px solid #e4e3e1;
    border-left: 1px solid #e4e3e1;
    text-align: center;
    vertical-align: top;
    white-space: inherit;
}
.sec div,.secTable .sec {
padding: 2px;
background: none !important;
} */

.tc{
width: 300px;
margin: auto;
}


</style>

<script defer="defer">
 $(document).ready(function() {
	 /**  var dayNames = [ 'Sun','Mon','Tue','Wed','Thu','Fri','Sat' ];
	var thismonthHolidayList = [7,14,21,28];
	
	var stid = parseInt($('#stid').val());
	var clsid = parseInt($('#clsid').val());
	
	var params = {
			cl: clsid
		};
	
	var classMonths = $.getData('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/user/studentClass/getMonths.htm?cl='+parseInt(clsid),params);
	var subjects = $.getData('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/user/studentClass/getSubjects.htm?cl='+parseInt(clsid),params);
	
	var html =$(".attendanceTable");
	//$.get('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/user/parent/getAttendance.htm?st='+stid, function( data ) {
		$.each(classMonths, function(ind, atm) {
			var attDayName;
			var m=atm.split("-");
			var year =  parseInt(m[0]);
			var month = parseInt(m[1]);
			var daysInMonth  = new Date(year, month, 0).getDate();
			var title = '<h4 class="widget-title"><span>'+getMonthName(month)+' '+year+'</span></h4>';
			
			
			
			$(html).append(title);
			var dt=new Date(2014, 11);
			dt.setDate( 01);
		var weekDay = dt.getDay();
		
		var ht_table =$('<table/>',{
			 class:'attTable secTable',
			 id:''
		 }).appendTo(html);
		
		var ht_trh =$('<tr/>',{
			 class:'attheader dates',
			 id:''
		 }).appendTo(ht_table);
		
			var ht_td =$('<td/>').appendTo(ht_trh);
			for (var dayCount = 1; dayCount <= daysInMonth; dayCount++) {
				attDayName = dayNames[((dayCount+weekDay-1)%7)];
				
				var td =$('<td/>',{
					 class:'attendance-day ',
					 id:'day_'+dayCount
				 }).appendTo(ht_trh);
				
				var dv1 =$('<div/>',{
					 class:'attDayName',
					 id:'day_'+dayCount,
					 html:attDayName
				 }).appendTo(td);
				var dv2 =$('<div/>',{
					 class:'attDay',
					 id:'day_'+dayCount,
					 html:dayCount
				 }).appendTo(td);
			}
			var eptd = $('<td/>',{
				 class:'',
				 id:'',
				 html:'Total'
			 }).appendTo(ht_trh);
			$.each(subjects, function(index, sub) {
				var s_tr =$('<tr/>',{
					 class:'sub_mon_y',
					 id:'smy_'+sub.id+"_"+month+"_"+year
				 }).appendTo(ht_table);
				var s_tdsub =$('<td/>',{
					 class:'',
					 id:'sub_'+sub.id,
					 html:sub.subjectDesc
				 }).appendTo(s_tr);
				
				for (var dayCount = 1; dayCount <= daysInMonth; dayCount++) {
					var td =$('<td/>',{
						 class:'',
						 id:'sdm_'+sub.id+'_'+dayCount+'_'+month //sub day month
					 }).appendTo(s_tr);
				}
				var eptd = $('<td/>',{
					 class:'subj_T',
					 id:'sbj_T_'+sub.id+'_'+month+'_'+year,
					 html:''
				 }).appendTo(s_tr);
			});
			
			var ht_mnTr =$('<tr/>',{
				 class:'attheader monthTotal',
				 id:''
			 }).appendTo(ht_table);
			var colstd =$('<td/>',{
				 class:'',
				 id:'',//sub day month
				 html:'<center>Total(month aggregate)</center>'
			 }).attr("colspan",daysInMonth+1).appendTo(ht_mnTr);
			var tolmntd =$('<td/>',{
				 class:'mn_T',
				 id:'mn_T_'+month //sub day month
			 }).appendTo(ht_mnTr);
			
		});
	
	
		loadAttendance();
		function loadAttendance(){
			
			$( ".sub_mon_y" ).each(function( index ) {
					var smid = $(this).attr("id");
					var s=smid.split('_');
					var subid = parseInt(s[1]);
					var monid =parseInt(s[2]);
					var yrid =parseInt(s[3]);
					var $curow = $(this);
					 var abs_count =0;
					 var prt_count=0;
					$.get('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/user/studentClass/getAttendance.htm?b='+subid+'&s='+stid+'&y='+yrid+'&m='+monid, function( data ) {
						$.each(data, function(ind, s) {
								var attdate = s.attdate;
								var attday = attdate.split('/');
								 var atd = parseInt(attday[0]);
								 var check;
								
								 if(s.present){
									//check =1; 
									check ='<span class="st_p">1</span>';
									prt_count=prt_count+1;
									$curow.find('td#sdm_'+subid+'_'+atd+"_"+monid).css( "background-color", "#74F194" ).html(check);
								 }
								 else{
									 //check =0;
									 check ='<span class="st_a">0</span>';
									 abs_count = abs_count+1;
									 $curow.find('td#sdm_'+subid+'_'+atd+"_"+monid).css( "background-color", "#FFAEAE" ).html(check);
								 }
								 
								//$(').html((check));//sdm_1_2_01
						});
						var sT = '<span class="prt_T">'+prt_count+'</span>'+'/'+'<span class="abs_T">'+(prt_count+abs_count)+'</span>';
						$curow.find('td#sbj_T_'+subid+'_'+monid+"_"+yrid).html(sT);
						//updateMonthPercentage(monid,prt_count,abs_count);
					//	$(this).find('.subj_T').html('<span class="prt_T">'+prt_count+'</span>'+'/'+'<span class="abs_T">'+(prt_count+abs_count)+'</span>');
					});
					
			});
			
			calculateMonthPerc();
		}
		
		function getMonthName(monthNumber) {
			  var months = ['January', 'February', 'March', 'April', 'May', 'June',
			  'July', 'August', 'September', 'October', 'November', 'December'];
			  return months[monthNumber-1];
			} 
	
		function updateMonthPercentage(m,p,a) {
			 var monid= parseInt(m);
			 var prt_count= parseInt(p);
			 var abs_count= parseInt(a);
			 
				var mnT = $("#mn_T_"+monid);
				 if (isEmpty(mnT)) {
					 var perc = prt_count==0?0:((prt_count*100)/(prt_count+abs_count)).toFixed(2);
					 var mnHt = '<span class="mnPr_T">'+prt_count+'</span>'+'/'+'<span class="mnT_T">'+(prt_count+abs_count)+'</span><span class="mnT_Per">('+perc+')</span>';
					 $("#mn_T_"+monid).html(perc);
				      
					// $('#rate').val(((priceTwo - priceOne) / priceOne * 100).toFixed(2));
				  }
				 else{
					 var eP = parseInt($("#mn_T_"+monid).find(".mnPr_T").html());
					 var eT = parseInt($("#mn_T_"+monid).find(".mnT_T").html());
					 
					 //Math.round(ch3,2)
					 $("#mn_T_"+monid).empty();
					 var nP = eP+prt_count;
					 var nT = eT+prt_count+abs_count;
					 
					 var perc = nP==0?0:((nP*100)/(nT)).toFixed(2);
					 var mnHt = '<span class="mnPr_T">'+nP+'</span>'+'/'+'<span class="mnT_T">'+nT+'</span><span class="mnT_Per">('+perc+')</span>';
					 $("#mn_T_"+monid).html(mnHt);
					 
				 }
			} 
		function isEmpty( el ){
		      return !$.trim(el.html())
		  }
		
		function calculateMonthPerc(){
			
			$.each(classMonths, function(ind, atm) {
				var attDayName;
				var m=atm.split("-");
				var year =  parseInt(m[0]);
				var month = parseInt(m[1]);
				var mnP=0,mnTo=0;
				$.each(subjects, function(index, sub) {

					var $mnT = $("#sbj_T_"+sub.id+"_"+month+"_"+year);
					mnP = mnP+parseInt($.isNumeric($mnT.find(".prt_T").text())?$mnT.find(".prt_T").text():0);
					mnTo = mnTo+parseInt($.isNumeric($mnT.find(".abs_T").text())?$mnT.find(".abs_T").text():0);
					 
				});
				
				 var perc = mnP==0?0:((mnP*100)/(mnTo)).toFixed(2);
				var mnHt = '<span class="mnPr_T">'+mnP+'</span>'+'/'+'<span class="mnT_T">'+mnTo+'</span><span class="mnT_Per">('+perc+')</span>';
				 $("#mn_T_"+month).html(mnHt);
				
			})
		} */
		
		/* calTotal();
		function calTotal(){
			
			$( ".sub_mon_y" ).each(function( index ) {
					var smid = $(this).attr("id");

					var pts = parseInt($(this).find(".st_p").length);
					var abs = parseInt($(this).find(".st_a").length);
					$(this).find('.subj_T').html((pts)+'/'+(abs+pts));
					
			});
		} 
});
 jQuery.extend({
		getData:function(url,params){
			var result = null;
			$.get(url,function(data){
					result =data;
			});
			return result;
		}
	}); */
	
	$(".attendanceTable").atm({
		path:'<spring:message code="application.name"/>${pageContext.servletContext.contextPath}',
		classId:parseInt($('#clsid').val()),
		studentId:parseInt($('#stid').val())
	});
	
/*  jQuery.extend({
	getData:function(url,params){
		var result = null;
		$.ajax({
			url:url,
			type: "GET",
			async:false,
			success:function(data){
				result =data;
			}
		});
		return result;
	} */
}); 
</script>


    <p>Welcome:&nbsp;<strong>${sessionScope.user_display_name}</strong> &nbsp; | &nbsp; <a href="${pageContext.servletContext.contextPath}/user/logout.htm" class="logoutLink">Logout</a></p>
   

    <p class="lastLogin">User TYpe: ${sessionScope.user_type}</p>
    </span>
    <div>Hello ${parent.firstName}  ${parent.lastName}</div>
    <div class="secTable">
				<table border="0" cellspacing="0" cellpadding="0" id="" width="100%">
					<thead>
						<tr>
							<th width="100%">${student.firstName} ${student.lastName}</th>
						</tr>
					</thead>
					<tr>
						<td>
							<div style="background-color: white;">
								<div class="sec">
									<div class="el">Name:</div>
									<div class="eld">${student.firstName} ${student.lastName}</div>
									<div class="el">Admission Number:</div>
									<div class="eld">${student.admNum}</div>
									<div class="el">Class:</div>
									<div class="eld">${student.className}</div>
								</div>
								<div class="sec" style="float: right;">
									<img
										src="${pageContext.request.contextPath}/static/simg-fit/96v120/${student.unid}.jpeg"
										class="" alt="" />
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
   <div id="tabularData">
				<div>
					<input type="hidden" id="stid" value="${student.studentId}">
					<input type="hidden" id="clsid" value="${cls.id}">
					 <div class="attendanceTable">
					</div>
			</div>
			</div>
			<c:if test='${null!=er_message}'>
				<div><center><div class="alertMsg">${er_message}</div></center></div>
			</c:if>
		
			