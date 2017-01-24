 $("#imageForm").validate({
					rules: {   
						 	imageFile : {
								required : {
									depends : function(
											element) {
										return ($('#cropedImage').src == '');
									}
								},
								extension: "jpeg|jpg",
							},
						       
					},
					messages: {
						imageFile : {
							required : "Please Select a Book category Image.",
							extension:"Please select a valid format(.jpeg)"
						}
					}
			 });