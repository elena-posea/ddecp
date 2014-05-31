using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Altcineva : System.Web.UI.Page
{
    static String id_proiect;
    static String id_task; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) {
           id_task = Request.Params["id_task"];
           id_proiect = Request.Params["id_proiect"];
           LabelNrTask.Text = id_task;
        }
    }
    protected void Button1_Click(object sender, EventArgs e) {
        String username = TextBoxUser.Text;
        // ai username -> vrei id
        try {
            String id = Membership.GetUser(TextBoxUser.Text).ProviderUserKey.ToString();
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            SqlCommand command = new SqlCommand("UPDATE Tasks SET [cod_asignat]=@cod_asignat where [id_task] = @id_task ;", connection);
            command.Parameters.AddWithValue("id_task", Convert.ToInt32(id_task));
            command.Parameters.AddWithValue("cod_asignat", Membership.GetUser(TextBoxUser.Text).ProviderUserKey.ToString());

            try {
                command.ExecuteNonQuery();
                Response.Redirect("~/Proiect.aspx?id_proiect=" + Request.Params["id_proiect"]);
            }
            catch (SqlException sqlex) {
                Raspuns.Text = sqlex.Message;
            }

            connection.Close();
        }
        catch (Exception sqlex) {
            Raspuns.Text = sqlex.Message;
        }
    }
}