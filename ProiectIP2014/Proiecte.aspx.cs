using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Proiecte : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void Detalii_Stire_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect("~/Proiect.aspx?id_proiect=" + e.CommandArgument);
    }
    protected void Colaborator_Command(object sender, CommandEventArgs e)
    {

    }
}