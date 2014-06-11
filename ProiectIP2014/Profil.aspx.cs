using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Profil : System.Web.UI.Page {
    private void eroareCuRedirectare(String x) {
        continutPagina.Visible = false;
        LabelMesaj.Text = x + " Veti fi redirectat in 5 secunde";
        LabelMesaj.CssClass = "notOk";
        Response.AddHeader("REFRESH", "5;URL=Default.aspx");
    }


    protected void Page_Load(object sender, EventArgs e) {
        if (!Page.IsPostBack) {
            String username = Request.Params["username"];
            if(username == null){
                eroareCuRedirectare("Link invalid!");
            }
            else{
                //src-ul imaginii de profil:
                string fn = "~/profil_images/" + username + "_profil.jpg";
                string fn2 = Server.MapPath("profil_images") + "/" + username + "_profil.jpg";
                if (File.Exists(fn2))
                    img_profil.Src = fn;
                //end

            // astea pot fi adaugate, daca e necesar sa le punem pe pagina de profil (stalker-oriented :)) )
            //LabelLastLoginDateInfo.Text = Profile.LastActivityDate.ToString();
            //LabelRegisterDateInfo.Text = Profile.RegisterDate.ToString();
            //emailul nu e in profile, e in baza de date

            GETProfil.SelectCommand = "SELECT dbo.GetProfilePropertyValue('NumeONG', PropertyNames, PropertyValuesString) AS NumeONG, dbo.GetProfilePropertyValue('DescriereActivitate', PropertyNames, PropertyValuesString) AS Descriere, dbo.GetProfilePropertyValue('Profil', PropertyNames, PropertyValuesString) AS Profil, dbo.GetProfilePropertyValue('TipONG', PropertyNames, PropertyValuesString) AS TipONG, aspnet_Users.username AS username from aspnet_Profile, aspnet_Users where aspnet_Users.UserId = aspnet_Profile.UserId and aspnet_Users.UserName = '"+username+"';";
            ProfileBase profile = ProfileBase.Create(username, true);

            LabelNumeONG.Text = profile.GetPropertyValue("NumeONG").ToString();
            inputEmail.Text = Membership.GetUser(username).Email;
            userName.Text = username;

            tipONG.Text = profile.GetPropertyValue("TipONG").ToString();
            anCamp.Text = profile.GetPropertyValue("AnInfiintare").ToString();
            profilCamp.Text = profile.GetPropertyValue("Profil").ToString();
            nrCamp.Text = profile.GetPropertyValue("NrInregistrare").ToString();

            descriere.Text = profile.GetPropertyValue("DescriereActivitate").ToString();
                // vreau sa completez formul cu ce era in Profile

            // daca sunt chiar pe profilul meu, da-mi si linkul de editare
            if (HttpContext.Current.User.Identity.IsAuthenticated && Profile.UserName == username) {
                HyperLink hl = (LoginView1.FindControl("HyperLink1") as HyperLink);
                hl.NavigateUrl = "~/EditareProfil.aspx?username=" + Profile.UserName;
                hl.Visible = true;
            }
                
            SqlDataSourceProiectePersonale.SelectCommand = "SELECT Proiecte.nume, Proiecte.id_proiect FROM [Proiecte] WHERE  CAST(cod_user AS VARCHAR(50)) = '" + Membership.GetUser(username).ProviderUserKey + "'";

            SqlDataSourceProiecteParticipant.SelectCommand = "SELECT Proiecte.nume, Proiecte.id_proiect FROM User_are_Colaboratori INNER JOIN Proiecte ON User_are_Colaboratori.cod_proiect = Proiecte.id_proiect WHERE  CAST(User_are_Colaboratori.cod_user AS VARCHAR(50)) = '" + Membership.GetUser(username).ProviderUserKey + "' AND stare='activ'";
            }
        }

    }
}