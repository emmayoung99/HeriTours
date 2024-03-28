﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Collections;
using System.Runtime.Remoting.Messaging;

/*Course: COMP 6036
Project Name: Project Heritours
Project Members: Ainslee, Emma, Hannah, Tori

Version     Date        Coder     Comments
1.0.0       2024-02-20  AGibbs    Initial.Try alternative database connection methods to write the model or write to file
                                    and uses lat long instead of coordinate
1.0.1       2024-02-22  AGibbs    Troubleshoot
1.0.2       2024-02-23  AGibbs    Troubleshoot
1.0.3       2024-03-06  HMusni    Added a strng query to the GetMarkers function, created while loop for SQL data reader, writealllines function creates a txt file for all heritage site types
1.1.0       2024-03-07  TBaxter   changed absolute paths to relative
1.2.0       2024-03-12  HMusni    Migrated from cshtml to aspx solution
1.3.0       2024-03-12  HMusni    Modified the GetMarkers script to read directly from the database rather than creating txt files for each heritage site type
1.3.1       2024-03-20  HMusni    Added the method GetHeritageTypes to read from the database to generate a list of heritage types
1.3.3       2024-03-25  AGibbs    Added a connection to tbl_Community to get community polygons from sql

   
Notes: 
- All paths need to be switched to relative (can't be absolute) - Tori
-
*/

/* Logistical Notes
Connect to SQL, build 'TheModel'; not writing to file

*/
namespace DatabaseConn
{
   

    public class DatabaseConn
    {

        private static List<String> TheModel = new List<String>();

        
        //Creates a file of markers for each heritage type
        public List<String> GetMarkers(String heritageType)
        {
            string query = "Select HeritageSitesID, Latitude, Longitude, HeritageSite From tbl_HeritageSites HS Join tbl_HeritageSite_Type HST On HS.HeritageSitesID = HST.HeritageSite_Type_Ref Where HST.Heritage_Type_Ref=(Select Heritage_TypeID From tbl_Heritage_Type Where Heritage_Type='" + heritageType + "')";
            List<String> Markers = new List<string>();
            SqlConnection conn = new SqlConnection();
            //conn.ConnectionString = @"Server=LAPTOP-277KOPL1;Database=DB_HeriTours;Trusted_Connection=Yes;";
            conn.ConnectionString = @"Server=TORI_BAXTER;Database=DB_HeriTours;Trusted_Connection=Yes";

            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                int i = 0;

                while (reader.Read())
                {
                    i++;

                    Markers.Add(reader["HeritageSitesID"].ToString() + "|" + reader["Latitude"].ToString() + "|" + reader["Longitude"].ToString() + "|" + reader["HeritageSite"].ToString() + "|" + heritageType);




                    //Markers.Add(@"var marker" + i.ToString() + @" = new google.maps.Marker({
                    //position: new google.maps.LatLng(" + reader["Latitude"].ToString() + ", " +
                    //reader["Longitude"].ToString() + ")," +
                    //@"map: map,
                    //title: " + "\"" + reader["HeritageSite"].ToString() + "\"" + "}); " +
                    //"marker" + i.ToString() + ".setMap(map);");
                    //Markers.Add(reader["Latitude"].ToString() + "," + reader["Longitude"].ToString() +"," + reader["HeritageSite"].ToString());
                }
                conn.Close();
                return Markers;
                //File.WriteAllLines(@"./wwwroot/Assets/HeritageMarkers" + heritageType + ".txt", Markers);
            }
        }


        public List<String> GetHeritageTypes()
        {
            List<String> HeritageTypes = new List<String>();
            SqlConnection conn = new SqlConnection();
            //conn.ConnectionString = @"Server=LAPTOP-277KOPL1;Database=DB_HeriTours;Trusted_Connection=Yes;";
            conn.ConnectionString = @"Server=TORI_BAXTER;Database=DB_HeriTours;Trusted_Connection=Yes";
            {
                SqlCommand cmd = new SqlCommand("SELECT Heritage_Type FROM tbl_Heritage_Type", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    HeritageTypes.Add(reader["Heritage_Type"].ToString());
                }

                conn.Close();

                return HeritageTypes;
            }


        }

        public List<String> GetPolys()
        {
            string query = "Select CommunityID, Linestring From tbl_Community";
            List<String> Polys = new List<string>();
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = @"Server=AINSLEE;Database=DB_HeriTours;Trusted_Connection=Yes";

            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                int i = 0;

                while (reader.Read())
                {
                    i++;

                    Polys.Add(reader["CommunityID"].ToString() + "|" + reader["Community"].ToString() + "|" + reader["LinestringWKT"].ToString());


                }
                conn.Close();
                return Polys;
            }
        }

        public List<String> GetCommunityPolygons()
        {
            List<String> Community = new List<String>();
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = @"Server=AINSLEE;Database=DB_HeriTours;Trusted_Connection=Yes";
            {
                SqlCommand cmd = new SqlCommand("SELECT Community FROM tbl_Community", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Community.Add(reader["Community"].ToString());
                }

                conn.Close();

                return Community;
            }


        }


    }
}
