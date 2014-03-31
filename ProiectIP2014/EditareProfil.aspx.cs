using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditareProfil : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
        if (!Page.IsPostBack) {

            TextBoxAn.Text = Profile.AnInfiintare.ToString();
            TextBoxDescriere.Text = Profile.DescriereActivitate;
            TextBoxProfil.Text = Profile.Profil;
            TextBoxNrInregistrare.Text = Profile.NrInregistrare.ToString();
            DropDownListTip.SelectedValue = Profile.TipONG;

            LabelNumeONG.Text = Profile.UserName;
            LabelEmailCamp.Text = Membership.GetUser(Profile.UserName).Email;

        }

    }

    protected void ButtonUpdate_Click(object sender, EventArgs e) {
        Profile.AnInfiintare = System.Convert.ToInt32(TextBoxAn.Text);
        Profile.DescriereActivitate = TextBoxDescriere.Text;
        Profile.Profil = TextBoxProfil.Text;
        Profile.NrInregistrare = System.Convert.ToInt32(TextBoxNrInregistrare.Text);
        Profile.TipONG = DropDownListTip.SelectedItem.ToString(); 

    }
}