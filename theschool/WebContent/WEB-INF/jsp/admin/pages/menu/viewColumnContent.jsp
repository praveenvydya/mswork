<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">  
jQuery(document).ready(function($){
	//var ccList = [{ "id": "index1.html", "image": "./images/1.png", "title": "This is a demo title" }, { "id": "index.html", "image": "./images/2.png", "title": "Another example of a title" }, { "id": "index.html", "image": "./images/1.png", "title": "Yet another random title" }, { "id": "index.html", "image": "./images/2.png", "title": "The 2nd last title in our array" }, { "id": "index.html", "image": "./images/noimg.png", "title": "Last title for the static example" }];
	var ccList;
	 
	  $("#columnMenuContentForm").validate({
			rules: {   
				 	name: {required: true},
				 	contentType: {required: true},
				 	contentId: {required: true}
				       
			},
			messages: {
				contentId:{required: "Content is required."},
				contentType:{	required: "Content Type Name is required."},
				name:{	required: "Content Name is required."}
			},
			
			submitHandler: function(form) { 
				
				$("#validity_label").html('<div class="alert alert-success">No errors.</div>');
				$(this).attr("disabled", true);	
				$("#columnMenuContentForm").submit();
				},
			invalidHandler: function(form, validator) {
				$("#validity_label").html('<div class="alert alert-error">There be '+validator.numberOfInvalids()+' error'+(validator.numberOfInvalids()>1?'s':'')+' here.</div>');
			}
		});
	  
	  $('#contentType').change(function(){
		  $('#contentId').attr('disabled',true);
		  $('#selected_contentId').attr('disabled','disabled');
		  $.post('getCCList.htm',$("#columnMenuContentForm").serialize(),function(data){updatedCCList(data);});
			
	  });
	  
	  function updatedCCList(data){
		  ccList=[];
		  ccList = data;
		  $('#contentId').empty();
		  $(ccList).each(function(index, val){
			 // $('#contentId').attr('disabled',false);
			 // $('#contentId').empty();
			  $('#contentId').append('<option value="'+val.id+'">'+val.name+'</option>');
			  $('#contentId').attr('disabled',false);
		  });
		 // populateDropdown();
		//$('#selected_contentId').attr('disabled',false);
	  }
	  
			function populateDropdown(){
				
				$( '#selected_contentId' ).each( function(){
					$(this).attr( 'title', $(this).val() )
					  .focus( function(){
						if ( $(this).val() == $(this).attr('title') ) {
						  $(this).val( '' );
						}
					  } ).blur( function(){
						if ( $(this).val() == '' || $(this).val() == ' ' ) {
						  $(this).val( $(this).attr('title') );
						}
					  } );
					} );

					$('input#selected_contentId').result(function(event, data, formatted) {
						$('#result').html( !data ? "No match!" : "Selected: " + formatted);
					}).blur(function(){		
					});
					
					$(function() {		
					function format(mail) {
						return "<a href='"+mail.id+"'><img src='data:image/jpg;base64," + mail.content + "' style='width: 35px; height:35px' /><span class='auto_title'>" + mail.name +"</span></a>";			
					}
				//<img class="main-image" src="data:image/jpg;base64,<c:out value='${notfn.content}'/>" />
					function link(mail) {
						return mail.id;
					}

					function title(mail) {
						return mail.name;
					}
					
					
				$("#selected_contentId").autocomplete(ccList, {
					width: "auto",//$("#selected_contentId").outerWidth()-2,			
					max: 5,			
					scroll: false,
					dataType: "json",
					//matchContains: "word",
					parse: function(data) {
						return $.map(data, function(row) {
							return {
								data: row,
								value: row.name,
								result: $("#selected_contentId").val()
								
							}
						});
					},
					matchContains: true,
					
					formatItem: function(item) {				
						return format(item);
					}
					}).result(function(e, item) {
						$("#selected_contentId").val(title(item));
						$("#contentId").val(link(item));
					});	
				
			})	
							
			};
	  
	  
			});
</script>
<style>
</style>


<form:form method="POST" commandName="columnMenuContent" id="columnMenuContentForm"
	name="columnMenuContentForm">
<form:input type="hidden" path="actionType" />
<form:input type="hidden" path="id" />
	<h1>${columnMenuContent.actionType} Column Content</h1>
	<div class="span5" id="validity_label"></div>
	<div style="" class="formDataDiv addFormv">
		<table width="560" border="0" class="order">
			<tbody>

				<tr>
					<td class="firstcol"><label for="name" class="">Content
							Name:</label>
					</td>
					<td><form:input type="text" path="name" value="" name="name"
							required="true" maxlength="200" size="24" /></td>
				</tr>

				<tr>
					<td class="firstcol"><label for="contentType" class="">Content
							Type:</label>
					</td>
					<td><form:select path="contentType" cssClass="dropDown" name="contentType"
							disabled="">
							<c:forEach items="${ccRefList}" var="ccRef">
								<form:option value="${ccRef.idValue}"
									label="${ccRef.description}"
									selected="${contentType eq ccRef.idValue ? 'selected': ''}" />
							</c:forEach>
						</form:select></td>
				</tr>

				<tr>
					<td class="firstcol"><label for="contentId" class="">Select
							Content:</label>
					</td>
					<td><form:select path="contentId" cssClass="dropDown" name="contentId">
								<c:forEach items="${cclist}" var="cc">
								<form:option value="${cc.id}"
									label="${cc.name}"
									selected="${contentId eq cc.id ? 'selected': ''}" />
							</c:forEach>
						</form:select></td>
					<!-- <td><input type="text" id="selected_contentId" value="" style="width:197px;" 
							required="true" maxlength="200" size="24" /></td> -->
				</tr>

				<tr>
					<td class="firstcol"><label for="active" class="">Active:</label>
					</td>
					<td><form:select path="active"> 
								<form:option value="1" label="Active" /> 
								<form:option value="0" label="Inactive" /> 
							</form:select></td>
				</tr>
 <%-- disabled="${1 eq columnMenuContent.active || empty columnMenuContent.active ? true : false}" --%>
				<tr>
					<td class="firstcol"></td>
					<td>
						<!-- <button type="submit" class="submit">Confirm</button> -->
						<input type="submit"  class="large clButton green" id="saveBttn" title="Save" value="Save"/>
						<input type="button"  class="large clButton yellow" id="backBttn" title="Back" onClick="history.back();return false;" value="Back"/>
				</tr>
			</tbody>
		</table>
	</div>
</form:form>
