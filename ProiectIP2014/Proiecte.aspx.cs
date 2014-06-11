using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Proiecte : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bool val1 = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
        if (val1){
            Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
            string user = userGuid.ToString();
            SqlDataSource1.SelectCommand = "SELECT Proiecte.id_proiect, Proiecte.cod_user, CONVERT (Date, Proiecte.data_inceput) AS data_i, CONVERT (Date, Proiecte.data_sfarsit) AS data_sfarsit, Proiecte.nume, Proiecte.descriere, Proiecte.domeniu, aspnet_Users.UserName FROM Proiecte INNER JOIN aspnet_Users ON Proiecte.cod_user = aspnet_Users.UserId WHERE aspnet_Users.UserId != '" + user + "';";
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

    protected bool imgExists(string _id_proiect)
    {
        //if (getImgSrc(_id_proiect) == "")
        //    return false;
        //else
            return true;
    }

    protected string getImgSrc(string _id_proiect)
    {
        int id_proiect = int.Parse(_id_proiect);
        if (_id_proiect != null)
        {
            //src-ul imaginii de profil:
            string fn = "~/proiect_images/" + id_proiect + ".jpg";
            string fn2 = Server.MapPath("proiect_images") + "/" + id_proiect + ".jpg";
            //asd.InnerHtml = fn2;
            if (File.Exists(fn2))
                return fn;
            //end
        }
        return "";
    }
}