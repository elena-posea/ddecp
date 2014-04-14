using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;

public partial class Mesaje_caut : System.Web.UI.Page
{
    private static string user_send;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                user_send = Membership.GetUser().UserName.ToString();
                SqlDataSource ds2 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceNeCitite");
                SqlDataSource ds4 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceCitite");
                
                //ds2.SelectCommand = "SELECT aspnet_Users.UserName as UserN, COUNT(*) AS nrC FROM aspnet_Users INNER JOIN Conversatii ON aspnet_Users.UserId = Conversatii.cod_receiver and Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' GROUP BY aspnet_Users.UserName;";

                //lista conversatii cu msg necitite
                ds2.SelectCommand = "SELECT aspnet_Users.UserName as UserN, count(*) AS nrC, Min(Conversatii.citit) as citit FROM aspnet_Users	INNER JOIN Conversatii ON (aspnet_Users.UserId = Conversatii.cod_receiver OR aspnet_Users.UserId = Conversatii.cod_sender) and (Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' OR Conversatii.cod_receiver = '" + Membership.GetUser().ProviderUserKey.ToString() + "') GROUP BY aspnet_Users.UserName HAVING Min(Conversatii.citit) = 0";
                //lista conversatii vechi
                ds4.SelectCommand = "SELECT aspnet_Users.UserName as UserN, count(*) AS nrC, Min(Conversatii.citit) as citit FROM aspnet_Users	INNER JOIN Conversatii ON (aspnet_Users.UserId = Conversatii.cod_receiver OR aspnet_Users.UserId = Conversatii.cod_sender) and (Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' OR Conversatii.cod_receiver = '" + Membership.GetUser().ProviderUserKey.ToString() + "') GROUP BY aspnet_Users.UserName HAVING Min(Conversatii.citit) = 1";

                
            }

        SqlDataSource ds6 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceMesaje");
        if (Session["select_cmd"] != null && ds6.SelectCommand == "")
        {
            
            ds6.SelectCommand = Session["select_cmd"].ToString();
            //http://stackoverflow.com/questions/17582930/aspsqldatasource-selectcommand-property-does-not-persist-when-paging
            //not recommended: unsafe
        }
    }

    protected void Button1_Click(object sender = null, EventArgs e = null)
    {
        TextBox tb1 = (TextBox)LoginView2.FindControl("TextBox1");
        TextBox tb2 = (TextBox)LoginView2.FindControl("TextBox2");
        SqlDataSource ds6 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceMesaje");
        Literal raspuns_user = (Literal)LoginView2.FindControl("UserExista");

        if (tb1.Text == null || tb1.Text == "") //n-a introdus niciun user, caut toate mesajele userului curent ce contin tb2.text
        {
            ds6.SelectCommand = "SELECT DISTINCT Conversatii.mesaj, Conversatii.citit, Conversatii.data, (SELECT UserName FROM aspnet_Users WHERE (UserId = Conversatii.cod_sender)) AS senderN, (SELECT UserName FROM aspnet_Users AS aspnet_Users_2 WHERE (UserId = Conversatii.cod_receiver)) AS receiverN FROM Conversatii INNER JOIN aspnet_Users AS aspnet_Users_1 ON (Conversatii.cod_sender = aspnet_Users_1.UserId OR Conversatii.cod_receiver = aspnet_Users_1.UserId) and (Conversatii.cod_sender = '"+ Membership.GetUser().ProviderUserKey.ToString() +"' or Conversatii.cod_receiver = '"+ Membership.GetUser().ProviderUserKey.ToString() +"' ) where mesaj like '%"+ tb2.Text +"%' order by data desc";
        }
        else //a fost introdus un nume de utilizator
        {
            
            string nume_user2 = tb1.Text, cod_user2 = "";
            //caut codul userului 2
            try
            {
                SqlConnection connection = new SqlConnection();
                connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
                connection.Open();

                SqlCommand command = new SqlCommand("Select UserId from aspnet_Users where LoweredUserName = LOWER(@user2);", connection);
                command.Parameters.AddWithValue("user2", nume_user2);
                SqlDataReader dr = command.ExecuteReader();

                if (dr.Read())
                {
                    cod_user2 = dr[0].ToString();
                    //raspuns_user.Text = "userul exista: " + cod_user2;
                }
                dr.Close();
                connection.Close();
            }
            catch (NullReferenceException ex)
            {
                raspuns_user.Text = ex.Message;
            }

            if (cod_user2 != "")
                ds6.SelectCommand = "SELECT DISTINCT Conversatii.mesaj, Conversatii.citit, Conversatii.data, (SELECT UserName FROM aspnet_Users WHERE (UserId = Conversatii.cod_sender)) AS senderN, (SELECT UserName FROM aspnet_Users AS aspnet_Users_2 WHERE (UserId = Conversatii.cod_receiver)) AS receiverN FROM Conversatii INNER JOIN aspnet_Users AS aspnet_Users_1 ON (Conversatii.cod_sender = aspnet_Users_1.UserId OR Conversatii.cod_receiver = aspnet_Users_1.UserId) and (Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' and Conversatii.cod_receiver = '" + cod_user2 + "') or (Conversatii.cod_sender = '" + cod_user2 + "' and Conversatii.cod_receiver = '" + Membership.GetUser().ProviderUserKey.ToString() + "' ) where mesaj like '%" + tb2.Text + "%' order by data desc";
            else
            {
                raspuns_user.Text = "Userul introdus nu exista";
                ds6.SelectCommand = "";
            }
        }
        //ds6.SelectCommand = "SELECT DISTINCT Conversatii.mesaj, Conversatii.citit, Conversatii.data, (SELECT UserName FROM aspnet_Users WHERE (UserId = Conversatii.cod_sender)) AS senderN, (SELECT UserName FROM aspnet_Users AS aspnet_Users_2 WHERE (UserId = Conversatii.cod_receiver)) AS receiverN FROM Conversatii INNER JOIN aspnet_Users AS aspnet_Users_1 ON (Conversatii.cod_sender = aspnet_Users_1.UserId OR Conversatii.cod_receiver = aspnet_Users_1.UserId) and (((SELECT UserName FROM aspnet_Users WHERE (UserId = Conversatii.cod_sender)) = '" + user_send + "' and (SELECT UserName FROM aspnet_Users AS aspnet_Users_2 WHERE (UserId = Conversatii.cod_receiver)) = '" + user_recv + "') or ((SELECT UserName FROM aspnet_Users WHERE (UserId = Conversatii.cod_sender)) = '" + user_recv + "' and (SELECT UserName FROM aspnet_Users AS aspnet_Users_2 WHERE (UserId = Conversatii.cod_receiver)) = '" + user_send + "')) order by data desc";
        Session["select_cmd"] = ds6.SelectCommand;
    }

    protected string culoare_text_comm(string sender)
    {
        if (Membership.GetUser().UserName.ToString() == sender)
            return "bg-success";
        else
            return "bg-info";
    }
    protected string mesaj_necitit(string citit)
    {
        if (citit == "0")
            return "style=\"border-left:2px solid #f00\"";
        else
            return "";
    }
}