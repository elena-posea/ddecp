using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Stire : System.Web.UI.Page
{
    private static string id_stire;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            id_stire = Request.Params["id_stire"];
            if (id_stire != null)
            {
                SqlDataSource1.SelectCommand = "SELECT Stiri.id_stire, Stiri.cod_user, Stiri.titlu, Stiri.descriere, Stiri.continut, aspnet_Users.UserName FROM Stiri INNER JOIN aspnet_Users ON Stiri.cod_user = aspnet_Users.UserId where id_stire = " + Server.UrlDecode(id_stire) + ";";

            }
        }
    }

    protected bool imgExists()
    {
        if (getImgSrc() == "")
            return false;
        else
            return true;
    }

    protected string getImgSrc()
    {
        id_stire = Request.Params["id_stire"];
        if (id_stire != null)
        {
            //src-ul imaginii de profil:
            string fn = "~/stiri_images/" + id_stire + ".jpg";
            string fn2 = Server.MapPath("stiri_images") + "/" + id_stire + ".jpg";
            //asd.InnerHtml = fn2;
            if (File.Exists(fn2))
                return fn;
            //end
        }
        return "";
    }
}