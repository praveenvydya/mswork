//var app = angular.module('ninja.toolbox.controllers',[]);

angular.module('LoadingBarExample', ['chieffancypants.loadingBar', 'ngAnimate'])
  .config(function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = true;
  });
  
//angular.module('someapp', ['ninja.toolbox.controllers']);

angular.module('angular.aps', []).

factory('apService', ['$http','$q', function ($http,$q) {
    var imageBase = 'http://localhost:8080/theschool/upload.htm';
    var apService = {};
    var urlBase = null;
    var dfd = $q.defer();
    apService.setUrl = function (url) {
        urlBase = url;
    };
    apService.add = function (g) {
        return $http.post(urlBase + '/add.htm', g);
    };
    apService.edit = function (g) {
        return $http.post(urlBase + '/edit.htm', g);
    };
    apService.delete = function (g) {
        return $http.post(urlBase + '/delete.htm', g);
    };
    apService.view = function (g) {
        //return $http.post(urlBase + '/view.htm', g);
    	var galleries;
        if (galleries) {
            dfd.resolve(galleries);
        } else {
        	$http.post(this.baseUrl + '/view.htm', g)
                .then(function (response) {
                	galleries = response.data;
                    dfd.resolve(galleries);
                }).catch(function (errorResponse) {
                    dfd.reject("Error Occured");
                }) 
        }
        return dfd.promise;
    };
    var ldata;
    apService.load = function (g) {
        return $http.post(urlBase + '/load.htm', g)
        .then(function (response) {
        			ldata = response.data;
                        dfd.resolve(ldata);
                    }).catch(function (errorResponse) {
                        dfd.reject("Error Occured");
                    });
    };
    apService.saveI = function (b) {
        return $http.post(imageBase, b);
    };
    
    return apService;
}]).service('gService', ['$http','$q', function ($http,$q) {
	this.baseUrl = null;
	this.setBaseUrl = function(url){
		this.baseUrl = url;
	}
	var galleries;
    this.getAll = function () {
        var dfd = $q.defer();
        if (galleries) {
            dfd.resolve(galleries);
        } else {
            $http.get($http.get(baseUrl+'/loadAll'))
                .then(function (response) {
                	galleries = response.data;
                    dfd.resolve(galleries);
                }).catch(function (errorResponse) {
                    dfd.reject("Error Occured");
                })
        }
        return dfd.promise;
    };
	
    this.view = function (g) {
        var dfd = $q.defer();
        	$http.post(this.baseUrl + '/view.htm', g)
                .then(function (response) {
                	galleries = response.data;
                    dfd.resolve(galleries);
                }).catch(function (errorResponse) {
                    dfd.reject("Error Occured");
                }) 
        return dfd.promise;
    };
	
	
    this.load = function (d) {
        var dfd = $q.defer();
        	$http.post(this.baseUrl + '/load.htm', d)
                .then(function (response) {
                    dfd.resolve(response.data);
                }).catch(function (errorResponse) {
                    dfd.reject("Error Occured");
                }) 
        return dfd.promise;
    };
	
    
    this.edit = function (g) {
        return $http.post(this.baseUrl + '/edit.htm', g);
    };
    this.delete = function (g) {
        return $http.post(this.baseUrl + '/delete.htm', g);
    };
   /* this.view = function (g) {
        return $http.post(this.baseUrl + '/view.htm', g);
    };*/
    this.add = function (g) {
        return $http.post(this.baseUrl + '/add.htm', g);
    };
	
}]).factory('httpRequestTracker', ['$http', function ($http) {

    var httpRequestTracker = {};
    httpRequestTracker.hasPendingRequests = function () {
        return $http.pendingRequests.length > 0;
    };

    return httpRequestTracker;
}])
.service('fileUpload', ['$http', function ($http) {
    this.uploadFileToUrl = function(fd, uploadUrl){
        /*var fd = new FormData();
        fd.append('file', file);*/
        $http.post(uploadUrl, fd, {
            transformRequest: angular.identity,
            headers: {'Content-Type': undefined}
        })
        .success(function(){
        })
        .error(function(){
        });
    }
}])
.service('generalService', function () {
	this.getImageBase64 = function(url, callback, outputFormat){
	    var img = new Image();
	    img.crossOrigin = 'Anonymous';
	    img.onload = function(){
	        var canvas = document.createElement('CANVAS'),
	        ctx = canvas.getContext('2d'), dataURL;
	        canvas.height = this.height;
	        canvas.width = this.width;
	        ctx.drawImage(this, 0, 0);
	        dataURL = canvas.toDataURL(outputFormat);
	        callback(dataURL);
	        canvas = null; 
	    };
	    img.src = url;
	};
	
	
})
.service('growlService', function(){
    var gs = {};
    gs.growl = function(message, type) {
        $.growl({
            message: message
        },{
            type: type,
            allow_dismiss: false,
            label: 'Cancel',
            className: 'btn-xs btn-inverse',
            placement: {
                from: 'top',
                align: 'right'
            },
            delay: 2500,
            animate: {
                    enter: 'animated bounceIn',
                    exit: 'animated bounceOut'
            },
            offset: {
                x: 20,
                y: 85
            }
        });
    }
    
    return gs;
}).service('loadService', ['$http', function ($http) {
	this.baseUrl = null;
	this.params = null;
	this.setBaseUrl = function(url){
		this.baseUrl = url;
	}
	this.setParams = function(d){
		this.params = d;
	}
	this.call = function(){
		var promise = $http.post(this.baseUrl + '/load.htm', this.params).
	    success(function (data) {
	        var loadData = data;
	        return loadData;
	    });
	    return promise;
	}
	
}])
.directive('dtPicker', function(){
    return {
        require : '?ngModel',
        restrict: 'A',
        scope: {
            viewMode: '@',
            format: '@'
        },
        link: function(scope, element, attrs, ngModel){
            element.datetimepicker({
                viewMode: scope.viewMode,
                format: scope.format
            })
            .on('dp.change', function (e) {
                // datepick doesn't update the value of the ng-model when the date is changed
                // when date changed event is triggered 
                // retreive the value of the new date
                // set the value to the ng-model 
                ngModel.$setViewValue($(element).val());
            });   
        }
    }
})
;


/*
var ImgService = angular.module.factory('ImgService', function($http) {
	 var imageBase = 'http://localhost:8280/theschool/upload.htm';
    var getData = function(b) {
    	return $http.post(imageBase, b).then(function(result){
        	return result;
        });
    };
    return { getData: getData };
});


app.service("PromiseUtils", function($q) {
    return {
        getPromiseHttpResult: function (httpPromise) {
            var deferred = $q.defer();
            httpPromise.success(function (data) {
                deferred.resolve(data);
            }).error(function () {
                deferred.reject(arguments);
            });
            return deferred.promise;
        }
    }
});

 $scope.saveImage = function(ng)
 {
	 $scope.ng = $scope.ng?$scope.ng:{};
	 var nsrc =   document.getElementById("croped-image").src;
	 var imageBase = 'http://localhost:8280/theschool/upload.htm';
		   
	 if(nsrc.indexOf("data:image/") != -1){
		   var im = nsrc.split(';base64,');
		   var type = im[0].substring(5);
		   var imageB = im[1];
		   var imageBlob = nsrc.replace("data:"+type+";base64,","");
		   $scope.ng.imageType=type.split('/')[1];
		   var dt={};
			dt['image']=imageBlob;
			dt["unid"]=ng.unid?ng.unid:'';
		   //$scope.imageUpdated=true;
		   return $http.post(imageBase, JSON.stringify(dt)).then(function(res){
			   $scope.imageUpdated=true;
			   $scope.ng.unid=res.data.name;
	        });   
		   
 }
 }
 
 function uploadImage2(b,a,unid,$scope, ImgService) {
	 var dt={};
		dt['image']=b;
		dt['a'] =a;
		dt["unid"]=unid;
		
		var myDataPromise = ImgService.getData(JSON.stringify(dt));
	    myDataPromise.then(function(result) {  // this is only run after $http completes
	    	if(a==="a"){
	    		$scope.ng.unid = result.data.name;
	    	}
	       console.log("Image UNID = "+$scope.ng.unid);
	    });
}


app.directive('galleryname', function($q, $timeout) {
	  return {
	    require: 'ngModel',
	    link: function(scope, elm, attrs, ctrl) {
	    var usernames = ['Jim', 'John', 'Jill', 'Jackie'];

	      ctrl.$asyncValidators.galleryname = function(modelValue, viewValue) {

	        if (ctrl.$isEmpty(modelValue)) {
	          // consider empty model valid
	          return $q.when();
	        }

	        var def = $q.defer();

	        $timeout(function() {
	          // Mock a delayed response
	          if (galleryname.indexOf(modelValue) === -1) {
	            // The username is available
	            def.resolve();
	          } else {
	            def.reject();
	          }

	        }, 2000);

	        return def.promise;
	      };
	    }
	  };
	});

*/

