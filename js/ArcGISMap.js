/*
Version     Date            Coder       Comments
1.0.0       2024-03-27      AGibbs      Initial. Converted from googleAPI to ArcGIS functions, add current location function, clear map function,
1.0.1       2024-03-28      TBaxter     Added Popup content
1.0.2       2024-03-29      AGibbs      Added scale bar and compass and frame constraint, bike, transit and buildings layers
1.0.3       2024-03-30      AGibbs      Styled feature layers and added a legend
1.0.2       2024-03-29      AGibbs      Added scale bar and compass and frame constraint
2.0.0       2024-03-30      TBaxter     Added Route. removed click event and changed to combo box (so it would only use visible site coordinates)
                                        Editd ClearMap function to include combo boxes and route components, Added Current location to combo box
                                        Route currently only allows for single destination. 


*/


require(["esri/config", "esri/Map", "esri/views/MapView", "esri/Graphic", "esri/layers/GraphicsLayer", "esri/widgets/Locate", "esri/widgets/ScaleBar",
    "esri/widgets/Compass", "esri/widgets/Legend", "esri/rest/route", "esri/rest/support/RouteParameters", "esri/rest/support/FeatureSet", "esri/layers/FeatureLayer"],
    function (esriConfig, Map, MapView, Graphic, GraphicsLayer, Locate, ScaleBar, Compass, Legend, route, RouteParameters, FeatureSet, FeatureLayer) {

        esriConfig.apiKey = "AAPK2814bdda61534a3aa9df296ba41b7c00KDJxD9KRkEhwMLrd-lIzZd5c_PoyiTb81_inphNdo5Q4XEQbluYCNr15smMhFbtD";

        /*add buildings*/
        //const buildingRender = {
        //    type: "simple-fill",
        //    color: "#9F1B04",            
        //    style: "solid",
        //    outline: {
        //        width: "0.5px",
        //        color: "#6D0D4D"
        //    }

        //};

        const buildings = new FeatureLayer({          
            url: "https://services.arcgis.com/rYz782eMbySr2srL/arcgis/rest/services/Buildings/FeatureServer/8",
            title: "Buildings",
            /*renderer: buildingRender*/
        });


        
      /*  add trails and style them based on surface type*/
        const trailsRender = {
            type: "unique-value",
            field: "SURFACE",
            defaultSymbol: {
                color: "#0D6D4A",
                type: "simple-line",
                style: "dot",
                width: "1px"
            },
            uniqueValueInfos: [{
                value: "Asphalt",
                symbol: {
                    color: "#0D6D4A",
                    type: "simple-line",
                    style: "solid",
                    width: "1px"
                }
            }]
        };

        
        const trails = new FeatureLayer({           
            url: "https://services.arcgis.com/rYz782eMbySr2srL/arcgis/rest/services/Trails/FeatureServer/14",
            renderer: trailsRender,
            
        });

        /*make each transit line a unique colour?*/
        //const transitRoutesColor = {};
        //const colors = ["#422D53", "#3A305A", "#323562", "#354769", "#385D71", "#3A7578", "#3C806F", "#3F8860", "#41904D", "#509843", "#6EA145", "#90A947", "#B1AC48", "#B8924C", "#BC7752", "#C05E59", "#C45F76", "#C8659A", "#CB6CBB", "#C372CF", "#AC79D2", "#9780D6", "#878AD9", "#8EA8DC", "#0D6D4A", "#009E2F", "#06C200", "#54E600", "#B6FF0A", "#FFF82E", "#FFBF52", "#FF9F75", "#FF999B", "#FFBDD4"]
        //const transitRouteNumbers = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "16", "18", "20", "21", "22", "23", "24", "25", "26", "27", "33", "34", "35", "41", "42", "43", "44", "51", "52", "55", "56","99"]

        //transitRouteNumbers.forEach((line, index) => {
        //    transitRoutesColor[line] = colors[index % colors.length];
        //});

        //const transitRenderer = {
        //    type: "unique-value",
        //    field: "ROUTE_NUMBER",
        //    uniqueValueInfos: transitRouteNumbers.map(line => ({
        //        value: line,
        //        symbol: {
        //            type: "simple-line",
        //            color: transitRoutesColor[line],
        //            width: "2px"
        //        }
        //    }))
        //};

        const transitRender = {
            type: "simple",
            symbol: {
                color: "#75A1FF",
                type: "simple-line",
                style: "solid",
                width: "2px",
            },
        }

      /*  label bus routes */
        const transitLabels = {
            symbol: {
                type: "text",
                color: "#FFFFFF",
                haloColor: "#5E8D74",
                haloSize: "2px",
                font: {
                    size: "12px",
                    family: "Noto Sans",
                    style: "italic",
                    weight: "normal"
                }
            },

            labelPlacement: "above-center",
            labelExpressionInfo: {
                expression: "$feature.ROUTE_NAME"
            }
        };

        const transit = new FeatureLayer({           
            url: "https://services.arcgis.com/rYz782eMbySr2srL/arcgis/rest/services/HSR_Bus_Routes/FeatureServer/1",
            renderer: transitRender,
            labelinginfo: [transitLabels],
        });


        const bikeRender = {
            type: "simple",
            symbol: {
                color: "#FF99F0",
                type: "simple-line",
                style: "short-dash",
                width: "1px",
            },
        }

        const bike = new FeatureLayer({
            /*url: "https://services.arcgis.com/rYz782eMbySr2srL/arcgis/rest/services/Bikeways/FeatureServer/7/query?where=1%3D1&outFields=*&outSR=4326&f=json",*/
            url: "https://services.arcgis.com/rYz782eMbySr2srL/arcgis/rest/services/Bikeways/FeatureServer/7",
            renderer: bikeRender,
        });
        

        const map = new Map({
            basemap: "arcgis/streets-relief",
            layers: [transit, bike, buildings, trails],
        });

        const view = new MapView({
            map: map,
            center: [-79.87203765102602, 43.246307400636745],
            zoom: 12,
            container: "viewDiv", 
            constraints: {
                snaptozoom: false,
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

        /*add Legend to map*/
        let legend = new Legend({
            view: view,        
                        
        });

        view.ui.add(legend, "bottom-left");



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
                    color: [142, 94, 245, 0.75],  //Purple
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