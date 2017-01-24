<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<script defer="defer">
	
</script>
<script type="text/javascript">
	$(document).ready(function() {

		$("a[rel=galleryImage_group]").fancybox({
			
			prevEffect : 'fade',
			nextEffect : 'fade',
			openEffect:'elastic',
			closeEffect:'elastic',
			helpers : {
				/* thumbs : {
					width  : 50,
					height : 50
				}, */
				overlay : {
					closeClick : false
				}
			}
		});
		
		$("a[rel=galleryVideo_group]").fancybox({
			
			fitToView	: true,
			helpers : {
				overlay : {
					closeClick : false
				}
			},
			arrows:false,
      	  title: this.title,
			autoSize	: true,
			openEffect	: 'elastic',
			nextClick  : false,
			closeEffect	: 'elastic',
			type: 'swf',
      	  swf: {
      	    'wmode': 'transparent',
      	    'allowfullscreen': 'true'
      	  }
		});

						/* 'onStart' : function() {
						}, */
						/* 'titleFormat' : function(
								title,
								currentArray,
								currentIndex,
								currentOpts) {
							return '<span id="fancybox-title-over"><span class="imageDesc">'
									+ (title.length ? ' &nbsp; '
											+ title
											: '')
									+ '</span><span class="imageIndex"> Image:'
									+ (currentIndex + 1)
									+ ' / '
									+ currentArray.length
									+ '</span>';
						} */

					$('#scrollboxDiv').finescroll({
					    verticalTrackClass: 'track',
					    verticalHandleClass: 'handle',
					    minScrollbarLength: 15,
					    showOnHover : false
					});
					});
</script>
<style>

div.allLibs div.cat-inner-boundary {
/* width: 188px !important; */
float: left;
height: auto;
}

#free-file .c-inner-border {
clear: both;
display: inline-block;
/* width: 136px; */
}

#free-file .cat-inner:hover {
border: 1px solid #A2F397; 
}


#free-file .cat-inner {
background-color: #FFFFFF;
 border: 1px solid #E4E3E1;
box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
padding: 2px;
}

.cat-inner div.trans {
background-color:rgba(0,0,0,0.7);
filter: alpha(opacity=40); /* For IE8 and earlier */
bottom: 44px;
color: #fff;
display: block;
left: 0;
padding: 12px 7px 12px 7px;
position: absolute;
word-wrap: break-word;
position: relative;

}
.cat-inner div.trans a{
color:#fff;
text-transform: uppercase;
font-weight: bold;
}
.catImage{

width: 145px;
height: 194px;
padding-left: 39px;
padding-top: 11px;
}

.book-thumbnail {
position: relative;
/* width: 138px; */
}
.content-div{
	width: inherit;
	height: 40px;
	/* border: 1px solid #F1F1F1; */
text-align: left;
text-overflow: ellipsis;
white-space: inherit;
overflow: hidden;
padding: 0 3px;
width: inherit;
height: 40px;
}
.division6 .c-inner-border{

padding: 0px;
}
.division6 .div-support{

padding: 0px;
margin: 0 auto;
width: 72%;
}

</style>


     <div class="blockquote" > 
		<div>
            <h2>${cat.title}</h2>
		</div>
	</div> 
	<div id="free-file" class="allLibs">
	
	<div class="outer-boundary">
		<c:if test='${null!=booksList }'>
			<c:forEach var="book" items="${booksList}">
				<div class="cat-inner-boundary division6" id="book_${book.id}"> 
					<div class="div-support">
					<div class="c-inner-border">
						<div class="cat-inner">
							<div class="book-thumbnail">
									<a title="${book.description}"
								href="${pageContext.request.contextPath}/books/r/${cat.url}/${book.url}" id="book_${book.id}"  target="_blank" class="gthumb">	
								<img class="std-thumb" src="data:image/jpg;base64,<c:out value='${book.image}'/>" /> </a>
								<div class="overdiv"> 
									<a href="${pageContext.request.contextPath}/books/r/${cat.url}/${book.url}" target="_blank"><span class="fl-read" id=""></span></a>
									<a href="${pageContext.request.contextPath}/books/d/${cat.url}/${book.url}"><span class="fl-download" id="" style="float: right;"></span></a>
								</div>
				 			</div>
							</div>
							<div class="content-div">
								<div class="book-title">
										${book.name}
								</div>
							</div>
						</div>
						</div>
					</div>
			</c:forEach>
		</c:if>
		</div>
		
	</div>
	
	<%-- <div>
		<div class="forBooks">
			<div class="catBooks">
				<c:if test='${null!=booksList }'>
					<c:forEach var="book" items="${booksList}"
						varStatus="">
							<a id="evntImg_${book.id}"
								title="${book.description}"
								href="${pageContext.request.contextPath}/books/${book.categoryUrl}/${book.url}"
								rel="galleryImage_group"> 
							<img class="std-thumb" src="data:image/jpg;base64,<c:out value='${book.image}'/>" /> </a>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div> --%>
	
	
	


