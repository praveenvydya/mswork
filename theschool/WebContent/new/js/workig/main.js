$(function () {

  'use strict';

  var console = window.console || { log: function () {} };
  var $body = $('body');

  $('[data-toggle="tooltip"]').tooltip();
  $.fn.tooltip.noConflict();
  //$body.tooltip();

  // Demo
  // -------------------------------------------------------------------------

  (function () {
    var $image = $('#cropper-image > img');
    var $dataX = $('#dataX');
    var $dataY = $('#dataY');
    var $dataHeight = $('#dataHeight');
    var $dataWidth = $('#dataWidth');
    var $dataRotate = $('#dataRotate');
    var $dataScaleX = $('#dataScaleX');
    var $dataScaleY = $('#dataScaleY');
    var options = {
          aspectRatio: 16 / 9,
          preview: '.img-preview',
          crop: function (e) {
            $dataX.val(Math.round(e.x));
            $dataY.val(Math.round(e.y));
            $dataHeight.val(Math.round(e.height));
            $dataWidth.val(Math.round(e.width));
            $dataRotate.val(e.rotate);
            $dataScaleX.val(e.scaleX);
            $dataScaleY.val(e.scaleY);
          }
        };

    $image.on({
      'build.cropper': function (e) {
        console.log(e.type);
      },
      'built.cropper': function (e) {
        console.log(e.type);
      },
      'cropstart.cropper': function (e) {
        console.log(e.type, e.action);
      },
      'cropmove.cropper': function (e) {
        console.log(e.type, e.action);
      },
      'cropend.cropper': function (e) {
        console.log(e.type, e.action);
      },
      'crop.cropper': function (e) {
        console.log(e.type, e.x, e.y, e.width, e.height, e.rotate, e.scaleX, e.scaleY);
      },
      'zoom.cropper': function (e) {
        console.log(e.type, e.ratio);
      }
    }).cropper(options);


    // Methods
    $body.on('click', '[data-method]', function () {
      var data = $(this).data();
      var $target;
      var result;

      if (!$image.data('cropper')) {
        return;
      }

      if (data.method) {
        data = $.extend({}, data); // Clone a new one

        if (typeof data.target !== 'undefined') {
          $target = $(data.target);

          if (typeof data.option === 'undefined') {
            try {
              data.option = JSON.parse($target.val());
            } catch (e) {
              console.log(e.message);
            }
          }
        }

        result = $image.cropper(data.method, data.option, data.secondOption);

        if (data.flip === 'horizontal') {
          $(this).data('option', -data.option);
        }

        if (data.flip === 'vertical') {
          $(this).data('secondOption', -data.secondOption);
        }

        if (data.method === 'getCroppedCanvas') {
        	
        	processImageData(data);
        	//displayCroped(data)
        	
		  //$('#vydya-canvas').html(result);
		        
		  $('#cropper-modal').modal('hide');
		  //BootstrapDialog.alert('I want banana!');
		  
        }

        if ($.isPlainObject(result) && $target) {
          try {
            $target.val(JSON.stringify(result));
          } catch (e) {
            console.log(e.message);
          }
        }

      }
    }).on('keydown', function (e) {

      if (!$image.data('cropper')) {
        return;
      }

      switch (e.which) {
        case 37:
          e.preventDefault();
          $image.cropper('move', -1, 0);
          break;

        case 38:
          e.preventDefault();
          $image.cropper('move', 0, -1);
          break;

        case 39:
          e.preventDefault();
          $image.cropper('move', 1, 0);
          break;

        case 40:
          e.preventDefault();
          $image.cropper('move', 0, 1);
          break;
      }

    });


    // Import image
    var $inputImage = $('#inputImage');
    var URL = window.URL || window.webkitURL;
    var blobURL;

    if (URL) {
      $inputImage.change(function () {
        var files = this.files;
        var file;

        /*if (!$image.data('cropper')) {
          return;
        }*/

        if (files && files.length) {
          file = files[0];

          if (/^image\/\w+$/.test(file.type)) {
            blobURL = URL.createObjectURL(file);
			
            $image.one('built.cropper', function () {
              URL.revokeObjectURL(blobURL); // Revoke when load complete
            }).cropper('reset').cropper('replace', blobURL);
			$('#cropper-modal').modal('show');
			//getBase64FromImageUrl(blobURL);
			
            $inputImage.val('');
          } else {
            $body.tooltip('Please choose an image file.', 'warning');
          }
        }
      });
    } else {
      $inputImage.parent().remove();
    }


    // Options
    $('.docs-options :checkbox').on('change', function () {
      var $this = $(this);
      var cropBoxData;
      var canvasData;

      if (!$image.data('cropper')) {
        return;
      }

      options[$this.val()] = $this.prop('checked');

      cropBoxData = $image.cropper('getCropBoxData');
      canvasData = $image.cropper('getCanvasData');
      options.built = function () {
        $image.cropper('setCropBoxData', cropBoxData);
        $image.cropper('setCanvasData', canvasData);
      };

      $image.cropper('destroy').cropper(options);
    });

	//var $image2 = $('#cropper-example-2 > img'),
    var cropBoxData,
    canvasData;
	$('#cropper-modal').on('shown.bs.modal', function () {
  $image.cropper({
    autoCropArea: 16/9,
    built: function () {
      // Strict mode: set crop box data first
      $image.cropper('setCropBoxData', cropBoxData);
      $image.cropper('setCanvasData', canvasData);
    }
  });
}).on('hidden.bs.modal', function () {
  cropBoxData = $image.cropper('getCropBoxData');

  canvasData = $image.cropper('getCanvasData');
  //var options = "";
  $image.cropper('destroy').cropper(options);
 // $image.cropper('destroy');
  
});

function processImageData(data){
	
	var rm = $image.cropper(data.method, data.option, data.secondOption);
	$('#croped-image').attr('src',rm.toDataURL());
	
}

function displayCroped(data){
	var dt = data;
	dt.option.height = 90;
	dt.option.width = 180;
	var img = $image;
	var can =img.img(dt.method, dt.option, dt.secondOption);
	$('#croped-image').attr('src',can.toDataURL());
	
}
	
function getBase64FromImageUrl(URL) {
    var img = new Image();
	//img.setAttribute('crossOrigin', 'anonymous');
    img.src = URL;
    img.onload = function() {

        var canvas = document.createElement("canvas");
        canvas.width = this.width;
        canvas.height = this.height;

        var ctx = canvas.getContext("2d");
        ctx.drawImage(this, 0, 0);

        var dataURL = canvas.toDataURL("image/png");
		$('#vydya-canvas-bg2').attr('src',dataURL)
       // alert(dataURL.replace(/^data:image\/(png|jpg);base64,/, ""));

    };
}


  }());

});
