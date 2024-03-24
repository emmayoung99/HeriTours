/*
    Version     Date            Coder       Comments
    1.0.0       2024-03-05      EYOUNG      Initial, using for user selection box
    1.0.1       2024-03-08      HMUSNI      Started adding in accordion selection for bike and transit routes
    1.1.0       2024-03-16      HMusni      Migrated from cshtml to aspx.
*/

//(document).ready(function ()
function ready(document){
    // Makes an array to store user selections for each step, all 3 show up after user selects anything
    var userSelections = ['', '', ''];

    ('.list-group-item').on('click', function () {
        // Determine the step based on the parent accordion item
        var step = (this).closest('.accordion-item').index();

        // Updates the userSelections array with the user's selection for the corresponding step
        userSelections[step] = $(this).text();

        // Display user selections below the accordion
        displayUserSelections();
    });

    // Clickers for accordion selection ------------------------------------------------
    // create functions associated with each accordion selection to generate output on the map. 
    // Need to migrate selection functionalities from one page to another.
    ('#Transit').on('click', function () {
        const transitLayer = new google.maps.TransitLayer();
        transitLayer.setMap(map);
    });

    ('#Bike').on('click', function () {
        const bikeLayer = new google.maps.BicyclingLayer();
        bikeLayer.setMap(map);
    });


    // Function to display user selections
    function displayUserSelections() {
        // Clear users previous selections
        ('#userSelectionBox').empty();

        // Display user selections for each step
        for (var i = 0; i < userSelections.length; i++) {
            ('#userSelectionBox').append('<p><strong>Step ' + (i + 1) + ':</strong> ' + userSelections[i] + '</p>');
        }
    }
};