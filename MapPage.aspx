<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapPage.aspx.cs" Inherits="HeriTours_4._0.MapPage" %>

<!--
Version Date        Coder       Comments
1.0.1   2024-02-01  TBaxter     Initial. Added bootstrap, InfoCard, map html and CSS links just to get it to show up
1.0.2   2024-02-02  TBaxter     added nav bar with the intention to move all html related files into a ASP.NET file
1.1.0   2024-02-08  TBaxter     Moved to asp.core
1.1.1   2024-02-17  TBaxter     Fixed links and script srcs
1.2.0   2024-02-20  TBaxter     Added LeftNavBar and made it sticky, connected it to reflect Accordian, added dropdown inside accordian
1.2.1   2024-02-21  TBaxter     Removed dropdowns and its css because looked odd, wasn't working bc it needs Popper and Bootstrap (couldn't get popper to work)
                                turned dropdown into simple list group. added button2
1.2.2   2024-02-21  AGibbs      Fixed map not loading (typo)
1.2.3   2024-02-24  EYoung      Edited the css files
1.2.4   2024-03-08  EYoung      Modified structure and added more comments
1.2.5   2024-03-08  HMusni      Added in heritage site type buttons, ID functions connect to AddMarkers.js
1.3.0   2024-03-13  HMusni      Migrated from cshtml to aspx solution. Reset the css and js relative paths.
1.3.1   2024-03-19  HMusni      Added temporary buttons on the map page for the heritage and transportation layers to activate the onClick functions
1.4.0   2024-03-27  AGibbs      Add ArcGIS script references (Map references need to be loaded after bootstrap to initialize properly); added a clearmap button
1.4.1   2024-03-27  TBaxter     Added Buttons.css link
1.4.2   2024-03-30  TBaxter     Added Combo boxes for Route
1.4.3   2024-03-30  EYOUNG      Added footer.

     

-->

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" style="height: 900px; width: 100%;">
    <title>Start Your Tour</title>

    <!-- Set the character set for the document -->
    <meta charset="utf-8" />
    <!--<meta name="viewport" content="width=device-width, initial-scale=1">-->
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
    <!-- Map CSS -->
    <%--<link href="./css/MapStyle.css" rel="stylesheet">--%>
    <link rel="stylesheet" href="./css/MapStyle.css" />
    <link rel="stylesheet" href="./css/Buttons.css" />
    <!-- Polyfill for Map -->
    <%--<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>--%>
    <link href="./css/GeneralStyle.css" rel="stylesheet" />

    <link rel="stylesheet" href="https://js.arcgis.com/4.29/esri/themes/light/main.css" />
    <script src="https://js.arcgis.com/4.29/"></script>
    <script src="./js/ArcGISMap.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


</head>

<body>

    <form id="form1" runat="server">

        <header>
            <nav class="navbar navbar-expand-sm navbar-light bg-orange border-bottom box-shadow mb-3">
                <div class="container">
                    <a class="navbar-brand" asp-area="" asp-page="/Index">
                        <!-- The navbar-logo class in GeneralStyle css isn't affecting logo, needs to be correct but working inline for now -->
                        <img src="/css/img/logo.png" alt="Logo" height="70" class="navbar-logo" />
                        HeriTours</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target=".navbar-collapse" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="navbar-collapse collapse d-sm-inline-flex justify-content-between">
                        <ul class="navbar-nav flex-grow-1">
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="History.aspx">History</a>
                            </li>
                            <%--<li class="nav-item">
                        <a class="nav-link text-dark" href="Selection.aspx">Selection</a>
                    </li>--%>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <div class="text-center">
            <!-- Display a message indicating that the page is under construction and show the timestamp -->
            <p>This page is under construction as of <%= Page.Items["TimeStamp"] %>.</p>
        </div>


        <div id="routeCon" class="container">
            <h5><b>Step 1: Pick A Heritage Site Type</b></h5>
            <button class="location-button" id="AntiqueShops" onclick="toggleSelected('AntiqueShops')" type="button">Antique Shops</button>
            <button class="location-button" id="CemeteryandFuneralHomes" onclick="toggleSelected('CemeteryandFuneralHomes')" type="button">Cemetery and Funeral Homes</button>
            <button class="location-button" id="Churches" onclick="toggleSelected('Churches')" type="button">Churches</button>
            <button class="location-button" id="Farms" onclick="toggleSelected('Farms')" type="button">Farms</button>
            <button class="location-button" id="Hospitals" onclick="toggleSelected('Hospitals')" type="button">Hospitals</button>
            <button class="location-button" id="Museums" onclick="toggleSelected('Museums')" type="button">Museums</button>
            <button class="location-button" id="ParkandGardens" onclick="toggleSelected('ParkandGardens')" type="button">Park and Gardens</button>
            <button class="location-button" id="Residences" onclick="toggleSelected('Residences')" type="button">Residences</button>
            <button class="location-button" id="Schools" onclick="toggleSelected('Schools')" type="button">Schools</button>
            <button class="location-button" id="Theatres" onclick="toggleSelected('Theatres')" type="button">Theatres</button>
            <button class="location-button" id="Other" onclick="toggleSelected('Other')" type="button">Other</button>
            <button id="Clear" onclick="ClearMap()" type="button"><b>CLEAR MAP</b></button>






            <!-- Combo boxes for picking locations in the route -->

            <h5><b>Step 2: Pick The Locations on Your Tour</b></h5>
            <div class="col-sm-10">
                <label for="SelOrig" class="control-label"><b>Pick a Starting Location</b> </label>
                <select id="SelOrig" class="form-select"></select><!-- Start -->

                <select id="Stop2" style="display: none" class="form-select"></select><!-- mid stop -->
                <select id="Stop3" style="display: none" class="form-select"></select><!-- mid stop -->
                <select id="Stop4" style="display: none" class="form-select"></select><!-- mid stop -->
                <select id="Stop5" style="display: none" class="form-select"></select><!-- mid stop -->
                <select id="Stop6" style="display: none" class="form-select"></select><!-- mid stop -->
                <select id="Stop7" style="display: none" class="form-select"></select><!-- mid stop -->
                <select id="Stop8" style="display: none" class="form-select"></select><!-- mid stop -->
                <select id="Stop9" style="display: none" class="form-select"></select><!-- mid stop -->

                <label for="SelDes" class=" control-label"><b>Pick a Destination Location</b> </label>
                <select id="SelDes" class="form-select"></select><!-- Destination -->

                <!--button that when selected unhides another stop select box -->
                <button id="AddStop" type="button"><b>Add Another Stop</b></button>
                <button id="RemoveStop" type="button"><b>Remove Last Added Stop</b></button>

            </div>
        </div>
        <br />

        <div id="viewDiv" style="height: 700px; width: 100%;"></div>


        <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true"></asp:ScriptManager>

    </form>

    <script src="./js/Buttons.js"></script>

</body>

</html>

<footer>
    <div class="container">
        &copy; <%= DateTime.Now.Year %> - HeriTours
    </div>
</footer>
