jQuery.fn.ForceAlphabetsOnly =
	 function()
	 {
	     return this.each(function()
	     {
	         $(this).keydown(function(e)
	         {
	             var key = e.charCode || e.keyCode || 0;
	             // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
	             // home, end, period, and numpad decimal
	             return (
	                 key == 8 || 
	                 key == 9 ||
	                 key == 32 ||
	                 key == 46 ||
	                 key == 110 ||
	                 key == 190 ||
	                 (key >= 35 && key <= 40) ||
	                 (key >= 65 && key <= 90));
	         });
	     });
	 };
	 
	 jQuery.fn.ForceAlphaNumericOnly =
		 function()
		 {
		     return this.each(function()
		     {
		         $(this).keydown(function(e)
		         {
		             var key = e.charCode || e.keyCode || 0;
		             // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
		             // home, end, period, and numpad decimal
		             return (
		                 key == 8 || 
		                 key == 9 ||
		                 key == 13 ||
		                 key == 46 ||
		                 key == 110 ||
		                 key == 190 ||
		                 (key >= 35 && key <= 40) ||
		                 (key >= 65 && key <= 90) ||
		                 (key >= 48 && key <= 57) ||
		                 (key >= 96 && key <= 105));
		         });
		     });
		 };
		 
	 jQuery.fn.ForceNumericOnly =
		 function()
		 {
		     return this.each(function()
		     {
		         $(this).keydown(function(e)
		         {
		             var key = e.charCode || e.keyCode || 0;
		             // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
		             // home, end, period, and numpad decimal
		             return (
		                 key == 8 || 
		                 key == 9 ||
		                 key == 13 ||
		                 key == 46 ||
		                 key == 110 ||
		                 key == 190 ||
		                 (key >= 35 && key <= 40) ||
		                 (key >= 48 && key <= 57) ||
		                 (key >= 96 && key <= 105));
		         });
		     });
		 };
		 
		 var cpath;
		 var contextPath;
		 
		 function loadLeftgalleryMenu(type,path,contxpath){
			 cpath=path;
			contextPath = contxpath;
			var adminPath;
			if(type=='g'){
				adminPath = 'manageGallery/viewAllImages.htm';
			}
			else if(type=='t'){
				adminPath='manageToppers/viewAll.htm';
			}
			
			 var  d1 = $('<div/>',{
				 id:'gmenu'
			 }).appendTo("#left-img-Column");
			 var  ul = $('<ul/>').appendTo(d1);
			$.get(path+'/getYlist.htm?t='+type, function( data ) {
				$.each(data, function(ind, y) {
					
					var  li = $('<li/>',{id:'gt'+y});
					var a = $('<a/>', {id:'', class:'', href:'javascript:loadthislist('+type+','+y+')'});
					$('<span>'+y+'</span>').appendTo(a);
					$(a).appendTo(li);
					var scdiv =$('<div/>',{ class:'scrollboxSDiv'}).appendTo(li);
					
					if(ind==0){
					$.get(path+'/getlist.htm?t='+type+'&y='+y, function( data ) {
						var html;
						$.each(data, function(index, e) {
								html='<div class="admin-left-boundary" id="gallery_'+e.id+'"><div class="a-inner-border">'+
								'<div class="gallery-inner"><div class="thumbnail-lm itemcontainer"><img src="'+contxpath+'/static/simg-fit/203x137/'+e.url+
								'" id="t_'+e.id+'_'+e.url+'" class=""	alt="'+e.name+'" /></div><div class="content-div">'+
									'<div class="gallery-decorator"><a href="'+contxpath+'/admin/'+adminPath+'?'+type+'='+e.id+'" id="t'+e.id+'_'+e.url+'"  class="tName">'+e.description+'</a></div></div></div></div></div></div>';
									$(html).appendTo(scdiv);
							
							});
						});
					}					
					$(li).appendTo(ul);
					});
				});
			
			$( document ).ajaxComplete(function() {
				$('.scrollboxSDiv').finescroll({
				    verticalTrackClass: 'track',
				    verticalHandleClass: 'handle',
				    minScrollbarLength: 15,
				    showOnHover : true
				});
				
			});
			  
			}
		 $('.message font').fadeIn().delay(5000).fadeOut();
		 $('.successMsg').fadeIn().delay(5000).fadeOut();
		 function loadthislist(t,y){
			 var adminPath;
			 if(t=='g'){
					adminPath = 'manageGallery/viewAllImages.htm';
				}
				else if(t=='t'){
					adminPath='manageToppers/viewAll.htm';
				}
			 
				$.get(cpath+'/getlist.htm?t='+t+'&y='+y, function( data ) {
					//var htm = '<div class="scrollboxGalDiv"/>';
					$('#gmenu .scrollboxSDiv').empty();
					//var clset = $(this).closest('.scrollboxSDiv');
					var html;
					$.each(data, function(index, e) {
						 html='<div class="admin-left-boundary" id="gallery_'+e.id+'"><div class="a-inner-border">'+
							'<div class="gallery-inner"><div class="thumbnail-lm itemcontainer"><img src="'+contextPath+'/static/simg-fit/203x137/'+e.url+
							'" id="t_'+e.id+'_'+e.url+'" class=""	alt="'+e.name+'" /></div><div class="content-div">'+
								'<div class="gallery-decorator"><a href="'+contextPath+'/admin/manageToppers/viewAll.htm?t='+e.id+'" id="t'+e.id+'_'+e.url+'"  class="tName">'+e.description+'</a></div></div></div></div></div></div>';
								$(html).appendTo('#gt'+y+' .scrollboxSDiv' );
						});
					});
				}
		 
		

			