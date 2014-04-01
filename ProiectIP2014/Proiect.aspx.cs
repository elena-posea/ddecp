using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Proiect : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id_proiect = Request.Params["id_proiect"];

        if (id_proiect != null)
        {
            SqlDataSource1.SelectCommand = "SELECT Proiecte.id_proiect, Proiecte.cod_user, CONVERT (Date, Proiecte.data_inceput) AS data_i, CONVERT (Date, Proiecte.data_sfarsit) AS data_sfarsit, Proiecte.nume, Proiecte.descriere, Proiecte.continut, Proiecte.domeniu, aspnet_Users.UserName FROM Proiecte INNER JOIN aspnet_Users ON Proiecte.cod_user = aspnet_Users.UserId where id_proiect = " + Server.UrlDecode(id_proiect) + ";";
           
        }
    }
}