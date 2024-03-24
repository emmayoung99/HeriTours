using System;
using System.Globalization;
using System.Web.UI;

namespace HeriTours_4._0
{
    public partial class History : Page
    {
        protected int YearsAgo { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            SetTimeStamp();
            CalculateYearsAgo();
        }

        private void SetTimeStamp()
        {
            // Creates the time stamp
            string dateTime = DateTime.Now.ToString("d", new CultureInfo("en-US"));
            Page.Items["TimeStamp"] = dateTime;
        }

        private void CalculateYearsAgo()
        {
            int yearAcquired = 1815;
            int currentYear = DateTime.Now.Year;
            YearsAgo = currentYear - yearAcquired;
        }
    }
}
