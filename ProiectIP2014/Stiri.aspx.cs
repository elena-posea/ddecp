using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Stiri : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void Vizualizeaza_Stire_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect("~/Stire.aspx?id_stire=" + e.CommandArgument);
    }
}