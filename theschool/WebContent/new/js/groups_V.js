
//var groupsApp = angular.module('groupsApp', ['angular.aps','ngAnimate', 'ui.bootstrap','imageCropApp','angular-loading-bar']).
	vydyaAdmin.controller('groupsctrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService) {
	 $scope.groups = {};
	 gService.setBaseUrl('/theschool/admin/manageGroups');
	 apService.setUrl('/theschool/admin/manageGroups');
	 
	 var d  = {};
	 	gService.view(d).then(function (response) {
	 		if(!angular.equals(response, {})){
				$scope.groups = response;
			}
      })
      .catch(function (response) {
          console.log(response);
      });
	 	
	 	
	 	
	/* var d={};
		// d['a']="gs";
		// d['y']="2015";
		apService.view(d).then(function(data) {
			 $scope.groups = data.data;
		});*/
	
 $scope.imageUpdated=false; 
 $scope.btnText = "Add Group";
 $scope.ng = "";
  
 $scope.save = function(valid)
 {
	 if(valid){
		 
		   if (!$scope.editMode)
		   {
			 var dg= {};
			 dg['groupName']=$scope.ng.groupName;
			 dg['groupDesc']=$scope.ng.groupDesc;
			 dg['groupStatus']=$scope.ng.groupStatus;
			// if($scope.isformValid() && $scope.gForm.$valid){
			 
			 
			 gService.add(JSON.stringify(dg)).then(function (response) {
			 		if(!angular.equals(response, {})||response.success){

			 			var d  = {};
			 		 	gService.view(d).then(function (response) {
			 		 		if(!angular.equals(response, {})){
			 					$scope.groups = response;
			 				}
			 	      })
			 	      .catch(function (response) {
			 	          console.log(response);
			 	      });
			 		 	 $scope.ng = "";
						 $('#groupForm').modal('hide');  
						 growlService.growl("Group "+' is added Successfully!', 'success');
		 				
		 			}
		         })
		         .catch(function (response) {
		             console.log(response);
		         });
			 
		   }   
		   else
		   {
			  var  dg ={};
			  dg['groupId']=$scope.ng.groupId;
			  dg['groupName'] = $scope.currentItem.groupName = $scope.ng.groupName; // ??
			  dg['groupDesc'] = $scope.currentItem.groupDesc = $scope.ng.groupDesc;
			  dg['groupStatus'] = $scope.currentItem.groupStatus = $scope.ng.groupStatus; // ??
			  // dg['unid'] = $scope.currentItem.unid = $scope.ng.unid;
			
			gService.edit(JSON.stringify(dg)).then(function(data) {
				
				var d  = {};
	 		 	gService.view(dg).then(function (response) {
	 		 		if(!angular.equals(response, {})){
	 					$scope.groups = response;
	 				}
	 	      })
	 	      .catch(function (response) {
	 	          console.log(response);
	 	      });
	 		 	
				 $scope.ng = "";
				 $('#groupForm').modal('hide');
				 growlService.growl("Group "+' is updated Successfully!', 'success'); 
			});
			
			 $scope.editMode = false;
			 $('#groupForm').modal('hide'); 
			 $scope.action="add";
			 $scope.btnText = "Add Group";
			
		   }   
	 }
	 else{
		 
		 
	 }
 };
 
 $scope.delete = function(ind)
 {
	 var dg= $scope.groups[ind];
	 
	 swal({   
         title: "Are you sure?",   
         text: "All the Group Items in the Group will be removed",   
         type: "warning",   
         showCancelButton: true,   
         confirmButtonColor: "#F44336",   
         confirmButtonText: "Yes, delete it!",   
         closeOnConfirm: false 
     }, function(){
    	 gService.delete(JSON.stringify(dg)).then(function(data) {
 		 	$scope.groups.splice( ind, 1 ); 
 		 	var d  = {};
 		 	gService.view(dg).then(function (response) {
 		 		if(!angular.equals(response, {})){
 					$scope.groups = response;
 				}
 	      })
 	      .catch(function (response) {
 	          console.log(response);
 	      });
 		 	
 		 	// display deleted message
 		 	swal("Done!", "Group and all items are deleted", "success"); 
 		});
         
     });
	 
 }
 

 $scope.add = function () {
	
		var g={};
		 var par = {};
		 g['action'] = 'Add';
		 par['dto'] = g;
		 par['json'] = $scope.sts;
   var modalInstance = $uibModal.open({
     animation: $scope.animationsEnabled,
     templateUrl: 'managegroup.html',
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
 				$scope.groups.push(data.data.respData);
 	 	 		 growlService.growl("Group "+' has updated Successfully!', 'success');  
 			 }
 			 else{
 				growlService.growl('Unable to update Group', 'error'); 
 			 } 
		});
 	 
 	    }, function () {
 	      //$log.info('Modal dismissed at: ' + new Date());
 	});
 }
 $scope.sts = [
                    {val: 0, text: 'Inactive'},
                    {val: 1, text: 'Active'}
                  ]; 
 /*$scope.showStatus = function(ng) {
	    if(ng.status && $scope.gs.length) {
	      var selected = $filter('filter')($scope.sts, {id: ng.status});
	      return selected.length ? selected[0].text : 'Not set';
	    } else {
	      return ng.status || 'Not set';
	    }
	  };*/

	 
	  
 $scope.edit = function (ind,g) {
	 
	 var par = {};
	 g['action'] = 'Edit';
	 par['dto'] = g;
	 par['json'] = $scope.sts;
	 par['callback'] = function (fn,ng){
		 if(fn=='showStatus'){
			 var selected;
			  var st = ng.groupStatus;
			  if(st!==""){
				  selected = $.grep($scope.sts,function(x){
					  return x.val ===st;
				  })[0].text;
			  }
			  return selected.length?selected:'Select Status';
		 }
	  }
   var modalInstance = $uibModal.open({
     animation: $scope.animationsEnabled,
     templateUrl: 'managegroup.html',
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
 				$scope.groups[ind] = data.data.respData;
 	 	 		 growlService.growl("Group "+' has updated Successfully!', 'success');  
 			 }
 			 else{
 				growlService.growl('Unable to update Group', 'error'); 
 			 }
		});
 		
 	    }, function () {
 	      //$log.info('Modal dismissed at: ' + new Date());
 	});
 };
 
 
 
});
	




	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 