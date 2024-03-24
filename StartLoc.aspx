<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StartLoc.aspx.cs" Inherits="HeriToursSprint2.Pages.StartLoc" %>
<%@ Import Namespace="HeriToursSprint2.Pages" %>
<!DOCTYPE html>

<!--
Version     Date            Coder       Comments
1.0.0       2024-03-05      EYOUNG      Initial, created this seperate starting point, timestamp
1.0.1       2024-03-08      EYOUNG      Modified structure and added more comments
2.0.0       2024-03-21      EYOUNG      Migrated from ASPX, made necessary syntax changes
-->

<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Choose Starting Location Page</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
    <!-- Include polyfill for Map -->
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <!-- Include custom CSS for the page -->
    <link href="./css/GeneralStyle.css" rel="stylesheet">
</head>
<body id="bodyI">
    <form id="form1" runat="server">
        <!-- Container for the main content, centered text -->
        <div class="text-center">
            <!-- Large Heading -->
            <h1 class="display-4"><b>Create Your Tour</b></h1>
            <!-- Subheading -->
            <h2> Where Would You Like To Start Your Tour?</h2>
            <!-- Display a message indicating that the page is under construction and show the timestamp -->
            <p>This page is under construction as of <%= Page.Items["TimeStamp"] %>.</p>

        </div>
        <!-- Line breaks for spacing -->
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />

        <!-- Container for location options -->
        <div class="text-center">
            <!-- Button to use user's current location and redirect to the selection page -->
            <!-- This button eventually needs to take the devices current location and save it as the first point for the route-->
            <a class="button3" href="Selection.aspx"><b>Use My Location</b></a>
            <!-- Button to allow the user to choose a starting point and redirect to the selection page -->
            <a class="button3" href="ChooseLoc.aspx"><b>Choose Starting Point</b></a>
        </div>
    </form>

    <script src="./js/GoogleMap.js"></script> 
</body>
</html>
