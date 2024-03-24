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
1.0.0       2024-03-16      HMusni      Initial. 
1.0.1       2024-03-21      EYOUNG      Rewrote the time stamp for ASPX

 */

namespace HeriTours_4._0
{
    public partial class Selection : System.Web.UI.Page
    { 


        List<String> ModelMarkers = new List<String>();

        protected void Page_Load(object sender, EventArgs e)
        {
            DatabaseConn.DatabaseConn D = new DatabaseConn.DatabaseConn();
            ModelMarkers = D.GetMarkers("Churches");

            // Creates the time stamp
            string dateTime = DateTime.Now.ToString("d", new CultureInfo("en-US"));
            Page.Items["TimeStamp"] = dateTime;
        }

    }
}