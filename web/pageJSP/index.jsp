<%-- 
    Document   : index
    Created on : Jul 17, 2015, 11:53:42 AM
    Author     : Administrator
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title></title>
    <style type="text/css">
        .style1
        {
        }
        #Text1
        {
            width: 175px;
        }
        #Text2
        {
            width: 224px;
        }
        #Text3
        {
            width: 224px;
            margin-left: 4px;
        }
        #Text4
        {
            width: 222px;
        }
        .style2
        {
            width: 424px;
        }
        .style3
        {
            width: 169px;
        }
        .style4
        {
            text-align: center;
        }
        #Submit1
        {}
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script>
        

       </script>
    <script>
$(document).ready(function(){
    $('#txtHint').change(function(){
          alert("hello world");
});
});
</script>
</head>
<body style="height: 437px; width: 663px" onload="chance()">
     <div id="map" style="width:500px;height:380px;"></div>
     <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false">
 </script> 
<script>
    function processString(string)
        {       
            var x = string.split("*");
            return x;
        }
</script>
 <%-- đây là đoạn mã phần ajax để thực hiện công việc khi nhận được số điện thoại đầu vào --%>
 <script>    
function showCustomer()
{
var str = document.getElementById("Text1").value;
var xmlhttp;
if (str=="")
  {
  document.getElementById("txtHint").value="";
  return false;
  }
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("txtHint").value=xmlhttp.responseText;
    }
  }
xmlhttp.open("GET","../getcustomer?q="+str,true);
xmlhttp.send();
return false;
}
</script> 
<script>
    function showCustomer2()
{
var str = document.getElementById("Text1").value;
var xmlhttp;
if (str=="")
  {
  document.getElementById("target").innerHTML="chưa có số điện thoại gọi đến";
  return false;
  }
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("target").innerHTML=xmlhttp.responseText;
    }
  }
xmlhttp.open("GET","../getcustomer2?q="+str,true);
xmlhttp.send();
return false;
}
</script>

<%-- đây là đoạn mã java script để hiện thị bản đồ google map --%>
 <script type="text/javascript">
  var locations;
  var delay = 100;
  var markers = [];
  var infowindow = new google.maps.InfoWindow();
  var latlng = new google.maps.LatLng(21.0000, 78.0000);
  var mapOptions = {
    zoom: 5,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var geocoder = new google.maps.Geocoder(); 
  var map = new google.maps.Map(document.getElementById("map"), mapOptions);
  var bounds = new google.maps.LatLngBounds();
  
  function geocodeAddress(address, next) {
    geocoder.geocode({address:address}, function (results,status)
      { 
         //removeAllMaker();
         if (status == google.maps.GeocoderStatus.OK) {
          var p = results[0].geometry.location;
          var lat=p.lat();
          var lng=p.lng();
          createMarker(address,lat,lng);
        }
        else {
           if (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
            nextAddress--;
            delay++;
          } else {
                        }   
        }
        next();
      }
    );
  }
 function createMarker(add,lat,lng) {
   var contentString = add;
   var marker = new google.maps.Marker({
     position: new google.maps.LatLng(lat,lng),
     map: map,
           });
   

  google.maps.event.addListener(marker, 'click', function() {
     infowindow.setContent(contentString); 
     infowindow.open(map,marker);
   });

   bounds.extend(marker.position);
   markers.push(marker);
 }
    
  var nextAddress = 0;
  function theNext() {
    if (nextAddress < locations.length) {
      setTimeout('geocodeAddress("'+locations[nextAddress]+'",theNext)', delay);
      nextAddress++;
    } else {
      map.fitBounds(bounds);
    }
   
  }
  function setAdress()
  {
      deleteMarkers();
      nextAddress = 0;
      locations =null;
      var x = document.getElementById("txtHint").value;
      locations = processString(x);  
      theNext();
  }
  // Sets the map on all markers in the array.
function setAllMap(map) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
  setAllMap(null);
}

// Shows any markers currently in the array.
function showMarkers() {
  setAllMap(map);
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
  clearMarkers();
  markers = [];
}
  theNext();
</script>  
<form action="" onsubmit="return showCustomer()"> 
    <table style="width:100%;">
        <tr>
            <td bgcolor="#FF9999" class="style3">
                Phía Khách Hàng</td>
        </tr>
        <tr>
            <td bgcolor="#FF9999" class="style3">
                Nhập số điện thoại của bạn :</td>
            
        </tr>
        <tr>
            <td bgcolor="#FF9999" class="style3">
                <input id="Text1" type="text" name="phonenumber" /></td>       
        </tr>
        <tr>
            <td bgcolor="#FF9999" class="style3">
                <input id="Submit1" type="submit" value="Gọi cho tổng đài" onclick="showCustomer2();"  /></td>           
        </tr>
        <tr>
        </tr>       
    </table>
        </form>  

<input type="text" id="txtHint" hidden="true">
<div id="target"> </div>
<input type="button" value="Hiện Thị Vị Trí Trên Bản Đồ" onclick="setAdress();">
</body>
</html>
