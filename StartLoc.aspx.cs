using System;
using System.Globalization;

/*
Version     Date            Coder       Comments
1.0.0       2024-03-21      EYOUNG      Initial migration to ASPX, rewrote time stamp.

 */

namespace HeriToursSprint2.Pages
{
    public partial class StartLoc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Creates the time stamp
            string dateTime = DateTime.Now.ToString("d", new CultureInfo("en-US"));
            Page.Items["TimeStamp"] = dateTime; 
        }
    }
}