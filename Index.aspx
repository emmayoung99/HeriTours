<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="HeriTours_4._0.Index" %>

<!DOCTYPE html>

<!--Version     Date            Coder      Comments
    1.0.1       2024-02-01      TBaxter    Initial. Added bootstrap, InfoCard, map html and CSS links just to get it to show up
    1.0.2       2024-02-02      TBaxter    added nav bar with the intention to move all html related files into a ASP.NET file
    1.1.0       2024-02-08      TBaxter    moved to asp.core (ASP.NET Web App (.NET Framework) wasn't an option
    1.1.1       2024-02-17      TBaxter    fixed .js and .css links
    1.2.0       2024-02-19      TBaxter    added timestamp, image, button that also links to page2
    1.2.1       2024-03-08      EYOUNG     Modified structure and added more comments
    1.3.0       2024-03-13      HMusni     Migrated from cshtml to aspx solution. Updated href links to new web pages and css stylesheets.
    1.3.1       2021-03-30      EYOUNG     Button now jumps to MapPage as we have decided to abandon ChooseLoc, StartLoc and the Selection as this will all be done directly on MapPage
    1.4.3       2024-03-31      EYOUNG     Added footer, needs to be modified a it won't stick to bottom of the view. Added logo to the navbar.
-->



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Explore Historic Hamilton</title>
    <!-- Set the character set for the document -->
    <meta charset="utf-8">
    <!--<meta name="viewport" content="width=device-width, initial-scale=1">-->
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Map CSS -->
    <link href="./css/MapStyle.css" rel="stylesheet">
    <!-- Polyfill for Map -->
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <link href="./css/GeneralStyle.css" rel="stylesheet">
</head>


<body id="bodyI">

    <form id="form1" runat="server">

        <%--      I AM NOT SURE HOW THIS IS SUPPOSED TO WORK, I WILL COMMENT OUT FOR NOW AN INSERT NAVBAR DIRECTLY INLINE********************    
    <!-- Include the navbar header -->
        <uc1:NavBar runat="server" ID="NavBar" />--%>


        <header>
            <nav class="navbar navbar-expand-sm navbar-light bg-orange border-bottom box-shadow mb-3">
                <div class="container">
                    <a class="navbar-brand" asp-area="" asp-page="/Index"> 
                        <!-- The navbar-logo class in GeneralStyle css isn't affecting logo, needs to be correct but working inline for now -->
                        <img src="/css/img/logo.png" alt="Logo" height="70px" class="navbar-logo">
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
                                <a class="nav-link text-dark" href="StartLoc.aspx">Start</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="Selection.aspx">Selection</a>
                            </li>--%>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="MapPage.aspx">Start Your Tour</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>



        <div class="text-center bg-beige">
            <!-- Display a heading with a large font and bold text -->
            <h1 class="display-4"><b>Explore Historic Hamilton</b></h1>
            <!-- Display a message indicating that the page is under construction and show the timestamp -->
            <p>This page is under construction as of <%= Page.Items["TimeStamp"] %>.</p>
        </div>

        <div>
            <!-- Creates button1 which links to the MapPage page-->
            <a class="button1" href="MapPage.aspx"><b>Create Your Tour</b></a>
        </div>

    </form>

</body>

</html>

<footer>
    <div class="footer">
        &copy; <%= DateTime.Now.Year %> - HeriTours - <a href="/Privacy.aspx">Privacy</a>
    </div>
</footer>


