 function loadY(type, path) {
				cpath = path;
				var d1 = $('<div/>', {
					id : 'pv'
				}).appendTo("#previous-years");
				var ul = $('<ul/>').appendTo(d1);
				$.get(path + '/getYlist.htm?t=' + type, function(data) {
					$.each(data, function(ind, y) {

						var li = $('<li/>', {
							id : 'py' + y
						});
						var a = $('<a/>', {
							id : '',
							class : '',
							href : '?y=' + y,
							html:y
						});
						//$('<span>' + y + '</span>').appendTo(a);
						$(a).appendTo(li);
						$(li).appendTo(ul);
					});
				});
 }
				