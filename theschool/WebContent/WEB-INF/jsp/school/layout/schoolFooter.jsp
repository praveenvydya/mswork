<%-- <div id="footer">
	  <span></span>
	  <div class="copyrightsText"><p>&copy; <script>document.write((new Date).getFullYear())</script> Vydya Holdings, Inc. </p>
	  <p class="second">All Rights Reserved</p></div><br>
	  <div id="footerBuild">Build Version:${applicationScope.build_version}</div> 
  </div> --%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%-- <%@ taglib prefix="f" uri="/WEB-INF/functions.tld" %> --%>
 <style>
 .row {
margin-right: -15px;
margin-left: -15px;
}

.row:before, .row:after {
display: table;
content: " ";
}

 .main .col-md-3:first-child {
min-height: 210px;
}
#sfooter-box .main .col-md-3 {
position: relative;
}


.col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 
{
/* margin:4px; */
}


.col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 
{
float: left;
 
}
.sfooter-content .col{
	 width: 100%;
	/* margin: 0px 20px; */
}
.sfooter-content, #sfooter-box ul.newslist  li a{
text-align: left;
/* float:left; */
color: #c2c2c2;
text-shadow: 0 1px 1px rgba(0,0,0,0.5);
}

.sfooter-content, #sfooter-box ul.newslist  li a:hover{
color: #fff;
}

#sfooter-box ul{
margin: 0 10px 10px 10px;
}

#sfooter-box ul.newslist  li{
display: table;
}
 #sfooter-box h5 {
margin: 10px 0 10px;
border-bottom: 1px solid #333;
padding: 0px !important;
color: #fff84f;
font-size: 14px !important;
}

h5 span {
display: inline-block;
margin-bottom: -1px;
padding: 8px 0;
font-size:18px;
border-bottom: 1px solid #319cee;
}

#sfooter-box ul li {
padding: 2px 0;
/* border-bottom: 1px solid #222; */
list-style: none;
}
.footer-row{
margin: 0 5px
}

 </style>
<div id="sfooter-box" class="main">
	<div class="sfooter-content">
		<div class="footer-row">

                <div class="col-md-3 col">
                    <h5><span>Main Menu</span></h5>
                    <ul class="list-unstyled">
                        <li>Gallery <a href="${pageContext.servletContext.contextPath}/gallery" class="pull-right" >visit</a></li>
                        <li>Toppers <a href="${pageContext.servletContext.contextPath}/toppers" class="pull-right" >visit</a></li>
                        <li>News <a href="${pageContext.servletContext.contextPath}/news" class="pull-right" >visit</a></li>
                        <li>Library<a href="${pageContext.servletContext.contextPath}/library" class="pull-right" >visit</a></li>
                        <li>Notifications<a href="${pageContext.servletContext.contextPath}/notifications" class="pull-right" >visit</a></li>
                        <li>Events<a href="${pageContext.servletContext.contextPath}/events" class="pull-right" >visit</a></li>
                    </ul>
                </div>
                <div class="col-md-3 col">
                    <h5><span>Latest News </span></h5>
                    <ul class="newslist">
                    
                    
<c:if test='${null!=newslist }'>


			      <c:forEach var="news" items="${newslist}" varStatus="cin">
			        <li><a href="${pageContext.request.contextPath}/news/${news.type}/${news.url}" class="pull-right" title="" target="_blank" >${news.name}.</a></li>
			        </c:forEach>
	</c:if>
                         <!--  <li>Auckland Website Design Agency <a href="#" class="pull-right" data-toggle="tooltip" data-placement="left" title="" target="_blank" data-original-title="http://www.clickthroughwebdesign.co.nz">visit</a></li>
                        <li>Concept Jewelry <a href="#" class="pull-right" data-toggle="tooltip" data-placement="left" title="" target="_blank" data-original-title="http://www.cptjewelry.com">visit</a></li>
                        <li>Hello bank! <a href="#" class="pull-right" data-toggle="tooltip" data-placement="left" title="" target="_blank" data-original-title="http://www.hellobank.be">visit</a></li>
                        <li>Contáctica Corp <a href="#" class="pull-right" data-toggle="tooltip" data-placement="left" title="" target="_blank" data-original-title="http://www.wearecontactica.com">visit</a></li>
                    --> 
                    </ul>
                </div>
                <div class="col-md-2  col">
                    <h5><span>Site Metrics</span></h5>
                    <ul class="list-unstyled">
                        <li><strong><c:out value='${sessionCount}'/></strong> Users viewing this site.</li>
                        <!-- <li><strong>36</strong> Pending Submissions</li> -->
                    </ul>
                </div>
                
                <div class="col-md-3  col">
                    <h5><span>Awards</span></h5>
                    <p>School Awards select the best students around all classes who met the performance expectations with respect to output, quality standards, delivery of goals and/or assignments..</p>
                    <p><small>© 2009-2014 School Student Awards. All screenshots © their respective owners. <a href="">Sitemap</a></small></p>
                </div>
                  <div class="col-md-2  col">
                    <h5><span>School</span></h5>
                    <p><a href="${pageContext.servletContext.contextPath}/admin/loginModule/login.htm" target="_blank">Admin Login</a></p>
                </div>
				<div class="col-md-1  col">
                    <h5><span>Social</span></h5>
                    <ul class="list-unstyled">
                        <li><a href="http://www.facebook.com/school" data-toggle="tooltip" data-placement="right" title="" data-original-title="Like us"><div class="fa fa-facebook"></div></a></li>
                        <li><a href="http://plus.google.com/school" data-toggle="tooltip" data-placement="right" title="" data-original-title="Subscribe"><div class="fa fa-gplus"></div></a></li>
                        <li><a href="http://www.twitter.com/school" data-toggle="tooltip" data-placement="right" title="" data-original-title="Follow us"><div class="fa fa-twitter"></div></a></li>
                        <li><a href="http://www.pinterest.com/school" data-toggle="tooltip" data-placement="right" title="" data-original-title="Pin it"><div class="fa fa-pinterest"></div></a></li>
                        <li><a href="http://feeds.feedburner.com/school" data-toggle="tooltip" data-placement="right" title="" data-original-title="Subscribe"><div class="fa fa-rss"></div></a></li>
                    </ul>
                </div>
               
                
                
            </div>
	</div>
  </div>
  
  
  