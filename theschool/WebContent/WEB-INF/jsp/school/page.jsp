<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<head>
<style>

</style>
<script type="text/javascript">

$(document).ready(function() {
	
	//$('code').displaycode({source:0, zebra:0, indent:'space', list:'ol'});
});

</script>
</head>

<div class="full-page">
	<div class="page-banner">
		<div class="img-parent">
			<img src="${pageContext.request.contextPath}/static/simg-org/${page.imageName}" width="100%"/>
		</div>
	</div>
	<div class="full-content">
		<div style="">
		<table class="contentTale">
			<tr>
			<td width="100%" style="margin:0px 5px">
				<div class="divc">
				<h3 class="tl07">${page.name}</h3>
				<p>
					
					${page.html}
				</p></div>
			</td>
			
			
			</tr>
		</table>
	</div>
	</div>

</div>