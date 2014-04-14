using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Mesaje1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                SqlDataSource ds2 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceNeCitite");
                SqlDataSource ds4 = (SqlDataSource)LoginView2.FindControl("SqlDataSourceCitite");
                //ds2.SelectCommand = "SELECT aspnet_Users.UserName as UserN, COUNT(*) AS nrC FROM aspnet_Users INNER JOIN Conversatii ON aspnet_Users.UserId = Conversatii.cod_receiver and Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' GROUP BY aspnet_Users.UserName;";
                ds2.SelectCommand = "SELECT aspnet_Users.UserName as UserN, count(*) AS nrC, Min(Conversatii.citit) as citit FROM aspnet_Users	INNER JOIN Conversatii ON (aspnet_Users.UserId = Conversatii.cod_receiver OR aspnet_Users.UserId = Conversatii.cod_sender) and (Conversatii.cod_sender <> Conversatii.cod_receiver) and (Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' OR Conversatii.cod_receiver = '" + Membership.GetUser().ProviderUserKey.ToString() + "') GROUP BY aspnet_Users.UserName HAVING Min(Conversatii.citit) = 0";
                ds4.SelectCommand = "SELECT aspnet_Users.UserName as UserN, count(*) AS nrC, Min(Conversatii.citit) as citit FROM aspnet_Users	INNER JOIN Conversatii ON (aspnet_Users.UserId = Conversatii.cod_receiver OR aspnet_Users.UserId = Conversatii.cod_sender) and (Conversatii.cod_sender <> Conversatii.cod_receiver) and (Conversatii.cod_sender = '" + Membership.GetUser().ProviderUserKey.ToString() + "' OR Conversatii.cod_receiver = '" + Membership.GetUser().ProviderUserKey.ToString() + "') GROUP BY aspnet_Users.UserName HAVING Min(Conversatii.citit) = 1";
            }
    }
}