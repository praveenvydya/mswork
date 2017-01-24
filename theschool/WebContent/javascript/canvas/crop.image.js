
var formName;
var cropRatio;
var photoId;
var imageUrl;
var filePath;
var dfactionType;
var options = { 
				type:'POST',
			url:'uploadImage.htm',
			extraData:$("#"+formName).serialize(),
			dataType:'json',
			iframe:true,
		    beforeSend: function() 
		    {
		    	$("#ctl00_Progress").show();
		    	//$('#studentPhoto').attr('src','');
		    	/* $("#progress").show();
		        //clear everything
		        
		       // $("#message").html("");
		         */
		    	$("#percent").html("0%");
		    	$("#bar").width('0%');
		    	var src = $('#'+photoId).attr('src'); 
		    	filePath = $('#fileUpload').val();
		    	if(!src.indexOf(":image/")>0){
		    		$('#cropedImage').attr('src',imageUrl);
				}
		    },
		    uploadProgress: function(event, position, total, percentComplete) 
		    {
		        $("#bar").width(percentComplete+'%');
		        $("#percent").html(percentComplete+'%');
		 
		    },
		    success: function(d) 
		    {	
		        if(d.valid==true){
		        	
					if(d.dontCrop){
						$.fancybox.close();
			        	$("#ctl00_Progress").hide();
			        	//$("#"+formName).clearFields;
			        	$('#actionType').val(dfactionType);
			        	//$('#fileUpload').val(filePath);
			        	$('#'+photoId).attr('src','');
			        	$('#'+photoId).attr('src','data:image/jpg;base64,'+d.image);
					}
					else{
						var cont = '<div class="crop-content"><div><h2>Crop Image </h2></div><div><img class="img-crop" id="image-crop" src="data:image/jpg;base64,'+d.image+'"/></div><div><input type="button"  class="large clButton yellow" id="fancybox-cancel" title="Cancel" value="Cancel" onClick="$.fancybox.close();"/><input type="button"  class="large clButton green" id="crop-submit" title="Ok" value="Ok" onClick="cropSubmit();return false;"/></div></div>';
					$.fancybox.open({																																																																													
						padding : 5,
						content:cont,
				        afterClose:function() {
							var src = $('#'+photoId).attr('src'); 
							if(!src.indexOf(":image/")>0){
								$('#'+photoId).css('display','block');
								$('#fileUpload').attr('value','');
								$('#'+photoId).attr('src',imageUrl);
								}
							else{
								$('#x').val('');
							    $('#y').val('');
							    $('#width').val('');
							    $('#height').val('');
							    $('#actionType').val(dfactionType);
							}
							},
							helpers : {
								overlay : {
									closeClick : false
								}
							}
					});
					}
					
					
				 }
				 else{
					 
					 $("#ImageError").append(d.errormsg);
				 }
		    },
		    complete: function(d) 
		    {	dfactionType = $('#actionType').val();
		    	$("#ctl00_Progress").hide();
		    	initJcrop(); 
		    },
		    error: function()
		    {
		        $("#message").html("<font color='red'> ERROR: unable to upload files</font>");
		    }
		 
		};  

var optionsForCrop = { 
		type:'POST',
	url:'uploadImage.htm',
	extraData:$("#"+formName).serialize(),
	dataType:'json',
	iframe:true,
    beforeSend: function() 
    {
    	$("#ctl00_Progress").show();
    	//filePath =$('#fileUpload').val();
    },
    uploadProgress: function(event, position, total, percentComplete) 
    {
       $("#bar").width(percentComplete+'%');
       $("#percent").html(percentComplete+'%');
 
    },
    success: function(data) 
    {
        if(data.valid==true){
        	
        	$.fancybox.close();
        	$("#ctl00_Progress").hide();
        	//$("#"+formName).clearFields;
        	$('#actionType').val(dfactionType);
        	//$('#fileUpload').val(filePath);
        	$('#'+photoId).attr('src','');
        	$('#'+photoId).attr('src','data:image/jpg;base64,'+data.image);
        	
        }
    },
    complete: function(data) 
    {
    	
    },
    error: function()
    {
        $("#message").html("<font color='red'> ERROR: unable to upload files</font>");
    }
 
}; 


function cropSubmit(){
	if($('#width').val()>0){
		 $("#"+formName).ajaxSubmit(optionsForCrop);
	}
	else{
		alert("Please select Crop area");
		return false;
	}
	 
}

function cropCancel(){
	parent.$.fancybox.cancel();
}

	 function initJcrop(){
		 $('#image-crop').Jcrop({
		      aspectRatio: cropRatio,
		      onSelect: updateCoords
		 },function(){
			 var r = cropRatio.toString().split('/');
		        jcrop_api = this;
		        jcrop_api.animateTo([100,100,r[0],r[1]]);
		      });
		 
	 }
	 
	 function updateCoords(c)
	  {
	    $('#x').val(c.x);
	    $('#y').val(c.y);
	    $('#width').val(Math.round(c.w));
	    $('#height').val(Math.round(c.h));
	    $('#actionType').val("crop");
	   //alert("x="+c.x+" y"+c.y+" w "+c.w+" h"+c.h);
	  };
	  
	  