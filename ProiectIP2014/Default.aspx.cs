using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bool isValid = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
        if (isValid){
            Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
            string user = userGuid.ToString();
            GETProiectePersonale.SelectCommand = "SELECT Proiecte.nume, Proiecte.id_proiect, CAST(Proiecte.descriere AS NVARCHAR(100)) AS descriere FROM Proiecte WHERE  CAST(cod_user AS VARCHAR(50)) = '" + userGuid + "' UNION" +
                " SELECT Proiecte.nume, Proiecte.id_proiect, CAST(Proiecte.descriere AS NVARCHAR(100)) AS descriere FROM User_are_Colaboratori INNER JOIN Proiecte ON User_are_Colaboratori.cod_proiect = Proiecte.id_proiect WHERE  CAST(User_are_Colaboratori.cod_user AS VARCHAR(50)) = '" + userGuid + "' AND stare='activ'";
           // GETProiecteParticip.SelectCommand = "SELECT Proiecte.id_proiect, Proiecte.cod_user, CONVERT (Date, Proiecte.data_inceput) AS data_i, CONVERT (Date, Proiecte.data_sfarsit) AS data_sfarsit, Proiecte.nume, Proiecte.descriere, Proiecte.domeniu, aspnet_Users.UserName FROM Proiecte p, User_are_Colaboratori uac WHERE p.id_proiect = uac.cod_proiect and uac.cod_user = '" + user + " ';";
        }
    }
    protected void Vizualizeaza_Proiect_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect("~/Proiect.aspx?id_proiect=" + e.CommandArgument);
    }
}