 $(function () { $("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
	  preventSubmit: false,
	  submitSuccess: function ($form, e) { 
		  e.preventDefault();
		    e.stopPropagation();
		    var data = {},ft;
		    $('input',$form).each(function(){
	            var inv = $(this).val();
	            var vn = $(this).attr("name");
	            //alert("name" +varName+"  value =  "+inputVal);
	            //var $parentTag = $(this).parent();
	            //if(inputVal == '')
	            //    $parentTag.addClass('error').append('<span class="error">Required field</span>');
	            if(vn=='ft'){
	            	ft=inv;
	            }
	            else{
	            	data[vn] = inv;
	            }
	            delete data["undefined"];
	            
	        });
		    //notify(null, null, null, "success", null, null);
		   // notify(from, align, icon, type, animIn, animOut);
		   //var reqData = {};
		   //reqData["data"] = data;
		    
		   $.ajax({
			    type: "POST",
			    url: $form.attr('form-action'),
			    data: JSON.stringify(data),      //add the converted json string to a document.
	            cache: false,    //This will force requested pages not to be cached by the browser  
	            processData:false,
			    success: function(data) {
			    	//alert("Response: Name: "+callback.name+"  DOB: "+callback.dob+"  Email: "+callback.email+"  Phone: "+callback.phone);
			    	$(this).modal('hide');
			    	setGallery(data,$form);
                    $(this).html("Success!");
                    swal("Good job!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.  purus sed, pharetra felis", "success")

										} //just to make sure it got to this point.
			 });
		   
		   
		  /*   $.ajax({
                contentType : 'application/json; charset=utf-8',
                type: $form.attr('form-method'),
                url: $form.attr('form-action'),
                dataType : 'json',
                data : JSON.stringify(reqData),
                success : function(callback){
                	//alert("Response: Name: "+callback.name+"  DOB: "+callback.dob+"  Email: "+callback.email+"  Phone: "+callback.phone);
                    $(this).html("Success!");
                    swal("Good job!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.  purus sed, pharetra felis", "success")
                },
                error : function(){
                    $(this).html("Error!");
                }
            });
		    */
	    }
  
  }); } );
 
 function setGallery(data,$form){
	 
	 
 }