
	vydyaAdmin.controller('eventsCtrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,$rootScope,
			growlService,loadService) {
	 $scope.editmode = false;
	 gService.setBaseUrl('/theschool/admin/manageEvents');
	 apService.setUrl('/theschool/admin/manageEvents');
	 loadService.setBaseUrl('/theschool/admin/manageEvents');
	 var self = this;
	
	 
 $scope.ng = "";
 loadN();
 loadP();
 function loadN(){
	 var ud={};
	 ud['t']='new';
	
 	gService.load(ud).then(function (response) {
 		if(!angular.equals(response, {})){
 			 $scope.upevents = response.respData;
		}
	   })
	   .catch(function (response) {
	       console.log(response);
	   });
 }
 
 function loadP(){
	 
	 var pd={};
	 pd['t']='prev';
	 
 	gService.load(pd).then(function (response) {
 		if(!angular.equals(response, {})){
 			 $scope.prvevents = response.respData;
		}
	   })
	   .catch(function (response) {
	       console.log(response);
	   });
 	
 }
 
 
 $rootScope.$on("EVENT-ADDED", function (evet, args) {
	 	loadN();
 });
 

 var hiddenData = {};
 hiddenData['imageUrl'] ='/theschool/static/simg-fit/302x180/';
 hiddenData['staticImageUrl']='/theschool/stvydya/new/img/ugi.png';
 hiddenData['baseUrl']= '/theschool/admin/manageEvents';
 hiddenData['module']='EVENT';
 hiddenData['item']='Event ';
 hiddenData['defaults'] =function(){ return {}};
 $scope.hidden = hiddenData;
  
 
 $scope.delete = function(ind)
 {
	 var dg= $scope.upevents[ind];
	 
	 swal({   
         title: "Are you sure?",   
         text: "Do You want remove this Event?",   
         type: "warning",   
         showCancelButton: true,   
         confirmButtonColor: "#F44336",   
         confirmButtonText: "Yes, delete it!",   
         closeOnConfirm: false 
     }, function(){
    	 gService.delete(JSON.stringify(dg)).then(function(data) {
 		 	$scope.upevents.splice( ind, 1 ); 
 		 	// display deleted message
 		 	swal("Done!", "Event Deleted", "success"); 
 		});
         
     });
	 
 }
 
});
	
	
	
	
	



	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 