using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search : System.Web.UI.Page
{
    private void eroareCuRedirectare(String x)
    {
        continutPagina.Visible = false;
        LabelMesaj.Text = x + " Veti fi redirectat in 5 secunde";
        LabelMesaj.CssClass = "notOk";
        Response.AddHeader("REFRESH", "5;URL=Default.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            String searchBox = Request.Params["searchBox"];
            if (searchBox == null)
            {
                eroareCuRedirectare("Link invalid!");
            }
            else
            {

                bool val1 = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
                if (val1)
                {
                    Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
                    string user = userGuid.ToString();
                    LabelMesaj.Text = "bla";
                    SearchProiecte.SelectCommand = "SELECT Proiecte.id_proiect, Proiecte.cod_user, CONVERT (Date, Proiecte.data_inceput) AS data_i, CONVERT (Date, Proiecte.data_sfarsit) AS data_sfarsit, Proiecte.nume, Proiecte.descriere, Proiecte.domeniu, aspnet_Users.UserName FROM Proiecte INNER JOIN aspnet_Users ON Proiecte.cod_user = aspnet_Users.UserId WHERE aspnet_Users.UserId != '" + user + "' and Proiecte.nume like '%" + searchBox + "%';";
                }
                else
                {
                    LabelMesaj.Text = "blabla";
                    SearchProiecte.SelectCommand = "SELECT Proiecte.id_proiect, Proiecte.cod_user, CONVERT (Date, Proiecte.data_inceput) AS data_i, CONVERT (Date, Proiecte.data_sfarsit) AS data_sfarsit, Proiecte.nume, Proiecte.descriere, Proiecte.domeniu, aspnet_Users.UserName FROM Proiecte INNER JOIN aspnet_Users ON Proiecte.cod_user = aspnet_Users.UserId WHERE Proiecte.nume like '%" + searchBox + "%';";

                }
            }
        }
    }

    protected void Detalii_Proiect_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect("~/Proiect.aspx?id_proiect=" + e.CommandArgument);
    }
    protected void Colaborator_Command(object sender, CommandEventArgs e)
    {
        try
        {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
            SqlCommand command = new SqlCommand("INSERT INTO [User_are_Colaboratori] ([cod_user],[cod_proiect],[stare]) VALUES (@cod_user,@cod_proiect, @stare)", connection);
            command.Parameters.AddWithValue("cod_user", userGuid);
            command.Parameters.AddWithValue("cod_proiect", e.CommandArgument);
            command.Parameters.AddWithValue("stare", "inactiv");

            try
            {
                command.ExecuteNonQuery();
                Response.Redirect("Notificari.aspx?id_notificare=-1");

            }
            catch (SqlException exc)
            {
                if (exc.ErrorCode.Equals(-2146232060))
                    Response.Redirect("Notificari.aspx?id_notificare=-2");
            }
        }
        catch (Exception exc)
        {
            Raspuns.Text = exc.Message;
        }
    }
}