
    
	vydyaAdmin.controller('rolesctrl', function($scope,$http,gService,apService,$q,httpRequestTracker,$uibModal,fileUpload,growlService) {
	 $scope.roles = {};
	 $scope.editmode = false;
	 gService.setBaseUrl('/theschool/admin/manageRoles');
	 apService.setUrl('/theschool/admin/manageRoles');
	 var d={};
		apService.view(d).then(function(data) {
			 $scope.roles = data.data.respData;
			 $scope.sessionRole = data.data.respData2;
		});
		
		
 $scope.ng = "";
 
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
 
 $scope.changeRoleType = function(){
	 $scope.show
 }

 $scope.add = function () {
	
	 var d={};
	 d['actionName']='ad';
		apService.load(d).then(function(data) {
			 $scope.dto = data.data;
			$scope.roleEntis =  updateAppr($scope.dto.sections);
		});
		
		 $scope.editmode = true;
		
 }

$scope.hideAction=function(v){

} 


$scope.cancel = function () {
	 
	 $scope.editmode = false;
 
};

function Choice(name, children) {
	  this.name = name;
	  this.checked = false;
	  this.children = children || [];
	}
$scope.apparel={};

 $scope.edit = function (ind,r) {
	 
	
	 var d={};
	 d['actionName']='ed';
	 d['dto'] = r;
		apService.load(d).then(function(data) {
			 $scope.dto = data.data;
		
	
		});
	 $scope.editmode = true;
 };
 
 function updateAppr(sc){
	 var sections = new Array();
	angular.forEach(sc, function(sv, sk) {
		 var reports =new Array();
		angular.forEach(sv.reports, function(rv, rk) {
			var actions =new Array();
			angular.forEach(rv.actions, function(av, ak) {
				
				actions.push(new Choice(av.actionName));
				});
			reports.push(new Choice(rv.reportName,actions));
			})
		sections.push(new Choice(sv.sectionDesc,reports));
		})
		
		return sections;
 	}
 
 
});
	
	vydyaAdmin.directive('choiceTree', function() {
	      return {
	        template: '<ul><choice ng-repeat="choice in tree"></choice></ul>',
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

	vydyaAdmin.directive('choice', function($compile) {
	  return { 
	    restrict: 'E',
	    //In the template, we do the thing with the span so you can click the 
	    //text or the checkbox itself to toggle the check
	    template: '<li>' +
	      '<span ng-click="choiceClicked(choice)">'+
	        '<input type="checkbox" ng-checked="choice.checked"> {{choice.name}}' +
	      '</span>' +
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
	
	
	



	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 