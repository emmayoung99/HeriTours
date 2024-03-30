<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapPage.aspx.cs" Inherits="HeriTours_4._0.MapPage" %>

<!--Version Date        Coder       Comments
1.0.1   2024-02-01  TBaxter     Initial. Added bootstrap, InfoCard, map html and CSS links just to get it to show up
1.0.2   2024-02-02  TBaxter     added nav bar with the intention to move all html related files into a ASP.NET file
1.1.0   2024-02-08  TBaxter     Moved to asp.core
1.1.1   2024-02-17  TBaxter     Fixed links and script srcs
1.2.0   2024-02-20  TBaxter     Added LeftNavBar and made it sticky, connected it to reflect Accordian, added dropdown inside accordian
1.2.1   2024-02-21  TBaxter     Removed dropdowns and its css because looked odd, wasn't working bc it needs Popper and Bootstrap (couldn't get popper to work)
                                turned dropdown into simple list group. added button2
1.2.2   2024-02-21  AGibbs      Fixed map not loading (typo)
1.2.3   2024-02-24  EYoung      Edited the css files
1.2.4   2024-03-08  EYOUNG      Modified structure and added more comments
1.2.5   2024-03-08  HMusni      Added in heritage site type buttons, ID functions connect to AddMarkers.js
1.3.0   2024-03-13  HMusni      Migrated from cshtml to aspx solution. Reset the css and js relative paths.
1.3.1   2024-03-19  HMusni      Added temporary buttons on the map page for the heritage and transportation layers to activate the onClick functions
1.4.0   2024-03-27  AGibbs      Add ArcGIS script references (Map references need to be loaded after bootstrap to initialize properly); added a clearmap button
1.4.1   2024-03-27  TBaxter     Added Buttons.css link
1.4.2   2024-03-30  TBaxter     Added Combo boxes for Route
-->

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" style="height: 900px; width: 100%;">
    <title>Start Your Tour</title>

    <!-- Set the character set for the document -->
    <meta charset="utf-8">
    <!--<meta name="viewport" content="width=device-width, initial-scale=1">-->
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Map CSS -->
    <%--<link href="./css/MapStyle.css" rel="stylesheet">--%>
    <link rel="stylesheet" href="./css/MapStyle.css"/>
    <link rel="stylesheet" href="./css/Buttons.css"/>
    <!-- Polyfill for Map -->
    <%--<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>--%>
    <link href="./css/GeneralStyle.css" rel="stylesheet">

    <link rel="stylesheet" href="https://js.arcgis.com/4.29/esri/themes/light/main.css">
    <script src="https://js.arcgis.com/4.29/"></script>
    <script src="./js/ArcGISMap.js"></script> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


</head>
<body>

    <form id="form1" runat="server">
      
<header>
    <nav class="navbar navbar-expand-sm navbar-light bg-orange border-bottom box-shadow mb-3">
        <div class="container">
            <a class="navbar-brand" asp-area="" asp-page="/Index">HeriTours</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target=".navbar-collapse" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="navbar-collapse collapse d-sm-inline-flex justify-content-between">
                <ul class="navbar-nav flex-grow-1">
                    <li class="nav-item">
                        <a class="nav-link text-dark" href="History.aspx">History</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark" href="StartLoc.aspx">Start</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark" href="Selection.aspx">Selection</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>
        <!-- Combo boxes for route. no styling at this time -->
        <select id="SelOrig" class="form-select" ></select> <!-- Start -->
        <select id="SelDes" class="form-select" ></select> <!-- Destination -->
                

        <div id="viewDiv" style="height: 700px; width: 100%;"></div>

        <button id="AntiqueShops" onclick="GetAntiqueShops()" type="button">Antique Shops</button>
        <button id="CemeteryandFuneralHomes" onclick="GetCemetery()" type="button">Cemetery and Funeral Homes</button>
        <button id="Churches" onclick="GetChurches()" type="button">Churches</button>
        <button id="Farms" onclick="GetFarms()" type="button">Farms</button>
        <button id="Hospitals" onclick="GetHospitals()" type="button">Hospitals</button>
        <button id="Museums" onclick="GetMuseums()" type="button">Museums</button>
        <button id="ParkandGardens" onclick="GetParks()" type="button">Park and Gardens</button>
        <button id="Residences" onclick="GetResidences()" type="button">Residences</button>
        <button id="Schools" onclick="GetSchools()" type="button">Schools</button>
        <button id="Theatres" onclick="GetTheatres()" type="button">Theatres</button>
        <button id="Other" onclick="GetOther()" type="button">Other</button>
        <button id="Clear" onclick="ClearMap()" type="button"><b>CLEAR MAP</b></button>
        
        <br />
        <%--transportation layers to be replaced--%>
        <%--<button id="Bike" onclick="getBikeLayer()" type="button">BIKE ROUTE</button>
        <button id="Transit" onclick="getTransitLayer()" type="button">TRANSIT ROUTE</button>
        <button id="Traffic" onclick="getTrafficLayer()" type="button">TRAFFIC ROUTE</button>--%>
        
        <%--<input type="checkbox" id="Community" name="Community" />
        <label for="Community">Community</label>--%>
    
               
        <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <%--<script src="js/GoogleMap.js"></script>--%>
       <%-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAX6haxPnf_GlOOJLMl4XX-_y9id7NBzh8&callback=initMap"
            async defer></script>--%>
    </form>
</body>
</html>
