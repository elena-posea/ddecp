using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SignUp : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {

    }
    protected void CreateUserWizard1_ContinueButtonClick(object sender, EventArgs e) {
        //Debug.WriteLine("continue button");
        //try {
        Profile.RegisterDate = System.DateTime.Now;
        Profile.NumeONG = ((TextBox)(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TextBoxNumeONG"))).Text;
        Profile.AnInfiintare = System.Convert.ToInt32(((TextBox)(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TextBoxAn"))).Text);
        Profile.DescriereActivitate = ((TextBox)(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TextBoxDescriere"))).Text;
        Profile.Profil = ((TextBox)(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TextBoxProfil"))).Text;
        Profile.NrInregistrare = ((TextBox)(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TextBoxNrInregistrare"))).Text;
        Profile.TipONG = ((DropDownList)(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("DropDownListTip"))).SelectedItem.ToString(); 
        Response.Redirect("~/Default.aspx", false);
        // }
        //catch (Exception exceptie) {
        //   Debug.WriteLine("continue button am prins exceptia "+ exceptie);        
        //}
        // Debug.WriteLine("continue button after redirect");
    }

    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e) {
        // aici ii spun ca vreau ca by default userul sa fie ONG
        Debug.WriteLine("create user");
        try {
            Roles.AddUserToRole(CreateUserWizard1.UserName, "ONG");
        }
        catch (System.Configuration.Provider.ProviderException) {
            Debug.WriteLine("am prins exceptia");
        }

    }

}