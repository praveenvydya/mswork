
var imapp = angular.module("imageCropApp",['ngAnimate', 'ui.bootstrap']);
imapp.controller("imageCtrl",function($scope,$uibModal){
	  
	  
});
imapp.directive('imageFile', ['$parse','$uibModal','$q', function ($parse,$uibModal,$q) {
	    return {
	        restrict: 'A',
			require: 'ngModel',
	        link: function(scope, element, attrs,ctrl) {
	            var model = $parse(attrs.fileModel);
	            var modelSetter = model.assign;
	            //scope.ng.filePath = scope.ng.imageName;
	            var croped;
	            if(scope.ng&&scope.ng.imageName!=''){
                	ctrl.$setValidity('required', true);
                	ctrl.$setValidity('invalidImage', true);
    	    	}
    	    	else{
    	    		ctrl.$setValidity('required', false);
    	    	}
	            
	            element.bind('change', function(){
	                scope.$apply(function(){
	                	var file =element[0].files[0];
	                   // modelSetter(scope,file );
	                	 var imageType = file.type;
					
						
						 if(angular.lowercase(imageType) ==='image/jpg' || angular.lowercase(imageType) ==='image/jpeg'){
							ctrl.$setValidity('invalidImage', true);
							ctrl.$setValidity('required', true);
							var imageEl = angular.element('<div></div>');
							
	                    var blobURL = URL.createObjectURL(file);
	                   // var blobURL = 'C:/Users/praveen/Downloads/dec_28.jpg';
		                   var modalInstance = $uibModal.open({
			              	     // animation: $scope.animationsEnabled,
			              	      template: '<div class="modal-header">'+			              	        
			              	        '<h4 class="modal-title">Crop Image</h4>'+
			              	     ' </div> <div class="modal-body"> '+
			              	  	  '<div class="" id="cropper-image">'+
			                      '<img image-crop   cropurl="'+blobURL+'"  alt="Image" crop="'+attrs.crop+'" crossOrigin="anonymous" class="img-responsive"></img>'+
			                    '</div></div><div class="modal-footer">'+
			                      '<button type="button" class="btn bgm-lightblue waves-effect" data-method='+attrs.method+' cropoptions="{ &quot;width&quot;: '+attrs.width+', &quot;height&quot;: '+attrs.width+' }" ng-click="getCrop()">OK</button>'+
			            	'<button type="button" class="btn bgm-bluegray waves-effect" ng-click="cancel()">Close</button></i>',
			              	      controller: 'CropImageCtrl',
			              	    backdrop : 'static',
			              	  keyboard :false,
			              	      size: "sm",//lg
			              	    	resolve: {
			              		        elem: function () {
			              		          return element;
			              		        }
			              		      }
			              	    });//{ &quot;width&quot;: 640, &quot;height&quot;: 320 }  //getCroppedCanvas
		                   modalInstance.result.then(function (croped) {
		                    	var bl = croped.toDataURL(imageType);
		                    	var imageBlob = croped.toDataURL(imageType).replace("data:"+imageType+";base64,","");
		                    	//element.append('<img src="'+bl+'" />');
		                    	$('#croped-image').attr("src",bl)
								 modelSetter(scope,imageBlob );
		                    	
		                    	//cropper.getCroppedCanvas().toBlob(function (blob) {
		                    	
		                    	
		             	    }, function () {
		             	      //$log.info('Modal dismissed at: ' + new Date());
		             	    });
						   }
						else{
							ctrl.$setValidity('invalidImage', false);
						}
	            });
	        });
	    } }
	}]).
	directive('imageCrop', ['$parse', function ($parse,$uibModal) {
	    return {
	        restrict: 'A',
	        link: function(scope, element, attrs) {
	        	
	        	var $image = $('#cropper-image > img');
	            var cropBoxData,
	            canvasData;
	          
	            $image.one('built.cropper', function () {
                     URL.revokeObjectURL(attrs.cropurl); // Revoke when load complete
                   }).cropper('reset').cropper('replace', attrs.cropurl)
                   if( attrs.crop){
                	   var crR= attrs.crop.split("/");
                	  $image.cropper("setAspectRatio", parseInt(crR[0])/parseInt(crR[1]));
                   }
                   else{
                	   $image.cropper("setAspectRatio", NaN);
                   }
                 
	          /*  $image.attr("src",attrs.cropurl);
                  $image.cropper({
	            autoCropArea: 16/9,
	            built: function () {
	              // Strict mode: set crop box data first
	            	$image.cropper('setCropBoxData', cropBoxData);
	            	$image.cropper('setCanvasData', canvasData);
	            }
	          });*/
                
	        }
	    }
	}]).controller('CropImageCtrl', function ($scope, $uibModalInstance,elem) {

	 
	  $scope.getCrop = function () {
		  var data=[];
		  data.method="getCroppedCanvas";
		  var op = [];
		  op.width=360;
		  op.height=180;
		  data.option=op;
		  data.viewMode=3;
		  var $image = $('#cropper-image > img');
		  var rm = $image.cropper(data.method,data.option,null);
         	//$('#croped-image').attr('src',rm.toDataURL(imageType));
         	//var bl = rm.toDataURL("image/jpeg");
         	//var imageBlob = rm.toDataURL().replace('data:image/jpeg;base64,',"");
		  
		 // $uibModalInstance.close(rm);
		  $uibModalInstance.close(rm);
	  };

	  $scope.cancel = function () {
		  $uibModalInstance.dismiss('cancel');
	  };
	});
