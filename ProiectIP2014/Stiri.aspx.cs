using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Stiri : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void Vizualizeaza_Stire_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect("~/Stire.aspx?id_stire=" + e.CommandArgument);
    }
    protected bool imgExists(string _id_proiect)
    {
        if (getImgSrc(_id_proiect) == "")
            return false;
        else
            return true;
    }

    protected string getImgSrc(string _id_proiect)
    {
        int id_proiect = int.Parse(_id_proiect);
        if (_id_proiect != null)
        {
            //src-ul imaginii de profil:
            string fn = "~/stiri_images/" + id_proiect + ".jpg";
            string fn2 = Server.MapPath("stiri_images") + "/" + id_proiect + ".jpg";
            //asd.InnerHtml = fn2;
            if (File.Exists(fn2))
                return fn;
            //end
        }
        return "";
    }
}