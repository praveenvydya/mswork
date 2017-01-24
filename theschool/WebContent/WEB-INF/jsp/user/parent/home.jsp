<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<style>

.secTable{
width: 50%;
float: left;

}
.secTable .sec{
float: left;
width: 47%;
}

.secTable .sec .el{
float: left;
}
.secTable .sec .eld{
}

.secTable th {
	background: #f1f1f1;
	color: #272626;
	padding: 4px 10px;
	border-bottom: 1px solid #e4e3e1;
	text-align: left;
	white-space: pre-wrap;
	font-weight: bold;
}

.secTable div {
	margin: 5px;
}
.secTable table {
width:96%;
	margin: 10px;
	background: #fff;
border-left: 1px solid #E4E3E1;
border-top: 1px solid #E4E3E1;
border-right: 1px solid #E4E3E1;
box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
}
.secTable td {
	border-bottom: 1px solid #e4e3e1;
	/* padding: 4px 10px; */
	white-space: inherit;
	vertical-align: top;
}

</style>
    <p>Welcome:&nbsp;<strong>${sessionScope.user_display_name}</strong> &nbsp; | &nbsp; <a href="${pageContext.servletContext.contextPath}/user/logout.htm" class="logoutLink">Logout</a></p>
   

    <p class="lastLogin">User TYpe: ${sessionScope.user_type}</p>
    </span>
    <div>Hello ${parent.firstName}  ${parent.lastName}</div>
   <div id="tabularData">
					
					<%-- <table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionsTable">
					 <thead>
					  <tr>
						<th width="4%">&nbsp;</th>
						<th width="12%">Child Name</th>
					  </tr>
					 </thead>
					  <c:forEach var="student" items="${students}"> 
                      <tr>
						<td>
							<form:radiobutton  path="id" id="${student.id}" value="${student.id}"/>
						</td>
						<td id ="st_${student.studentId}">${student.firstName} ${student.lastName}</td>
					  </tr>
                     </c:forEach> 					  
					</table> --%>
					<div id="sectionBttns">
					</div>
				
				
				<div>

					 <c:forEach var="student" items="${students}"> 
					 <div class="secTable">
					<table border="0" cellspacing="0" cellpadding="0"
						 id="">
						<thead>
							<tr>
								<th width="100%">${student.firstName} ${student.lastName}</th>
							</tr>
						</thead>
						<tr>
							<td>
								<div>
								<div class="sec"> 
									<div class="el"> Name: </div> <div class="eld"> ${student.firstName} ${student.lastName}</div>
									<div class="el"> Admission Number: </div> <div class="eld">  ${student.admNum}</div>
									<div class="el"> Class: </div> <div class="eld"> ${student.className}</div>
								</div>
								<div class="sec" style="float: right;">
									<img src="${pageContext.request.contextPath}/static/simg-fit/96v120/${student.unid}.jpeg" class=""
								alt="" />
								</div>
								</div>
							</td>
						</tr>
						<tr>
							<%-- <td><input type="button" value="Attendance" class="cms-btn" id="att_${student.studentId}" /></td> --%>
							<td><a href="${pageContext.servletContext.contextPath}/user/parent/attendance.htm?st=${student.studentId}"
							 id="att_${student.studentId}"  class="cms-btn att">Attendance</a><td>
							
						</tr>
					</table>
					</div>
					 </c:forEach> 		
			</div>
			
			</div>