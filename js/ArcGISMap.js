/*
Version     Date            Coder       Comments
1.0.0       2024-03-27      AGibbs      Initial. Converted from googleAPI to ArcGIS functions, add current location function, clear map function,
1.0.1       2024-03-28      TBaxter     Added Popup content
1.0.2       2024-03-29      AGibbs      Added scale bar and compass and frame constraint


*/


require(["esri/config", "esri/Map", "esri/views/MapView", "esri/Graphic", "esri/layers/GraphicsLayer", "esri/widgets/Locate", "esri/widgets/ScaleBar",
    "esri/widgets/Compass", "esri/layers/GeoJSONLayer", "esri/rest/route", "esri/rest/support/RouteParameters", "esri/rest/support/FeatureSet", "esri/layers/FeatureLayer"],
    function (esriConfig, Map, MapView, Graphic, GraphicsLayer, Locate, ScaleBar, Compass, GeoJSONLayer, route, RouteParameters, FeatureSet, FeatureLayer) {

        esriConfig.apiKey = "AAPKb9ba5b70acaf4564beb06aec117188cd9URpR3n5paDTjcdXIRS8mmifpBaPFoboHHsoscJskwOXRXBtJGQntMsKlnRjVBAb";

        const map = new Map({
            basemap: "arcgis/streets-relief"
        });

        const view = new MapView({
            map: map,
            center: [-79.87203765102602, 43.246307400636745],
            zoom: 11.5,
            container: "viewDiv", 
            constraints: {
                snaptozoom: false
            }
        });


        /*  constrain map view to Hamilton*/
        view.when(() => {
            view.constraints.minScale = view.scale;
            
        });

        /*add scalebar*/
        const scalebar = new ScaleBar({
            view: view
        });
        view.ui.add(scalebar, "bottom-right");

        /*add compass*/
        const compassWidget = new Compass({
            view: view
        });

        
        view.ui.add(compassWidget, "top-left");

        /*current location*/
        const locate = new Locate({
            view: view,
            useHeadingEnabled: false,
            goToOverride: function (view, options) {
                options.target.scale = 1500;
                return view.goTo(options.target);
            }
        });
        view.ui.add(locate, "top-left");

      

        const graphicsLayer = new GraphicsLayer();
        map.add(graphicsLayer);


        /*add points/markers*/
        function onSuccess(result) { PresentData(result); }
        function onError(result) { alert("Error on Coordinate Entry"); }



        function PresentData(TheData) {
            for (let i = 0; i < TheData.length; ++i) {
                let tempArray = TheData[i].split("|");

                let point = {
                    type: "point",
                    longitude: parseFloat(tempArray[2]),
                    latitude: parseFloat(tempArray[1])
                };

                let simpleMarkerSymbol = {
                    type: "simple-marker",
                    color: [142, 94, 245],  //Purple
                    outline: {
                        color: [255, 255, 255], // White
                        width: 1
                    }

                };

                //4=streetNo1, 5=StreetName, 6=Community, 
                let address = ('Address: ' + tempArray[4] + ' ' + tempArray[5] + ', ' + tempArray[6])

                let popupTemplate = {
                    title: tempArray[3],                   
                    content: address 
                };

                let pointGraphic = new Graphic({
                    geometry: point,
                    symbol: simpleMarkerSymbol,
                    popupTemplate: popupTemplate
                });
                graphicsLayer.add(pointGraphic);
            }

        }



        function GetResidences() {

            let Message = "Residences";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("Residences").addEventListener("click", GetResidences);


        function GetFarms() {

            let Message = "Farms";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("Farms").addEventListener("click", GetFarms);


        function GetSchools() {

            let Message = "Schools";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("Schools").addEventListener("click", GetSchools);


        function GetChurches() {

            let Message = "Churches";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("Churches").addEventListener("click", GetChurches);


        function GetAntiqueShops() {

            let Message = "AntiqueShops";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("AntiqueShops").addEventListener("click", GetAntiqueShops);


        function GetTheatres() {

            let Message = "Theatres";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("Theatres").addEventListener("click", GetTheatres);


        function GetParks() {

            let Message = "ParkandGardens";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("ParkandGardens").addEventListener("click", GetParks);


        function GetCemetery() {

            let Message = "CemeteryandFuneralHomes";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("CemeteryandFuneralHomes").addEventListener("click", GetCemetery);


        function GetHospitals() {

            let Message = "Hospitals";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("Hospitals").addEventListener("click", GetHospitals);


        function GetMuseums() {

            let Message = "Museums";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("Museums").addEventListener("click", GetMuseums);


        function GetOther() {

            let Message = "Other";

            PageMethods.GetData(Message, onSuccess, onError);
        }
        document.getElementById("Other").addEventListener("click", GetOther);

        function ClearMap() {
            graphicsLayer.removeAll();
        }
        document.getElementById("Clear").addEventListener("click", ClearMap);














        /* create your route???*/
        const routeUrl = "https://route-api.arcgis.com/arcgis/rest/services/World/Route/NAServer/Route_World";

        view.on("click", function (event) {

            if (view.graphics.length === 0) {
                addGraphic("origin", event.mapPoint);
                }
                else if (view.graphics.length === 1) {
                    addGraphic("destination", event.mapPoint);

                    getRoute(); // Call the route service

                 }
                    else {
                    view.graphics.removeAll();
                    addGraphic("origin", event.mapPoint);
                    }

        });

        function addGraphic(type, point) {
            const graphic = new Graphic({
                symbol: {
                    type: "simple-marker",
                    color: (type === "origin") ? "white" : "black",
                    size: "8px"
                },
                geometry: point
            });
            view.graphics.add(graphic);
        }

        function getRoute() {
            const routeParams = new RouteParameters({
                stops: new FeatureSet({
                    features: view.graphics.toArray()
                }),

                returnDirections: true

            });

            route.solve(routeUrl, routeParams)
                .then(function (data) {
                    data.routeResults.forEach(function (result) {
                        result.route.symbol = {
                            type: "simple-line",
                            color: [5, 150, 255],
                            width: 3
                        };
                        view.graphics.add(result.route);
                    });

                    // Display directions
                    if (data.routeResults.length > 0) {
                        const directions = document.createElement("ol");
                        directions.classList = "esri-widget esri-widget--panel esri-directions__scroller";
                        directions.style.marginTop = "0";
                        directions.style.padding = "15px 15px 15px 30px";
                        const features = data.routeResults[0].directions.features;

                        // Show each direction
                        features.forEach(function (result, i) {
                            const direction = document.createElement("li");
                            direction.innerHTML = result.attributes.text + " (" + result.attributes.length.toFixed(2) + " miles)";
                            directions.appendChild(direction);
                        });

                        view.ui.empty("top-right");
                        view.ui.add(directions, "top-right");

                    }

                })

                .catch(function (error) {
                    console.log(error);
                })

            /*define stops for route using a collection of stops*/


        }

});