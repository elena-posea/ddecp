using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdaugaStire : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Adauga_Stire(object sender, EventArgs e)
    {
        try
        {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
            SqlCommand command = new SqlCommand("INSERT INTO [Stiri] ([cod_user],[titlu], [descriere], [continut]) VALUES (@cod_user,@titlu, @descriere,@continut)", connection);
            command.Parameters.AddWithValue("cod_user", userGuid);
            command.Parameters.AddWithValue("titlu", titlu_stire.Text);
            command.Parameters.AddWithValue("continut", continut_stire.Text);
            command.Parameters.AddWithValue("descriere", descriere_stire.Text);
            try
            {
                command.ExecuteNonQuery();
                Response.Redirect("Stiri.aspx");

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