
    vydyaAdmin.factory('RoleFactory',function($http){
    	
    	var data = [];
    	return {
    		resolver:function(){
    			var r ={};
    			r['actionName']='ad';
    			return $http.post('/theschool/admin/manageRoles/load.htm',r).success(function(resp){
    				data = resp;
    			})
    		},
    		get(){
    			return data;
    		}
    	}
    	
    });

	vydyaAdmin.controller('rolesctrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService,RoleFactory,$rootScope) {
	 $scope.roles = {};
	 $scope.editmode = false;
	 gService.setBaseUrl('/theschool/admin/manageRoles');
	 apService.setUrl('/theschool/admin/manageRoles');
	 
	 load();
	 function load(){
	 var d  = {};
	 	gService.view(d).then(function (response) {
	 		if(!angular.equals(response, {})){
	 			$scope.roles = response.respData;
				 $scope.sessionRole = response.respData2;
			}
		   })
		   .catch(function (response) {
		       console.log(response);
		   });
	 	
	 }
	 $scope.hideAction=function(v){
		return v.roleType=='Portal Administrator';	
	 } 

	 $scope.refresh=function(){
		 load();
	 }
	 
	 $rootScope.$on("ROLE-ADDED", function (evet, args) {
		 	load();
	 });
	 
	 var hiddenData = {};
	 hiddenData['baseUrl']= '/theschool/admin/manageRoles';
	 hiddenData['module']='ROLE';
	 hiddenData['item']='Role ';
	 hiddenData['dependent']=true;
	 hiddenData['loadReportActions'] = 
		 function(r,a) {
		 r.actionName = a;
			apService.load(r).then(function(response) {
				return {
					//"currentRole":response.data,
					//"reportActions":updateAppr(response.data.sections)
				}
				//$scope.currentRole = data.data;
				//$scope.currentRole.reportActions = updateAppr(response.data.sections);
			});
	}
	 hiddenData['loadDependentData'] = function(sc){
		 var ng;
		 if(sc.ng&&!(sc.ng==undefined)){
			 ng=sc.ng;
		 }
		 else{
			 ng={}
		 }
			 ng.actionName=sc.action;
			 var dfd = $q.defer();
		 var depData =  new Array();
		 gService.load(ng).then(function (response) {
		 		if(!angular.equals(response, {})){
		 			//depData['currentRole']=response;
		 			//var ra = updateAppr(response.sections);
		 			var ra = response.sections;
		 			//depData['reportActions'] = ra;
		 			//depData['rp']=checkboxTree(response.sections);
		 			//ng.currentRole = response;
		 			ng.selectedReportActions = response.selectedReportActions;
		 			ng.reportActions =ra;
		 			 dfd.resolve(ng); 
				}
			   })
			   .catch(function (response) {
			       console.log(response);
			   });
		 
		 return dfd.promise;
	 }
	 hiddenData['defaults'] =function(ng){
		 
		 var actions = [];
		 angular.forEach(ng.reportActions, function(sv, sk) {
			 angular.forEach(sv.reports, function(rv, rk) {
				 angular.forEach(rv.actions, function(av,ak) {
					 
					 if(av.selected==true){
						actions.push(av.reportActionId);
					 }
				 }) 
			 })
		 });
		 
		 return {
			'listChanged':$scope.listChanged 
		 }
			 
	 };
	 $scope.listChanged = false;
 hiddenData['listChanged'] =function(){
		 
		$scope.listChanged=true;
			 
	 };
	 
	 $scope.hidden = hiddenData;
	 
	/* $scope.loadReportActions = function(r) {
		 var d={};
		 d['actionName']='ad';
		 d['dto'] = angular.copy(r);
		 
			apService.load(r).then(function(data) {
				// $scope.dto = data.data;
				$scope.currentRole = data.data;
				$scope.currentRole.reportActions = updateAppr(data.data.sections);
				//return $scope.currentRole.reportActions;
			});
	}*/
	 
	 
 $scope.delete = function(ind)
 {
	 var dg= $scope.roles[ind];
	 
	 swal({   
         title: "Are you sure?",   
         text: "Do You want remove this Role?",   
         type: "warning",   
         showCancelButton: true,   
         confirmButtonColor: "#F44336",   
         confirmButtonText: "Yes, delete it!",   
         closeOnConfirm: false 
     }, function(){
    	 gService.delete(JSON.stringify(dg)).then(function(data) {
 		 	$scope.roles.splice( ind, 1 ); 
 		 	// display deleted message
 		 	swal("Done!", "Role Deleted", "success"); 
 		});
         
     });
	 
 }
 
 /*
 $scope.edit = function (ind,r) {
	 
	 r.actionName='ed';
	 loadReportActions(r);
	 
	 var par = {};
	 g['action'] = 'Edit';
	 par['dto'] = $scope.currentRole;
	 //par['json'] = $scope.sts;
	 
  var modalInstance = $uibModalInstance.open({
    animation: $scope.animationsEnabled,
    templateUrl: 'manageRole.html',
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
	 	 		 growlService.growl("Role "+' has updated Successfully!', 'success');  
			 }
			 else{
				growlService.growl('Unable to update Role', 'error'); 
			 }
		});
		
	    }, function () {
	      //$log.info('Modal dismissed at: ' + new Date());
	});
};

*/
 

/*
$scope.add = function () {
	
	//loadReportActions(r);
	
	 var par = {};
	 var r={};
	// var repA = loadReportActions();
	 RoleFactory.resolver();
	 par['action'] = 'Add';
	 par['callback'] = function(fn,dt){
		 
		 if(fn=='ld'){
			 var d={};
			 d['actionName']='ad';
			 apService.load(d).then(function(data) {
					// $scope.dto = data.data;
					$scope.currentRole = data.data;
					$scope.currentRole.reportActions = updateAppr(data.data.sections);
					//return $scope.currentRole.reportActions;
				});
		 }
		 if(fn=='get'){
			 return $scope.currentRole;
		 }
		 
	 }

	
		
		//var rl = RoleFactory.get();
  var modalInstance = $uibModalInstance.open({
    animation: $scope.animationsEnabled,
    templateUrl: 'manageRole.html',
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
				$scope.roles[ind] = data.data.respData;
	 	 		 growlService.growl("Role "+' has updated Successfully!', 'success');  
			 }
			 else{
				growlService.growl('Unable to update Role', 'error'); 
			 }
		});
		
	    }, function () {
	      //$log.info('Modal dismissed at: ' + new Date());
	});
};
*/


/*function Choice(name,id,check, children) {
	  this.name = name;
	  this.checked = check||false;
	  this.reportActionId= id;
	  this.children = children || [];
	}

function checkboxTreex(sc){
	 var sections = [];
	angular.forEach(sc, function(sv, sk) {
		 var reports =[];
		angular.forEach(sv.reports, function(rv, rk) {
			var actions =[];
			angular.forEach(rv.actions, function(av, ak) {
				actions.push({"actionName":av.actionName,"reportActionId":av.reportActionId,selected:false})
				});
			reports.push({"reportName":rv.reportName,"reportId":rv.reportId,selected:false,"actions":actions});
			})
		sections.push({"sectionDesc":sv.sectionDesc,"sectionId":sv.sectionId,selected:false,"reports":reports});
		})
		11
		return sections;
	}
*/


/*function checkboxTree(sc){
	 var sections = [];
	angular.forEach(sc, function(sv, sk) {
		 var reports =[];
		angular.forEach(sv.reports, function(rv, rk) {
			var actions =[];
			angular.forEach(rv.actions, function(av, ak) {
				actions.push({"actionName":av.actionName,"reportActionId":av.reportActionId,selected:false})
				});
			reports.push({"reportName":rv.reportName,"reportId":rv.reportId,selected:false,"children":actions});
			})
		sections.push({"sectionDesc":sv.sectionDesc,"sectionId":sv.sectionId,selected:false,"children":reports});
		})
		
		return sections;
	}


*/
/*
 function updateAppr(sc){
	 var sections = new Array();
	 	angular.forEach(sc, function(sv, sk) {
	 		 var reports = new Array();
	 		angular.forEach(sv, function(rv, rk) {
		 		 var actions = new Array();
		 		 angular.forEach(rv.actions, function(av, ak) {
		 			 actions.push(new Choice(av.actionName,av.reportActionId,false));
				});
			reports.push(new Choice(rv.reportName,rv.reportId,false,actions));
			})
		sections.push(new Choice(sv.sectionDesc,sv.sectionId,false,reports));
		})
		
		return sections;
 	}
 
 */
});
	
/*	vydyaAdmin.directive('choiceTree', function($compile) {
	      return {
	        template: '<ul class="tree" ng-check-tree >{{treeString}}</ul>',
	        replace: true,
	        transclude: true,
	        restrict: 'E',
	        scope: {
	          tree: '=ngModel',
	          withchildren: '=withchildren'
	        },
	        link: function(scope, elm, attrs) {
	            console.log(scope);
	            var t = $compile('<li><input type="checkbox"  value="Praveen"><label>Hi</label><ul><li><input type="checkbox"  value="Meena"><label>hello</label>'+
				'</li><li><input type="checkbox"  value="x"><label>User2</label></li></ul>');
	            scope.treeString=t;
	            
	            
	        }
	      };
	});*/
	
	vydyaAdmin.controller('roleModalCtrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService,$uibModalInstance, items,
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
					 $rootScope.$broadcast(hidden.module+'-ADDED', {
			                data: response
			            }); 
				 }
				 else{
					 swal("Failed !", response.data.message, "error");
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
	
	
	vydyaAdmin.directive('choiceTree', function() {
	      return {
	        template: '<ul class=""><choice ng-repeat="choice in tree"></choice></ul>',
	        replace: true,
	        transclude: true,
	        restrict: 'E',
	        scope: {
	          tree: '=ngModel',
	          withchildren: '=withchildren'
	        },
	        link: function(scope, elm, attrs) {
	            console.log(scope);
	        }
	      };
	});
	
	vydyaAdmin.directive('ngCheckTree', function($compile,$timeout) {
	      return {
	        restrict: 'A',
	        link: function(scope, elm, attrs) {
	        	elm.hide();
	        	$timeout(function(){
	        		elm.addClass("tree");
	        		//elm.ready(scope.$apply(elm.checkTree()));
	        		elm.ready(function(){
	        			scope.$apply(function(){
	        				elm.checkTree({
	        					collapseAll : true
	        				});
	        				elm.show();
	        			});
	        		})
	        		
	        		//scope.$apply(elm.checkTree()));
	        		
	        	},100);
	        	
	           // elm.checkTree();
	            
	        }
	      };
	});

	vydyaAdmin.directive('choice', function($compile) {
	  return { 
	    restrict: 'E',
	    //In the template, we do the thing with the span so you can click the 
	    //text or the checkbox itself to toggle the check
	    template: '<li>' +
	      //'<span ng-click="choiceClicked(choice)">'+
	        '<input type="checkbox" value="{{check.reportActionId}}" ng-checked="choice.checked"> {{choice.name}}' +
	      //'</span>' +
	    '</li>',
	    transclude: true,
	    link: function(scope, elm, attrs) {
	      scope.choiceClicked = function(choice) {
	        choice.checked = !choice.checked;
	        function checkChildren(c) {
	          angular.forEach(c.children, function(c) {
	            c.checked = choice.checked;
	            checkChildren(c);
	          });
	        }
	        if(scope.withchildren === true)checkChildren(choice);
	      };
	      //Add children by $compiling and doing a new choice directive
	      if (scope.choice.children.length > 0) {
	        var childChoice = $compile('<choice-tree ng-model="choice.children" withchildren="withchildren"></choice-tree>')(scope);
	        elm.append(childChoice);
	      }
	    }
	  };
	});
	
	
	



	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 