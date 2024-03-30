/*
Version     Date            Coder       Comments
1.0.0       2024-03-27      AGibbs      Initial. Converted from googleAPI to ArcGIS functions, add current location function, clear map function,
1.0.1       2024-03-28      TBaxter     Added Popup content
1.0.2       2024-03-29      AGibbs      Added scale bar and compass and frame constraint
2.0.0       2024-03-30      TBaxter     Added Route. removed click event and changed to combo box (so it would only use visible site coordinates)
                                        Editd ClearMap function to include combo boxes and route components, Added Current location to combo box
                                        Route currently only allows for single destination. 


*/


require(["esri/config", "esri/Map", "esri/views/MapView", "esri/Graphic", "esri/layers/GraphicsLayer", "esri/widgets/Locate", "esri/widgets/ScaleBar",
    "esri/widgets/Compass", "esri/layers/GeoJSONLayer", "esri/rest/route", "esri/rest/support/RouteParameters", "esri/rest/support/FeatureSet", "esri/layers/FeatureLayer"],
    function (esriConfig, Map, MapView, Graphic, GraphicsLayer, Locate, ScaleBar, Compass, GeoJSONLayer, route, RouteParameters, FeatureSet) {

        esriConfig.apiKey = "AAPK2814bdda61534a3aa9df296ba41b7c00KDJxD9KRkEhwMLrd-lIzZd5c_PoyiTb81_inphNdo5Q4XEQbluYCNr15smMhFbtD";

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
                //AddSelLoc(options.target.geometry.point, "Current Location"); //uses current location, but doesn't have the coordinates yet. 
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


        //needed for creating routes
        var pointz=[];
        var pointzpos = 0;

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
                let address = ('Address: ' + tempArray[4] + ' ' + tempArray[5] + ', ' + tempArray[6]);

                AddSelLoc(point, tempArray[3]);

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
        //allows for the current location to be an option in the route. 
            //currently doesnt quite work when used.
        function AddSelLoc(point, name) {
            select1 = document.getElementById("SelOrig");
            select2 = document.getElementById("SelDes");
            pointz[pointzpos] = point;
            var opt1 = document.createElement('option');
            opt1.value = pointzpos;
            opt1.innerHTML = name;//show name in box
            select1.appendChild(opt1);

            var opt2 = document.createElement('option');
            opt2.value = pointzpos;
            opt2.innerHTML = name;
            select2.appendChild(opt2);
            pointzpos += 1;//move to next element
        }


        //MAIN ROUTE CODE
        const routeUrl =
            "https://route-api.arcgis.com/arcgis/rest/services/World/Route/NAServer/Route_World";
       
        //populates combobox
        function changeRoute() {
            select1 = document.getElementById("SelOrig");
            select2 = document.getElementById("SelDes");
            mapmyroute(pointz[select1.value], pointz[select2.value]);

        }
        document.getElementById("SelOrig").addEventListener("change", changeRoute);
        document.getElementById("SelDes").addEventListener("change", changeRoute);

        //uses combo box to create a route of 2 locations
        function mapmyroute(orig, dest) {
            view.graphics.removeAll();
            addGraphic("origin", orig);
            addGraphic("destination", dest);
            getRoute();
        }

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

        }


        //GET HERITAGE SITE TYPES
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
            select1 = document.getElementById("SelOrig"); //needed?
            select2 = document.getElementById("SelDes");
            while (select1.options.length) select1.options.remove(0); //clears combo box
            while (select2.options.length) select2.options.remove(0);
            view.graphics.removeAll();//remove line
            view.ui.empty("top-right");//remove direction box
        }
        document.getElementById("Clear").addEventListener("click", ClearMap);

});