(function ( $ ) {
 
    $.fn.atm = function( options ) {
    	var atmOpts = $.extend({}, $.fn.atm.defaults, options);
    	var flags = {
    			wrap: "",
    			classMonths:[],
    			subjects:[],
    			exams:[],
    			errorList:[],
    			holidays:[],
    			atdData:[],
    			marks:[]
    		};
    	
    	this.each(function(){
    		
    		flags.wrap = $(this);
    		var title =	'<div class="fL"><div class="atTabs fR tl"></div><div class="mt"></div><div class="mksTabs fR tl"></div><div class="tm"></div></div>';
			flags.wrap.addClass('atm-wrap').append(title);
			loadData();
    		generateAttTab();
    		loadAttendance();
    		calculateMonthPerc();
			aggr();
			generateMksTab();
			loadMarks();
			aggrM();
    	});
    	
    	function loadData(){
    		var clsid = atmOpts.classId;
    		var stuId = atmOpts.studentId;
    		var params = {
    				cl: clsid,
    				st:stuId
    			};
    		var classMonths = $.getData(atmOpts.path+'/user/studentClass/getMonths.htm?cl='+parseInt(clsid),params);
        	var subts = $.getData(atmOpts.path+'/user/studentClass/getSubjects.htm?cl='+parseInt(clsid),params);
        	flags.classMonths = classMonths;
        	flags.subjects = subts;
        	var stid = atmOpts.studentId;
        	$.each(classMonths, function(ind, atm) {
        		var m=atm.split("-");
    			var year =  parseInt(m[0]);
    			var month = parseInt(m[1]);
    			$.each(subts, function(i, sub) {
    				var pms = {
    	    				b: sub.id,
    	    				s:stid,
    	    				y:year,
    	    				m:month
    	    			};
    				 
    				 var days = [],prt_count=0,abs_count=0,at =false;
    				var atData = $.getData(atmOpts.path+'/user/studentClass/getAttendance.htm?b='+sub.id+'&s='+stid+'&y='+year+'&m='+month,pms);
    				$.each(atData, function(inx, s) {
    					at =true;
						var attdate = s.attdate;
						var attday = attdate.split('/');
						 var atd = parseInt(attday[0]);
						 days.push({
							 day:atd,
							 present:s.present
						 });
						 if(s.present){
							prt_count=prt_count+1;
						 }
						 else{
							 abs_count = abs_count+1;
						 }
				});
    				if (at){
    					flags.atdData.push({
   						 st:stid,
   						 subj:sub.id,
   						 yr:year,
   						 mn:month,
   						 days:days,
   						 abs:abs_count,
   						 pst:prt_count
   					 });
    				}
    			});
        		
        	});
        	var exms = $.getData(atmOpts.path+'/students/getExams.htm?st='+parseInt(stuId),params);
        	flags.exams = exms;
        	
        	var mks = $.getData(atmOpts.path+'/students/getMarks.htm?st='+parseInt(stuId),params);
        	flags.marks =mks;
    	}
    	
    	function generateAttTab(){
    		var tb =$('<div/>',{
  				 class:'tabs'}).attr('id','tbs');
    		var ul =$('<ul/>',{ class:'tabs-list'});
    		var dv =$('<div/>',{ class:'tabBox'}); 
    		var clms = flags.classMonths;
    		
    		$.each(clms, function(ind, atm) {
    			var attDayName;
    			var m=atm.split("-");
    			var year =  parseInt(m[0]);
    			var month = parseInt(m[1]);
    			var dt  = new Date(year, month, 0);
    			var weekDay = dt.getDay();
    			var daysInMonth = dt.getDate();
    			//var currentMonth = atmOpts.monthsNames[new Date().getMonth()];
    			var li =$('<li/>',{ class:(new Date().getMonth()===month)?'current':''}).append('<a href=""><div >'+atmOpts.monthsNames[month-1]+'</div><div>'+year+'</div></a>');
    			var ht_table =$('<table/>',{
    				 class:'attTable secTable',
    				 id:''
    			 });
    			createATtable(ht_table,daysInMonth,month,year,weekDay);
    			var d = $('<div/>',{ class:'tabbody',html:ht_table}).attr('id','atbMY_'+month+'_'+year).css('display','block'); 
    			
    			$(dv).append(d);
    			$(ul).append(li);
    		});
    		
    		$(tb).append(ul);
			$(tb).append(dv);
			flags.wrap.find('.atTabs').append(tb);
			flags.wrap.find('#tbs').fineTabs({
				tabhead : 'h2',
				fx : "fadeIn",
				syncheights : true,
				saveState : true,
				clearfixClass : 'ym-clearfix',
				currentInfoText : ""
			});
    	}
    	
    	function createATtable(tbl,daysInMonth,month,year,weekDay){
    		var attDayName;
    		var ht_trh =$('<tr/>',{
   			 	class:'attheader dates',
	   			 id:''
	   		 }).appendTo(tbl);
	   		
    		var ht_td =$('<td/>').appendTo(ht_trh);
			for (var dayCount = 1; dayCount <= daysInMonth; dayCount++) {
				attDayName = atmOpts.dayNames[((dayCount+weekDay-1)%7)];
				
				var td =$('<td/>',{
					 class:'attendance-day ',
					 id:'day_'+dayCount
				 }).appendTo(ht_trh);
				
				var dv1 =$('<div/>',{
					 class:'c attDayName',
					 id:'day_'+dayCount,
					 html:attDayName
				 }).appendTo(td);
				var dv2 =$('<div/>',{
					 class:'c attDay',
					 id:'day_'+dayCount,
					 html:dayCount
				 }).appendTo(td);
			}
			var eptd = $('<td/>',{
				 class:'',
				 id:'',
				 html:'<div>Total</div>'
			 }).appendTo(ht_trh);
			
			/*var eptd = $('<td/>',{
				 class:'',
				 id:'',
				 html:'Total'
			 }).appendTo(ht_trh);*/
			var subjs = flags.subjects;
			$.each(subjs, function(index, sub) {
				var s_tr =$('<tr/>',{
					 class:'sub_mon_y',
					 id:'smy_'+sub.id+"_"+month+"_"+year
				 }).appendTo(tbl);
				var s_tdsub =$('<td/>',{
					 class:'',
					 id:'sub_'+sub.id,
					 html:sub.subjectName
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
			 }).appendTo(tbl);
			var colstd =$('<td/>',{
				 class:'',
				 id:'',//sub day month
				 html:'<div><center>Total(month aggregate)</center></div>'
			 }).attr("colspan",daysInMonth+1).appendTo(ht_mnTr);
			var tolmntd =$('<td/>',{
				 class:'mn_T',
				 id:'mn_T_'+month //sub day month
			 }).appendTo(ht_mnTr);
    		
    	}
    	
function loadAttendance(){
			
	
	var atds = flags.atdData;
	
$.each(atds, function(index, at) {
		 var $tb = flags.wrap.find("#atbMY_"+at.mn+"_"+at.yr);
		 var ds = at.days;
		 $.each(ds, function(index, d) {
			 if(d.present){
					check ='<span class="st_p">1</span>';
					$tb.find('td#sdm_'+at.subj+'_'+d.day+"_"+at.mn).css( "background-color", "#74F194" ).html(check);
				 }
				 else{
					 check ='<span class="st_a">0</span>';
					 $tb.find('td#sdm_'+at.subj+'_'+d.day+"_"+at.mn).css( "background-color", "#FFAEAE" ).html(check);
				 }
		 });
		 var sT = '<span class="prt_T">'+at.pst+'</span>'+'/'+'<span class="abs_T">'+(at.pst+at.abs)+'</span>';
		$tb.find('td#sbj_T_'+at.subj+'_'+at.mn+"_"+at.yr).html(sT);
	});
}

function isEmpty( el ){
     return !$.trim(el.html());
 }

function calculateMonthPerc(){
	var clms = flags.classMonths;
	
	$.each(clms, function(ind, atm) {
		var attDayName;
		var m=atm.split("-");
		var year =  parseInt(m[0]);
		var month = parseInt(m[1]);
		var mnP=0,mnTo=0;
		var subjs = flags.subjects;
		$.each(subjs, function(index, sub) {
			var $mnT = $("#sbj_T_"+sub.id+"_"+month+"_"+year);
			mnP = mnP+parseInt($.isNumeric($mnT.find(".prt_T").text())?$mnT.find(".prt_T").text():0);
			mnTo = mnTo+parseInt($.isNumeric($mnT.find(".abs_T").text())?$mnT.find(".abs_T").text():0);
		});
		var perc = mnP==0?0:((mnP*100)/(mnTo)).toFixed(2);
		var mnHt = '<span class="mnPr_T">'+mnP+'</span>'+'/'+'<span class="mnT_T">'+mnTo+'</span><span class="mnT_Per">('+perc+')</span>';
		 $("#mn_T_"+month).html(mnHt);
		
	});
}

function aggr(){
	var mnP=0,mnTo=0;
	var subjs = flags.subjects;
		
	$(".mnPr_T").each(function(){
		mnP = mnP+parseInt($.isNumeric($(this).text())?$(this).text():0);
	});
	$(".mnT_T").each(function(){
		mnTo = mnTo+parseInt($.isNumeric($(this).text())?$(this).text():0);
	});
	
	var perc = mnP==0?0:((mnP*100)/(mnTo)).toFixed(2);
	var tol = '<table class="secTable tc"><tr><td><div class="c"><b>Total % </b></div></td><td><div>'+mnP+'/'+mnTo+' ('+perc+'%)</div></td></tr></table>';
	flags.wrap.find('.mt').append(tol);
	
}

function generateMksTab(){
	var tb =$('<div/>',{
			 class:'tabs'}).attr('id','mtbs');
	var ul =$('<ul/>',{ class:'tabs-list'});
	var dv =$('<div/>',{ class:'tabBox'}); 
	var exms = flags.exams;
	
	$.each(exms, function(ind, exm) {
		var li =$('<li/>',{ class:''}).append('<a href=""><div >'+exm.examName+'</div><div></div></a>').attr('id','exam_'+exm.id);
		var ht_table =$('<table/>',{
			 class:'mkTable secTable',
			 id:''
		 });
		createMarksTable(ht_table,exm.id);
		var d = $('<div/>',{ class:'tabbody',html:ht_table}).attr('id','mkT_'+exm.id).css('display','block'); 
		
		$(dv).append(d);
		$(ul).append(li);
	});
	
	$(tb).append(ul);
	$(tb).append(dv);
	flags.wrap.find('.mksTabs').append(tb);
	flags.wrap.find('#mtbs').fineTabs({
		tabhead : 'h2',
		fx : "fadeIn",
		syncheights : true,
		saveState : true,
		clearfixClass : 'ym-clearfix',
		currentInfoText : ""
	});
}
function createMarksTable(tbl,ex){
	var ht_trh =$('<tr/>',{
		 	class:'sheader subs',
			 id:''
		 }).appendTo(tbl);
	var ht_trM =$('<tr/>',{
	 	class:'mks'
	 }).attr('id','ex_'+ex).appendTo(tbl);
	
	var subjs = flags.subjects;
	var tot = 0
	$.each(subjs, function(index, sub) {
		var tds =$('<th/>',{
			 class:'',
			 html:'<div>'+sub.subjectName+'</div><div>('+sub.totalMarks+')</div>'
		 }).appendTo(ht_trh);
		var tdm =$('<td/>',{
			 class:'stm'
		 }).attr('id','es_'+ex+'_'+sub.id).appendTo(ht_trM);
		
		tot = tot+sub.totalMarks;
		 
	});
	atmOpts.totalMarks =tot;
	var eptd = $('<th/>',{
		 html:'<div>Total('+tot+')</div>'
	 }).appendTo(ht_trh);
	var eptd = $('<td/>',{
		class:'exT',
		 html:''
	 }).attr('id','mkT_'+ex).appendTo(ht_trM);
		
	}

function loadMarks(){
	var mks = flags.marks;
	$.each(mks, function(index, mk) {
		flags.wrap.find('#es_'+mk.examId+'_'+mk.subjectId).append(mk.marks);
	});
	
	var mkd = flags.wrap.find('.mks');
	$.each(mkd, function(index, mk) {
		var mr = $(this).find('.stm');
		var t =0;
		$.each(mr, function(index, m) {
			t = t+parseInt($.isNumeric($(this).text())?$(this).text():0);
		});
		
		var pc =(t*100/atmOpts.totalMarks).toFixed(1);
		$(this).find('.exT').append('<span class="mk_T">'+t+'</span>('+pc+'%)');
	});
    }

function aggrM(){
	var mnP=0,mnTo=0;
	var subjs = flags.subjects;
	
	var exms = flags.exams;
	var mTbl = flags.wrap.find('.mkTable');
	var fm =0,ft=0
	$.each(mTbl, function(index, tl) {
		
		fm = fm+parseInt($.isNumeric($(this).find('.mk_T').text())?$(this).text():0);
		ft =ft+atmOpts.totalMarks;
	});
	
	var perc = fm==0?0:((fm*100)/(ft)).toFixed(2);
	var tol = '<table class="secTable tc"><tr><td><div class="c"><b>Total % </b></div></td><td><div>('+perc+'%)</div></td></tr></table>';
	flags.wrap.find('.tm').append(tol);
	
}



   }
}( jQuery ));

jQuery.extend({
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
	}
}); 

$.fn.atm.defaults = {
        path:'',
        formValid:false,
        today:new Date(),
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
        students :new Array(),//JSON.stringify({students: []},
       // thismonthHolidayList:[7,14,21,28],
        classId:null,
        studentId:null,
        totalMarks: null,
        classMonths:['2014-04', '2014-05', '2014-06', '2014-7', '2014-8', '2014-9', '2014-10', '2014-11', '2014-12', '2015-1', '2015-2', '2015-3'],
        monthsNames : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        subjects : [{id:1,name:"Telugu",max:80},{id:2,name:"English",max:80},{id:3,name:"Hindi",max:100},{id:4,name:"Mathematics",max:100},{id:5,name:"Sanskrit",max:20},{id:6,name:"Science",max:100},{id:7,name:"Social",max:100}]
        
};