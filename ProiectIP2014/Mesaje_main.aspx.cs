using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;

public partial class Mesaje1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //asd.InnerText = "ASDASDASD";
        //asd.InnerText = getKeyFromUsername("daniela_ong");
        if (!Page.IsPostBack)
            if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                string userk = Membership.GetUser().ProviderUserKey.ToString();
                SqlDataSource ds2 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceNeCitite");
                SqlDataSource ds4 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceCitite");
                //ds2.SelectCommand = "SELECT aspnet_Users.UserName as UserN, COUNT(*) AS nrC FROM aspnet_Users INNER JOIN Conversatii ON aspnet_Users.UserId = Conversatii.cod_receiver and Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' GROUP BY aspnet_Users.UserName;";
                //ds2.SelectCommand = "SELECT aspnet_Users.UserName as UserN, count(*) AS nrC, Min(Conversatii.citit) as citit FROM aspnet_Users	INNER JOIN Conversatii ON (aspnet_Users.UserId = Conversatii.cod_receiver OR aspnet_Users.UserId = Conversatii.cod_sender) and (Conversatii.cod_sender <> Conversatii.cod_receiver) and (Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' OR Conversatii.cod_receiver = '" + Membership.GetUser().ProviderUserKey.ToString() + "') GROUP BY aspnet_Users.UserName HAVING Min(Conversatii.citit) = 0";
                ds2.SelectCommand = "select (select UserName from aspnet_Users where UserId = (case cod_sender when '" + userk + "' then cod_receiver else cod_sender end) ) as userN, count(case citit when 0 then 1 else null end) as nrC, count(*) as nrC2 from Conversatii where (cod_sender = '" + userk + "' and cod_receiver <> cod_sender) or (cod_receiver = '" + userk + "' and cod_sender <> cod_receiver) group by (case cod_sender when '" + userk + "' then cod_receiver else cod_sender end) having min(citit) = 0";
                //ds2.SelectParameters["" + userk + ""].DefaultValue = userk;
                //ds4.SelectCommand = "SELECT aspnet_Users.UserName as UserN, count(*) AS nrC, Min(Conversatii.citit) as citit FROM aspnet_Users	INNER JOIN Conversatii ON (aspnet_Users.UserId = Conversatii.cod_receiver OR aspnet_Users.UserId = Conversatii.cod_sender) and (Conversatii.cod_sender <> Conversatii.cod_receiver) and (Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' OR Conversatii.cod_receiver = '" + Membership.GetUser().ProviderUserKey.ToString() + "') GROUP BY aspnet_Users.UserName HAVING Min(Conversatii.citit) = 1";
                ds4.SelectCommand = "select (select UserName from aspnet_Users where UserId = (case cod_sender when '" + userk + "' then cod_receiver else cod_sender end) ) as userN, count(case citit when 1 then 1 else null end) as nrC, count(*) as nrC2 from Conversatii where (cod_sender = '" + userk + "' and cod_receiver <> cod_sender) or (cod_receiver = '" + userk + "' and cod_sender <> cod_receiver) group by (case cod_sender when '" + userk + "' then cod_receiver else cod_sender end) having min(citit) = 1";
                //ds4.SelectParameters["@userkey"].DefaultValue = Membership.GetUser().ProviderUserKey.ToString();
            }
    }

    protected string getUsernameFromKey(string key)
    {
        string nume_user = "";
        //try
        //{
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            SqlCommand command = new SqlCommand("select UserName from aspnet_users where ApplicationId = '0657f582-1791-422d-872a-5a7ae8663066' and UserId = '@key'", connection);
            command.Parameters.AddWithValue("@key", key);
            SqlDataReader dr = command.ExecuteReader();

            if (dr.Read())
            {
                nume_user = dr[0].ToString();
                //raspuns_user.Text = "userul exista: " + cod_user2;
            }
            dr.Close();
            connection.Close();
        //}
        //catch (NullReferenceException ex)
        //{
        //    //raspuns_user.Text = ex.Message;
        //}
        return nume_user;
    }

    protected string getKeyFromUsername(string username)
    {
        string cod_user = "";
        try
        {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            SqlCommand command = new SqlCommand("select UserId from aspnet_Users where ApplicationId = '0657f582-1791-422d-872a-5a7ae8663066' and LoweredUserName = lower(@usern)", connection);
            command.Parameters.AddWithValue("@usern", username);
            SqlDataReader dr = command.ExecuteReader();

            asd.InnerText = "read yet?";
            if (dr.Read())
            {
                cod_user = dr[0].ToString();
                //asd.InnerText = "raspuns sql: " + cod_user;
            }
            dr.Close();
            connection.Close();
        }
        catch (NullReferenceException ex)
        {
            //asd.InnerText = ex.Message;
        }
        return cod_user;
    }
}