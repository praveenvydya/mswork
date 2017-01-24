
var formName;
var cropRatio;
var photoId;
var imageUrl;
var dfactionType;
var options = { 
				type:'POST',
			url:'uploadImage.htm',
			extraData:$("#"+formName).serialize(),
			dataType:'json',
			iframe:true,
		    beforeSend: function() 
		    {
		    	//$('#studentPhoto').attr('src','');
		    	/* $("#progress").show();
		        //clear everything
		       // $("#bar").width('0%');
		       // $("#message").html("");
		        //$("#percent").html("0%"); */
		    	var src = $('#'+photoId).attr('src'); 
		    	if(!src.indexOf(":image/")>0){
		    		$('#cropedImage').attr('src',imageUrl);
				}
		    },
		    uploadProgress: function(event, position, total, percentComplete) 
		    {
		       /*  $("#bar").width(percentComplete+'%');
		        $("#percent").html(percentComplete+'%'); */
		 
		    },
		    success: function(d) 
		    {	
		        if(d.valid==true){
					var cont = '<div class="crop-content"><div><h2>Crop Image </h2></div><div><img class="img-crop" id="image-crop" src="data:image/jpg;base64,'+d.image+'"/></div><div><button id="fancybox-cancel" onClick="$.fancybox.close();">Cancel</button><button id="crop-submit" onClick="cropSubmit();return false;">Ok</button></div></div>';
					 $.fancybox(cont,
								{
							'width'				: 'auto',
							'height'			: 'auto',
							'transitionIn'		: 'fade',
							'transitionOut'		: 'fade',
							'autoScale'			: false,
							'overlayShow'	: true,
							'hideOnOverlayClick':false,
							'autoDimensions'	:false,
							'onClosed'			:function() {
								var src = $('#'+photoId).attr('src'); 
								if(!src.indexOf(":image/")>0){
									$('#'+photoId).css('display','block');
									$('#fileUpload').attr('value','');
									$('#'+photoId).attr('src',imageUrl);
									
								}
								/*else{
									$('#studentPhoto').attr('src','');
								}*/
								
							},
							'onCancel' 			: function() {
								//parent.$.fancybox.close();
								//$("#studentPhoto").css('display','block');
								// $('#fileUpload').attr('value','');*/
								alert("cancel clickd");
							}
							}
						);
				 }
				 else{
					 
					 $("#studentPhotoError").append(d.errormsg);
				 }
		    },
		    complete: function(d) 
		    {	dfactionType = $('#actionType').val();
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
    	
    },
    uploadProgress: function(event, position, total, percentComplete) 
    {
       /*  $("#bar").width(percentComplete+'%');
        $("#percent").html(percentComplete+'%'); */
 
    },
    success: function(data) 
    {
        if(data.valid==true){
        	parent.$.fancybox.close();
        	//$("#"+formName).clearFields;
        	$('#actionType').val(dfactionType);
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