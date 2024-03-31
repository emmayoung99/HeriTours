using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DatabaseConn;


/*
Version     Date            Coder       Comments
1.0.0       2024-03-16      HMusni      Initial.Added Page_Load and GetData models to retrieve and organize heritage type data.
1.2.0       2024-03-25      AGibbs      Added a function to get community polygons 
1.2.1       2024-03-31      TBaxter     Added timestamp
*/


namespace HeriTours_4._0
{
    public partial class MapPage : System.Web.UI.Page
    {
        private static List<String> ModelMarkers = new List<String>();
        private static List<String> ModelPolygons = new List<String>();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Creates the time stamp
            string dateTime = DateTime.Now.ToString("d", new CultureInfo("en-US"));
            Page.Items["TimeStamp"] = dateTime;
            DatabaseConn.DatabaseConn D = new DatabaseConn.DatabaseConn();
            List<String> HeritageTypes = new List<String>();

            //Get the list of heritage types
            HeritageTypes.AddRange(D.GetHeritageTypes());

            //HeritageSitesID, Latitude, Longitude, HeritageSite
            //For each type of heritage type add the list of that type to the full list
            foreach (String heritageType in HeritageTypes)
            {
                ModelMarkers.AddRange(D.GetMarkers(heritageType));
            }

            //ModelPolygons.AddRange(D.GetPolys());
            

        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static String[] GetData(String TheMessage)
        {
            List<String> ReturnList = new List<string>();

            foreach (String value in ModelMarkers.FindAll(n => n.Contains(TheMessage)))
            {
                ReturnList.Add(value);
            }

            return ReturnList.ToArray();
        }

        
        public static String[] GetPolygons(String TheMessage)
        {
            List<String> ModelPolys = new List<string>();

            foreach (String value in ModelPolygons.FindAll(n => n.Contains(TheMessage)))
            {
                ModelPolys.Add(value);
            }

            return ModelPolys.ToArray();
        }


    }
}