using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Organizatii : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Detalii_ONG(object sender, CommandEventArgs e)
    {
        Response.Redirect("~/Profil.aspx?username=" + e.CommandArgument);
    }

    protected bool imgExists(string _username)
    {
        if (getImgSrc(_username) == "")
            return false;
        else
            return true;
    }

    protected string getImgSrc(string _username)
    {
        if (_username != null)
        {
            //src-ul imaginii de profil:
            string fn = "~/profil_images/" + _username + "_profil.jpg";
            string fn2 = Server.MapPath("profil_images") + "/" + _username + "_profil.jpg";
            //asd.InnerHtml = fn2;
            if (File.Exists(fn2))
                return fn;
            else
                return "~/profil_images/default.jpg";
            //end
        }
        return "";
    }
}