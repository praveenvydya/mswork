var vydyaAdmin = angular.module('vydyaAdmin', [
    'ngAnimate',
    'angular.aps',
   // 'ui.router',
    'ui.bootstrap',
    'angular-loading-bar',
  //  'oc.lazyLoad',
    'imageCropApp',
    'ngMessages',
    'checklist-model'
    //'ngTable'
    //'ngOptions'
    
])

vydyaAdmin.controller('ModalInstCtrl', function ($scope, $modalInstance, param) {
		
	  $scope.dto = param.dto;
	  $scope.json = param.json;
	  $scope.save = function (dto) {
		$modalInstance.close(dto);
	  };

	  $scope.cancel = function () {
	    $modalInstance.dismiss('cancel');
	  };
	  
	 $scope.callback = function(fn,dto){
		 
		 //dt = $scope.currentRole;
		 $scope.dto = param.callback(fn,dto);
		
	 }
	 
	 $scope.load = function(dto){
		 //dto = param.load();
		// $scope.dto = angular.copy(dto);
		// $scope.dto = RoleFactory.get();
			//$scope.dto.reportActions = updateAppr($scope.dto.sections);
	 }
	 
	});
	 
vydyaAdmin.directive('nos', function() {
    return {
      require: 'ngModel',
      restrict: 'A',
      link: function(scope, element, attrs, modelCtrl) {
        modelCtrl.$parsers.push(function(inputValue) {
          if (inputValue == undefined)
            return ''
          cleanInputValue = inputValue.replace(/[^\w\s]/gi, '');
         //cleanInputValue = cleanInputValue.replace(/^[A-Za-z][A-Za-z0-9]+$/, '');
         
          if ((cleanInputValue != inputValue)) {
            modelCtrl.$setViewValue(cleanInputValue);
            modelCtrl.$render();
          }           
          return cleanInputValue;
        });
      }
    }
  });


vydyaAdmin.directive('pname', function($templateCache,$compile,$q) {
   return {
           // restrict to an attribute type.
           restrict: 'A',
          // element must have ng-model attribute.
           require: 'ngModel',
           link: function(scope, ele, attrs, ctrl){
              // add a parser that will process each time the value is
              // parsed into the model when the user updates it.
              ctrl.$parsers.unshift(function(value) {
                if(value){
                  // test and set the validity after update.
                     var valid2 = /^[A-Za-z0-9 -]*$/.test(value);
                     ctrl.$setValidity('invalidEntry', valid2);
                    // var valid = /^[A-Za-z][A-Za-z0-9]+$/.test(value);
                    var valid = /^[A-Za-z][A-Za-z0-9 -]+$/.test(value);
                 // var valid = value.charAt(0) == 'A' || value.charAt(0) ==
					// 'a';
                  ctrl.$setValidity('invalidStart', valid);
                }
                // if it's valid, return the value to the model,
                // otherwise return undefined.
                return valid ? value : undefined;
              });

           }
          }
	});

vydyaAdmin.directive('gname', function($templateCache,$compile,$q) {
   return {
           // restrict to an attribute type.
           restrict: 'A',
          // element must have ng-model attribute.
           require: 'ngModel',
           link: function(scope, ele, attrs, ctrl){

              // add a parser that will process each time the value is
              // parsed into the model when the user updates it.
              ctrl.$parsers.unshift(function(value) {
                if(value){
                  // test and set the validity after update.
                   // var valid = /^[A-Za-z][A-Za-z0-9 -]*$/.test(value);
                     var valid = /^[A-Za-z][A-Za-z0-9 -]*$/.test(value);
                 // var valid = value.charAt(0) == 'A' || value.charAt(0) == 'a';
                  ctrl.$setValidity('invalidEntry', valid);
                }
                // if it's valid, return the value to the model,
                // otherwise return undefined.
                return valid ? value : undefined;
              });

           }
          }
});



vydyaAdmin.directive('vyTemplate', function($templateCache,$compile) {
    return {
        restrict: 'A',
        scope:{
            template : "@"
           /* mydata : "=",
            mycallback:"&"*/
        },
        link: function(scope,element) {
            var template = $templateCache.get(scope.template);
           
            element.append($compile(template)(scope));
        }
    }
});


vydyaAdmin.directive('email', function($templateCache,$compile,$q) {
   return {
           restrict: 'A',
           require: 'ngModel',
           link: function(scope, ele, attrs, ctrl){
              ctrl.$parsers.unshift(function(value) {
                if(value){
                  var valid =/^[a-z]+[a-z0-9._]+@[a-z]+\.[a-z.]{2,5}$/.test(value);
                ctrl.$setValidity('invalidEmail', valid);
                }
                return valid ? value : undefined;
              });

           }
          }
	});
	
	
vydyaAdmin.directive('imageRequired', function($templateCache,$compile,$q) {
  return {			  
    restrict: 'A',
    require: 'ngModel',
    link: function(scope, element, attr, ngModel) {
      // fetch the call address from directives 'checkIfAvailable' attribute
      //var serverAddr = attr.checkAvailability;
      
    	 if(ngModel.$valid) {
    		 ngModel.$parsers.unshift(function(value) {
  	           if(value){
  	        	 console.log(value);
  	           }
  		   })
    	 }
    	/*ngModel.$validators.imageRequired = function (modelValue, viewValue) {
             When no value is present 
            var isValid;
            if ((!modelValue || modelValue.length === 0)&&(scope.ng&&scope.ng.imageName=='')) {
                isValid = false;
            } else {
                isValid = true;
                ngModel.$valid = true;
            }
			//(url.lastIndexOf('/') !
             Set required validator as this is not a standard html form input 
            ngModel.$setValidity('required', isValid);


             Return the model so the model is updated in the view 
            return modelValue;
        };*/
     
    }
  }
});

/*vydyaAdmin.directive('checkUnique', function($timeout, $q) {
    return {
   restrict: 'A',
   require: 'ngModel',
     scope:{
        fn : "="
        },
   link: function(scope, elm, attr, model) { 
	   var property = scope.$eval(attr.checkUnique);
	   
	  
      // var currentValue = elm.val();
	  // var mode = property.mode;
	  
	   model.$setValidity('unique', true);
		if(model.$valid) {
			
			scope.$watch(attr.unique, function() {
                        //var compareValue = this.last;
				
      model.$asyncValidators.unique = function(modelValue, viewValue) { 
    	  var disabled = scope.$eval(attr.ngDisabled);
    	  model.$setValidity('checking', false);
    	  var defer = $q.defer();
    	  var action = scope.$parent.action;
    	  if ((typeof  action !== "undefined")&&(action=='add'||(action=='edit'&&(model.$modelValue!==model.$viewValue)))) { 
       //  $timeout(function(){
          scope.fn(property,modelValue).then(function (response) {
        	  model.$setValidity('unique', !(response.valid)); 
			  model.$setValidity('checking', true);
          }).catch(function (response, error) {
              console.log(response);
          });
         defer.resolve;
      // }, 1000);
    	  } else {
    		  model.$setValidity('unique', true); 
			  model.$setValidity('checking', true);
			  model.$valid = true;
			  defer.resolve;
          }
    	  return defer.promise;
     };
	 
			});
		}
	 
   }
 } 
});*/


vydyaAdmin.directive('checkUnique', function($timeout, $q) {
    return {
   restrict: 'A',
   require: 'ngModel',
     scope:{
        fn : "="
        },
   link: function(scope, elm, attr, model) { 
	   var property = scope.$eval(attr.checkUnique);
	    // var currentValue = elm.val();
	  // var mode = property.mode;
	  
	   model.$setValidity('unique', true);
	   var defer = $q.defer();
	   var action = scope.$parent.action;
	   if(model.$valid) {
		   model.$parsers.unshift(function(value) {
	           if(value){
	        	   var valid = true;
	        	   var disabled = scope.$eval(attr.ngDisabled);
	        	   model.$setValidity('checking', false);
	        	   
	        	   if ((typeof  action !== "undefined")&&(action=='add'||(action=='edit'&&(model.$modelValue!==model.$viewValue)))) { 
	        	          scope.fn(property,value).then(function (response) {
	        	        	  valid = !response.valid;
	        	        	  if(response.valid==true){
	        	        		  model.$setValidity('unique', false);
	        	        	  }
	        	        	  else{
	        	        		  model.$setValidity('unique', true);
	        	        	  }
	        				  model.$setValidity('checking', true);
	        	          }).catch(function (response, error) {
	        	              console.log(response);
	        	             valid = false;
	        	          });
	        	    	  } else {
	        	    		  model.$setValidity('unique', true); 
	        				  model.$setValidity('checking', true);
	        				  model.$valid = true;
	        	          }
	           }
	           return valid ? value : undefined;
	         });
		}
	 
   }
 } 
});


vydyaAdmin.directive('username', function($timeout, $q) {
    return {
   restrict: 'A',
   require: 'ngModel',
   link: function(scope, elm, attr, ctrl) { 
       elm.bind('keypress', function(e){
           if(elm[0].value.length >= 8){ //scope.wmBlockLength){
             e.preventDefault();
             return false;
           }
         });
         ctrl.$parsers.unshift(function(value) {
               if(value&&value.length>5){
                   ctrl.$setValidity('minl', true); 
                   var valid1 = /^[A-Za-z0-9]*$/.test(value);
                   ctrl.$setValidity('invalidEntry', valid1); 
                  
               if(valid1){
                    var valid = /^AP|ap.*$/.test(value);
                    ctrl.$setValidity('username', valid);
                    }
               }
               else{
                   ctrl.$setValidity('minl', false); 
               }
               // if it's valid, return the value to the model,
               // otherwise return undefined.
               return valid ? value : undefined;
             });
   }
 } 
});

vydyaAdmin.directive('modalTrigger', function($vydyaModal,$timeout, $q) {
	 function postLink(scope, iElement, iAttrs) {
		    function onClick() {
		    	var template = scope.$eval(iAttrs.template);
		         var controller = scope.$eval(iAttrs.c);
		         var params = {
		        		 size:scope.$eval(iAttrs.size) || 'sm',
		        		 header:scope.$eval(iAttrs.header) || 'Default Title',
		        		 message:scope.$eval(iAttrs.message) || 'Default Message',
		        		 ng:scope.$eval(iAttrs.data),
		        		 action:scope.$eval(iAttrs.action),
		        		 m:scope.$eval(iAttrs.m),
		        		 hidden:scope.hidden
		         };
		         
		         $vydyaModal.open(template,controller,params);
		    }
		    iElement.on('click', onClick);
		    scope.$on('$destroy', function() {
		      iElement.off('click', onClick);
		    });
		  }
	
    return {
   restrict: 'A',
   link: postLink
 } 
});

vydyaAdmin.factory('$vydyaModal', function($uibModal) {
	var open = function (template,controller,params) {
	    return $uibModal.open({
	      controller: controller,
	      controllerAs: 'vm',
	      templateUrl : template,
	      size: params.size,
	    backdrop : 'static',
	      resolve: {
	        items: function() {
	          return {
	            data:params
	          };
	        }
	      }
	    });
	  };

	  return {
	    open: open
	  };

});


vydyaAdmin.directive('imagePreview', function($templateCache,$compile,$q,gService) {
	  return {			  
	    restrict: 'A',
	    link: function(scope, element, attr) {
	    	if(scope.ng&&scope.ng.imageName!=''){
	    		var imagePath = scope.hidden.imageUrl+""+scope.ng.imageName;
		    	 attr.$set('src',imagePath);
	    	}
	    	else{
	    		 attr.$set('src', scope.hidden.staticImageUrl);
	    	}
	    	
	    }
	  }
	});

vydyaAdmin.directive('uiDatePicker', function($templateCache,$compile,$q,gService) {
	  return {			  
	    restrict: 'A',
	    link: function(scope, element, attr) {
			
			 var config = {};
               
              //  element.datetimepicker(config);
	    	element.datetimepicker({  
	            changeMonth: true,
	            changeYear: true,
	            showButtonPanel: true,
				//dateFormat:'dd/mm/yy',
				dateFormat:attr.df,
				//yearRange: stY+":"+endY,
				ampm : true,
				showButtonPanel: false
				//shortYearCutoff: 10
	        }); 
	    }
	  }
	});

vydyaAdmin.directive('rmCheckbox', function($templateCache,$compile,$q,gService) {
	  return {			  
	    restrict: 'A',
	    require:'ngModel',
	    link: function(scope, element, attr) {
	    	scope.$watch(attr.ngModel,function(){
	    		alert(jQuery(element).is(':checked'));
	    	});
	    	element.bind('clcik',function(){
	    		scope.$apply(function(){
	    			ctrl.$setViewValue(element.hasClass('checked'));
	    		});
	    		
	    	});
	    }
	  }
	});


vydyaAdmin.directive('vdate', function($templateCache,$compile,$q) {
    return {
        restrict: 'A',
        require: 'ngModel',
        
        link: function(scope, element, attr, ngModel) {
            ngModel.$asyncValidators.invalidDate = function(modelValue, viewValue) {
            	var deferred = $q.defer();
            	var valid = /^\d{2}\/\d{2}\/\d{4}$/.test(viewValue);    
            	var d = new Date(viewValue);
                var dd = (d.getDate() < 10 ? '0' : '') + d.getDate();
                var MM = ((d.getMonth() + 1) < 10 ? '0' : '') + (d.getMonth() + 1);
                var yyyy = d.getFullYear();
          if(valid && !isNaN( d.getTime()) && (viewValue==MM+"/"+dd+"/"+yyyy) ){
                deferred.resolve(); 
          }
          else{
              deferred.reject();
          }
       
        // return the promise of the asynchronous validator
        return deferred.promise;
      }  
            
        }
    }
});

/*vydyaAdmin.filter('filterReceiptsForDate', function () {
	  return function (input, scope) {
	    return input + ' <strong>' + scope.var2 + '</strong>';
	  };
	});
*/
/*vydyaAdmin.directive('username', function($templateCache,$compile,$q,gService) {
	  return {			  
	    restrict: 'A',
	    require: 'ngModel',
	    link: function(scope, element, attr, ngModel) {
	    	ngModel.$validators.username = function (modelValue, viewValue) {
	             When no value is present 
	            var isValid =true;
	            if (viewValue) {
	            	if(viewValue.length < 5){
	            		isValid =false;
	            	ngModel.$setValidity('minl', isValid);
	            	}
	            	else{
	            		var g ={};
		        		g['t'] = 'v';
		        		g['p'] = 'username';
		        		g['val'] = viewValue;
		        		
		    			gService.load(g).then(function (response) {
		    		 		if(!angular.equals(response, {})){
		    		 			ngModel.$setValidity('existed', !(response.valid));
		    				}
		    			   })
		    			   .catch(function (response) {
		    			       console.log(response);
		    			   });
	            	}
	            } else{

	            	
	            }
	            return modelValue;
	        };
	     
	    }
	  }
	});*/

vydyaAdmin.controller('modalCtrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService,$uibModalInstance, items,
		$rootScope,$parse) {
	 var vm = this;
	 vm.content = items;
	 
	$scope.action = vm.content.data.action ;
	$scope.header = vm.content.data.header;
	$scope.ng = vm.content.data.ng;
	
	var hidden = vm.content.data.hidden;
	$scope.hidden = hidden;
	
	if(hidden.dependent){
		loadDependent();
	}
	
	function loadDependent(){
		hidden.loadDependentData($scope).then(function (response) {
			$scope.ng=response;
		})
	}
	/*angular.forEach(vm.content.data.hidden, function(v, k) {
			if(k!=null){
				$parse(k).assign($scope,v);
			}
		})*/
	
	 gService.setBaseUrl(hidden.baseUrl);
	 apService.setUrl(hidden.baseUrl);
	  
	
	$scope.submitted= true;
	$scope.submitForm = function(valid)
	 {
		var model = this;
		 if(valid){
	   if ($scope.action==='add')
	   {
		   if(angular.isFunction(hidden.defaults)){
			   $scope.ng = angular.extend($scope.ng, hidden.defaults($scope.ng));
		   }
				 gService.add(JSON.stringify($scope.ng)).then(function(response) {
					 if(!angular.equals(response, {})&response.data.success){
						 $uibModalInstance.dismiss('cancel');
						 growlService.growl(hidden.item+' added Successfully!', 'success'); 
						 $scope.submitted= true;
						 $rootScope.$broadcast(hidden.module+'-ADDED', {
				                data: response
				            }); 	
			 			}
					 else{
						 swal("Failed !", "Unable to add "+hidden.item, "error");
					 } 
				});
				 
	   }   
	   else
	   {
		gService.edit(JSON.stringify($scope.ng)).then(function(response) {
			 if(!angular.equals(response, {})&response.data.success){
				 $uibModalInstance.dismiss('cancel');
				 growlService.growl(hidden.item+' updated Successfully!', 'success'); 
				 $scope.submitted= true;
				 $rootScope.$broadcast(hidden.module+'-UPDATED', {
		                data: response
		            }); 
			 }
			 else{
				 swal("Failed !", response.data.message, "fail");
				 //growlService.growl(response.data.message, 'error'); 
			 }
			 
		});
	   }   
	 }
		 else{
			   $scope.submitted= false;	
		 }
	}
	
	 $scope.close =  function(){
		 $uibModalInstance.dismiss('cancel');
	 }
})
	 