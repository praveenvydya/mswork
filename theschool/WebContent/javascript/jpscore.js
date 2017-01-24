(function(e){e.jps=e.jps||{};e.jps.define=function(e,t,n){e[t]=function(){if(this.baseType){this.base=new e[this.baseType];this.base.defineInstance()}this.defineInstance()};e[t].prototype.defineInstance=function(){};e[t].prototype.base=null;e[t].prototype.baseType=undefined;if(n&&e[n]){e[t].prototype.baseType=n}};e.jps.invoke=function(t,n){if(n.length==0){return}var r=typeof n==Array||n.length>0?n[0]:n;var i=typeof n==Array||n.length>1?Array.prototype.slice.call(n,1):e({}).toArray();while(t[r]==undefined&&t.base!=null){t=t.base}if(t[r]!=undefined&&e.isFunction(t[r])){return t[r].apply(t,i)}if(typeof r=="string"){var s=r.toLowerCase();return t[s].apply(t,i)}return};e.jps.hasProperty=function(e,t){if(typeof t=="object"){for(var n in t){var r=e;while(r){if(r.hasOwnProperty(n)){return true}r=r.base}return false}}else{while(e){if(e.hasOwnProperty(t)){return true}e=e.base}}return false};e.jps.hasFunction=function(t,n){if(n.length==0){return false}if(t==undefined){return false}var r=typeof n==Array||n.length>0?n[0]:n;var i=typeof n==Array||n.length>1?Array.prototype.slice.call(n,1):{};while(t[r]==undefined&&t.base!=null){t=t.base}if(t[r]&&e.isFunction(t[r])){return true}if(typeof r=="string"){var s=r.toLowerCase();if(t[s]&&e.isFunction(t[s])){return true}}return false};e.jps.isPropertySetter=function(t,n){if(n.length==1&&typeof n[0]=="object"){return true}if(n.length==2&&typeof n[0]=="string"&&!e.jps.hasFunction(t,n)){return true}return false};e.jps.validatePropertySetter=function(t,n,r){if(!e.jps.propertySetterValidation){return true}if(n.length==1&&typeof n[0]=="object"){for(var i in n[0]){var s=t;while(!s.hasOwnProperty(i)&&s.base){s=s.base}if(!s||!s.hasOwnProperty(i)){if(!r){throw"Invalid property: "+i}return false}}return true}if(n.length!=2){if(!r){throw"Invalid property: "+n.length>=0?n[0]:""}return false}while(!t.hasOwnProperty(n[0])&&t.base){t=t.base}if(!t||!t.hasOwnProperty(n[0])){if(!r){throw"Invalid property: "+n[0]}return false}return true};e.jps.set=function(t,n){if(n.length==1&&typeof n[0]=="object"){e.each(n[0],function(n,r){var i=t;while(!i.hasOwnProperty(n)&&i.base!=null){i=i.base}if(i.hasOwnProperty(n)){e.jps.setvalueraiseevent(i,n,r)}else{if(e.jps.propertySetterValidation){throw"jpsCore: invalid property '"+n+"'"}}})}else{if(n.length==2){while(!t.hasOwnProperty(n[0])&&t.base){t=t.base}if(t.hasOwnProperty(n[0])){e.jps.setvalueraiseevent(t,n[0],n[1])}else{if(e.jps.propertySetterValidation){throw"jpsCore: invalid property '"+n[0]+"'"}}}}};e.jps.setvalueraiseevent=function(e,t,n){var r=e[t];e[t]=n;if(!e.isInitialized){return}if(e.propertyChangedHandler!=undefined){e.propertyChangedHandler(e,t,r,n)}if(e.propertyChangeMap!=undefined&&e.propertyChangeMap[t]!=undefined){e.propertyChangeMap[t](e,t,r,n)}};e.jps.get=function(e,t){if(t==undefined||t==null){return undefined}if(e.propertyMap){var n=e.propertyMap(t);if(n!=null){return n}}if(e.hasOwnProperty(t)){return e[t]}var r=undefined;if(typeof t==Array){if(t.length!=1){return undefined}r=t[0]}else{if(typeof t=="string"){r=t}}while(!e.hasOwnProperty(r)&&e.base){e=e.base}if(e){return e[r]}return undefined};e.jps.serialize=function(t){var n="";if(e.isArray(t)){n="[";for(var r=0;r<t.length;r++){if(r>0){n+=", "}n+=e.jps.serialize(t[r])}n+="]"}else{if(typeof t=="object"){n="{";var i=0;for(var r in t){if(i++>0){n+=", "}n+=r+": "+e.jps.serialize(t[r])}n+="}"}else{n=t.toString()}}return n};e.jps.propertySetterValidation=true;e.jps.jpsWidgetProxy=function(t,n,r){var i=e(n);var s=e.data(n,t);if(s==undefined){return undefined}var o=s.instance;if(e.jps.hasFunction(o,r)){return e.jps.invoke(o,r)}if(e.jps.isPropertySetter(o,r)){if(e.jps.validatePropertySetter(o,r)){e.jps.set(o,r);return undefined}}else{if(typeof r=="object"&&r.length==0){return}else{if(typeof r=="object"&&r.length==1&&e.jps.hasProperty(o,r[0])){return e.jps.get(o,r[0])}else{if(typeof r=="string"&&e.jps.hasProperty(o,r[0])){return e.jps.get(o,r)}}}}throw"jpsCore: Invalid parameter '"+e.jps.serialize(r)+"' does not exist.";return undefined};e.jps.jpsWidget=function(t,n,r){var i=false;try{jpsArgs=Array.prototype.slice.call(r,0)}catch(s){jpsArgs=""}try{i=window.MSApp!=undefined}catch(s){}var o=t;var u="";if(n){u="_"+n}e.jps.define(e.jps,"_"+o,u);e.fn[o]=function(){var t=Array.prototype.slice.call(arguments,0);var n=null;if(t.length==0||t.length==1&&typeof t[0]=="object"){return this.each(function(){var r=e(this);var s=this;var u=e.data(s,o);if(u==null){u={};u.element=s;u.host=r;u.instance=new e.jps["_"+o];if(s.id==""){s.id=e.jps.utilities.createId()}u.instance.get=u.instance.set=u.instance.call=function(){var t=Array.prototype.slice.call(arguments,0);return e.jps.jpsWidgetProxy(o,s,t)};e.data(s,o,u);e.data(s,"jpsWidget",u.instance);var f=new Array;var l=u.instance;while(l){l.isInitialized=false;f.push(l);l=l.base}f.reverse();f[0].theme="";e.jps.jpsWidgetProxy(o,this,t);for(var h in f){l=f[h];if(h==0){l.host=r;l.element=s;l.WinJS=i}if(l!=undefined){if(l.createInstance!=null){if(i){MSApp.execUnsafeLocalFunction(function(){l.createInstance(t)})}else{l.createInstance(t)}}}}for(var h in f){if(f[h]!=undefined){f[h].isInitialized=true}}if(i){MSApp.execUnsafeLocalFunction(function(){u.instance.refresh(true)})}else{u.instance.refresh(true)}n=this}else{e.jps.jpsWidgetProxy(o,this,t)}})}else{if(this.length==0){if(this.selector){throw new Error("Invalid jQuery Selector - "+this.selector+"! Please, check whether the used ID or CSS Class name is correct.")}else{throw new Error("Invalid jQuery Selector! Please, check whether the used ID or CSS Class name is correct.")}}this.each(function(){var r=e.jps.jpsWidgetProxy(o,this,t);if(n==null){n=r}})}return n};try{e.extend(e.jps["_"+o].prototype,Array.prototype.slice.call(r,0)[0])}catch(s){}e.extend(e.jps["_"+o].prototype,{toThemeProperty:function(e,t){if(this.theme==""){return e}if(t!=null&&t){return e+"-"+this.theme}return e+" "+e+"-"+this.theme}});e.jps["_"+o].prototype.refresh=function(){if(this.base){this.base.refresh()}};e.jps["_"+o].prototype.createInstance=function(){};e.jps["_"+o].prototype.propertyChangeMap={};e.jps["_"+o].prototype.addHandler=function(t,n,r,i){switch(n){case"mousewheel":if(window.addEventListener){if(e.jps.browser.mozilla){t[0].addEventListener("DOMMouseScroll",r,false)}else{t[0].addEventListener("mousewheel",r,false)}return false}break;case"mousemove":if(window.addEventListener&&!i){t[0].addEventListener("mousemove",r,false);return false}break}if(i==undefined||i==null){if(t.on){t.on(n,r)}else{t.bind(n,r)}}else{if(t.on){t.on(n,i,r)}else{t.bind(n,i,r)}}};e.jps["_"+o].prototype.removeHandler=function(t,n,r){switch(n){case"mousewheel":if(window.removeEventListener){if(e.jps.browser.mozilla){t[0].removeEventListener("DOMMouseScroll",r,false)}else{t[0].removeEventListener("mousewheel",r,false)}return false}break;case"mousemove":if(e.jps.browser.msie&&e.jps.browser.version>=9){if(window.removeEventListener){t[0].removeEventListener("mousemove",r,false)}}break}if(n==undefined){if(t.off){t.off()}else{t.unbind()}return}if(r==undefined){if(t.off){t.off(n)}else{t.unbind(n)}}else{if(t.off){t.off(n,r)}else{t.unbind(n,r)}}}};e.jps.utilities=e.jps.utilities||{};e.extend(e.jps.utilities,{createId:function(){var e=function(){return((1+Math.random())*65536|0).toString(16).substring(1)};return"jpsWidget"+e()+e()},setTheme:function(t,n,r){if(typeof r==="undefined"){return}var i=r[0].className.split(" "),s=[],o=[],u=r.children();for(var f=0;f<i.length;f+=1){if(i[f].indexOf(t)>=0){if(t.length>0){s.push(i[f]);o.push(i[f].replace(t,n))}else{o.push(i[f]+"-"+n)}}}this._removeOldClasses(s,r);this._addNewClasses(o,r);for(var f=0;f<u.length;f+=1){this.setTheme(t,n,e(u[f]))}},_removeOldClasses:function(e,t){for(var n=0;n<e.length;n+=1){t.removeClass(e[n])}},_addNewClasses:function(e,t){for(var n=0;n<e.length;n+=1){t.addClass(e[n])}},getOffset:function(t){var n=e.jps.mobile.getLeftPos(t[0]);var r=e.jps.mobile.getTopPos(t[0]);return{top:r,left:n}},resize:function(t,n,r){if(this.resizeHandlers&&r===true){var i=-1;for(var s=0;s<this.resizeHandlers.length;s++){if(this.resizeHandlers[s].id==t.id){i=s;break}}if(i!=-1){this.resizeHandlers.splice(i,1)}if(this.resizeHandlers.length==0){var o=e(window);if(o.off){o.off("resize.jps")}else{o.unbind("resize.jps")}this.resizeHandlers=null}}if(!this.resizeHandlers){this.resizeHandlers=new Array;var u=this;var f=function(){var t=function(e,t){var n=e.widget.parents().length;var r=t.widget.parents().length;try{if(n<r){return-1}if(n>r){return 1}}catch(i){var s=i}return 0};u.hiddenWidgets=new Array;u.resizeHandlers.sort(t);e.each(u.resizeHandlers,function(t,n){var r=this.widget.data();if(!r){return true}if(!r.jpsWidget){return true}var i=r.jpsWidget.width;var s=r.jpsWidget.height;var o=false;if(i!=null&&i.toString().indexOf("%")!=-1){o=true}if(s!=null&&s.toString().indexOf("%")!=-1){o=true}if(o){if(e.jps.isHidden(this.widget)){u.hiddenWidgets.push(this)}else{this.callback();u.hiddenWidgets.pop(this)}}});if(u.hiddenWidgets.length>0){u.hiddenWidgets.sort(t);if(u.__resizeInterval){clearInterval(u.__resizeInterval)}u.__resizeInterval=setInterval(function(){var t=false;var n=new Array;e.each(u.hiddenWidgets,function(r,i){if(e.jps.isHidden(this.widget)){t=true;n.push(this)}else{this.callback()}});u.hiddenWidgets=n;if(!t){clearInterval(u.__resizeInterval)}},100)}};var o=e(window);if(o.on){o.on("resize.jps",function(e){f()})}else{o.bind("resize.jps",function(e){f()})}}this.resizeHandlers.push({id:t[0].id,widget:t,callback:n})},html:function(t,n){if(!e(t).on){return e(t).html(n)}try{return jQuery.access(t,function(e){var n=t[0]||{},r=0,i=t.length;if(e===undefined){return n.nodeType===1?n.innerHTML.replace(rinlinejQuery,""):undefined}var s=/<(?:script|style|link)/i,o="abbr|article|aside|audio|bdi|canvas|data|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|summary|time|video",u=/<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/gi,a=/<([\w:]+)/,f=/<(?:script|object|embed|option|style)/i,l=new RegExp("<(?:"+o+")[\\s/>]","i"),h=/^\s+/,p={option:[1,"<select multiple='multiple'>","</select>"],legend:[1,"<fieldset>","</fieldset>"],thead:[1,"<table>","</table>"],tr:[2,"<table><tbody>","</tbody></table>"],td:[3,"<table><tbody><tr>","</tr></tbody></table>"],col:[2,"<table><tbody></tbody><colgroup>","</colgroup></table>"],area:[1,"<map>","</map>"],_default:[0,"",""]};if(typeof e==="string"&&!s.test(e)&&(jQuery.support.htmlSerialize||!l.test(e))&&(jQuery.support.leadingWhitespace||!h.test(e))&&!p[(a.exec(e)||["",""])[1].toLowerCase()]){e=e.replace(u,"<$1></$2>");try{for(;r<i;r++){n=this[r]||{};if(n.nodeType===1){jQuery.cleanData(n.getElementsByTagName("*"));n.innerHTML=e}}n=0}catch(d){}}if(n){t.empty().append(e)}},null,n,arguments.length)}catch(r){return e(t).html(n)}},hasTransform:function(t){var n="";n=t.css("transform");if(n==""||n=="none"){n=t.parents().css("transform");if(n==""||n=="none"){var r=e.jps.utilities.getBrowser();if(r.browser=="msie"){n=t.css("-ms-transform");if(n==""||n=="none"){n=t.parents().css("-ms-transform")}}else{if(r.browser=="chrome"){n=t.css("-webkit-transform");if(n==""||n=="none"){n=t.parents().css("-webkit-transform")}}else{if(r.browser=="opera"){n=t.css("-o-transform");if(n==""||n=="none"){n=t.parents().css("-o-transform")}}else{if(r.browser=="mozilla"){n=t.css("-moz-transform");if(n==""||n=="none"){n=t.parents().css("-moz-transform")}}}}}}else{return n!=""&&n!="none"}}if(n==""||n=="none"){n=e(document.body).css("transform")}return n!=""&&n!="none"&&n!=null},getBrowser:function(){var e=navigator.userAgent.toLowerCase();var t=/(chrome)[ \/]([\w.]+)/.exec(e)||/(webkit)[ \/]([\w.]+)/.exec(e)||/(opera)(?:.*version|)[ \/]([\w.]+)/.exec(e)||/(msie) ([\w.]+)/.exec(e)||e.indexOf("compatible")<0&&/(mozilla)(?:.*? rv:([\w.]+)|)/.exec(e)||[];var n={browser:t[1]||"",version:t[2]||"0"};n[t[1]]=t[1];return n}});e.jps.browser=e.jps.utilities.getBrowser();e.jps.isHidden=function(e){try{var t=e[0].offsetWidth,n=e[0].offsetHeight;if(t===0&&n===0){return true}else{return false}}catch(r){return false}};e.jps.ariaEnabled=true;e.jps.aria=function(t,n,r){if(!e.jps.ariaEnabled){return}if(n==undefined){e.each(t.aria,function(n,r){var i=!t.base?t.host.attr(n):t.base.host.attr(n);if(i!=undefined&&!e.isFunction(i)){var s=i;switch(r.type){case"number":s=new Number(i);if(isNaN(s)){s=i}break;case"boolean":s=i=="true"?true:false;break;case"date":s=new Date(i);if(s=="Invalid Date"||isNaN(s)){s=i}break}t[r.name]=s}else{var i=t[r.name];if(e.isFunction(i)){i=t[r.name]()}if(i==undefined){i=""}try{!t.base?t.host.attr(n,i.toString()):t.base.host.attr(n,i.toString())}catch(o){}}})}else{try{if(t.host){if(!t.base){if(t.host){if(t.element.setAttribute){t.element.setAttribute(n,r.toString())}else{t.host.attr(n,r.toString())}}else{t.attr(n,r.toString())}}else{if(t.base.host){t.base.host.attr(n,r.toString())}else{t.attr(n,r.toString())}}}else{if(t.setAttribute){t.setAttribute(n,r.toString())}}}catch(i){}}};if(!Array.prototype.indexOf){Array.prototype.indexOf=function(e){var t=this.length;var n=Number(arguments[1])||0;n=n<0?Math.ceil(n):Math.floor(n);if(n<0){n+=t}for(;n<t;n++){if(n in this&&this[n]===e){return n}}return-1}}e.jps.mobile=e.jps.mobile||{};e.jps.position=function(t){var n=parseInt(t.pageX);var r=parseInt(t.pageY);if(e.jps.mobile.isTouchDevice()){var i=e.jps.mobile.getTouches(t);var s=i[0];n=parseInt(s.pageX);r=parseInt(s.pageY)}return{left:n,top:r}};e.extend(e.jps.mobile,{_touchListener:function(e,t){var n=function(e,t){var n=document.createEvent("MouseEvents");n.initMouseEvent(e,t.bubbles,t.cancelable,t.view,t.detail,t.screenX,t.screenY,t.clientX,t.clientY,t.ctrlKey,t.altKey,t.shiftKey,t.metaKey,t.button,t.relatedTarget);n._pageX=t.pageX;n._pageY=t.pageY;return n};var r={mousedown:"touchstart",mouseup:"touchend",mousemove:"touchmove"};var i=n(r[e.type],e);e.target.dispatchEvent(i);var s=e.target["on"+r[e.type]];if(typeof s==="function"){s(e)}},setMobileSimulator:function(t,n){if(this.isTouchDevice()){return}this.simulatetouches=true;if(n==false){this.simulatetouches=false}var r={mousedown:"touchstart",mouseup:"touchend",mousemove:"touchmove"};var i=this;if(window.addEventListener){var s=function(){for(var e in r){if(t.addEventListener){t.removeEventListener(e,i._touchListener);t.addEventListener(e,i._touchListener,false)}}};if(e.jps.browser.msie){s()}else{window.addEventListener("load",function(){s()},false)}}},isTouchDevice:function(){if(this.touchDevice!=undefined){return this.touchDevice}var e="Browser CodeName: "+navigator.appCodeName+"";e+="Browser Name: "+navigator.appName+"";e+="Browser Version: "+navigator.appVersion+"";e+="Platform: "+navigator.platform+"";e+="User-agent header: "+navigator.userAgent+"";if(e.indexOf("Android")!=-1){return true}if(e.indexOf("IEMobile")!=-1){return true}if(e.indexOf("Windows Phone OS")!=-1){return true}if(e.indexOf("Windows Phone 6.5")!=-1){return true}if(e.indexOf("BlackBerry")!=-1&&e.indexOf("Mobile Safari")!=-1){return true}if(e.indexOf("ipod")!=-1){return true}if(e.indexOf("nokia")!=-1||e.indexOf("Nokia")!=-1){return true}if(e.indexOf("Chrome/17")!=-1){return false}if(e.indexOf("Opera")!=-1&&e.indexOf("Mobi")==-1&&e.indexOf("Mini")==-1&&e.indexOf("Platform: Win")!=-1){return false}if(e.indexOf("Opera")!=-1&&e.indexOf("Mobi")!=-1&&e.indexOf("Opera Mobi")!=-1){return true}var t={ios:"i(?:Pad|Phone|Pod)(?:.*)CPU(?: iPhone)? OS ",android:"(Android |HTC_|Silk/)",blackberry:"BlackBerry(?:.*)Version/",rimTablet:"RIM Tablet OS ",webos:"(?:webOS|hpwOS)/",bada:"Bada/"};try{if(this.touchDevice!=undefined){return this.touchDevice}this.touchDevice=false;for(i in t){if(t.hasOwnProperty(i)){prefix=t[i];match=e.match(new RegExp("(?:"+prefix+")([^\\s;]+)"));if(match){if(i.toString()=="blackberry"){this.touchDevice=false;return false}this.touchDevice=true;return true}}}if(navigator.platform.toLowerCase().indexOf("win")!=-1){this.touchDevice=false;return false}document.createEvent("TouchEvent");this.touchDevice=true;return this.touchDevice}catch(n){this.touchDevice=false;return false}},getLeftPos:function(e){var t=e.offsetLeft;while((e=e.offsetParent)!=null){if(e.tagName!="HTML"){t+=e.offsetLeft;if(document.all){t+=e.clientLeft}}}return t},getTopPos:function(t){var n=t.offsetTop;while((t=t.offsetParent)!=null){if(t.tagName!="HTML"){n+=t.offsetTop-t.scrollTop;if(document.all){n+=t.clientTop}}}if(this.isSafariMobileBrowser()){if(this.isSafari4MobileBrowser()&&this.isIPadSafariMobileBrowser()){return n}n=n+e(window).scrollTop()}return n},isChromeMobileBrowser:function(){var e=navigator.userAgent.toLowerCase();var t=e.indexOf("android")!=-1;return t},isOperaMiniMobileBrowser:function(){var e=navigator.userAgent.toLowerCase();var t=e.indexOf("opera mini")!=-1||e.indexOf("opera mobi")!=-1;return t},isOperaMiniBrowser:function(){var e=navigator.userAgent.toLowerCase();var t=e.indexOf("opera mini")!=-1;return t},isNewSafariMobileBrowser:function(){var e=navigator.userAgent.toLowerCase();var t=e.indexOf("ipad")!=-1||e.indexOf("iphone")!=-1||e.indexOf("ipod")!=-1;t=t&&e.indexOf("version/5")!=-1;return t},isSafari4MobileBrowser:function(){var e=navigator.userAgent.toLowerCase();var t=e.indexOf("ipad")!=-1||e.indexOf("iphone")!=-1||e.indexOf("ipod")!=-1;t=t&&e.indexOf("version/4")!=-1;return t},isWindowsPhone:function(){var e=navigator.userAgent.toLowerCase();var t=(e.indexOf("msie 11")!=-1||e.indexOf("msie 10")!=-1)&&e.indexOf("touch")!=-1;return t},isSafariMobileBrowser:function(){var e=navigator.userAgent.toLowerCase();var t=e.indexOf("ipad")!=-1||e.indexOf("iphone")!=-1||e.indexOf("ipod")!=-1;return t},isIPadSafariMobileBrowser:function(){var e=navigator.userAgent.toLowerCase();var t=e.indexOf("ipad")!=-1;return t},isMobileBrowser:function(){var e=navigator.userAgent.toLowerCase();var t=e.indexOf("ipad")!=-1||e.indexOf("iphone")!=-1||e.indexOf("android")!=-1;return t},getTouches:function(e){if(e.originalEvent){if(e.originalEvent.touches&&e.originalEvent.touches.length){return e.originalEvent.touches}else{if(e.originalEvent.changedTouches&&e.originalEvent.changedTouches.length){return e.originalEvent.changedTouches}}}if(!e.touches){e.touches=new Array;e.touches[0]=e.originalEvent!=undefined?e.originalEvent:e;if(e.originalEvent!=undefined&&e.pageX){e.touches[0]=e}if(e.type=="mousemove"){e.touches[0]=e}}return e.touches},getTouchEventName:function(e){if(this.isWindowsPhone()){if(e.toLowerCase().indexOf("start")!=-1){return"MSPointerDown"}if(e.toLowerCase().indexOf("move")!=-1){return"MSPointerMove"}if(e.toLowerCase().indexOf("end")!=-1){return"MSPointerUp"}}else{return e}},dispatchMouseEvent:function(e,t,n){if(this.simulatetouches){return}var r=document.createEvent("MouseEvent");r.initMouseEvent(e,true,true,t.view,1,t.screenX,t.screenY,t.clientX,t.clientY,false,false,false,false,0,null);if(n!=null){n.dispatchEvent(r)}},getRootNode:function(e){while(e.nodeType!==1){e=e.parentNode}return e},setTouchScroll:function(e,t){if(!this.enableScrolling){this.enableScrolling=[]}this.enableScrolling[t]=e},touchScroll:function(t,n,r,i){if(t==null){return}var s=this;var o=0;var u=0;var f=0;var l=0;var c=0;var h=0;if(!this.scrolling){this.scrolling=[]}this.scrolling[i]=false;var p=false;var d=e(t);var v=["select","input","textarea"];var m=0;var g=0;if(!this.enableScrolling){this.enableScrolling=[]}this.enableScrolling[i]=true;var i=i;var y=this.getTouchEventName("touchstart")+".touchScroll";var b=this.getTouchEventName("touchend")+".touchScroll";var w=this.getTouchEventName("touchmove")+".touchScroll";var m=function(t){if(!s.enableScrolling[i]){return true}if(e.inArray(t.target.tagName.toLowerCase(),v)!==-1){return}var n=s.getTouches(t);var r=n[0];if(n.length==1){s.dispatchMouseEvent("mousedown",r,s.getRootNode(r.target))}p=false;u=r.pageY;c=r.pageX;if(s.simulatetouches){u=r._pageY;c=r._pageX}s.scrolling[i]=true;o=0;l=0;return true};if(d.on){d.on(y,m)}else{d.bind(y,m)}var E=function(e){if(!s.enableScrolling[i]){return true}if(!s.scrolling[i]){return true}var t=s.getTouches(e);if(t.length>1){return true}var n=t[0].pageY;var a=t[0].pageX;if(s.simulatetouches){n=t[0]._pageY;a=t[0]._pageX}var d=n-u;var v=a-c;g=n;touchHorizontalEnd=a;f=d-o;h=v-l;p=true;o=d;l=v;r(-h*1,-f*1,v,d,e);e.preventDefault();e.stopPropagation();if(e.preventManipulation){e.preventManipulation()}return false};if(d.on){d.on(w,E)}else{d.bind(w,E)}if(this.simulatetouches){var S=e(window).on!=undefined||e(window).bind;var x=function(e){s.scrolling[i]=false};e(window).on!=undefined?e(window).on("mouseup.touchScroll",x):e(window).bind("mouseup.touchScroll",x);if(window.frameElement){if(window.top!=null){var T=function(e){s.scrolling[i]=false};if(window.top.document){e(window.top.document).on?e(window.top.document).on("mouseup",T):e(window.top.document).bind("mouseup",T)}}}var N=e(document).on!=undefined||e(document).bind;var C=function(e){if(!s.scrolling[i]){return true}s.scrolling[i]=false;var t=s.getTouches(e)[0],n=s.getRootNode(t.target);s.dispatchMouseEvent("mouseup",t,n);s.dispatchMouseEvent("click",t,n)};e(document).on!=undefined?e(document).on("touchend",C):e(document).bind("touchend",C)}var k=function(e){if(!s.enableScrolling[i]){return true}var t=s.getTouches(e)[0];if(!s.scrolling[i]){return true}s.scrolling[i]=false;if(p){s.dispatchMouseEvent("mouseup",t,n)}else{var t=s.getTouches(e)[0],n=s.getRootNode(t.target);s.dispatchMouseEvent("mouseup",t,n);s.dispatchMouseEvent("click",t,n);return true}};d.on?d.on(b+" touchcancel.touchScroll",k):d.bind(b+" touchcancel.touchScroll",k)}});e.jps.cookie=e.jps.cookie||{};e.extend(e.jps.cookie,{cookie:function(e,t,n){if(arguments.length>1&&String(t)!=="[object Object]"){n=jQuery.extend({},n);if(t===null||t===undefined){n.expires=-1}if(typeof n.expires==="number"){var r=n.expires,i=n.expires=new Date;i.setDate(i.getDate()+r)}t=String(t);return document.cookie=[encodeURIComponent(e),"=",n.raw?t:encodeURIComponent(t),n.expires?"; expires="+n.expires.toUTCString():"",n.path?"; path="+n.path:"",n.domain?"; domain="+n.domain:"",n.secure?"; secure":""].join("")}n=t||{};var s,o=n.raw?function(e){return e}:decodeURIComponent;return(s=(new RegExp("(?:^|; )"+encodeURIComponent(e)+"=([^;]*)")).exec(document.cookie))?o(s[1]):null}});e.jps.string=e.jps.string||{};e.extend(e.jps.string,{replace:function(e,t,n){if(t===n){return this}var r=e;var i=r.indexOf(t);while(i!=-1){r=r.replace(t,n);i=r.indexOf(t)}return r},contains:function(e,t){if(e==null||t==null){return false}return e.indexOf(t)!=-1},containsIgnoreCase:function(e,t){if(e==null||t==null){return false}return e.toUpperCase().indexOf(t.toUpperCase())!=-1},equals:function(e,t){if(e==null||t==null){return false}e=this.normalize(e);if(t.length==e.length){return e.slice(0,t.length)==t}return false},equalsIgnoreCase:function(e,t){if(e==null||t==null){return false}e=this.normalize(e);if(t.length==e.length){return e.toUpperCase().slice(0,t.length)==t.toUpperCase()}return false},startsWith:function(e,t){if(e==null||t==null){return false}return e.slice(0,t.length)==t},startsWithIgnoreCase:function(e,t){if(e==null||t==null){return false}return e.toUpperCase().slice(0,t.length)==t.toUpperCase()},normalize:function(e){if(e.charCodeAt(e.length-1)==65279){e=e.substring(0,e.length-1)}return e},endsWith:function(e,t){if(e==null||t==null){return false}e=this.normalize(e);return e.slice(-t.length)==t},endsWithIgnoreCase:function(e,t){if(e==null||t==null){return false}e=this.normalize(e);return e.toUpperCase().slice(-t.length)==t.toUpperCase()}});e.extend(jQuery.easing,{easeOutBack:function(e,t,n,r,i,s){if(s==undefined){s=1.70158}return r*((t=t/i-1)*t*((s+1)*t+s)+1)+n},easeInQuad:function(e,t,n,r,i){return r*(t/=i)*t+n},easeInOutCirc:function(e,t,n,r,i){if((t/=i/2)<1){return-r/2*(Math.sqrt(1-t*t)-1)+n}return r/2*(Math.sqrt(1-(t-=2)*t)+1)+n},easeInOutSine:function(e,t,n,r,i){return-r/2*(Math.cos(Math.PI*t/i)-1)+n},easeInCubic:function(e,t,n,r,i){return r*(t/=i)*t*t+n},easeOutCubic:function(e,t,n,r,i){return r*((t=t/i-1)*t*t+1)+n},easeInOutCubic:function(e,t,n,r,i){if((t/=i/2)<1){return r/2*t*t*t+n}return r/2*((t-=2)*t*t+2)+n},easeInSine:function(e,t,n,r,i){return-r*Math.cos(t/i*(Math.PI/2))+r+n},easeOutSine:function(e,t,n,r,i){return r*Math.sin(t/i*(Math.PI/2))+n},easeInOutSine:function(e,t,n,r,i){return-r/2*(Math.cos(Math.PI*t/i)-1)+n}})})(jQuery);(function(e){e.extend(jQuery.event.special,{close:{noBubble:true},open:{noBubble:true},expand:{noBubble:true},collapse:{noBubble:true},tabclick:{noBubble:true},selected:{noBubble:true},expanded:{noBubble:true},collapsed:{noBubble:true},valuechanged:{noBubble:true},expandedItem:{noBubble:true},collapsedItem:{noBubble:true},expandingItem:{noBubble:true},collapsingItem:{noBubble:true}});e.fn.extend({ischildof:function(t){var n=e(this).parents().get();for(var r=0;r<n.length;r++){if(typeof t!="string"){var i=n[r];if(i==t[0]){return true}}else{if(e(n[r]).is(t)){return true}}}return false}});var t=this.originalVal=e.fn.val;e.fn.val=function(n){if(typeof n=="undefined"){if(e(this).hasClass("jps-widget")){var r=e(this).data().jpsWidget;if(r&&r.val){return r.val()}}return t.call(this)}else{if(e(this).hasClass("jps-widget")){var r=e(this).data().jpsWidget;if(r&&r.val){if(arguments.length!=2){return r.val(n)}else{return r.val(n,arguments[1])}}}return t.call(this,n)}};e.fn.coord=function(t){var n,r,i={top:0,left:0},s=this[0],o=s&&s.ownerDocument;if(!o){return}n=o.documentElement;if(!jQuery.contains(n,s)){return i}if(typeof s.getBoundingClientRect!==undefined){i=s.getBoundingClientRect()}var u=function(e){return jQuery.isWindow(e)?e:e.nodeType===9?e.defaultView||e.parentWindow:false};r=u(o);var a=0;var f=0;var l=navigator.userAgent.toLowerCase();var c=l.indexOf("ipad")!=-1||l.indexOf("iphone")!=-1;if(c){a=2}if(true==t){if(e(document.body).css("position")!="static"){var h=e(document.body).coord();a=-h.left;f=-h.top}}return{top:f+i.top+(r.pageYOffset||n.scrollTop)-(n.clientTop||0),left:a+i.left+(r.pageXOffset||n.scrollLeft)-(n.clientLeft||0)}}})(jQuery)