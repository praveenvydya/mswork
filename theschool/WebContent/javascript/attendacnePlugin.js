(function ( $ ) {
 
    $.fn.attendance = function( options ) {
 
    	var attOpts = $.extend({}, $.fn.attendance.defaults, options);
 
    	var flags = {
    			wrap: "",
    			studentsJson:[]
    		};
    	
    	this.each(function(){
    		
    		
      		
    		flags.wrap = $(this);
    		//flags.wrap.addClass('attendance-wrap').append("<div class='attendance-list-wrap'><p class='attendance-subtitle'></p><span class='attendance-loading'></span><div class='attendance-list-content'><ul class='attendance-list'></ul></div></div>");
    		var title =	'<div class="monthTitle fL"><div class="monthDropdown fR"><div><select name="monthYear" class="mY">'+	
			'</select></div><div> <input type="button" value="Load" id="loadAt" class="cms-btn" /></div> <div class="mesage_label"></div></div></div>';//<div class="attMonth"> </div>
    		flags.wrap.addClass('attendance-wrap').append(title);
    		generateMonthsDropdown();
    		loadStudents();
    		//setDateDefaults();
    		//generateAttendanceSheet();
    		//loadAttendance();
    		
    	});

    	
    	function generateMonthsDropdown(){
    		//loadStudents();
    		var months = attOpts.monthYearList;
    		flags.wrap.find('.mY').empty();
    		$(months).each(function( ind,my ) {
    			
    			var m = my.split('_');
    			var mn = parseInt(m[0]);
    			var yr = parseInt(m[1]);
    			var selc = '';
    			if(mn===(attOpts.today.getMonth()+1)){
    				selc = 'selected=true';
    			}
    			flags.wrap.find('.mY').append('<option value="'+mn+'_'+yr+'" '+selc+'>'+attOpts.monthsNames[mn-1]+" "+yr+'</option>');
    		});
    	}
    	
    	function generateAttendanceSheet(){
    		setDateDefaults();
    		
    		var tbl =$('<table/>',{
				 id:'sectionsTable'
			 }).attr('class','attTable dataTable');
    		
    		insertDays(tbl);
    		insertStudentAttendance(tbl);
    		flags.wrap.append(tbl);
    	}
    	
    	
    	function insertStudentAttendance(tbl){
    		
    		createEmptyTdsForStudents(tbl);
    		createActionDropDowns(tbl);
    	}
    	
    	function createEmptyTdsForStudents(tbl){
    		//var students = attOpts.students;
    		
    		var students = flags.studentsJson;
    		$(students).each(function( index,std ) {
    			
    			var tr =$('<tr/>',{
	   				 class:'student',
	   				 id:std.id
	   			 });
    			tr.append('<td class="rollno">'+std.adminssionNo+'</td><td class="stname">'+std.name+'</td>');
    			var day = attOpts.today.getDate();
    			var dt = attOpts.date;
    			for(var i=1;i<=attOpts.daysOnTheMonth;i++){
    				var stid = $(this).id;
    				var dayClass = "";
    				var hdy = "";
    				var tod = false;
    				var attDayName;
    				if (day > 0 && i === day && dt.getFullYear() === attOpts.today.getFullYear() && dt.getMonth()===attOpts.today.getMonth()) {
    					dayClass = "today";
    					tod = true;
    				}
    				
    				if((jQuery.inArray(i, attOpts.thismonthHolidayList)!=-1)||(jQuery.inArray(i, attOpts.sun)!=-1)||(jQuery.inArray(i, attOpts.sat)!=-1)){
    					hdy = "holiday";
    				}
    				tr.append('<td class="tdcheck '+dayClass+' '+hdy+'  col'+i+'" id="td_'+std.id+'_'+i+'"></td>');
    			}
    			tbl.append(tr);
    		});
    	}
    	
function createActionDropDowns(tbl){
    		
    		//var students = attOpts.students;
	var students = flags.studentsJson;
    			var tr =$('<tr/>',{
	   				 class:'actionrow',
	   				 id:''
	   			 });
    			tr.append('<td class="actions" colspan="2" >Actions</td>');
    			
    			var day = attOpts.today.getDate();
    			var maxAllowedDay = getMaxAllowedDay();
    			var dt = attOpts.date;
    		//	for(var i=1;i<=attOpts.daysOnTheMonth;i++){
    			for(var i=1;i<=maxAllowedDay;i++){
    				var stid = $(this).id;
    				var dayClass = "";
    				var hdy = "";
    				var tod = false;
    				var attDayName;
    				if (day > 0 && i === day && dt.getFullYear() === attOpts.today.getFullYear() && dt.getMonth()===attOpts.today.getMonth()) {
    					dayClass = "today";
    					tod = true;
    				}
    				
    				if((jQuery.inArray(i, attOpts.thismonthHolidayList)!=-1)||(jQuery.inArray(i, attOpts.sun)!=-1)||(jQuery.inArray(i, attOpts.sat)!=-1)){
    					hdy = "holiday";
    				}
    				var actionHtml = '<td><nav><a class="dropdown-toggle insert_vert" href="#" title="Menu"><span class="icon-uniF419" ></span></a>'+
    				'<ul class="dropdown"> <li class="addedit_dd"  id="addedit_'+i+'_V">Add/Edit</li>'+
    				  '<li class="save_dd" id="save_'+i+'_V" ><a >Save</a></li><li class="cancel_dd"  id="cancel_'+i+'_V"><a >Cancel</a></li></ul></nav></td>';
    				  $(tr).append(actionHtml);
    				  
    			}
    			tbl.append(tr);
    	}
    	
    	function insertDays(tbl){
    		var tr =$('<tr/>',{
				 class:'attheader dates',
				 id:''
			 });
    		tr.append('<td colspan="1"><td>');
    		var dt = attOpts.date;
    		
    		var day = attOpts.today.getDate();
    		var weekDay = dt.getDay(); 
    		for (var dayCount = 1; dayCount <= attOpts.daysOnTheMonth; dayCount++) {
					var dayClass = "";
					var hdy = "";
					var tod = false;
					var attDayName;
					if (day > 0 && dayCount === day && dt.getFullYear() === attOpts.today.getFullYear() && dt.getMonth()===attOpts.today.getMonth()) {
						dayClass = "today";
						tod = true;
					}
					if((jQuery.inArray(dayCount, attOpts.thismonthHolidayList)!=-1)||(jQuery.inArray(dayCount, attOpts.sun)!=-1)||(jQuery.inArray(dayCount, attOpts.sat)!=-1)){
						hdy = "holiday";
					}
					attDayName = attOpts.dayNames[((dayCount+weekDay-1)%7)];
					tr.append('<td id="day_' + dayCount + '" rel="'+dayCount+'" class="attendance-day '+dayClass+' '+hdy+'"><div class="attDayName">'+attDayName+'</div><div class="attDay">'+dayCount+'</div></td>');
			}
    		tbl.append(tr);
    		
    	}
    	


/*flags.wrap.find('.save_dd').click(function(){
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
	    url: attOpts.path+'/admin/manageClass/saveAttendance.htm', //the name and location of your php file
	    data: myString,      //add the converted json string to a document.
        async: false,    //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
        cache: false,    //This will force requested pages not to be cached by the browser  
        processData:false,
	    success: function(data) {
	    	if(data.success){
				 $("#message_label").html('<div class="alert alert-success">'+data.message+'</div>').fadeIn().delay(5000).fadeOut();
			 }
			 else{
				 $("#mesage_label").html('<div class="alert alert-error">'+data.message+'</div>').fadeIn().delay(5000).fadeOut();
					
			 }
		} //just to make sure it got to this point.
	 });
	 return false;
	
	});*/

    	
    	$(document).on('click','.addedit_dd',function(e){
    		var id = $(this).attr("id");
			var d = id.split('_');
				var type =d[2];
		 		var col = parseInt(d[1]);
				 $( ".col"+col ).each(function( index ) {
					 var elm = $(this).attr("id");
					 var elmid = elm.split('_');
					 var stid = elmid[1];
					 var atid = elmid[2];
					 if ($(this).is(':empty')){
						 var htm ='<input type="checkbox" class="attelement" id="'+stid+'_'+atid+'"  />';
						 $('#td_'+stid+'_'+atid).html((htm));
						}
					 else{
						$(this).find('input[type=checkbox]').attr("disabled",false);
					 }
				 });
				 $(this).hide();
				 $(this).siblings(".save_dd").show();
    		});
    	
    $(document).on('click','.save_dd',function(e){
    		var id = $(this).attr("id");
			var d = id.split('_');
		 var col = parseInt(d[1]);
		 var temp="";
		 var temp2="";
		 var type =d[2];
		 var subid = attOpts.subjectId;
		 var data = {sts: [],subid:subid};
		 
		 $( ".col"+col ).each(function( index ) {
					var elm = $(this).attr("id");
					 var elmid = elm.split('_');
					 var stid = parseInt(elmid[1]);
					 
					 var atid = parseInt(elmid[2]);
					 $(stid+'_'+atid).attr("disabled", true);
					 if(atid===col){

						 if ($(this).is(':empty')){
							//alert("empty"); //do nothing
							}
						 else{
							 if($("#"+stid+"_"+atid).is(':checked')){
									data.sts.push(
										    {studentId: stid, attdate: atid, present: 1,subjectId:subid,year:attOpts.year,month:attOpts.date.getMonth()+1}
										);
								}
								else{
									data.sts.push(
											{studentId: stid, attdate: atid, present: 0,subjectId:subid,year:attOpts.year,month:attOpts.date.getMonth()+1}
										);
								} 
						 }
					 }
					 $(this).find('input[type=checkbox]').attr("disabled",true);
			 });
		 $(".dropdown").hide();
		 $(this).hide();
		 $(this).siblings(".addedit_dd").show();
		 
    		 var myString = JSON.stringify(data.sts);  //converts json to string and prepends the POST variable name
    		 saveAttendance(myString);
			 return false;
			
			});
    	 
   	 function saveAttendance(myString){
   		 
   		 $.ajax({
			    type: "POST",
			    url: attOpts.path+'/admin/manageClass/saveAttendance.htm', //the name and location of your php file
			    data: myString,      //add the converted json string to a document.
	            async: false,    //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
	            cache: false,    //This will force requested pages not to be cached by the browser  
	            processData:false,
			    success: function(data) {
			    	attendanceMessage(data);
										} //just to make sure it got to this point.
			 });
   	 }
       
   	 
	 function attendanceMessage(data){
		 
		 if(data.success){
			 flags.wrap.find(".mesage_label").html('<div class="alert alert-success">'+data.message+'</div>').fadeIn().delay(5000).fadeOut();
		 }
		 else{
			 flags.wrap.find(".mesage_label").html('<div class="alert alert-error">'+data.message+'</div>').fadeIn().delay(5000).fadeOut();
				
		 }
	 }
    	
    	 $(document).on('click','.insert_vert',function(e){
     		$('.dropdown').hide();
			 $("nav").css( "background-color", "#FFF" );
			 $(this).parent().css( "background-color", "#E9EDFF" );
			 $(this).next('.dropdown').toggle();
			 e.preventDefault();
   		});
    	 
    	/*flags.wrap.find('.actionrow').on('click','.insert_vert',function(e){
    		$('.dropdown').hide();
			 $("nav").css( "background-color", "#FFF" );
			 $(this).parent().css( "background-color", "#E9EDFF" );
			 $(this).next('.dropdown').toggle();
			 e.preventDefault();
    		});*/
    	
    	$(document).click(function(e) {
  		  var target = e.target;
  		  if (!$(target).is('.insert_vert') && !$(target).parents().is('.insert_vert')) {
  			 // $('.dropdown-toggle').removeClass("active");
  			  $("nav").css( "background-color", "#FFF" );
  			  $('.dropdown').hide();
  		  }
  		});
    	
    	 $(document).on('click','#loadAt',function(e){
    		 flags.wrap.find('.attTable').remove();
     		generateAttendanceSheet();
     		loadAttendance();
    		 
    	 });
    	 
    	flags.wrap.find('.monthDropdown').on('change','.mY',function(e){

    		var d = $(this).val().split('_'); 
    		var mn = parseInt(d[0]);
    		var yr = parseInt(d[1]);
    		attOpts.date =new Date(yr,mn-1);
    		attOpts.date.setDate( 01);
    		attOpts.year = yr;
    		reloadSheet();
    		
    		});
    	function reloadSheet(){
    		flags.wrap.find('.attTable').remove();
    		generateAttendanceSheet();
    		loadAttendance();
    		/*var tl = flags.wrap.find('.attMonth');
    		tl.empty();
    		tl.html(attOpts.monthsNames[attOpts.month]);*/
    	}
    	
    	function setDateDefaults(){
    		if(null == attOpts.date|| 'null' ==attOpts.date){
    			attOpts.date =new Date();
    			attOpts.date.setDate( 01);
    		}
    		var dt=attOpts.date;
    		//dt.setDate(01);
    		attOpts.weekDay = dt.getDay();
    		attOpts.month=dt.getMonth();
    		attOpts.year=dt.getFullYear();
    		//attOpts.getTot = daysInMonth(dt);
    		attOpts.daysOnTheMonth = daysOnMonth(dt);
    		attOpts.sat = [];
    		attOpts.sun = [];
    		//flags.wrap.find('.attMonth').empty().html(attOpts.monthsNames[attOpts.month]);
    		flags.wrap.find('.mY option[value="'+attOpts.month+1+"_"+attOpts.year+'"]').attr("selected",true);
    		
    		for(var i=1;i<=attOpts.daysOnTheMonth;i++){    
    			//looping through days in month
    		    var newDate = new Date(dt.getFullYear(),dt.getMonth(),i);
    		    if(newDate.getDay()==0){   //if Sunday
    		    	attOpts.sat.push(i);
    		    }
    		    if(newDate.getDay()==6){   //if Saturday
    		    	attOpts.sun.push(i);
    		    }
    		}
    		
    	}
    	

    	function loadStudents(){
    		 var classId = attOpts.classId;
    		 var students = [];
    		 $.getJSON(attOpts.path+'/students/getStudents.htm?c='+classId, function(data) {
    			 $.each(data, function(ind,s) {
    					students.push(
    						    {id: s.studentId, name: s.firstName+","+s.lastName, rollNumber: s.rollNumber,adminssionNo:s.admNum}
    						);
    					});
    			 
 				flags.studentsJson = students; // save data to future filters
 			}).error(function() {
 				showError("error getting json: ");
 			});
    	}
    	function showError(msg) {
    		//flags.wrap.find('.ecalendar-list-wrap').html("<span class='ecalendar-loading error'>"+msg+" " +eventsOpts.eventsjson+"</span>");
    	}
    	function loadAttendance(){
    		
    				var subid = attOpts.subjectId;
    				var dt = attOpts.date;
    				var month = dt.getMonth()+1;
    				var year = attOpts.year;
    				
    				$.get(attOpts.path+'/admin/manageClass/getAttendance.htm?b='+subid+'&y='+year+'&m='+month, function( data ) {
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
    							 var htm ='<input type="checkbox" class="attelement" '+check+' id="'+s.studentId+'_'+atd+'" disabled="true"/>';
    							$('#td_'+s.studentId+'_'+atd).html((htm));
    					});
    				});	
    		
    	}
    	
    	function getStudentsList(){
    		
    		//load students and add to 
    	}
    	
    	function getMonthYearList(){
    		
    		//load month year list using class id  
    	}
    	
    	function daysInMonth(date){
    		return new Date(date.getMonth(),date.getFullYear(), 0).getDate();
    	}
    	
    	function daysOnMonth(date){
    		return 32 - new Date(date.getFullYear(), date.getMonth(), 32).getDate();
    	}
    	
    	function getMaxAllowedDay(){
    		
    		
    		var now = new Date();
    		
    		if (attOpts.date< now) {
    			
    			if(attOpts.date.getMonth() === now.getMonth()){
    				return attOpts.today.getDate();
    			}
    			
    			return daysOnMonth(attOpts.date);
			}
    		else if(attOpts.date = now && (attOpts.date.getMonth = now.getMonth())){
    			return attOpts.date.getDate()+1;
    		}
    		else{
    			return 0;
    		}
    	}
    };
 
}( jQuery ));

$.fn.attendance.defaults = {
		month: null,
        year: null,
        date: null,
        yearMonth:"",
        dayNames : ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
        weekDay:null,
        getTot:0,
        path:'',
        sat:new Array(),    //Declaring array for inserting Sundays
        sun: new Array(),   //Declaring array for inserting Sundays
        daysOnTheMonth:null,
        today:new Date(),
        students :new Array(),//JSON.stringify({students: []},
       // thismonthHolidayList:[7,14,21,28],
        classId:null,
        subjectId:null,
        monthsNames : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        monthYearList:['04_2014','05_2014','06_2014','07_2014','08_2014','09_2014','10_2014','11_2014','12_2014','01_2015','02_2015','03_2015']
};