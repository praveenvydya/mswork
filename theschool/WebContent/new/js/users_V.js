
//vydyaAdmin.constant("UserStatusType", new com.vydya.theschool.common.types.UserStatusType());
    
	vydyaAdmin.controller('usersctrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService,$rootScope) {
	 $scope.users = {};
	 gService.setBaseUrl('/theschool/admin/manageUsers');
	 apService.setUrl('/theschool/admin/manageUsers');
	 
	 load();
	 function load(){
	 var d  = {};
	 	gService.view(d).then(function (response) {
	 		if(!angular.equals(response, {})){
				$scope.users = response;
			}
		   })
		   .catch(function (response) {
		       console.log(response);
		   });
	 }
	 
 $scope.imageUpdated=false; 
 $scope.ng = "";
$scope.refresh = function(){
	load();
}
 
 $scope.delete = function(ind)
 {
	 var dg= $scope.users[ind];
	 swal({   
         title: "Are you sure?",   
         text: "Do You want remove this User?",   
         type: "warning",   
         showCancelButton: true,   
         confirmButtonColor: "#F44336",   
         confirmButtonText: "Yes, delete it!",   
         closeOnConfirm: false 
     }, function(){
    	 gService.delete(JSON.stringify(dg)).then(function(data) {
 		 	//$scope.users.splice( ind, 1 ); 
 		 	var d  = {};
 		 	gService.view(d).then(function (response) {
 		 		if(!angular.equals(response, {})){
 					$scope.users = response;
 				}
 			   })
 			   .catch(function (response) {
 			       console.log(response);
 			   });
 		 	// display deleted message
 		 	swal("Done!", "User Deleted", "success"); 
 		}).catch(function (response) {
		       console.log(response);
			   swal("Failed !", "Unable to delete", "fail");
		   });;
         
     });
 }
 
 
/* 
 $scope.edit = function(ind,g)
 {
	   $scope.editMode = true;
	   $scope.mode = 'edit';
	   $scope.btnText = "Edit User";
	   $scope.ng = angular.copy(g); // ??
	   $scope.ng.action="edit";
	   $scope.currentItem = g;  // ??
	   $scope.ind = ind;
	 $('#userForm').modal('show');   
 }
 */
/*
 $scope.add = function()
 {
	 $scope.ng = {};
	 //$scope.ng.$setPristine;
	 $scope.ng.action="add";
	 $('#userForm').modal('show');   
 }
 */

 $rootScope.$on("USER-ADDED", function (evet, args) {
load();
 });
 $scope.imageUpdated=false; 
 $scope.btnText = "Add User";
 $scope.ng = "";
 $scope.submitted= true;
 $scope.submitUserForm = function(valid)
 {
		   if (!$scope.editMode)
		   {
			 if(valid){
				 
			 var dg= {};
			 dg['userName']=$scope.ng.userName;
			 dg['firstName']=$scope.ng.firstName;
			 dg['lastName']=$scope.ng.lastName;
			 dg['status']=$scope.ng.status;
			 dg['email']=$scope.ng.email;
			 dg['status']=$scope.ng.status;
			 dg['groupId']=$scope.ng.groupId;
			 dg['roleId']=$scope.ng.roleId;
			 dg['adminRole']=$scope.ng.adminRole;
			 
			 gService.add(JSON.stringify(dg)).then(function (response) {
			 		if(!angular.equals(response, {})||response.success){
			 			var d  = {};
			 		 	gService.view(d).then(function (response) {
			 		 		if(!angular.equals(response, {})){
			 					$scope.users = response;
			 				}
			 	      })
			 	      .catch(function (response) {
			 	          console.log(response);
			 	      });
			 		 	 $scope.ng = "";
						 $('#userForm').modal('hide');  
						 growlService.growl("User "+' is added Successfully!', 'success');
		 			}
		         })
		         .catch(function (response) {
		             console.log(response);
		         });
		   }

			 else{
				 
				 $scope.submitted= false;	
			 }		   
		   }		   
		   else
		   {
			   
			   this.uForm.username.$valid =true;
			   this.uForm.email.$valid =true;
			 if(valid){ 
				
			  var dg= {};
				 dg['firstName']=$scope.ng.firstName;
				 dg['lastName']=$scope.ng.lastName;
				 dg['status']=$scope.ng.status;
				
				 dg['status']=$scope.ng.status;
				 dg['group']=$scope.ng.groupId;
				 dg['role']=$scope.ng.roleId;
				 dg['adminRole']=$scope.ng.adminRole;
			  // dg['unid'] = $scope.currentItem.unid = $scope.ng.unid;
			
			gService.edit(JSON.stringify(dg)).then(function(data) {
				var d  = {};
	 		 	gService.view(dg).then(function (response) {
	 		 		if(!angular.equals(response, {})){
	 					$scope.users = response;
	 				}
	 	      })
	 	      .catch(function (response) {
	 	          console.log(response);
	 	      });
	 		 	
				 $scope.ng = "";
				 $('#userForm').modal('hide');
				 growlService.growl("User "+' is updated Successfully!', 'success'); 
			});
			
			 $scope.editMode = false;
			 $('#userForm').modal('hide'); 
			 $scope.action="add";
			 $scope.btnText = "Add User";
			 
			 }
			 else{
				 
				 $scope.submitted= false;	
			 }
		   }   
	 
 };
 
 
 $scope.close = function()
 {
	 $scope.ng = {};
	 $scope.submitted = true;
	 $scope.editMode = false;
	$scope.uForm.$setPristine();
	// $scope.gForm.$setUntouched();
	   $('#userForm').modal('hide');   
 }

 $scope.addx = function () {
	
		/*var g={};
		 var par = {};
		 g['action'] = 'Add';
		 par['dto'] = g;
		 var ls = {};
		 ls['urs'] = $scope.urs;
			ls['ug'] = $scope.ug;
			 ls['ars'] = $scope.ars;
			 ls['us'] = $scope.us;
		 
		 //ls['urs'] = $scope.urs;
		// ls['ug'] = $scope.ug;
		 //ls['ars'] = $scope.ars;
		 par['json'] = ls;
   var modalInstance = $uibModal.open({
     animation: $scope.animationsEnabled,
     templateUrl: 'manageuser.html',
     controller: 'ModalInstCtrl',
     size: "lg",
     backdrop : 'static',
 	 keyboard :false,
     resolve: {
    	 param: function () {
	          return par;
	        }  
     }
   });
   modalInstance.result.then(function (nd) {
 		 apService.add(nd).then(function(data) {
 			
 			if(data.data.respData.success){
 				$scope.users[ind] = data.data.respData;
 	 	 		 growlService.growl("User "+' has updated Successfully!', 'success');  
 			 }
 			 else{
 				growlService.growl('Unable to update User', 'error'); 
 			 } 
		});
 	 
 	    }, function () {
 	      //$log.info('Modal dismissed at: ' + new Date());
 	});*/
 }
 /*$scope.showStatus = function(ng) {
	    if(ng.status && $scope.gs.length) {
	      var selected = $filter('filter')($scope.sts, {id: ng.status});
	      return selected.length ? selected[0].text : 'Not set';
	    } else {
	      return ng.status || 'Not set';
	    }
	  };*/

$scope.hideAction=function(v){

	return false;
} 
	  
 $scope.editx = function (ind,g) {
	 
	 var par = {};
	 g['action'] = 'Edit';
	 par['dto'] = g;
	 var ls = new Array();
	
	 ls['urs'] = $scope.urs;
	ls['ug'] = $scope.ug;
	 ls['ars'] = $scope.ars;
	 ls['us'] = $scope.us;
	 par['json'] = ls;
	 par['callback'] = function (fn,ng){
		 if(fn=='get'){
			if(ng=='urs'){
				return $scope.urs;
			}
			if(ng=='ug'){
				return $scope.ug;
			}
			if(ng=='ars'){
				return $scope.ars;
			}
		 }
	  }
   var modalInstance = $uibModal.open({
     animation: $scope.animationsEnabled,
     templateUrl: 'manageuser.html',
     controller: 'ModalInstCtrl',
     size: "lg",
     backdrop : 'static',
 	 keyboard :false,
     resolve: {
       param: function () {
	          return par;
	        }
     }
   });
   modalInstance.result.then(function (nd) {
 		 apService.edit(nd).then(function(data) {
 			 
 			 if(data.data.respData.success){
 				
 				//$scope.users.push(data.data.respData);
 				var d  = {};
 			 	gService.view(d).then(function (response) {
 			 		if(!angular.equals(response, {})){
 						$scope.users = response;
 					}
 				   })
 				   .catch(function (response) {
 				       console.log(response);
 				   });
 			 	
 	 	 		 growlService.growl("User details"+' updated Successfully!', 'success');  
 			 }
 			 else{
 				growlService.growl('Unable to update User', 'error'); 
 			 }
		});
 		
 	    }, function () {
 	      //$log.info('Modal dismissed at: ' + new Date());
 	});
 };
 
 
 
});
	
	vydyaAdmin.controller('adminUser', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService,$uibModalInstance, items,
			$rootScope) {
		 $scope.users = {};
		 gService.setBaseUrl('/theschool/admin/manageUsers');
		 apService.setUrl('/theschool/admin/manageUsers');
		  
		 var vm = this;
		 vm.content = items;
		 
		$scope.action = vm.content.data.action ;
		$scope.title = vm.content.data.header;
		$scope.ng = vm.content.data.ng;
		 vm.cancel = $uibModalInstance.dismiss;
		 
		
		 $scope.verify= function(prop,value){
			 var g ={};
				g['t'] = 'v';
				g['p'] = prop.key;
				g['val'] = value;
				var dfd = $q.defer();
				gService.load(g).then(function (response) {
			 		if(!angular.equals(response, {})){
			 			dfd.resolve(response);
					}
				   })
				   .catch(function (response) {
					   dfd.reject(response);
				       console.log(response);
				   });
				return dfd.promise;
		 }
		 
		 $scope.submitted= true;
		 $scope.submitUserForm = function(valid)
		 {
				   if ($scope.action=='add')
				   {
					 if(valid){
						 
					 var dg= {};
					 dg['userName']=$scope.ng.userName;
					 dg['firstName']=$scope.ng.firstName;
					 dg['lastName']=$scope.ng.lastName;
					 dg['status']=$scope.ng.status;
					 dg['email']=$scope.ng.email;
					 dg['groupId']=$scope.ng.groupId;
					 dg['roleId']=$scope.ng.roleId;
					 dg['adminRole']=$scope.ng.adminRole||0;
					 
					 gService.add(JSON.stringify(dg)).then(function (response) {
					 		if(!angular.equals(response, {})||response.success){
					 			/*var d  = {};
					 		 	gService.view(d).then(function (response) {
					 		 		if(!angular.equals(response, {})){
					 					$scope.users = response;
					 				}
					 	      })
					 	      .catch(function (response) {
					 	          console.log(response);
					 	      });*/
					 			//$uibModalInstance.close;
					 			$uibModalInstance.dismiss('cancel');
					 		 	 //$scope.ng = "";
								// $('#userForm').modal('hide'); 
					 			$rootScope.$broadcast("USER-ADDED", {
					                data: response
					            });
								 growlService.growl("User "+' is added Successfully!', 'success');
				 			}
				         })
				         .catch(function (response) {
				             console.log(response);
				         });
				   }

					 else{
						 
						 $scope.submitted= false;	
					 }		   
				   }		   
				   else
				   {
					   
					   this.uForm.username.$valid =true;
					   this.uForm.email.$valid =true;
					 if(valid){ 
						
					  var dg= {};
						 dg['firstName']=$scope.ng.firstName;
						 dg['lastName']=$scope.ng.lastName;
						 dg['userName']=$scope.ng.userName;
						 dg['status']=$scope.ng.status;
						 dg['groupId']=$scope.ng.groupId;
						 dg['roleId']=$scope.ng.roleId;
						 dg['adminRoleId']=$scope.ng.adminRoleId;
						 dg['userId'] = $scope.ng.userId;
						 dg['email']=$scope.ng.email;
					  // dg['unid'] = $scope.currentItem.unid = $scope.ng.unid;
					
					gService.edit(JSON.stringify(dg)).then(function(response) {
			 		 		if(!angular.equals(response, {})&&response.data.success){
			 		 			$uibModalInstance.dismiss('cancel');
			 		 			$rootScope.$broadcast("USER-ADDED", {
					                data: response
					            });
			 		 			 growlService.growl("User "+' is updated Successfully!', 'success'); 
			 		 			
			 				}
			 		 		else{
			 		 			 swal({   
			 		 		         title: "Failed",   
			 		 		         text: response.data.message,   
			 		 		         type: "warning",   
			 		 		     }, function(){
			 		 		    	 
			 		 		     })
			 		 		     }
			 		 			 //growlService.growl(response.data.message, 'error'); 
			 		 		})
			 		 	//$uibModalInstance.dismiss('cancel');
					}
					 else{
						 
						 $scope.submitted= false;	
						 
					 }
				   }   
			 
		 };
		 
		 $scope.cancel =  $uibModalInstance.close;
		 $scope.closex = function()
		 {
			 $uibModalInstance.close;
			 $uibModalInstance.dismiss;
			 
			 $scope.ng = {};
			 $scope.submitted = true;
			 $scope.editMode = false;
			$scope.uForm.$setPristine();
			// $scope.gForm.$setUntouched();
		 }
		 
		 var g ={};
			g['t'] = 'g';
			$scope.ug ={};
				gService.load(g).then(function (response) {
			 		if(!angular.equals(response, {})){
						$scope.ug = response;
					}
				   })
				   .catch(function (response) {
				       console.log(response);
				   });
			 	
			var ud ={};
			ud['t'] = 'ur';
			$scope.urs = {};
			gService.load(ud).then(function (response) {
		 		if(!angular.equals(response, {})){
					$scope.urs = response;
				}
			   })
			   .catch(function (response) {
			       console.log(response);
			   });
			
			var ad={};
			ad['t'] = 'ar';
			$scope.ars= {};
			gService.load(ad).then(function (response) {
		 		if(!angular.equals(response, {})){
					$scope.ars = response;
				}
			   })
			   .catch(function (response) {
			       console.log(response);
			   });
			  $scope.us = [
			               {val: 0, text: 'Inactive'},
			               {val: 1, text: 'Active'},
			               {val: 2, text: 'Locked'},
			               {val: 3, text: 'Security_QA_Locked'}
			             ]; 
		 
	});


	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 