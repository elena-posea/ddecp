using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Profil : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
        if (!Page.IsPostBack) {
            string username = Request.Params["username"];
            // astea pot fi adaugate, daca e necesar sa le punem pe pagina de profil (stalker-oriented :)) )
            //LabelLastLoginDateInfo.Text = Profile.LastActivityDate.ToString();
            //LabelRegisterDateInfo.Text = Profile.RegisterDate.ToString();
            LabelUserNameCamp.Text = username;

            //emailul nu e in profile, e in baza de date
            LabelEmailCamp.Text = Membership.GetUser(username).Email;

            ProfileBase profile = ProfileBase.Create(username, true);

            LabelNumeONG.Text = profile.GetPropertyValue("NumeONG").ToString();
            LabelDescriereCamp.Text = profile.GetPropertyValue("DescriereActivitate").ToString();
            LabelNrInregistrareCamp.Text = profile.GetPropertyValue("NrInregistrare").ToString();
            LabelTipONGCamp.Text = profile.GetPropertyValue("TipONG").ToString(); ;
            LabelAnCamp.Text = profile.GetPropertyValue("AnInfiintare").ToString();
            LabelProfilCamp.Text = profile.GetPropertyValue("Profil").ToString();
            // vreau sa completez formul cu ce era in Profile

            // daca sunt chiar pe profilul meu, da-mi si linkul de editare
            if (HttpContext.Current.User.Identity.IsAuthenticated && Profile.UserName == username) {
                HyperLink hl = (LoginView1.FindControl("HyperLink1") as HyperLink);
                hl.NavigateUrl = "~/EditareProfil.aspx?username=" + Profile.UserName;
                hl.Visible = true;
            }

            SqlDataSourceProiectePersonale.SelectCommand = "SELECT * FROM [Proiecte] WHERE  CAST(cod_user AS VARCHAR(50)) = '" + username + "'";

        }

    }
}