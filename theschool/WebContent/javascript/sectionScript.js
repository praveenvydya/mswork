// JavaScript Document



/* Select boxes for Adding/Modifying section details */
$(document).ready(function(){
	 var values = new Array();
 $('#addSelected').click(function(){
        $('#list1 option:selected').each( function() {
                $('#list2').append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
            $(this).remove();
        });
    });
	 $('#removeSelected').click(function(){
	     $('#list2 option:selected').each( function() {
	    	// alert("Selected "+$(this).val());
	    	 values.push($(this).val());
	    	 var allValues = values.join(",");
	    	 $("#deletedReports").val(allValues); 
	         $('#list1').append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
	         $(this).remove();
	     });
	 });
    $('#btn-up').bind('click', function() {
        $('#list2 option:selected').each( function() {
            var newPos = $('#list2 option').index(this) - 1;
            if (newPos > -1) {
                $('#list2 option').eq(newPos).before("<option value='"+$(this).val()+"' selected='selected'>"+$(this).text()+"</option>");
                $(this).remove();
            }
        });
    });
    $('#btn-down').bind('click', function() {
        var countOptions = $('#list2 option').size();
        $('#list2 option:selected').each( function() {
            var newPos = $('#list2 option').index(this) + 1;
            if (newPos < countOptions) {
                $('#list2 option').eq(newPos).after("<option value='"+$(this).val()+"' selected='selected'>"+$(this).text()+"</option>");
                $(this).remove();
            }
        });
    });	   
});	
/* Select boxes for Adding section details */




/*pop up for delete */ 

function confirmDelete()
{
  if (confirm('Do you want to delete ?'))
  {
      return true;
  }
  else
  {
      return false;
  }
}