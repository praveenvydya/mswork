<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<head>
<style>
.camp_loc_map{
	
        height: 335px;
}
.tabs ul.tabs-list{
	position: relative;
	top:-550px;
}
.tabs .tabBox{
	padding: 0px !important;
}
.tabs .content{
	margin: 0px !important;
}
.map-banner{
	padding-bottom: 39px;
}
</style>

<!-- <script src="https://maps.googleapis.com/maps/api/js"></script> -->

   <script type="text/javascript">
   
jQuery(document).ready(function ($) {
	
	
      function init_map1() {
        var mapCanvas1 = document.getElementById('map1');
        var mapOptions1 = {
          center: new google.maps.LatLng(18.2889935,79.4723156),
          zoom: 18,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        
        var map1 = new google.maps.Map(mapCanvas1, mapOptions1);
        marker = new google.maps.Marker({
			map : map1,
			position : new google.maps.LatLng(18.2889935,79.4723156)
		});
		infowindow = new google.maps.InfoWindow({
			content : "<b>The Vydya</b><br/><br/>505122 Jammikunta"
		});
		google.maps.event.addListener(marker, "click", function() {
			infowindow.open(map1, marker);
		});
		infowindow.open(map1, marker);
		
       
      }
      
      
      
      function init_map2() {
          var mapCanvas2 = document.getElementById('map2');
          var mapOptions2 = {
            center: new google.maps.LatLng(44.5403, -78.5463),
            zoom: 18,
            mapTypeId: google.maps.MapTypeId.ROADMAP
          };
          var map2 = new google.maps.Map(mapCanvas2, mapOptions2);
          marker = new google.maps.Marker({
  			map : map2,
  			position : new google.maps.LatLng(44.5403, -78.5463)
  		});
  		infowindow = new google.maps.InfoWindow({
  			content : "<b>The School</b><br/><br/>500078 Hyderabad"
  		});
  		google.maps.event.addListener(marker, "click", function() {
  			infowindow.open(map2, marker);
  		});
  		infowindow.open(map2, marker);
         
        }
        
      
      
      
      google.maps.event.addDomListener(window, 'load', init_map1);
      google.maps.event.addDomListener(window, 'load', init_map2);
    

    $("#campusTab").fineTabs({
		tabhead : 'h2',
		fx : "fadeIn",
		syncheights : true,
		saveState : true,
		clearfixClass : 'ym-clearfix',
		currentInfoText : ""

	});
});
    </script>
</head>


<div class="full-page" >


		<div class="tabs" id="campusTab">
				<div class="tabBox">
					<div style="display: block;" class="tabbody">
						<div class="map-banner">
							<div class="img-parent">
								<div class="camp_loc_map" id="map1"></div>
							</div>
						</div>	
						<div class="full-content" style="margin: 5px;">
							<table width="100%">
								<tr><td colspan="2"> <strong>Campus:</strong> </td></tr>
								<tr>
								<td width="30%" style="vertical-align: top;"><p>PB. No.437 <br>
					                            Kukatpally<br>
					                            Hyderabad,
					                            <br>
					                            (5km from JNTU) <br>
					                            Hyderabad - 500 078<br>
					                            Andhra Pradesh, India.<br>
					                            <br>
					                            Tel.: <strong>+91-40-1234 6789 / 6790</strong><br>                            
					                            E-mail: <a href="mailto:info@vydya.com"><strong>info@vydya.com</strong></a> <br>
					                            <br>
					                          </p></td>
								
								<td width="70%"><img src="images/school-campus2.jpg" alt="Vydya School" style="width:586px; height: 185px; display: inline-block;"></td>
								</tr>
							</table>
						</div>
					</div>
					<div style="display: block;" class="tabbody">
						<div class="map-banner">
							<div class="img-parent">
								<div class="camp_loc_map" id="map2"></div>
							</div>
						</div>	
						<div class="full-content" style="margin: 5px;">
							<table width="100%">
								<tr><td colspan="2"> <strong>Campus:</strong> </td></tr>
								<tr>
								<td width="30%" style="vertical-align: top;"><p>PB. No.437 <br>
					                            Dilshuknagar<br>
					                            Hyderabad,
					                            <br>
					                            (5km from ) <br>
					                            Hyderabad - 500 079<br>
					                            Andhra Pradesh, India.<br>
					                            <br>
					                            Tel.: <strong>+91-40-1234 6789 / 6790</strong><br>                            
					                            E-mail: <a href="mailto:info@vydya.com"><strong>info@vydya.com</strong></a> <br>
					                            <br>
					                          </p></td>
								
								<td width="70%"><img src="images/school-campus2.jpg" alt="Vydya School" style="width:586px; height: 185px; display: inline-block;"></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<ul class="clearfix tabs-list tabamount3">
					<li class="current first" id="accessibletabsnavigation0-0"><a
						href="#accessibletabscontent0-0"><span class="current-info"></span>Kukatpally</a>
					</li>
					<li id="accessibletabsnavigation0-1"><a
						href="#accessibletabscontent0-1"><span class="current-info"></span>Dilshuknagar</a>
					</li>
				</ul>
				
	</div>
	
</div>


<script type="text/javascript"
	src="http://maps.google.com/maps/api/js?sensor=false"></script>
<!-- <div style="overflow: hidden; height: 335px; width: 845px;">
	<div id="gmap_canvas" style="height: 335px; width: 845px;"></div>
	<style>
#gmap_canvas img {
	max-width: none !important;
	background: none !important
}
</style>
</div>
<script type="text/javascript">
	function init_map() {
		var myOptions = {
			zoom : 18,
			center : new google.maps.LatLng(18.2889935,79.4723156),
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		map = new google.maps.Map(document.getElementById("map1"),
				myOptions);
		marker = new google.maps.Marker({
			map : map,
			position : new google.maps.LatLng(18.2889935,79.4723156)
		});
		infowindow = new google.maps.InfoWindow({
			content : "<b>The Vydya School</b><br/><br/>505122 Kukatpally"
		});
		google.maps.event.addListener(marker, "click", function() {
			infowindow.open(map, marker);
		});
		infowindow.open(map, marker);
	}
	google.maps.event.addDomListener(window, 'load', init_map);
</script> 

<script type="text/javascript">
	function init_map2() {
		var myOptions = {
			zoom : 18,
			center : new google.maps.LatLng(18.2889935,79.4723156),
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		map2 = new google.maps.Map(document.getElementById("map2"),
				myOptions);
		marker = new google.maps.Marker({
			map : map2,
			position : new google.maps.LatLng(18.2889935,79.4723156)
		});
		infowindow = new google.maps.InfoWindow({
			content : "<b>The Vydya School</b><br/><br/>500048 Dilshuknagar"
		});
		google.maps.event.addListener(marker, "click", function() {
			infowindow.open(map, marker);
		});
		infowindow.open(map, marker);
	}
	google.maps.event.addDomListener(window, 'load', init_map2);
</script> -->
