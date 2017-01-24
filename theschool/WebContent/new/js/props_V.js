

vydyaAdmin.controller('propsCtrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,$rootScope) {
	 $scope.hi = {};
	 gService.setBaseUrl('/theschool/admin/manageProperties');
	 apService.setUrl('/theschool/admin/manageProperties');
	 
	 load();
	 function load(){
	 var d  = {};
	 	gService.view(d).then(function (response) {
	 		if(!angular.equals(response, {})){
	 			 $scope.props = response;
			}
		   })
		   .catch(function (response) {
		       console.log(response);
		   });
	 	
	 }
	 $scope.load = load();
	 $rootScope.$on("PROPS-UPDATED", function (evet, args) {
		 	load();
	 });
	 
 $scope.imageUpdated=false; 
 
 var hiddenData = {};
 hiddenData['baseUrl']= '/theschool/admin/manageProperties';
 hiddenData['module']='PROPS';
 hiddenData['item']='Admin Property';
 $scope.hidden = hiddenData;
});

	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 