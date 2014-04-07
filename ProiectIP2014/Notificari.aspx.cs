using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Notificari : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id_notificare = Request.Params["id_notificare"];
        if (id_notificare != null)
        {
            if (id_notificare.Equals("-2"))
            {   
              

                Label lb = (Label) LoginView1.FindControl("Raspuns");
                lb.Text = "Ati aplicat deja la acest proiect!";

                Button bt = (Button) LoginView1.FindControl("ok");
                bt.Visible = true;

                ListView lw = (ListView)LoginView1.FindControl("ListView1");
                lw.Visible = false;
            }
            else
                if (id_notificare.Equals("-1"))
                {
                    Label lb = (Label)LoginView1.FindControl("Raspuns");
                    lb.Text = "Ati aplicat cu succes la acest proiect! Va rugam sa asteptati confirmarea ONG-ului care a initiat proiectul!";

                    Button bt = (Button)LoginView1.FindControl("ok");
                    bt.Visible = true;

                    ListView lw = (ListView)LoginView1.FindControl("ListView1");
                    lw.Visible = false;
                }
        }
        else
        {
            bool val1 = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
            if (val1)
            {
                Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
                string user = userGuid.ToString();

                SqlDataSource1.SelectCommand = "SELECT aspnet_Users_1.UserId, aspnet_Users_1.UserName AS propus, Proiecte.id_proiect, Proiecte.nume, (SELECT UserName FROM aspnet_Users WHERE (UserId = User_are_Colaboratori.cod_user)) AS nume_colab, User_are_Colaboratori.cod_user, User_are_Colaboratori.cod_proiect FROM aspnet_Users AS aspnet_Users_1 INNER JOIN Proiecte ON aspnet_Users_1.UserId = Proiecte.cod_user INNER JOIN User_are_Colaboratori ON Proiecte.id_proiect = User_are_Colaboratori.cod_proiect where stare='inactiv' and UserId='" + user + "';";
            }
        }
    }
    protected void ok_Click(object sender, EventArgs e)
    {
        Response.Redirect("Proiecte.aspx");
    }
    protected void acepta_Command(object sender, CommandEventArgs e)
    {
       
        try
        {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            SqlCommand command = new SqlCommand("UPDATE User_are_Colaboratori SET stare='activ' WHERE cod_user='"+e.CommandName+"' and cod_proiect="+e.CommandArgument, connection);

            try
            {
                command.ExecuteNonQuery();
                Response.Redirect("Notificari.aspx");
            }
            catch (SqlException exc)
            {
                Label lb = (Label)LoginView1.FindControl("Raspuns");
                lb.Text = exc.Message;
            }
        }
        catch (Exception exc)
        {
            Label lb = (Label)LoginView1.FindControl("Raspuns");
            lb.Text = exc.Message;
        }
    }
}