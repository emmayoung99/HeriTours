<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="HeriTours_4._0.History" %>

<!DOCTYPE html>

<!--
Version     Date            Coder       Comments
1.0.0       2024-03-15      EYOUNG      Initial, having issues formatting images, would live to add an associated image to each text box.
1.0.1       2024-03-16      EYOUNG      Attempted migration to ASPX.
1.0.2       2024-03-21      EYOUNG      Completed migration to ASPX.
1.0.3       2024-03-22      TBaxter     Changed body ID to match Index and show background image
1.1.0       2024-03-30      EYOUNG      Removed body ID as I will be adding images. Fixed text.
1.1.1       2024-03-31      EYOUNG      Corrected images during Clay's help session. Added footer. Added logo to the navbar.
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome to HeriTours</title>
    <meta charset="utf-8" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
    <link href="./css/GeneralStyle.css" rel="stylesheet" />
    <link href="./css/History.css" rel="stylesheet" />
</head>

<body>

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
                            <a class="nav-link text-dark" href="Index.aspx">Start</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="MapPage.aspx">Map</a>
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
    <div class="row">
        <div class="left-hst-text">
            <div class="content">
                <div class="column">
                    <div class="text">
                        <h2>Land Acknowledgment</h2>
                        <p>
                            The City of Hamilton is situated upon the traditional territories of the Erie, Neutral, Huron-Wendat, Haudenosaunee and Mississaugas. This land is covered by the Dish With One Spoon Wampum Belt Covenant, which was an agreement between the Haudenosaunee and Anishinaabek to share and care for the resources around the Great Lakes. We further acknowledge that this land is covered by the Between the Lakes Purchase, 1792, between the Crown and the Mississaugas of the Credit First Nation.<br />
                            Today, the City of Hamilton is home to many Indigenous people from across Turtle Island (North America) and we recognize that we must do more to learn about the rich history of this land so that we can better understand our roles as residents, neighbours, partners, and caretakers. To see an interactive map of the historical indigenous territories of this region, click <a href="https://native-land.ca/" target="_blank">here</a>.
                        </p>
                    </div>
                </div>
                <div class="column">
                    <!-- Image source: https://canadiangeographic.ca/articles/laws-braided-into-belts-three-haudenosaunee-wampum-belts-you-should-know/ -->
                    <div class="image">
                        <img src="/css/img/treatybelt.png" alt="Man holds glass replica of the belt of the treaty of the Dish With One Spoon">
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="row">
        <div class="right-hst-text">

            <div class="content">
                <div class="column">
                    <!-- Source: https://www.istockphoto.com/photo/tiffany-waterfall-gm1330292976-413753259?searchscope=image%2Cfilm -->
                    <div class="image">
                        <img src="/css/img/Waterfall.png" alt="Image of a Hamilton waterfall.">
                    </div>
                </div>
                <div class="column">
                    <div class="text">
                        <h2>Before Hamilton</h2>
                        <p>
                            Hamilton, Ontario, bears a significant historical connection to the Indigenous peoples who inhabited the region long before European settlement. Initially settled by the Neutral Nation approximately 650 years ago, the area witnessed the flourishing of Indigenous cultures engaged in trade and resource management. 
            However, the decline of the Neutral Nation, compounded by conflicts with other Indigenous groups and the arrival of European diseases, marked a tragic chapter in Hamilton's early history. 
            Despite their eventual displacement, the legacy of Indigenous stewardship endures as an integral part of Hamilton's identity.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="left-hst-text">
            <div class="content">
                <div class="column">
                    <h2>The Founding of the City</h2>
                    <!--Included a counter for the number of years passed since the founding of the city-->
                    <p>
                        In the early 19th century, the foundations of modern Hamilton were laid by British loyalist and politician George Hamilton and Nathaniel Hughson.                
                            Acquiring the land <strong><%= YearsAgo %> years ago</strong> in the area in 1815, Hamilton's vision and entrepreneurial spirit set the stage for the town's development. 
                            An interesting fact about the establishment of the city, is how it was actually first known as "Head-of-the-Lake" until being renamed in 1816.
                            Collaborating with Hughson and implementing urban planning initiatives, Hamilton transformed the landscape, leading to the emergence of a vibrant urban center. 
                            With strategic infrastructure investments such as canals and railways, Hamilton's growth surged, cementing its status as a key industrial hub in Upper Canada.
                    </p>
                </div>
                <div class="column">
                    <!-- Source: https://en.wikipedia.org/wiki/George_Hamilton_(city_founder) -->
                    <div class="image">
                        <img src="/css/img/Tombstone.jpg" alt="The tombstone of George Hamilton. There are no known portraits of him.">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="right-hst-text">
            <div class="content">
                <div class="column">
                    <h2>Hamilton's Renaissance: Reinventing a Rust Belt Legacy</h2>
                
                
                    <p>
                        Building upon its storied past, Hamilton, Ontario, has continued to evolve into a thriving metropolis embracing progress and innovation. From its humble beginnings as a trading post to its pivotal role in Canada's industrial revolution, Hamilton has adapted to changing economic landscapes while preserving its cultural heritage. Overcoming the challenges of being a rust belt city, Hamilton has diversified its economy, transitioning from heavy reliance on manufacturing to embracing new industries and technologies. Through strategic investments and forward-thinking initiatives, the city has revitalized its urban core, fostering a vibrant arts and cultural scene, and attracting new businesses and entrepreneurs. Today, Hamilton stands as a testament to resilience and reinvention, embodying the spirit of transformation and opportunity. As the city continues to chart its course forward, it remains committed to building a prosperous and inclusive future for all its residents.
                    </p>
                </div>
                <div class="column"
                    
               <!-- Source: https://www.istockphoto.com/photo/hamilton-ontario-james-street-looking-north-gm1219410534-356685302?searchscope=image%2Cfilm -->
                <div class="image">
                    <img src="/css/img/street.png" alt="A photo of the streets of downtown Hamilton.">
                </div>
            </div>
        </div>
        </div>

        <br /><br />

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <%--<script src="./js/GoogleMap.js"></script>--%>
</body>

</html>

<footer >
    <div class="container">
        &copy; <%= DateTime.Now.Year %> - HeriTours - <a href="/Privacy.aspx">Privacy</a>
    </div>
</footer>
