

//var app = angular.module('gApp', ['angular.aps','ngAnimate', 'ui.bootstrap','imageCropApp','angular-loading-bar']).
vydyaAdmin.controller('galleryCtrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService,$rootScope) {
	 $scope.gs = {};
	 gService.setBaseUrl('/theschool/admin/manageGallery');
	 apService.setUrl('/theschool/admin/manageGallery');
	 load();
	 function load(){
		 var d={};
		 	d['a']="gs";
		 	d['y']=String(new Date().getFullYear());
		 	$scope.gs = {};
		 	gService.view(d).then(function (response) {
		 		if(!angular.equals(response, {})){
	 				$scope.gs = response;
	 			}
	         })
	         .catch(function (response) {
	             console.log(response);
	         }); 
	 }
	 	 $rootScope.$on("GALLERY-ADDED", function (evet, args) {
	 		 	load();
	 	 });
	 	 
	 	$rootScope.$on("cfpLoadingBar:completed", function (evet, args) {
 		 	//alert("Started");
 	 });
	 	
	 loadPreviousYears();
	 function loadPreviousYears(){
		 var d={};
		 	d['a']="data";
		 	d['type']="yearlist";
		 	$scope.pylist = {};
		 	gService.view(d).then(function (response) {
		 		if(!angular.equals(response, {})){
	 				$scope.pylist = response;
	 			}
	         })
	         .catch(function (response) {
	             console.log(response);
	         }); 
	 }
	 function loadPYG(y){
		 var d={};
		 	d['a']="gs";
		 	d['y']=y;
		 	$scope.gs = {};
		 	gService.view(d).then(function (response) {
		 		if(!angular.equals(response, {})){
	 				$scope.pglist = response;
	 			}
	         })
	         .catch(function (response) {
	             console.log(response);
	         }); 
	 }
	 //	$rootScope.$broadcast('cfpLoadingBar:completed');
		 var verify= function(prop,value){
			 var g ={};
				g['t'] = 'v';
				g['p'] = prop.key;
				g['val'] = value;
				var dfd = $q.defer();
				gService.load(g).then(function (response) {
			 		if(!angular.equals(response, {})){
			 			dfd.resolve(!response);
					}
				   })
				   .catch(function (response) {
					   dfd.reject(response);
				       console.log(response);
				   });
				return dfd.promise;
		 }
		 
		 
		 var hiddenData = {};
		 hiddenData['imageUrl'] ='/theschool/static/simg-fit/302x180/';
		 hiddenData['staticImageUrl']='/theschool/stvydya/new/img/ugi.png';
		 hiddenData['baseUrl']= '/theschool/admin/manageGallery';
		 hiddenData['module']='GALLERY';
		 hiddenData['item']='Gallery ';
		 hiddenData['verify']=verify;
		 hiddenData['defaults'] =function(){ 
			 return {'objectType':'g'};
		 }
		 $scope.hidden = hiddenData;
	 	 
	 	 
 $scope.submitted= true;
 
 $scope.delete = function(g,ind)
 {
	 var dg= {};
	 dg['a']="gs";
	 dg['id']=g.id;
	 
	 swal({   
         title: "Are you sure?",   
         text: "All the images in the gallery will be deleted",   
         type: "warning",   
         showCancelButton: true,   
         confirmButtonColor: "#F44336",   
         confirmButtonText: "Yes, delete it!",   
         closeOnConfirm: false 
     }, function(){
    	 gService.delete(JSON.stringify(dg)).then(function(response) {
    		 if(!angular.equals(response, {})&response.data.success){
	    			$rootScope.$broadcast("GALLERY-ADDED", {
		                data: response
		            });  
	    			swal("Done!", "Gallery and all images are deleted", "success"); 
 		 }
 		 else{
 			 swal(response.data.message, "error");
 		 }
 		});
         
     });
	 
 }


 //$scope.filePath ="";
/* $scope.edit = function(g,i)
 {
	 
	$scope.action="edit";
   $scope.editMode = true;
   $scope.btnText = "Edit Gallery";
   g.filePath=$scope.imageContext+g.imageName;
   $scope.ng = angular.copy(g); // ??
   $scope.currentItem = g;  // ??
   $scope.ind = i;
   $('#galleryForm').modal('show'); 
   
 }  
  
 $scope.open = function()
 {
	$scope.ng = {};
	 //$scope.ng.$setPristine;
	 $scope.ng.action="add";
	
	 $('#galleryForm').modal('show');   
 }*/
 
 
/* $scope.hasPendingRequests = function () {
	   return httpRequestTracker.hasPendingRequests();
	};*/
	
	
});




vydyaAdmin.controller('gImagesCtrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService,$rootScope) {
	 apService.setUrl('/theschool/admin/manageGallery');
	 gService.setBaseUrl('/theschool/admin/manageGallery');
	 
$scope.loadImages = function(id){
	load(id);
}
	
	function  load(id){
	  var d={};
		d['id']=id;
		d['a'] = "gi";
		$scope.gid = id;
		$scope.images = {};
	 	gService.view(d).then(function (response) {
	 		if(!angular.equals(response, {})){
	 			$scope.images  = response;
 			}
         })
         .catch(function (response) {
             console.log(response);
         });
};

$rootScope.$on("GALLERYI-ADDED", function (evet, args) {
	 	load($scope.gid);
});

var hiddenData = {};
hiddenData['imageUrl'] ='/theschool/static/simg-fit/302x180/';
hiddenData['staticImageUrl']='/theschool/stvydya/new/img/ugi.png';
hiddenData['baseUrl']= '/theschool/admin/manageGallery';
hiddenData['module']='GALLERYI';
hiddenData['item']='Gallery Image';
hiddenData['defaults'] =function(){ return {'objectType':'gi','gid':$scope.gid}};
$scope.hidden = hiddenData;
 
 

$scope.delete = function(g,ind)
{
var dg= {};
dg['a']="gi";
dg['id']=g.id;

swal({   
title: "Do you want to delete this image?",   
type: "warning",   
showCancelButton: true,   
confirmButtonColor: "#F44336",   
confirmButtonText: "Yes, delete it!",   
closeOnConfirm: false 
}, function(){
gService.delete(JSON.stringify(dg)).then(function(response) {
	 if(!angular.equals(response, {})&response.data.success){
			$rootScope.$broadcast("GALLERYI-ADDED", {
               data: response
           });  
			swal("Done!", "Gallery image deleted", "success"); 
 }
 else{
	 swal(response.data.message, "error");
 }
});

});

}



})



vydyaAdmin.controller('cgallery', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService,$uibModalInstance, items,
		$rootScope) {
	 gService.setBaseUrl('/theschool/admin/manageGallery');
	 apService.setUrl('/theschool/admin/manageGallery');
	  
	 var vm = this;
	 vm.content = items;
	 
	$scope.action = vm.content.data.action ;
	$scope.header = vm.content.data.header;
	$scope.ng = vm.content.data.ng;

	 
	 $scope.submitted= true;
	// $scope.ng.filePath = 'http://localhost:8080/theschool/stvydya/new/img/ugi.png';
	 $scope.imageContext ="/theschool/static/simg-fit/302x180/";
	 $scope.submitGForm = function(valid)
	 {
		 var model = this;
		 if(valid){
			 if ($scope.action==='add')
			 {
				 var dg= {};
				 dg['a']="gs";
				 dg['name']=$scope.ng.name;
				 dg['eventDesc']=$scope.ng.eventDesc;
				 dg['title']=$scope.ng.title;
				 dg['image']=$scope.ng.fileToUpload;
						 gService.add(JSON.stringify(dg)).then(function(response) {
							 if(response.data.success){
								 $scope.ng = "";
								 $uibModalInstance.dismiss('cancel');
								 growlService.growl("Gallery "+' has added Successfully!', 'success'); 
								 $scope.submitted= true;
								 $rootScope.$broadcast("GALLERY-ADDED", {
						                data: response
						            });
							 }
							 else{
								 	$scope.gForm.submitted= true;
									growlService.growl(response.data.errormsg, 'error'); 
								}
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
		
		gService.edit(JSON.stringify(dg)).then(function(response) {
			if(response.data.success){
				
				$uibModalInstance.dismiss('cancel');
				 growlService.growl("Gallery "+' has updated Successfully!', 'success'); 
				 $scope.submitted= true;
				 $rootScope.$broadcast("GALLERY-ADDED", {
		                data: response
		            });
			}
			else{
				$scope.submitted= false;
				growlService.growl(data.data.errormsg, 'error'); 
			}
		});
	   }   
	 }
		 else{
			   $scope.submitted= false;	
		 }
	}
	 
	 $scope.close =  $uibModalInstance.close;
	 $scope.closex = function()
	 {
		 $scope.ng = {};
		 $scope.submitted = true;
		 $scope.editMode = false;
		$scope.gForm.$setPristine();
		// $scope.gForm.$setUntouched();
		   $('#galleryForm').modal('hide');   
	 }
});


vydyaAdmin.filter('gEmbFUrl', function ($sce) {
    return function(imgName) {
        return $sce.trustAsResourceUrl('/theschool/static/simg-org/' + imgName);
      };
    });
vydyaAdmin.filter('gEmbUrl', function ($sce) {
    return function(imgName) {
        return $sce.trustAsResourceUrl('/theschool/static/simg-fit/203x137/' + imgName);
      };
    });

	 
	 
	 
	 
	 
	 