using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdaugaProiect : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        upload_pic(sender, e);
        try
        {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
            SqlCommand command = new SqlCommand("INSERT INTO [Proiecte] ([cod_user],[nume], [descriere], [continut], [domeniu], [data_inceput],[data_sfarsit]) VALUES (@cod_user,@nume, @descriere,@continut, @domeniu, @data_inceput,@data_sfarsit)", connection);
            command.Parameters.AddWithValue("cod_user", userGuid);
            command.Parameters.AddWithValue("nume", titlu_proiect.Text);
            command.Parameters.AddWithValue("continut", continut_proiect.Text);
            command.Parameters.AddWithValue("descriere", descriere_proiect.Text);
            command.Parameters.AddWithValue("domeniu", domeniu_proiect.Text);
            command.Parameters.AddWithValue("data_inceput", data_inceput.SelectedDate);
            command.Parameters.AddWithValue("data_sfarsit", data_sfarsit.SelectedDate);

            try
            {
                command.ExecuteNonQuery();
                Response.Redirect("Proiecte.aspx");

            }
            catch (SqlException ex)
            {
                Raspuns.Text = ex.Message;
            }
        }
        catch (NullReferenceException ex)
        {
            Raspuns.Text = ex.Message;
        }
    }

    protected void upload_pic(object sender, System.EventArgs e)
    {

        //caut ultimul id al proiectelor
        SqlConnection connection = new SqlConnection();
        connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.MDF;Integrated Security=True;User Instance=True";
        connection.Open();
        SqlCommand commandGetLastId = new SqlCommand("SELECT MAX(id_proiect) from Proiecte", connection);
        int last_id = int.Parse(commandGetLastId.ExecuteScalar().ToString()) + 1;
        connection.Close();

        if ((File1.PostedFile != null) && (File1.PostedFile.ContentLength > 0))
        {
            string fn = System.IO.Path.GetFileName(File1.PostedFile.FileName);
            string fext = System.IO.Path.GetExtension(File1.PostedFile.FileName);
            string SaveLocation = Server.MapPath("proiect_images") + "/" + last_id + ".jpg";
            try
            {
                File1.PostedFile.SaveAs(SaveLocation);
                rasp_up.InnerText = "Fisier uploadat cu succes (" + fn + ").";
            }
            catch (Exception ex)
            {
                rasp_up.InnerText = "Eroare: " + ex.Message;
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