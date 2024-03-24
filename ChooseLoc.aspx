<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChooseLoc.aspx.cs" Inherits="HeriTours_4._0.ChooseLoc" %>
<!DOCTYPE html>
<!--
Version     Date            Coder       Comments
1.0.0       2024-03-05      EYOUNG      Initial, created this separate starting point, timestamp
1.0.1       2024-03-08      EYOUNG      Modified structure and added more comments
1.0.2       2024-03-08      HMUSNI      Corrected the </body> tag
2.0.0       2024-03-21      EYOUNG      Migrated to ASPX
1.0.2       2024-03-22      TBaxter     Fixed css and js references, and button 2 link
-->

<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Location Selection Page</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
    <!-- Polyfill for Map -->
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <!-- Include Map CSS -->
    <link href="./css/MapStyle.css" rel="stylesheet" />
    <!-- Include General CSS -->
    <link href="./css/GeneralStyle.css" rel="stylesheet" />
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

        <div class="text-center">
            <!-- Display a heading with a large font and bold text -->
            <h1 class="display-4"><b>Create Your Tour</b></h1>
            <!-- Subheading indicating the purpose of the page -->
            <h2>Select Your Starting Location</h2>
            <!-- Display a message indicating that the page is under construction and show the timestamp -->
            <p>This page is under construction as of <%= Page.Items["TimeStamp"] %>.</p>
        </div>

        <!-- Container for the map -->
        <div id="map"></div>
      
        <br />

        <div>
            <!-- Creates button2 which links to Page2 -->
            <a class="button2" href="MapPage.aspx"><b>Choose This Location</b></a>
        </div>

        <br />
        <br />

    </form>

    <!-- JavaScript block for Google Maps API and additional libraries -->
 <%--   <script>
        (g => { var h, a, k, p = "The Google Maps JavaScript API", c = "google", l = "importLibrary", q = "__ib__", m = document, b = window; b = b[c] || (b[c] = {}); var d = b.maps || (b.maps = {}), r = new Set, e = new URLSearchParams, u = () => h || (h = new Promise(async (f, n) => { await (a = m.createElement("script")); e.set("libraries", [...r] + ""); for (k in g) e.set(k.replace(/[A-Z]/g, t => "_" + t[0].toLowerCase()), g[k]); e.set("callback", c + ".maps." + q); a.src = `https://maps.${c}apis.com/maps/api/js?` + e; d[q] = f; a.onerror = () => h = n(Error(p + " could not load.")); a.nonce = m.querySelector("script[nonce]")?.nonce || ""; m.head.append(a) })); d[l] ? console.warn(p + " only loads once. Ignoring:", g) : d[l] = (f, ...n) => r.add(f) && u().then(() => d[l](f, ...n)) })
            ({ key: "AIzaSyAZASdF_ujeH_f4eyDO0wBOurZHJzwMqk0", v: "weekly" });
    </script>--%>

     <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAX6haxPnf_GlOOJLMl4XX-_y9id7NBzh8&callback=initMap"
     async defer></script>

    <!-- Include necessary scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="./js/GoogleMap.js"></script> 
   <!-- <script src="./js/SelectionFunctions.js"></script> -->
</body>
</html>
