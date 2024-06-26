﻿using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


/*
Version     Date            Coder       Comments
1.0.0       2024-03-16      HMusni      Initial. Added a ViewModel class
1.0.1       2024-03-21      EYOUNG      Rewrote the time stamp for ASPX

 */
namespace HeriTours_4._0
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Creates the time stamp
            string dateTime = DateTime.Now.ToString("d", new CultureInfo("en-US"));
            Page.Items["TimeStamp"] = dateTime;
        }
    }
}