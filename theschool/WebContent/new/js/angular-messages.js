"use strict";function ngMessageDirectiveFactory(){function a(a,b){if(a)return isArray(a)?a.indexOf(b)>=0:a.hasOwnProperty(b)}return["$animate",function(b){return{restrict:"AE",transclude:"element",priority:1,terminal:!0,require:"^^ngMessages",link:function(c,d,e,f,g){var i,h=d[0],j=e.ngMessage||e.when,k=e.ngMessageExp||e.whenExp,l=function(a){i=a?isArray(a)?a:a.split(/[\s,]+/):null,f.reRender()};k?(l(c.$eval(k)),c.$watchCollection(k,l)):l(j);var m,n;f.register(h,n={test:function(b){return a(i,b)},attach:function(){m||g(function(a,c){b.enter(a,null,d),m=a;var e=m.$$attachId=f.getAttachId();m.on("$destroy",function(){m&&m.$$attachId===e&&(f.deregister(h),n.detach()),c.$destroy()})})},detach:function(){if(m){var a=m;m=null,b.leave(a)}}})}}}]}var forEach,isArray,isString,jqLite;angular.module("ngMessages",[],function(){forEach=angular.forEach,isArray=angular.isArray,isString=angular.isString,jqLite=angular.element}).directive("ngMessages",["$animate",function(a){function d(a,b){return isString(b)&&0===b.length||e(a.$eval(b))}function e(a){return isString(a)?a.length:!!a}var b="ng-active",c="ng-inactive";return{require:"ngMessages",restrict:"AE",controller:["$element","$scope","$attrs",function(g,h,i){function p(a,b){for(var c=b,d=[];c&&c!==a;){var e=c.$$ngMessageNode;if(e&&e.length)return m[e];c.childNodes.length&&d.indexOf(c)===-1?(d.push(c),c=c.childNodes[c.childNodes.length-1]):c.previousSibling?c=c.previousSibling:(c=c.parentNode,d.push(c))}}function q(a,b,c){var d=m[c];if(j.head){var e=p(a,b);e?(d.next=e.next,e.next=d):(d.next=j.head,j.head=d)}else j.head=d}function r(a,b,c){var d=m[c],e=p(a,b);e?e.next=d.next:j.head=d.next}var j=this,k=0,l=0;this.getAttachId=function(){return l++};var n,o,m=this.messages={};this.render=function(f){f=f||{},n=!1,o=f;for(var k=d(h,i.ngMessagesMultiple)||d(h,i.multiple),l=[],m={},p=j.head,q=!1,r=0;null!=p;){r++;var s=p.message,t=!1;q||forEach(f,function(a,b){if(!t&&e(a)&&s.test(b)){if(m[b])return;m[b]=!0,t=!0,s.attach()}}),t?q=!k:l.push(s),p=p.next}forEach(l,function(a){a.detach()}),l.length!==r?a.setClass(g,b,c):a.setClass(g,c,b)},h.$watchCollection(i.ngMessages||i.for,j.render),g.on("$destroy",function(){forEach(m,function(a){a.message.detach()})}),this.reRender=function(){n||(n=!0,h.$evalAsync(function(){n&&o&&j.render(o)}))},this.register=function(a,b){var c=k.toString();m[c]={message:b},q(g[0],a,c),a.$$ngMessageNode=c,k++,j.reRender()},this.deregister=function(a){var b=a.$$ngMessageNode;delete a.$$ngMessageNode,r(g[0],a,b),delete m[b],j.reRender()}}]}}]).directive("ngMessagesInclude",["$templateRequest","$document","$compile",function(a,b,c){function d(a,d){var e=c.$$createComment?c.$$createComment("ngMessagesInclude",d):b[0].createComment(" ngMessagesInclude: "+d+" "),f=jqLite(e);a.after(f),a.remove()}return{restrict:"AE",require:"^^ngMessages",link:function(b,e,f){var g=f.ngMessagesInclude||f.src;a(g).then(function(a){b.$$destroyed||(isString(a)&&!a.trim()?d(e,g):c(a)(b,function(a){e.after(a),d(e,g)}))})}}}]).directive("ngMessage",ngMessageDirectiveFactory()).directive("ngMessageExp",ngMessageDirectiveFactory());