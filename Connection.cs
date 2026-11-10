using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TasteBiteRestaurant
{
    public class Connection
    {
        public SqlConnection con;
        public string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        public void connection()
        {
            con = new SqlConnection(s);
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
        }

        public SqlConnection getcon()
        {
            connection();
            return con;
        }

        public DataTable getdata(string sql)
        {
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(sql, getcon());
            da.Fill(dt);
            return dt;
        }

        public int setdata(string sql)
        {
            SqlCommand cmd = new SqlCommand(sql, getcon());
            return cmd.ExecuteNonQuery();
        }
    }
}
