/*Course: COMP 6036
Project Name: Project Heritours
Project Members: Ainslee, Emma, Hannah, Tori

Version  Date        Coder      Comments
1.0.0    2024-01-22  TBaxter    Initial. Creation of classes Coordinate, Address, Property, Route.
1.0.1    2024-01-26  TBaxter    Changed encapsulations, added inheritences
1.0.2    2024-02-02  TBaxter    Added connection string and first attempt at loading SQL
                                added with intent to move to ASP.NET format
1.1.0    2024-02-08  TBaxter    moved to asp.core
1.1.1    2024-03-07  TBaxter    changed absolute paths to relative

*/

/* Logistical Notes
not yet fully connected to SQL,only added connection string and basic readfile code
turn sql into JSON?

*/

using System;

namespace HeriToursSprint2.Model
{
    public class Coordinate
    {
        protected Double Latitude { get; set; } //only things that can see it are things based off a coordinate
        protected Double Longitude { get; set; }
        public Coordinate()
        {
            Latitude = 0;
            Longitude = 0;
        }
        public Coordinate(Double latitude, Double longitude)
        {
            Latitude = latitude;
            Longitude = longitude;
        }
        //protected virtual Boolean Valid() //building a function that validates the coordinate
        //{
        //    return true;
        //}
    }
    public class Address : Coordinate
    {

        protected String Street1; //mandatory (can't be 0)
        protected String Street2;
        protected String StreetName; //mandatory

        public Address(int St1, int St2, String StName, Double Cord)
        {
            // I don't believe this actually allows this to be null, assigns empty values, added these to get rid of warnings as well (ey)
            Street1 = "";
            Street2 = ""; //allows null
            StreetName = "";
        }
        public string getStreet1Name()

        {
            return Street1 + StreetName;
        }
        public string GetStreet()
        {
            if (Street2 == "")
            {
                return Street1 + " " + StreetName;
            }
            return Street1 + " " + Street2 + " " + StreetName;
        }
        //street number MUST have a street name
        //    protected override bool Valid()
        //    {
        //        if (!base.Valid())
        //        {
        //            return false;
        //            //checking validity goes here
        //        }
        //        return true;
        //    }
        //}
    }

    public class Property : Address //all need to be private
    {//all public bc could be change/updated
        protected String Name; //mandatory
        protected String SiteType;
        protected String Status; //mandatory. //either 'Registered Non-Designated', 'Designated' or 'Inventoried'
        protected int HeritageDate; //some are blank (override to allow for blanks?)
        protected String Community; //some are blank (override?)
        protected Boolean Part4; //yes/no, or blank
        protected Boolean Part5;
        protected String ByLaw;
        public Property(int St1, int St2, string StName, double Cord) : base(St1, St2, StName, Cord)
        {
            // Added these empty variables to get rid of the warnings
            Name = "";
            SiteType = "";
            Status = "";
            Community = "";
            ByLaw = "";

        }
    }

    //public class Route
    //{
    //    public List<Coordinate> CoordinateList { get; set; } //remove bc property has coordinates aready 
    //                                                         //but if removed, ToSQL doesn't work
    //    public List<Property> PropertyList { get; set; }
    //    public Route()
    //    {
    //        //CoordinateList = new List<Coordinate>();
    //        PropertyList = new List<Property>();
    //        PropertyList.Add(new Property());
    //        PropertyList.Add(new Property()); //making sure there are at least 2 sites in the route
    //    }       
    //    public String ToSQLGEOGRAPHY()
    //    {
    //        String sql = "LINESTRING (";
    //        foreach (Coordinate C in CoordinateList)
    //        {
    //            sql = sql + $"{C.Longitude} {C.Latitude},";
    //        }
    //        //Now we remove the last comma.
    //        sql = sql.Remove(sql.Length - 1, 1);
    //        //and glue on the end
    //        sql = sql + ")";
    //        return sql;
    //    }
    //}

    internal class Program
    {
        private static String GetConnectionString()
        {
            //change the server to match yours so it will run
            //return @"Server=TORI_BAXTER;Database=DB_HeriTours;Trusted_Connection=Yes;";
            return @"Server=AINSLEE;Database=DB_HeriTours;Trusted_Connection=Yes;";
        }

        static void Main(string[] args)
        {
            //Having a bit more control over the output file name
            if (args.Length > 0) //if there is a command line provided, do the code
            {
                Console.WriteLine("Running Heritours");
                try
                {
                    //    Random Randotron = new Random();
                    //    DirectoryInfo dir = new DirectoryInfo("..\\..\\..\\..\\"); //move up and out of one folder from the current .exe
                    //    String absoluteDir = dir.FullName; //make the directory's full name a string
                    //    String LoadFile = "f\\f1\\filename.sql"; //change this
                    //    //String LoadFile = "f\\f1\\filename.sql"; //change this
                    //    String SaveFile = "Data\\csv\\HeriToursCoords.csv"; //change this
                    //    //String SaveFile = "f\\f1\\filename.sql"; //change this
                    //    String absoluteFile = absoluteDir + LoadFile;

                }
                //I have a catch block
                catch (NotImplementedException A)
                {
                    Console.WriteLine("Under development Error");
                    Console.WriteLine(A.Message);
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            else
            {
                Console.WriteLine("Please provide a valid FileName");
                Console.ReadLine();
            }
        }
    }
}
