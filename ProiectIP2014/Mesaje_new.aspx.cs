using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI.HtmlControls;

public partial class Mesaje_new : System.Web.UI.Page
{
    private static string user_recv, cod_user_recv;
    private static string user_send;
    protected void Page_Load(object sender, EventArgs e)
    {
        user_recv = Request.Params["to"];
        //cod pt sidebar conversatii stanga
        if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
        {
            user_send = Membership.GetUser().UserName.ToString();
            SqlDataSource ds2 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceNeCitite");
            SqlDataSource ds4 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceCitite");
            SqlDataSource ds6 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceMesaje");
            //ds2.SelectCommand = "SELECT aspnet_Users.UserName as UserN, COUNT(*) AS nrC FROM aspnet_Users INNER JOIN Conversatii ON aspnet_Users.UserId = Conversatii.cod_receiver and Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' GROUP BY aspnet_Users.UserName;";
            
            //lista conversatii cu msg necitite
            ds2.SelectCommand = "SELECT aspnet_Users.UserName as UserN, count(*) AS nrC, Min(Conversatii.citit) as citit FROM aspnet_Users	INNER JOIN Conversatii ON (aspnet_Users.UserId = Conversatii.cod_receiver OR aspnet_Users.UserId = Conversatii.cod_sender) and (Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' OR Conversatii.cod_receiver = '" + Membership.GetUser().ProviderUserKey.ToString() + "') GROUP BY aspnet_Users.UserName HAVING Min(Conversatii.citit) = 0";
            //lista conversatii vechi
            ds4.SelectCommand = "SELECT aspnet_Users.UserName as UserN, count(*) AS nrC, Min(Conversatii.citit) as citit FROM aspnet_Users	INNER JOIN Conversatii ON (aspnet_Users.UserId = Conversatii.cod_receiver OR aspnet_Users.UserId = Conversatii.cod_sender) and (Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' OR Conversatii.cod_receiver = '" + Membership.GetUser().ProviderUserKey.ToString() + "') GROUP BY aspnet_Users.UserName HAVING Min(Conversatii.citit) = 1";
            //lista mesaje dintre 2 useri
            ds6.SelectCommand = "SELECT DISTINCT Conversatii.mesaj, Conversatii.citit, Conversatii.data, (SELECT UserName FROM aspnet_Users WHERE (UserId = Conversatii.cod_sender)) AS senderN, (SELECT UserName FROM aspnet_Users AS aspnet_Users_2 WHERE (UserId = Conversatii.cod_receiver)) AS receiverN FROM Conversatii INNER JOIN aspnet_Users AS aspnet_Users_1 ON (Conversatii.cod_sender = aspnet_Users_1.UserId OR Conversatii.cod_receiver = aspnet_Users_1.UserId) and (((SELECT UserName FROM aspnet_Users WHERE (UserId = Conversatii.cod_sender)) = '" + user_send + "' and (SELECT UserName FROM aspnet_Users AS aspnet_Users_2 WHERE (UserId = Conversatii.cod_receiver)) = '" + user_recv + "') or ((SELECT UserName FROM aspnet_Users WHERE (UserId = Conversatii.cod_sender)) = '" + user_recv + "' and (SELECT UserName FROM aspnet_Users AS aspnet_Users_2 WHERE (UserId = Conversatii.cod_receiver)) = '" + user_send + "')) order by data desc";
                
        }

        //cod pt zona centrala textboxuri
        if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated) {
            TextBox tb1 = (TextBox)LoginView2.FindControl("TextBox1");
            Literal l1 = (Literal)LoginView2.FindControl("UserExista");
            if (!Page.IsPostBack)
            {
                user_recv = Request.Params["to"];
                
                if (user_recv != null)
                    tb1.Text = user_recv;
            }

            //verific daca exista userul din campul "catre"
            string user2 = tb1.Text;
            try
            {
                SqlConnection connection = new SqlConnection();
                connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
                connection.Open();

                SqlCommand command = new SqlCommand("Select UserId from aspnet_Users where LoweredUserName = LOWER(@user2);", connection);
                command.Parameters.AddWithValue("user2", user2);
                SqlDataReader dr = command.ExecuteReader();

                if (dr.Read())
                {
                    cod_user_recv = dr[0].ToString();
                    //l1.Text = "userul exista: " + user_recv;
                }
                dr.Close();
                connection.Close();
            }
            catch (NullReferenceException ex)
            {
                l1.Text = ex.Message;
            }
        }

        //update_read();
    }

    protected void Page_Unload(object sender, EventArgs e)
    {
        update_read();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        TextBox tb1 = (TextBox)LoginView2.FindControl("TextBox1");
        Literal l1 = (Literal)LoginView2.FindControl("UserExista");
        //verific daca exista userul din campul "catre"
        string user2 = tb1.Text;
        try
        {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            SqlCommand command = new SqlCommand("Select UserId from aspnet_Users where LoweredUserName = LOWER(@user2);", connection);
            command.Parameters.AddWithValue("user2", user2);
            SqlDataReader dr = command.ExecuteReader();

            if (dr.Read())
            {
                cod_user_recv = dr[0].ToString();
                //l1.Text = "userul exista: " + user_recv;
            }
            dr.Close();
            connection.Close();
        }
        catch (NullReferenceException ex)
        {
            l1.Text = ex.Message;
        }

        if (cod_user_recv == null)
        {
            l1.Text = "Userul introdus nu exista.";
            return;
        }

        //trimit mesajul
        TextBox tb2 = (TextBox)LoginView2.FindControl("TextBox2");
        Literal l2 = (Literal)LoginView2.FindControl("Raspuns");
        try
        {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
            SqlCommand command = new SqlCommand("INSERT INTO [Conversatii] ([cod_sender], [cod_receiver], [mesaj], [citit], [data]) VALUES (@cod_user, @cod_recv, @mesaj, @citit, @data)", connection);
            command.Parameters.AddWithValue("cod_user", userGuid);
            command.Parameters.AddWithValue("cod_recv", cod_user_recv);
            command.Parameters.AddWithValue("mesaj", tb2.Text);
            command.Parameters.AddWithValue("citit", "0");
            command.Parameters.AddWithValue("data", DateTime.Now);

            try
            {
                command.ExecuteNonQuery();

            }
            catch (SqlException ex)
            {
                l2.Text = ex.Message;
            }
        }
        catch (NullReferenceException ex)
        {
            l2.Text = ex.Message;
        }
        //deci s-a trimis:
        l2.Text = "Succes!";
        Response.Redirect("Mesaje_new.aspx?to=" + user2);
    }

    protected string header_title()
    {
        user_recv = Request.Params["to"];
        if (user_recv != null)
            return "Conversatie cu " + "<a href='Profil.aspx?username=" + user_recv + "'>" + user_recv + "</a>:";
        else
            return "Conversatie noua!";

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

    protected void update_read()
    {
        //user_recv = Request.Params["to"];
        
        if (!(HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated) || user_recv == null)
            return;


        //Label lb = (Label)LoginView2.FindControl("RaspunsCitit");



        //cod pt setare mesaje cu (sender,receiver) ca citite 
        try
        {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
            SqlCommand command = new SqlCommand("UPDATE Conversatii set citit = '1' where cod_receiver = @cod_user and cod_sender=@cod_sender;", connection);
            command.Parameters.AddWithValue("cod_user", userGuid);
            command.Parameters.AddWithValue("cod_sender", cod_user_recv);
            try
            {
                command.ExecuteNonQuery();
                //lb.Text = "Toate mesajele noi au fost marcate ca citite.";
            }
            catch (SqlException ex)
            {
                //lb.Text = ex.Message;
            }
        }
        catch (NullReferenceException ex)
        {
            //lb.Text = ex.Message;
        }
    }
}