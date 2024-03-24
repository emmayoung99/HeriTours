<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Selection.aspx.cs" Inherits="HeriTours_4._0.Selection" %>

<!DOCTYPE html>

<!--
Version     Date            Coder       Comments
1.0.0       2024-03-01      EYOUNG      Initial, created this seperate selection page and removed options from Page2
1.0.1       2024-03-02      TBaxter     Fixed timestamp
1.2.0       2024-03-05      EYOUNG      Created a user selection box to display the current selection before the user creates route
1.2.1       2024-03-05      HMusni      Added ids for accordion selection of 'Bike' and 'Transit'
1.2.2       2024-03-08      EYOUNG      Added additional comments
1.3.0       2024-03-12      HMusni      Migrated from cshtml to aspx solution
1.3.1       2024-03-13      HMusni      Reset href links and relative paths for js and css
1.3.2       2024-03-14      HMusni      Added onClick functions for each heritage site type
1.3.3       2024-03-22      TBaxter     Added js for bootstrap accordian

Ainslee's Notes: functions need to be added to the accordian to save the user selections, and also interact with the GoogleMap.js
-->

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Your Route</title>
    <!-- Set the character set for the document -->
    <meta charset="utf-8">
    <!-- Include Bootstrap CSS from a CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Include additional CSS for Map -->
    <link href="./css/GeneralStyle.css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">

        <div class="text-center">
            <!-- Large Heading -->
            <h1 class="display-4"><b>Create Your Tour</b></h1>

            <!-- Display a message indicating that the page is under construction and show the timestamp -->
            <p>This page is under construction as of <%= Page.Items["TimeStamp"] %>.</p>
        </div>
        <div id="AccordionContainer">
            <!-- Each <a> in the accordian is a link, currently they are '#' which take you back to the top of the page,
         could turn into buttons that once clicked add to the route-->
            <div id="Accordian" data-bs-spy="scroll" data-bs-target="#navbar-example3" data-bs-offset="0" tabindex="0">
                <div id="accordionFlushExample" class="accordion accordion-flush">

                    <!-- Step 1: Pick the Number of Sites on your Tour -------------------------------------------------->
                    <div id="item-1" class="accordion-item">
                        <h2 class="accordion-header" id="flush-headingOne">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                                <b>Step 1: Pick the Number of Sites on your Tour</b>
                            </button>
                        </h2>
                        <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                            <div id="item-1-1" class="accordion-body">
                                <div class="list-group">
                                    <a href="#" class="list-group-item list-group-item-action">1-3 sites</a>
                                    <a href="#" class="list-group-item list-group-item-action">4-10 sites</a>
                                    <a href="#" class="list-group-item list-group-item-action">11-15 sites</a><!-- Decided against unlimited-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Step 2: Pick the Type of Heritage Site ---------------------------------------------------------->
                    <div id="item-2" class="accordion-item">
                        <h2 class="accordion-header" id="flush-headingTwo">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                                <b>Step 2: Pick the Type of Heritage Site</b>
                            </button>
                        </h2>
                        <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
                            <div id="item-2-1" class="accordion-body">
                                <div class="list-group">
                                    <a href="#" onclick="GetResidences()" class="list-group-item list-group-item-action">Residences</a>
                                    <a href="#" onclick="GetFarms()" class="list-group-item list-group-item-action">Farms</a>
                                    <a href="#" onclick="GetSchools()" class="list-group-item list-group-item-action">Schools</a>
                                    <a href="#" onclick="GetChurches()" class="list-group-item list-group-item-action">Churches</a>
                                    <a href="#" onclick="GetAntiqueShops()" class="list-group-item list-group-item-action">Antique Shops</a>
                                    <a href="#" onclick="GetTheatres()" class="list-group-item list-group-item-action">Theatres</a>
                                    <a href="#" onclick="GetParks()" class="list-group-item list-group-item-action">Parks and Gardens</a>
                                    <a href="#" onclick="GetCemetery()" class="list-group-item list-group-item-action">Cemetery and Funeral Homes</a>
                                    <a href="#" onclick="GetHospitals()" class="list-group-item list-group-item-action">Hospitals</a>
                                    <a href="#" onclick="GetMuseums()" class="list-group-item list-group-item-action">Museums</a>
                                    <a href="#" onclick="GetOther()" class="list-group-item list-group-item-action">Other</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Step 3: Pick Your Mode of Transportation ---------------------------------------------------------->
                    <div id="item-3" class="accordion-item">
                        <h2 class="accordion-header" id="flush-headingThree">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
                                <b>Step 3: Pick Your Mode of Transportation</b>
                            </button>
                        </h2>
                        <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
                            <div id="item-3-1" class="accordion-body">
                                <div class="list-group">
                                    <a href="#" class="list-group-item list-group-item-action" id="Car">Car - change the colour via css hover</a>
                                    <a href="#" class="list-group-item list-group-item-action" id="Transit">Public Transit</a>
                                    <a href="#" class="list-group-item list-group-item-action" id="Bike">Bike</a>
                                    <a href="#" class="list-group-item list-group-item-action" id="Walking">Walking</a>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="SelectionContainer" class="text-center">
            <div>
                <!-- Creates "button2" which links to "Page2" -->
                <a class="button2" href="MapPage.aspx" id="GetRoute" runat="server"><b>Click to Get Tour Route</b></a>
                <!-- Lists the users selections for steps 1, 2 and 3 -->
                <div id="userSelectionBoxContainer">
                    <b>Current Selection:</b>
                    <hr />
                    <div id="userSelectionBox"></div>
                </div>
            </div>
            <br />
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <!-- Include necessary scripts -->
        <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="./js/SelectionFunctions.js"></script>
        <!--Bootstrap js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    </form>
</body>
</html>
