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
}