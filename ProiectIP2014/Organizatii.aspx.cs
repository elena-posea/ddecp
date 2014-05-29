using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Organizatii : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Detalii_ONG(object sender, CommandEventArgs e)
    {
        Response.Redirect("~/Profil.aspx?username=" + e.CommandArgument);
    }
}