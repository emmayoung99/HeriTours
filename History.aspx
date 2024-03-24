<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="HeriTours_4._0.History" %>
<!DOCTYPE html>

<!--
Version     Date            Coder       Comments
1.0.0       2024-03-15      EYOUNG      Initial, having issues formatting images, would live to add an associated image to each text box.
1.0.1       2024-03-16      EYOUNG      Attempted migration to ASPX.
1.0.2       2024-03-21      EYOUNG      Completed migration to ASPX.
1.0.3       2024-03-22      TBaxter     Changed body ID to match Index and show background image

*NOTE: NEED TO FIGURE OUT WHY TEXT IS BEING CUT OFF IN THE TEXT BOXES POST-MIGRATION*

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome to HeriTours</title>
    <meta charset="utf-8" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
    <link href="./css/GeneralStyle.css" rel="stylesheet" />
    <link href="./css/History.css" rel="stylesheet" />
</head>

<body id="bodyI">

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

    <div class="text-center">
        <h1 class="display-4"><b>History of the City</b></h1>
        <!-- Display a message indicating that the page is under construction and show the timestamp -->
        <p>This page is under construction as of <%= Page.Items["TimeStamp"] %>.</p>
    </div>

    <!-- Land acknowledgment -->
    <div class="left-hst-text">
        <h2>Land Acknowledgment</h2>
        <p>
            The lands upon which the City of Hamilton now stands have long been inhabited by Indigenous peoples...
        </p>
    </div>

    <div class="right-hst-text">
        <h2>Before Hamilton</h2>
        <p>
            Hamilton, Ontario, bears a significant historical connection to the Indigenous peoples...
        </p>
    </div>

    <div class="left-hst-text">
        <h2>The Founding of the City</h2>
        <!--Included a counter for the number of years passed since the founding of the city-->
        <p>
            In the early 19th century, the foundations of modern Hamilton were laid by British loyalist and politician George Hamilton. 
            Acquiring the land <strong><%= YearsAgo %> years ago</strong> in the area in 1815, Hamilton's vision and entrepreneurial spirit set the stage for the town's development...
        </p>
    </div>

    <div class="right-hst-text">
        <h2>Hamilton's Renaissance: Reinventing a Rust Belt Legacy</h2>
        <p>
            Building upon its storied past, Hamilton, Ontario, has continued to evolve into a thriving metropolis...
        </p>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="./js/GoogleMap.js"></script>
</body>
</html>
