using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web;
using System.IO;

public partial class EditareProfil : System.Web.UI.Page {

    private void eroareCuRedirectare(String x)
    {
        continutPagina.Visible = false;
        LabelMesaj.Text = x + " Veti fi redirectat in 5 secunde";
        LabelMesaj.CssClass = "notOk";
        Response.AddHeader("REFRESH", "5;URL=Default.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            String username = Request.Params["username"];
            if (username == null)
            {
                eroareCuRedirectare("Link invalid!");
            }
            else
            {
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

                GETProfil.SelectCommand = "SELECT dbo.GetProfilePropertyValue('NumeONG', PropertyNames, PropertyValuesString) AS NumeONG, dbo.GetProfilePropertyValue('DescriereActivitate', PropertyNames, PropertyValuesString) AS Descriere, dbo.GetProfilePropertyValue('Profil', PropertyNames, PropertyValuesString) AS Profil, dbo.GetProfilePropertyValue('TipONG', PropertyNames, PropertyValuesString) AS TipONG, aspnet_Users.username AS username from aspnet_Profile, aspnet_Users where aspnet_Users.UserId = aspnet_Profile.UserId and aspnet_Users.UserName = '" + username + "';";
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

               
              
            }
        }
    }
    protected void ButtonUpdate_Click(object sender, EventArgs e) {
        Profile.AnInfiintare = System.Convert.ToInt32(anCamp.Text);
        Profile.DescriereActivitate = descriere.Text;
        Profile.Profil = profilCamp.Text;
        Profile.NrInregistrare = nrCamp.Text;
        
    }

    protected void upload_pic(object sender, System.EventArgs e)
    {
        if ((File1.PostedFile != null) && (File1.PostedFile.ContentLength > 0))
        {
            string fn = System.IO.Path.GetFileName(File1.PostedFile.FileName);
            string fext = System.IO.Path.GetExtension(File1.PostedFile.FileName);
            string SaveLocation = Server.MapPath("profil_images") + "\\" + Membership.GetUser().UserName + "_profil.jpg";
            try
            {
                File1.PostedFile.SaveAs(SaveLocation);
                rasp_up.InnerText = "Fisier uploadat cu succes (" + fn + "). Schimbarea pozei poate dura cateva minute in functie de cache.  Pagina se va reincarca in 5 secunde.";
                Response.AddHeader("REFRESH", "5");
            }
            catch (Exception ex)
            {
                Response.Write("Eroare: " + ex.Message);
                //Note: Exception.Message returns a detailed message that describes the current exception. 
                //For security reasons, we do not recommend that you return Exception.Message to end users in 
                //production environments. It would be better to return a generic error message. 
            }
        }
        else
        {
            rasp_up.InnerText = "Selecteaza o imagine pentru upload.";
        }
    }
}