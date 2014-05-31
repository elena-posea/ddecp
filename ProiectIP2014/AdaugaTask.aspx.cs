using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdaugaTask : System.Web.UI.Page
{
    private static string id_proiect;
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void adauga_task_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            id_proiect = Request.Params["id_proiect"];
            Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
            SqlCommand command = new SqlCommand("INSERT INTO [Tasks] ([cod_initiator], [cod_proiect], [descriere], [nr_voluntari], [deadline]) VALUES (@cod_initiator,@cod_proiect, @descriere,@nr_voluntari, @deadline)", connection);
            command.Parameters.AddWithValue("cod_initiator", userGuid);
            command.Parameters.AddWithValue("cod_proiect", id_proiect);
            command.Parameters.AddWithValue("descriere", descriere.Text);
            command.Parameters.AddWithValue("nr_voluntari", Convert.ToInt32(nr_voluntari.Text));
            command.Parameters.AddWithValue("deadline", deadline.SelectedDate);

            try
            {
                command.ExecuteNonQuery();
                Response.Redirect("Proiect.aspx?id_proiect="+id_proiect);

            }
            catch (SqlException ex)
            {
                Raspuns.Text = ex.Message;
            }
        }
        catch (Exception ex)
        {
            Raspuns.Text = ex.Message.ToString();
        }
    }
}
    
    
