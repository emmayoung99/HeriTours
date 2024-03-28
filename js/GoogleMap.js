/*
Version     Date            Coder       Comments
1.0.0       2024-03-15      HMusni      Initial.Added onClick functions for heritage site accordion selections
1.1.0       2024-03-16      HMusni      Added onClick functions for each heritage type
1.1.2       2024-03-22      HMusni      Added an event listener in the Present Data for loop to create an infowindow when each marker is clicked
1.1.3       2024-03-22      HMusni      Added mobility layer functions. Set up a toggle to turn the bike, transit and traffic layers on and off.
1.1.4       2024-03-23      AGibbs      Fixed boroken map initialization, removed zoom from transportation buttons
*/

var map;
let infowindow2;
var MarkerArray = [];
var bikeLayer;
var bikeToggle;
var transitLayer;
var transitToggle;
var trafficLayer;
var trafficToggle;
var infowindow;
var contentString;

function initMap() {


    bikeLayer = new google.maps.BicyclingLayer();
    bikeToggle = false;

    transitLayer = new google.maps.TransitLayer();
    transitToggle = false;

    trafficLayer = new google.maps.TrafficLayer();
    trafficToggle = false;

    contentString = "Test Info Page";

    map = new google.maps.Map(document.getElementById('map'), {
        center: { lat: 43.246307400636745, lng: - 79.87203765102602 },
        zoom: 11
    });

    infowindow = new google.maps.InfoWindow({        
        content: contentString,
    });
    

}

function PresentData(TheData) {
    for (var i = 0; i < TheData.length; ++i) {
        let tempArray = TheData[i].split("|");

        var myLatlng = new google.maps.LatLng(parseFloat(tempArray[1]), parseFloat(tempArray[2]));

        var marker = new google.maps.Marker({
            position: myLatlng,
            title: tempArray[3]
        });

        google.maps.event.addListener(marker, 'click', function () {
            infowindow.setContent(contentString);
            infowindow.open(map, this);
        });

        marker.setMap(map);
        //MarkerArray.push(marker);
    }
}



function onSuccess(result) { PresentData(result); }
function onError(result) { alert("Error on Coordinate Entry"); }

function GetResidences() {

    let Message = "Residences";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetFarms() {

    let Message = "Farms";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetSchools() {

    let Message = "Schools";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetChurches() {

    let Message = "Churches";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetAntiqueShops() {

    let Message = "AntiqueShops";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetTheatres() {

    let Message = "Theatres";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetParks() {

    let Message = "ParksandGardens";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetCemetery() {

    let Message = "CemeteryandFuneralHomes";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetHospitals() {

    let Message = "Hospitals";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetMuseums() {

    let Message = "Museums";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetOther() {

    let Message = "Other";

    PageMethods.GetData(Message, onSuccess, onError);
}

function GetPolys() {

    let Message = "Community";

    PageMethods.GetData(Message, onSuccess, onError);

}

function getBikeLayer() {

    map.setCenter(new google.maps.LatLng(43.246307400636745, - 79.87203765102602));
    //map.setZoom(11);

    if (!bikeToggle) {

        bikeLayer.setMap(bikeLayer.getMap() ? null : map);
        transitLayer.setMap(null);
        trafficLayer.setMap(null);
        bikeToggle = true;
    }

    else {

        bikeLayer.setMap(null);
        transitLayer.setMap(null);
        trafficLayer.setMap(null);
        bikeToggle = false;
    }
}


function getTransitLayer() {

    map.setCenter(new google.maps.LatLng(43.246307400636745, - 79.87203765102602));
    //map.setZoom(11);

    if (!transitToggle) {

        transitLayer.setMap(transitLayer.getMap() ? null : map);
        bikeLayer.setMap(null);
        trafficLayer.setMap(null);
        transitToggle = true;
    }

    else {

        transitLayer.setMap(null);
        bikeLayer.setMap(null);
        trafficLayer.setMap(null);
        transitToggle = false;
    }
}

function getTrafficLayer() {

    map.setCenter(new google.maps.LatLng(43.246307400636745, - 79.87203765102602));
    //map.setZoom(11);

    if (!trafficToggle) {

        trafficLayer.setMap(trafficLayer.getMap() ? null : map);
        bikeLayer.setMap(null);
        transitLayer.setMap(null);
        trafficToggle = true;
    }

    else {

        trafficLayer.setMap(null);
        bikeLayer.setMap(null);
        transitLayer.setMap(null);
        trafficToggle = false;
    }
}


window.initmap = initMap;


