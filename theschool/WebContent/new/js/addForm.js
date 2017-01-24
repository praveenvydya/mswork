

//var app = angular.module('gApp', ['angular.aps','ngAnimate', 'ui.bootstrap','imageCropApp','angular-loading-bar']).
vydyaAdmin.controller('galleryCtrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService) {
	 $scope.gs = {};
	 gService.setBaseUrl('/theschool/admin/manageGallery');
	 apService.setUrl('/theschool/admin/manageGallery');
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
	  
 $scope.imageUpdated=false; 
 $scope.btnText = "Add Gallery";
 $scope.ng = "";
 $scope.submitted= true;
 $scope.submitGForm = function(valid)
 {
	 var model = this;
	 if(valid){
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
						 if(data.data.success){
							 //$scope.gs.push(data.data.respData);
							// $scope.load(null);
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
							 	
							 $scope.ng = "";
							 $('#galleryForm').modal('hide');  
							 growlService.growl("Gallery "+' has added Successfully!', 'success'); 
							 $scope.submitted= true;
						 }
						 else{
							 	$scope.gForm.submitted= true;
								growlService.growl(data.data.errormsg, 'error'); 
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
	
	gService.edit(JSON.stringify(dg)).then(function(data) {
		if(data.data.success){
			var ind = $scope.ind;
			 $('#galleryForm').modal('hide');
			 growlService.growl("Gallery "+' has updated Successfully!', 'success'); 
			 $scope.editMode = false;
			 $('#galleryForm').modal('hide'); 
			 $scope.action="add";
			 $scope.btnText = "Add Gallery";
			 $scope.submitted= true;
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
 
 $scope.delete = function(g,ind)
 {
	 var dg= {};
	 dg['a']="gs";
	 dg['id']=g.id;
	 
	 swal({   
         title: "Are you sure?",   
         text: "All the images in the gallery will be removed",   
         type: "warning",   
         showCancelButton: true,   
         confirmButtonColor: "#F44336",   
         confirmButtonText: "Yes, delete it!",   
         closeOnConfirm: false 
     }, function(){
    	 gService.delete(JSON.stringify(dg)).then(function(data) {
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
    		 var ngs = $scope.gs;
    		 $scope.gs={};
    		 $scope.gs = ngs;
 		 	swal("Done!", "Gallery and all images are deleted", "success"); 
 		});
         
     });
	 
 }

 $scope.imageContext ="/theschool/static/simg-fit/302x180/";
 $scope.filePath ="";
 $scope.edit = function(g,i)
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
	 $scope.ng.filePath = 'http://localhost:8080/theschool/stvydya/new/img/ugi.png';
	 $('#galleryForm').modal('show');   
 }
 
 $scope.close = function()
 {
	 $scope.ng = {};
	 $scope.submitted = true;
	 $scope.editMode = false;
	$scope.gForm.$setPristine();
	// $scope.gForm.$setUntouched();
	   $('#galleryForm').modal('hide');   
 }
 
/* $scope.hasPendingRequests = function () {
	   return httpRequestTracker.hasPendingRequests();
	};*/
	
	
});


vydyaAdmin.controller('gImagesCtrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService,$rootScope) {
	 apService.setUrl('/theschool/admin/manageGallery');
	 gService.setBaseUrl('/theschool/admin/manageGallery');
	 
$scope.loadImages = load(id);
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
hiddenData['defaults'] ={'objectType':'gi'};
$scope.hidden = hiddenData;
 
 

$scope.delete = function(g,ind)
{
var dg= {};
dg['a']="gs";
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

vydyaAdmin.controller('gImagesCtrlx', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService) {
	 //$scope.test = "Hi Praveen";
	$scope.animationsEnabled = true;
	$scope.images={};
	apService.setUrl('/theschool/admin/manageGallery');
	 gService.setBaseUrl('/theschool/admin/manageGallery');
	 
$scope.loadImages = function(id){
	$scope.gid=id;
	 
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

$scope.close = function()
{
	 $scope.ngi = {};
	 $scope.submitted = true;
	 $scope.editMode = false;
	$scope.giForm.$setPristine();
	// $scope.gForm.$setUntouched();
	   $('#galleryImageForm').modal('hide');   
}

$scope.openI = function()
{
	$scope.ngi = {};
	 //$scope.ng.$setPristine;
	 $scope.ngi.action="add";
	 $scope.ngi.filePath = 'http://localhost:8080/theschool/stvydya/new/img/ugi.png';
	 $('#galleryImageForm').modal('show');   
}

$scope.submitGiForm = function(valid)
{
	 var model = this;
	 if(valid){
			 var dg= {};
			
			 dg['description']=$scope.ngi.description;
			 dg['image']=$scope.ngi.fileToUpload;//base64Image;
			 dg['a'] = "gi";
			 dg['gid']=$scope.gid;
			// if($scope.isformValid() && $scope.gForm.$valid){
					 gService.add(JSON.stringify(dg)).then(function(data) {
						 if(data.data.success){
							 //$scope.gs.push(data.data.respData);
							// $scope.load(null);
							 var d={};
							 	d['a']="gi";
							 	d['id']=$scope.gid;
							 	$scope.images = {};
							 	gService.view(d).then(function (response) {
							 		if(!angular.equals(response, {})){
						 				$scope.images = response;
						 			}
						         })
						         .catch(function (response) {
						             console.log(response);
						         });
							 	
							 $scope.ngi = "";
							 $('#galleryImageForm').modal('hide');  
							 growlService.growl("Gallery "+' Image added Successfully!', 'success'); 
							 $scope.submitted= true;
						 }
						 else{
							 	$scope.submitted= true;
								growlService.growl(data.data.errormsg, 'error'); 
							}
					});
					 
			 /*}
			 else{
				 
			 }*/
 
}
	 else{
		   $scope.submitted= false;	
	 }
}
	  $scope.openIA = function () {
		  $scope.items = ['hi'];
		  //$scope.ng.imageCropped = 'http://localhost:8280/stvydya/new/img/ugi.png';
		  
	    var modalInstance = $uibModal.open({
	      animation: $scope.animationsEnabled,
	      templateUrl: 'myModalContent.html',
	      controller: 'ImageInstanceCtrl',
	      size: "lg",
	      backdrop : 'static',
      	  keyboard :false,
	      resolve: {
	        items: function () {
	          return $scope.items;
	        },
	        gid:$scope.gid
	      }
	    });

	   /* modalInstance.result.then(function (selectedItem) {
	      $scope.selected = selectedItem;
	    }, function () {
	      //$log.info('Modal dismissed at: ' + new Date());
	    });*/
	    
	    modalInstance.result.then(function (image) {
		      $scope.images.push(image);
		    }, function () {
		      //$log.info('Modal dismissed at: ' + new Date());
		});
	    
	    
	  };

	  $scope.delete = function(g,ind)
	  {
	 	 var dg= {};
	 	 dg['a']="gi";
	 	 dg['id']=g.id;
	 	 gService.delete(JSON.stringify(dg)).then(function(data) {
	 		if(data.data.success){
	 			 //$scope.gs.splice( $scope.gs.indexOf(g), 1 ); 
	 			 delete  $scope.images[ind];
				
				 var d={};
				 	d['a']="gi";
				 	d['id']=$scope.gid;
				 	$scope.images = {};
				 	gService.view(d).then(function (response) {
				 		if(!angular.equals(response, {})){
			 				$scope.images = response;
			 			}
			         })
			         .catch(function (response) {
			             console.log(response);
			         });
				 	 growlService.growl("Gallery "+' Image deleted  Successfully!', 'success'); 
			}
	 		else{
	 			growlService.growl(data.data.errormsg, 'error'); 
	 		}
	 		 	// display deleted message
	 		});
	  }
	  $scope.cancel = function () {
		    $modalInstance.dismiss('cancel');
		  };
		  
	  $scope.toggleAnimation = function () {
	    $scope.animationsEnabled = !$scope.animationsEnabled;
	  };
	 
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

	 
vydyaAdmin.controller('ImageInstanceCtrl', function ($scope, $modalInstance, items,gid,fileUpload,generalService,apService,gService,$rootScope) {
	
		
	  $scope.items = items;
	  $scope.selected = {
	    item: $scope.items[0]
	  };
	  $scope.temp = $rootScope.images;
	 // $scope.ngi.filePath = 'http://localhost:8080/theschool/stvydya/new/img/ugi.png';
	  $('#croped-image').attr('src','http://localhost:8280/stvydya/new/img/ugi.png');
	  $scope.uploadImage = function (valid) {
		  /*var blobURL = URL.createObjectURL(ng.fileToUpload);
		  var base64Image;
		  generalService.getImageBase64(blobURL,function(base64){
			  base64Image = base64;
		  });*/
		  
		  var model = this;
			 if(valid){
					  gService.setBaseUrl('/theschool/admin/manageGallery');
					  var dg= {};
						 dg['description']=ngi.description;
						 dg['image']=ngi.fileToUpload;//base64Image;
						 dg['a'] = "gi";
						 dg['gid']=gid;
						 $scope.imageData={};
						 //if($scope.isformValid() && $scope.gForm.$valid){
						 gService.add(JSON.stringify(dg)).then(function(data) {
							 
							 if(data.data.success){
								 $scope.ng = "";
								 $scope.imageData = data.data.respData;
								 $modalInstance.close($scope.imageData);
								 $scope.submitted=true;
								 growlService.growl("Image added Successfully!", 'success'); 
								
							}
							else{
								growlService.growl(data.data.errormsg, 'error'); 
							}
						}); 
			}
			 else{
				  $scope.submitted= false;	
			 }
	  };

	  $scope.cancel = function () {
	    $modalInstance.dismiss('cancel');
	  };
	});
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 