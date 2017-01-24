

vydyaAdmin.controller('homectrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,$rootScope) {
	 $scope.hi = {};
	 gService.setBaseUrl('/theschool/admin/manageHomePage');
	 apService.setUrl('/theschool/admin/manageHomePage');
	 
	 load();
	 function load(){
	 var d  = {};
	 d['y']="2015";
	 	gService.view(d).then(function (response) {
	 		if(!angular.equals(response, {})){
	 			 $scope.hi = response;
			}
		   })
		   .catch(function (response) {
		       console.log(response);
		   });
	 	
	 }
	 
	 $rootScope.$on("HOME-ADDED", function (evet, args) {
		 	load();
	 });
	 
 $scope.imageUpdated=false; 
  
 

 
 var titlePos = [
              {val: 'LB', text: 'Left Bottom'},
              {val: 'LT', text: 'Left Top'},
              {val: 'RB', text: 'Right Bottom'},
              {val: 'RT', text: 'Right Top'}
            ]; 
 
 
 var hiddenData = {};
 hiddenData['imageUrl'] ='/theschool/static/simg-fit/302x180/';
 hiddenData['tp'] = titlePos;
 hiddenData['staticImageUrl']='/theschool/stvydya/new/img/ugi.png';
 hiddenData['baseUrl']= '/theschool/admin/manageHomePage';
 hiddenData['module']='HOME';
 hiddenData['item']='Home Page Image';
 $scope.hidden = hiddenData;
 
 $scope.delete = function(g)
 {
	 var dg= {};
	 dg['a']="hi";
	 dg['id']=g.id;
	 swal({   
         title: "Are you sure?",   
         text: "Do you want to delete this Home Page Image?",   
         type: "warning",   
         showCancelButton: true,   
         confirmButtonColor: "#F44336",   
         confirmButtonText: "Yes, delete it!",   
         closeOnConfirm: false 
     }, function(){
    	 
    	 gService.delete(JSON.stringify(dg)).then(function(response) {
    		 if(!angular.equals(response, {})&response.data.success){
	    			$rootScope.$broadcast("HOME-ADDED", {
		                data: response
		            });  
	    		 	swal("Done!", "Home Page Image is deleted", "success");
    		 }
    		 else{
    			 swal(response.data.message, "error");
    		 }
 		});
     });
 }
});

	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 