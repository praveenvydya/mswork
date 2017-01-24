(function ( $ ) {
 
    $.fn.marks = function( options ) {
 
    	var marksOpts = $.extend({}, $.fn.marks.defaults, options);
 
    	var flags = {
    			wrap: "",
    			studentsJson:[],
    			subjectsJson:[],
    			examsJson:[],
    			errorList:[],
    			exportTable:"",
    			tls:[]
    		};
    	
    	this.each(function(){
    		
    		flags.wrap = $(this);
    		//flags.exportTable = $(this);
    		//flags.wrap.addClass('marks-wrap').append("<div class='marks-list-wrap'><p class='marks-subtitle'></p><span class='marks-loading'></span><div class='marks-list-content'><ul class='marks-list'></ul></div></div>");
    		var title =	'<div class="examsTitle"><div class="examsDropdown tl">'+
    			'<select name="exams" class="exmS"></select> </div><div class="tl"><input type="button" value="Load" id="loadMarks" class="cms-btn" /></div>'+
    			'<div class="tl"><input type="button" value="Report" id="getReport" style="display:none" class="cms-btn" /></div><div class="mesage_label tl"></div>'+
    			'<div class="fR"><input type="button" value="Export" id="exportExel" disabled="true" class="cms-btn" /></div>'+
    			'<div class="fR"><input type="button" value="Export All" id="exportAll" disabled="true" class="cms-btn" /></div>'+
    			'</div><div class="mTbl"></div><div class="pie"></div>';//<div class="attMonth"> </div>
    		flags.wrap.addClass('marks-wrap').append(title);
    		generateExamsDropdown();
    		setDateDefaults();
    		loadData();
    		 getMarks();
    		 
    		//generatemarksSheet();
    		//getMarks();
    		
    	});

    	function loadData(){
    		
    	var classId = marksOpts.classId;
    		//var classId = marksOpts.classId;
   		 var subjects = [];
   		  $.getJSON(marksOpts.path+'/students/getSubjects.htm?c='+classId, function(data) {
   			 $.each(data, function(ind,sj) {
   				subjects.push(
   						    {id: sj.id, name: sj.subjectName, max: sj.totalMarks}
   						);
   					});
   			 
   			flags.subjectsJson = subjects; // save data to future filters
			}).error(function() {
				showError("error getting json: ");
			});
   		 
   		var students = [];
		 $.getJSON(marksOpts.path+'/students/getStudents.htm?c='+classId, function(data) {
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

    	function generateExamsDropdown(){
    		//loadStudents();
    		flags.examsJson = marksOpts.exams;
    		flags.wrap.find('.exmS').empty();
    		var exms = flags.examsJson;
    		$(exms).each(function( ind,ex ) {
    			
    			flags.wrap.find('.exmS').append('<option value="'+ex.id+'">'+ex.name+'</option>');
    		});
    	}
    	
    	function generatemarksSheet(){
    		setDateDefaults();
    		
    		var tbl =$('<table/>').attr('class','marksTable').attr('id','sectionsTable');
    		
    		insertSubjects(tbl);
    		insertStudentmarks(tbl);
    		flags.wrap.find('.mTbl').append(tbl);
    	}
    	
    	
    	function insertStudentmarks(tbl){
    		
    		createEmptyTdsForStudents(tbl);
    		createActionDropDowns(tbl);
    	}
    	
    	function createEmptyTdsForStudents(tbl){
    		//var students = marksOpts.students;
    		var examId = marksOpts.currentExam;
    		var students = flags.studentsJson;
    		var subjs =flags.subjectsJson;
    		$(students).each(function( index,std ) {
    			
    			var tr =$('<tr/>',{
	   				 id:std.id
	   			 }).attr('class','student');
    			tr.append('<td class="rollno" width="10%">'+std.adminssionNo+'</td><td class="stname"><b>'+std.name+'</b></td>');
    			
				$(subjs).each(function(ind,sub){
									
						tr.append('<td id="jes_'+sub.id+'_'+examId+'_'+std.id+'" rel=" " class="td_marks-subject col'+sub.id+' row'+std.id+'"></td>');
				});
				var actionHtml = '<td  class="actBt"><nav><a class="dropdown-toggle insert_horz"  title="Menu"><span class="icon-uniF419" ></span></a>'+
				'<ul class="dropdown"> <li class="addedit_dd"  id="addedit_'+std.id+'_H">Add/Edit</li>'+
				  '<li class="save_dd" id="save_'+std.id+'_H" ><a >Save</a></li><li class="cancel_dd"  id="cancel_'+std.id+'_H"><a >Cancel</a></li></ul></nav></td>';
				  tr.append(actionHtml);
				  tr.append('<td class="tl_st" id="tl_'+std.id+'"></td>');
				tbl.append(tr);
    			});
    	}
    	
function createActionDropDowns(tbl){
    		
    		//var students = marksOpts.students;
			//var students = flags.studentsJson;
			var subjs =flags.subjectsJson;
    			var tr =$('<tr/>',{
	   				 id:''
	   			 }).attr('class','actionrow');
    			tr.append('<td class="actions" colspan="2" >Actions</td>');
    			
    			$(subjs).each(function(ind,sub){
					
					//tr.append('<td id="stm_'+sub.id+'_'+examId+'_'+std.id+'" rel=" " class="td_marks-subject"></td>');
    				var actionHtml = '<td class="actBt"><nav><a class="dropdown-toggle insert_vert"  title="Menu"><span class="icon-uniF419" ></span></a>'+
    				'<ul class="dropdown"> <li class="addedit_dd"  id="addedit_'+sub.id+'_V">Add/Edit</li>'+
    				  '<li class="save_dd" id="save_'+sub.id+'_V" ><a >Save</a></li><li class="cancel_dd"  id="cancel_'+sub.id+'_V"><a >Cancel</a></li></ul></nav></td>';
    				  $(tr).append(actionHtml);
    				  
    			});
    			tr.append('<td></td>');
    			tbl.append(tr);
    	}
    	
    	
   		function insertSubjects(tbl){
    		var tr =$('<tr/>',{
				 id:''
			 }).attr('class','subheader subjs');
    		tr.append('<td colspan="1"><td>');
    		var subjs  =flags.subjectsJson;
    		var tot = 0;
    		$(subjs).each(function(ind,s){
					tr.append('<td id="s_'+s.id+'" rel=" " class="marks-subject"><div class="attDayName">'+s.name+'</div></td>');
					tot= tot+s.max;
			});
    		tr.append('<td class="marks-subject"></td>');
    		tr.append('<td class="marks-subject">Total ('+tot+')</td>');
    		tbl.append(tr);
    		
    	}
    	

   		$(document).on('click','.addedit_dd',function(e){
   		//flags.wrap.find('.addedit_dd').click(function(e){
    		var id = $(this).attr("id");
			var d = id.split('_');
				var type =d[2];
				
		 		
		 		if(type=="V"){
		 			var col = parseInt(d[1]);
		 			$( ".col"+col ).each(function( index ) {
						 var elm = $(this).attr("id");
						 var elmid = elm.split('_');
						 var subjId = elmid[1];
						 var exmId = elmid[2];//jes_1_1_2
						 var stuId = elmid[3];
						 if ($(this).is(':empty')){
							 var htm =$('<input type="text" class="stMark" value=""/>').keypress(function(event){
					    	       if(event.which != 8 && isNaN(String.fromCharCode(event.which))){
					    	           event.preventDefault(); //stop character from entering input
					    	       }
					    	   });
							 $(this).append((htm));//'<input type="text" class="" value="'+m.marks+'"/>'
							}
						 else{
							$(this).find('input[type=text]').attr("disabled",false);
						 }
					 });
		 		}
		 		else if(type=="H"){
		 			var row = parseInt(d[1]);
		 			$( ".row"+row ).each(function( index ) {
						 var elm = $(this).attr("id");
						 var elmid = elm.split('_');
						 var subjId = parseInt(elmid[1]);
						 var exmId = parseInt(elmid[2]);//jes_1_1_2
						 var stuId = parseInt(elmid[3]);
						 if ($(this).is(':empty')){
							 var htm =$('<input type="text" class="stMark" value=""/>').keypress(function(event){
					    	       if(event.which != 8 && isNaN(String.fromCharCode(event.which))){
					    	           event.preventDefault(); //stop character from entering input
					    	       }
					    	   });
							 $(this).append((htm));//'<input type="text" class="" value="'+m.marks+'"/>'
							}
						 else{
							$(this).find('input[type=text]').attr("disabled",false);
						 }
					 });
		 			
		 		}
				 $(this).hide();
				 $(this).siblings(".save_dd").show();
    		});
    	
    	
   		flags.wrap.find('#loadMarks').click(function(e){
    		// flags.wrap.find('.marksTable').remove();
   			$(this).attr('disabled',true);
   			flags.wrap.find('.mTbl').empty();
    		// generatemarksSheet();
    		 reloadSheet();
    		 //getMarks();
    		 setMarks();
    		 $("#getReport").show();
    		 loadTotals();
    		 $(this).attr('disabled',false);
    		 generateStatistics();
    	 });
   		
			$(document).on('click','.save_dd',function(e){
   		//flags.wrap.find('.save_dd').click(function(e){
    		var id = $(this).attr("id");
			var d = id.split('_');
		 var data = {marks: []};
				var type =d[2];
				marksOpts.inProgress = true;
		 		if(type=="V"){
		 			var col = parseInt(d[1]);

		 			$( ".col"+col ).each(function( index ) {
		 				
						 var elm = $(this).attr("id");
						 var elmid = elm.split('_');
						 var subjId = parseInt(elmid[1]);
						 var exmId = parseInt(elmid[2]);// jes_1_1_2
						 var stuId = parseInt(elmid[3]);
						var ths = $(this);
						 if ($(this).is(':empty')){
								// alert("empty"); //do nothing
								}
							 else{
								 var marks = $(this).find('input[type=text]').val();
									  // $(this).find('input[type=text]').attr("disabled",true);
									   if(marks.length>0){
											data.marks.push({studentId: stuId, examId: exmId, subjectId: subjId,marks:marks});
											}
											else{
												data.marks.push({studentId: stuId, examId: exmId, subjectId: subjId,marks:0});
											} 
							 }
							
						 });
		 		}
		 		else{
		 			var row = parseInt(d[1]);
		 			$( ".row"+row ).each(function( index ) {
						 var elm = $(this).attr("id");
						 var elmid = elm.split('_');
						 var subjId = parseInt(elmid[1]);
						 var exmId = parseInt(elmid[2]);// jes_1_1_2
						 var stuId = parseInt(elmid[3]);
						 if ($(this).is(':empty')){
								// alert("empty"); //do nothing
								}
							 else{
								 var marks = $(this).find('input[type=text]').val();
								 if(marks.length>0){
									data.marks.push({studentId: stuId, examId: exmId, subjectId: subjId,marks:marks});
									}
									else{
										data.marks.push({studentId: stuId, examId: exmId, subjectId: subjId,marks:0});
									} 
							 }
						 });
		 			}
		 if(flags.errorList.length==0){
			 $(".dropdown").hide();
			 $(this).hide();
			 $(this).siblings(".addedit_dd").show();
			 var myString = JSON.stringify(data.marks);  // converts json to
	    	savemarks(myString,type,parseInt(d[1]));
			 return false; 
		 }		
		
		});
    	 
   	 function savemarks(myString,type,rc){
   		 if(type=="V"){
			 var col = rc;
	 			$( ".col"+col ).each(function( index ) {
	 				$(this).prepend('<div class="loader"></div>')
	 			}) ;
		 }
		 else{
			 var row = rc;
	 			$( ".row"+row ).each(function( index ) {
	 				$(this).prepend('<div class="loader"></div>')
	 			});
		 }
   		 $.ajax({
			    type: "POST",
			    url: marksOpts.path+'/admin/manageMarks/update.htm', //the name and location of your php file
			    data: myString,      //add the converted json string to a document.
	            async: false,    //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
	            cache: false,    //This will force requested pages not to be cached by the browser  
	            processData:false,
			    success: function(data) {
			    	if(type=="V"){
						 var col = rc;
						 $(".col"+col).find('.loader').remove();
						 $(".col"+col).find('input[type=text]').attr("disabled",true);
					 }
					 else{
						 var row = rc;
						 $(".row"+row).find('.loader').remove();
						 $(".row"+row).find('input[type=text]').attr("disabled",true);
					 }
			    	marksMessage(data);
			    	getMarks();
			    	loadTotals();
			    	marksOpts.inProgress = false;
			    	//generateStatistics();
										} //just to make sure it got to this point.
			 });
   	 }
   	$(document).on('blur','.stMark',function(e){

   		var elm = $(this).parent().attr('id');
		 var elmid = elm.split('_');
		 var subjId = parseInt(elmid[1]);
		 var exmId = parseInt(elmid[2]);// jes_1_1_2
		 var stuId = parseInt(elmid[3]);
		 
		 var subjs = flags.subjectsJson;
		var studs = flags.studentsJson;
		var maxM = null;var stName = null;sjName = null;
		$(subjs).each(function(index, j) {
			if (j.id === subjId) {
				maxM = j.max;
				sjName = j.name;
				return false;
			}
		});
		$(studs).each(function(index, std) {
			if (std.id === stuId) {
				stName = std.name;
				return false;
			}
		});
		
		 if($(this).val()>maxM){
			 var error = '<div class="alert alert-error">Marks entered for <b>'+stName+'</b> cannot be greater than <b>'+maxM+'</b> in <b>'+sjName+'</b></div>';
			// flags.wrap.find(".mesage_label").html(error);
			 $(this).addClass('error');
			 marksOpts.formValid=false;
			 if(!$.findFromArray('name', elm, flags.errorList) )
				 {
				 flags.errorList.push({
						message: error,
						name: elm
					});
				 }
			 showErrors();
			 return false;
		 }
		 else{
			 marksOpts.formValid=true;
			 //flags.wrap.find(".mesage_label").empty();
			 flags.errorList = $.grep( flags.errorList, function( error ) {
					//return !(error.name in elm);
					 return error.name != elm;
				});
			 $(this).removeClass('error');
		 }
		 showErrors();
		 return true; 
   	});
   	
    function showErrors(){
    	var errors = flags.errorList;
    	flags.wrap.find(".mesage_label").empty().show();
    	$(errors).each(function(ind,e){
    		flags.wrap.find(".mesage_label").append(e.message);
    	});
    	 
    }
   	$.findFromArray = function(property, value, arr)
   	{
   	    var matching = $(arr).filter(function(index, elem)
   	    {
   	        return elem[property] === value;
   	    }); 
   	    return matching.length > 0;
   	};
   	
	 function marksMessage(data){
		 
		 if(data.success){
			 flags.wrap.find(".mesage_label").html('<div class="alert alert-success">'+data.message+'</div>').fadeIn().delay(5000).fadeOut();
		 }
		 else{
			 flags.wrap.find(".mesage_label").html('<div class="alert alert-error">'+data.message+'</div>').fadeIn().delay(5000).fadeOut();
				
		 }
	 }
    	
	// $('.dropdown-toggle').click(function(e){
		 $(document).on('click','.dropdown-toggle',function(e){
    		 if(!marksOpts.inProgress){
    			 $('.dropdown').hide();
    			 //$("nav").css( "background-color", "#FFF" );
    			 $(this).parent().css( "background-color", "#E9EDFF" );
    			 $(this).next('.dropdown').toggle();
    			 e.preventDefault(); 
    		 }
     		
   		});
    	 
    	/* 
    	 $(document).on('click','.insert_horz',function(e){
      		$('.dropdown').hide();
 			 $("nav").css( "background-color", "#FFF" );
 			 $(this).parent().css( "background-color", "#E9EDFF" );
 			 $(this).next('.dropdown').toggle();
 			 e.preventDefault();
    		});*/
    	 
    	/* $('.td_marks-subject input[type=text]').keypress(function(event){

    	       if(event.which != 8 && isNaN(String.fromCharCode(event.which))){
    	           event.preventDefault(); //stop character from entering input
    	       }

    	   });*/
    	 
    	$(document).click(function(e) {
  		  var target = e.target;
  		  if (!$(target).is('.dropdown-toggle') && (!$(target).parents().is('.insert_vert')||!$(target).parents().is('.insert_horz'))) {
  			 // $('.dropdown-toggle').removeClass("active");
  			  $("nav").css( "background-color", "#FFF" );
  			 // $('.dropdown').hide();
  		  }
  		});
    	
    	flags.wrap.find('.examsDropdown .exmS').change(function(e){
    		$('#loadMarks').attr('disabled',true);
    		var examId = parseInt($(this).val()); 
    		marksOpts.currentExam = examId;
    		getMarks();
    		reloadSheet();
    		$('#loadMarks').attr('disabled',false);
    		});
    	function reloadSheet(){
    		//flags.wrap.find('.marksTable').remove();
    		// flags.wrap.find('.dataReportTable').remove();
    		flags.wrap.find('.mTbl').empty();
    		generatemarksSheet();
    		//setMarks();
    		
    	}
    	
    	function setDateDefaults(){
    		marksOpts.currentExam = parseInt(flags.wrap.find(".exmS").val());
    		marksOpts.currentExamName = flags.wrap.find('.examsDropdown option:selected').text();	
    	}
    	

    	
    	function showError(msg) {
    		//flags.wrap.find('.ecalendar-list-wrap').html("<span class='ecalendar-loading error'>"+msg+" " +eventsOpts.eventsjson+"</span>");
    	}
    	function getMarks(){
     		  $.getJSON(marksOpts.path+'/studentClass/getMarks.htm?c='+marksOpts.classId+'&x='+marksOpts.currentExam, function(data) {
     			  flags.marksData = [];
     			  flags.marksData = data;
     			 
  			}).error(function() {
  				showError("error getting json: ");
  			});
    	}
    	
    	function setMarks(){
    		var  data=flags.marksData;
    		 $.each(data, function(ind,m) {
  				flags.wrap.find('#jes_'+m.subjectId+'_'+m.examId+'_'+m.studentId).append('<input type="text" class="stMark" value="'+m.marks+'" disabled ="true"/>').keypress(function(event){

			    	       if(event.which != 8 && isNaN(String.fromCharCode(event.which))){
			    	           event.preventDefault(); //stop character from entering input
			    	       }

			    	   });
  					});
    	}
    	function loadTotals(){
    		$(".tl_st").each(function(){
    			var d = $(this).attr('id');
    			var st = parseInt(d.split('_')[1]);
    			var sujs = flags.subjectsJson;
    			var xm =marksOpts.currentExam;
    			var mks = 0;
    			var total =0;
    			$(sujs).each(function(ind,s){
    				var m = parseInt(flags.wrap.find('#jes_'+s.id+'_'+xm+'_'+st).find('input[type=text]').val());
    				if(m){
    					mks = mks+ m;
    				}
    				else{
    					mks = mks+0;
    				}
    				total = total+s.max;
    			});
    			var pc =(mks*100/total).toFixed(1);
    			$(this).html(mks+'('+pc+'%)');
    			flags.tls.push(pc);
    		});
    	}
    	
    	
    	flags.wrap.find('#getReport').click(function(e){
    		flags.wrap.find('.mTbl').empty();
			
       		generateReport();
			flags.wrap.find('#exportExel').attr('disabled',false);
			flags.wrap.find('#exportAll').attr('disabled',false);
       	 });
    	
		flags.wrap.find('#exportAll').click(function(e){
			var tbl = flags.exportTable;
    		$(tbl).table2excel({
					exclude: ".noExl",
    				//name: "Excel Document Name"
					name: marksOpts.className+"_"+marksOpts.currentExamName+"_AllStudentsMarks"
				});
    		$(this).attr('disabled',true);
       	 });
		
		flags.wrap.find('#exportExel').click(function(e){
			var tbl = flags.exportTable;
			flags.wrap.find('#dataReportTable').table2excel({
					exclude: ".noExl",
					name: marksOpts.className+"_"+marksOpts.currentExamName+"_Marks"
				});
			$(this).attr('disabled',true);
       	 });
		
function generateStatistics(){
			
			flags.wrap.find('.pie').empty();
			var t =$('<table/>').attr('class','setCheck').attr('id','');
			
			var r1 = $('<tr>');
			var r2 = $('<tr>');
			
			$(r1).append('<td><input type="checkbox" name="pieChecks" class="pieChecks" value="0" disabled="true"/></td>');
			$(r2).append('<td><div> 0% </div></td>');
    		for(i=1;i<10;i++){
    			
    			$(r1).append('<td><input type="checkbox" name="pieChecks" class="pieChecks" value="'+i+'0"/>  </td>');
    			$(r2).append('<td><div>'+i+"0%"+'</div></td>')
    		}
    		
    		$(r1).append('<td><input type="checkbox" name="pieChecks" class="pieChecks" value="100" disabled="true"/></td>');
			$(r2).append('<td><div>100%</div></td>');
			
    		$(t).append(r1);
    		
    		$(t).append(r2);
    		flags.wrap.find('.pie').append(t);
    		
    		var pieDiv =$('<div/>').attr('class','pieSet').attr('id','placeholder').css('position','relative').css('padding','0px');//style="padding: 0px; position: relative;"
			
    		flags.wrap.find('.pie').append(pieDiv);
    		
    		flags.wrap.find('.pieChecks').click(function(e){
    			var da =[];
    			var checks = [];
    			checks.push(0);
    			$('.setCheck input:checked').each(function() {
    				checks.push($(this).val());
    	        });
    			checks.push(100);
    			//var c ="";
    			var start=null;
    			$(checks).each(function(i,v){
    				//c = c+v+'-';
    				if(v==0){
    					start=v;
    				}
    				else{	
    					var s = start;
    					var e =v;
    					var tls = flags.tls;
    					var tl = 0;
    					$(tls).each(function(ind,vl){
    						if(vl>s &&vl<=e){
    							tl=tl+1;
    						}
    					});
    					
    					da.push({
							label: "Between " +s+" and "+e +' ('+tl+')',
							data: tl
						});
    					start = v;
    					//alert( "between "+ s +" and "+e + " is "+ tl);
    				}
    			});
    			
    			var placeholder = flags.wrap.find("#placeholder");
    				placeholder.unbind();
    				//$("#title").text("Default pie chart");
    				//$("#description").text("The default pie chart with no options set.");
    				$.plot(placeholder, da, {
    					series: {
    						pie: { 
    							innerRadius: 0.5,
    							show: true,
    							radius: 1,
    							label: {
    								show: true,
    								radius: 2/3,
    								formatter: labelFormatter,
    								threshold: 0.1
    							}
    						}
    					},
    					legend: {
    						show: true
    					}
    				});
           	 });
		}
		
		
		function labelFormatter(label, series) {
			return "<div style='font-size:8pt; text-align:center; padding:2px; color:white;'>" + label + "<br/>" + Math.round(series.percent) + "%</div>";
		}
		
   	function generateReport(){
   		var tbl =$('<table/>').attr('class',' display').attr('id','dataReportTable');
   		generateReportHead(tbl);
   		genereteReportRows(tbl);
   		
   		flags.wrap.find('.mTbl').append(tbl);
   		loadReportMarks();
   		loadReportTotals();
   		//var newTbl = tbl;
   		flags.exportTable = flags.wrap.find('.mTbl').html();
   		var oTable = $(tbl).dataTable({
			"sPaginationType" : "full_numbers",
			"bJQueryUI" : true,
			"bRetrieve" : true,
			"bAutoWidth": false, // Disable the auto width calculation 
			"columnDefs": [
			               { "width": "10%", "targets": 0 },
			               { "width": "15%", "targets": 1 }
			             ]
			
		/*	"aoColumns": [
			      { "sWidth": "15%" }, // 1st column width 
			      { "sWidth": "25%" }, // 2nd column width 
			      { "sWidth": "10%" } // 3rd column width and so on 
			    ]*/
		});
   		//flags.exportTable = oTable.fnGetData();
   	}
   	
   	function generateReportHead(tbl){
   		
   		var thd =$('<thead/>');
  			var tfoot =$('<tfoot/>').css('display','none');
  			var trf =$('<tr/>');
   		var tr =$('<tr/>',{
				 id:''
			 }).attr('class','subheader subjs');
   		var th1 =$('<th/>').css('width','100px !important').html("Admission No");
		var th2 =$('<th/>').css('width','320px !important').html("Name");		
		tr.append(th1);
		tr.append(th2);
		
   		var subjs  =flags.subjectsJson;
   		var tot =0;
		$(subjs).each(function(ind,s){
				tot = tot+s.max;
					tr.append('<th id="s_'+s.id+'" rel=" " style="" class="marks-subject sorting">'+s.name+'</th>');
					trf.append('<th colspan="1" rowspan="1">'+s.name+'</th>');
			});
   		//tr.append('<th class="marks-subject"></th>');
   		tr.append('<th>Total ('+tot+')</th>');
   		thd.append(tr);
   		tbl.append(thd);
   		
   		//trf.append('<th class="marks-subject"></th>');
   		trf.append('<th style="width:72px">Total ('+tot+')</th>');
   		tfoot.append(trf);
   		//tbl.append(tfoot);
   	}
   	function genereteReportRows(tbl){
   		//var students = marksOpts.students;
   		var examId = marksOpts.currentExam;
   		var students = flags.studentsJson;
   		var subjs =flags.subjectsJson;
   		var tbody =$('<tbody/>');
   		$(students).each(function( index,std ) {
   			
   			var tr =$('<tr/>',{
	   				 id:std.id
	   			 }).attr('class','student');
   			tr.append('<td class="rollno">'+std.adminssionNo+'</td><td class="stname">'+std.name+'</td>');
   			
				$(subjs).each(function(ind,sub){
									
						tr.append('<td id="jes_'+sub.id+'_'+examId+'_'+std.id+'" rel=" " class="td_marks-subject col'+sub.id+' row'+std.id+'"></td>');
				});
				tr.append('<td class="tl_st" id="tl_'+std.id+'"></td>');
				  tbody.append(tr);
   			});
   		tbl.append(tbody);
   	}
   	function loadReportMarks(){
   	 var  data=flags.marksData;
		 $.each(data, function(ind,m) {
			flags.wrap.find('#jes_'+m.subjectId+'_'+m.examId+'_'+m.studentId).append(m.marks);
				});
   	}
   	

	function loadReportTotals(){
		$(".tl_st").each(function(){
			var d = $(this).attr('id');
			var st = parseInt(d.split('_')[1]);
			var sujs = flags.subjectsJson;
			var xm =marksOpts.currentExam;
			var mks = 0;
			var total =0;
			$(sujs).each(function(ind,s){
				var m = parseInt(flags.wrap.find('#jes_'+s.id+'_'+xm+'_'+st).html());
				if(m){
					mks = mks+ m;
				}
				else{
					mks = mks+0;
				}
				total = total+s.max;
			});
			var pc =(mks*100/total).toFixed(1);
			$(this).html(mks+'('+pc+'%)');
			flags.tls.push(pc);
		});
	}
	
    	
    };
 
}( jQuery ));

$.fn.marks.defaults = {
        path:'',
        formValid:false,
        classId:null,
        className:null,
        inProgress:false,
        today:new Date(),
        classId:null,
        exams : [{id:1,name:"Internal"},{id:2,name:"Quaterly"}],
        currentExam:null,
        currentExamName:null
};