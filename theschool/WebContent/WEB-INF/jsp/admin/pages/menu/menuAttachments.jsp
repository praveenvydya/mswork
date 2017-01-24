<script type="text/javascript">
		$(document).ready(function() {
			
			$("#attachmentForm").validate({
				rules: {     
					name: {required: true},
						   file: {
							   	required: true,
							   	extension: "jpeg|jpg|zip|doc|docx|gif|png|pdf|csv|xlsx|xls|txt|xml",
								maxSize:true,
								minSize:true
								}
				},
				messages: {
					
					name:{required: "Please write attachment name."},
					file:{
						required: "Please Select a File",
						extension:"Please select a valid format"
						}
				},
				
				submitHandler: function(form) { 
					
					$(this).attr("disabled", true);	
					$("#attachmentForm").ajaxSubmit(attachmentOptions);
					},
				invalidHandler: function(form, validator) {

				}
			});
			
			$.validator.addMethod("maxSize", function (val, element) {
			    var ext = $(element).val().split('.').pop().toLowerCase();
			  
			    var size = element.files[0].size;

			    if ( size > 10485760) {//5MB =5242880
			        return false;
			    } else {
			        return true;
			    }

			}, "Image size cannot be more than 10Mb");

			$.validator.addMethod("minSize", function (val, element) {
			    var ext = $(element).val().split('.').pop().toLowerCase();
			  
			    var allow = new Array('jpeg','jpg','zip','doc','doc','gif','png','pdf','csv','xlsx','xsl','txt','xml'); 
			    var size = element.files[0].size;

			    if ( size < 1024) {//1048576
			        return false;
			    } else {
			        return true;
			    }

			}, "Image size cannot be less than 1kb");
			
			
			//ADD FORM AJAX SUBMIT 
			var attachmentOptions = { 
				type:'POST',
			url:'attachments.htm',
			extraData:$("#attachmentForm").serialize(),
			dataType:'json',
			iframe:true,
		    beforeSend: function() 
		    {
		    	
		    },
		    uploadProgress: function(event, position, total, percentComplete) 
		    {
		 
		    },
		    success: function(data) 
		    {
		        if(data.success==true){
		        	
		        	$(".message").html('<font class="g">'+data.message+'</font>');
		        		
		        	$("#attcBody").prepend('<tr><td><div class="name"><span class="fileType '+data.type+'f"></span>'+data.name+' (' +data.size+')</div>'+
							'<div class="url"><spring:message code="application.name"/>${pageContext.request.contextPath}/attachments/m/'+data.url+'</div>'+
								'</td><td><a class="downloadlink" href="<spring:message code="application.name"/>${pageContext.request.contextPath}/attachments/m/'+data.url+'">Download</a>&nbsp;<a id="d-'+data.id+'" class="deleteC">Delete</a></td></tr>');
						
		        	$("#attachmentForm")[0].reset();
		        }
		        else{
		        	$(".message").html('<font class="r">'+data.message+'</font>');
		        }
		    },
		    complete: function(data) 
		    {
		    	
		    },
		    error: function()
		    {
		    	$(".message").html('<font class="g">'+data.message+'</font>');
		    }
		 
		}; 
			
			$(document).on("click",".deleteAtch",function(e){
				var atId = $(this).attr("id").split('_')[1];
				if (confirm("Do you want to delete this attachment?")) {
					$("#fileid").val(atId);
					$.post('deleteAttachment.htm',$("#attachmentForm").serialize(),
									function(data) {
										if (data.success == true) {
											var tr = $("tr#attmt_"+ atId);
											tr.css("background-color","#666666");
											tr.fadeOut(400,function() {tr.remove();});
											$(".message").empty().html("<font class='g'>"+ data.message+ "</font>");
											return false;
										} else {
											$(".message").empty().html("<font class='r'>"+data.errormsg+ "</font>");
										}
									});
				} else
					return false;
			});
			 $('.message').fadeIn().delay(5000).fadeOut();
		
		});
	</script>

<div class="message"></div>
<form:form enctype="multipart/form-data" name="attachmentForm"
	id="attachmentForm" method="POST" commandName="attachment">
	<form:input type="hidden" path="contentId" class="" id="menuIdAtt" />
	<form:input type="hidden" path="unid" class="" id="attunid" />
	<form:input type="hidden" path="id" class="" id="fileid" />
	
	<div style="" class="formDataDiv addFormv">
		<table width="660" border="0" class="order">
			<tbody>

				<tr>
					<td><label class="">Attachment Name
							Image:<span class="mandatory">*</span>
					</label>
					</td>
					<td><form:input path="name"
							name="name" required="" placeholder="Required" type="text"/>
					</td>
				</tr>
				
				<tr>
					<td><label class="text-right padding-top5">File:<span
							class="mandatory">*</span>
					</label>
					</td>
					<td><form:input type="file" path="file" class="upload"
							name="file" placeholder="Select File" required="" /></td>
					
				</tr>
				<tr>
					<td></td>
					<td><input type="button" class="large clButton yellow"
						id="cancelImageBttn" title="Cancel" value="Cancel" /> <input
						type="submit" class="large clButton green" id="addImageBttnx"
						title="Add" value="Add" /></td>
					<td></td>
				</tr>
		</table>
	</div>
	<div class="attachmentlist">
		
	</div>
</form:form>



	
	<div id="content-Column">

				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="attachmentsTable">
					<thead>
						<tr>
							<th width="80%">Attachments</th>
							<th width="20%"></th>
						</tr>
					</thead>
					<tbody id="attcBody">
					
					<c:choose>
						<c:when test="${empty attachmentList}">
							<div class="alertMsg">No Attachements Found</div>
						</c:when>
						<c:otherwise>
					
						<c:forEach var="att" items="${attachmentList}" varStatus="loop">
							<tr class="" id="attmt_${att.id}">
								<td><div class="name">
										<span class="fileType ${att.fileType}f"></span>${att.name}
										
									</div>
									<div class="url"><spring:message code="application.name"/>${pageContext.request.contextPath}/attachments/m/${att.url}</div>
								</td>
								<td><a class="downloadlink"
									href="<spring:message code="application.name"/>${pageContext.request.contextPath}/attachments/m/${att.url}">Download</a>
									&nbsp;<a id="da_${att.id}" class="deleteAtch">Delete</a>
								</td>
							</tr>
						</c:forEach>
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>
			
	</div>

