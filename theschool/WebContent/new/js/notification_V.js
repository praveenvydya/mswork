

var app = angular.module('hApp', ['angular.aps','ngAnimate', 'ui.bootstrap','imageCropApp']).
controller('hctrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload) {
	 $scope.ns = {};
	 gService.setBaseUrl('/theschool/admin/manageNotifications');
	 apService.setUrl('/theschool/admin/manageNotifications');
	 var d={};
		d['y']="2015";
		apService.load(d).then(function(data) {
			 $scope.ns = data.data;
		});
	
 $scope.imageUpdated=false; 
 $scope.btnText = "Add Home Image";
 $scope.ng = "";
  
 $scope.submitGForm = function(g)
 {
   if (!$scope.editMode)
   {
	 var dg= {};
	 dg['a']="gs";
	 dg['name']=$scope.ng.name;
	 dg['eventDesc']=$scope.ng.eventDesc;
	 dg['title']=$scope.ng.title;
	 dg['image']=$scope.ng.fileToUpload;
	// if($scope.isformValid() && $scope.gForm.$valid){
			 gService.add(JSON.stringify(dg)).then(function(data) {
				 $scope.ns.push(data.data.respData);
				 $scope.ng = "";
				 $('#galleryForm').modal('hide');  
			});
	 /*}
	 else{
		 
	 }*/
   }   
   else
   {
	  var  dg ={};
	  dg['a']="gs";
	  dg['id']=$scope.ng.id;
	  dg['name'] = $scope.currentItem.name = $scope.ng.name; // ??
	  dg['eventDesc'] = $scope.currentItem.eventDesc = $scope.ng.eventDesc;
	  dg['title'] = $scope.currentItem.title = $scope.ng.title; // ??
	  dg['unid'] = $scope.currentItem.unid = $scope.ng.unid;
	dg['image'] = $scope.currentItem.image = $scope.ng.fileToUpload;
	
	gService.edit(JSON.stringify(dg)).then(function(data) {
		 $scope.ns.push(data.data.respData);
		 $scope.ng = "";
		 $('#galleryForm').modal('hide');  
	});
	
	 $scope.editMode = false;
	 $('#galleryForm').modal('hide'); 
	 $scope.action="add";
	 $scope.btnText = "Add Gallery";
	
   }   
  
 };
 
 $scope.delete = function(g)
 {
	 var dg= {};
	 dg['a']="gs";
	 dg['id']=g.id;
	 
	 gService.delete(JSON.stringify(dg)).then(function(data) {
		 	$scope.ns.splice( $scope.ns.indexOf(g), 1 ); 
		 	// display deleted message
		});
 }
 
 
$scope.isformValid = function(){
	var isValid=false;
    if($scope.ng.action==='add'&&$scope.imageUpdated){
    	isValid =true;
    }else if($scope.action==='edit'){
    	isValid =true;
    }
    if (!isValid) {
    	//$scope.filePath.$setValidity("required", false);
      }
	return isValid;
}
 $scope.imageContext ="/theschool/static/simg-fit/302x180/";
 $scope.filePath ="";
 $scope.edit = function(g)
 {
	 
	$scope.action="edit";
   $scope.editMode = true;
   $scope.btnText = "Edit Gallery";
   g.filePath=$scope.imageContext+g.imageName;
   $scope.ng = angular.copy(g); // ??
   $scope.currentItem = g;  // ??
   $('#galleryForm').modal('show'); 
   
 };  
  
 $scope.open = function()
 {
	$scope.ng = {};
	 //$scope.ng.$setPristine;
	 $scope.ng.action="add";
	 $scope.ng.filePath = 'http://localhost:8280/stvydya/new/img/ugi.png';
	 $('#galleryForm').modal('show');   
 }
 
 $scope.close = function()
 {
	 $scope.ng = {};
	$scope.gForm.$setPristine();
	// $scope.gForm.$setUntouched();
	   $('#galleryForm').modal('hide');   
 }
 
/* $scope.hasPendingRequests = function () {
	   return httpRequestTracker.hasPendingRequests();
	};*/
	
	
});

	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 