using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditareTask : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Page.IsPostBack == false) && Request.Params["id_task"] != null)
        {
            try
            {
                SqlConnection connection = new SqlConnection();
                connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
                connection.Open();

                SqlCommand command = new SqlCommand("SELECT descriere, nr_voluntari, deadline from Tasks where id_task=@id_task", connection);
                command.Parameters.AddWithValue("id_task", Request.Params["id_task"]);

                try
                {
                    SqlDataReader r = command.ExecuteReader();
                    if (r.Read())
                    {
                        descriere.Text = r["descriere"].ToString();
                        nr_voluntari.Text = r["nr_voluntari"].ToString();
                        deadline.SelectedDate = Convert.ToDateTime(r["deadline"]);
                    }
                }
                catch (SqlException ex)
                {
                    Raspuns.Text = ex.Message;
                }
                connection.Close();

            }

            catch (SqlException sqlex)
            {
                Raspuns.Text = sqlex.Message;
            }

        }
    }
    protected void editeaza_task_Click(object sender, EventArgs e)
    {
        try
        {
           SqlConnection connection = new SqlConnection();
           connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
           connection.Open();
           
           int id_task = Convert.ToInt32(Request.Params["id_task"]);
           SqlCommand command = new SqlCommand("UPDATE Tasks SET [descriere]=@descriere,[nr_voluntari]=@nr_voluntari,[deadline]=@deadline where [id_task] = "+id_task+";",connection);
           command.Parameters.AddWithValue("descriere", descriere.Text);
           command.Parameters.AddWithValue("nr_voluntari", Convert.ToInt32(nr_voluntari.Text));
           command.Parameters.AddWithValue("deadline", deadline.SelectedDate);
           
            try
            {
                command.ExecuteNonQuery();
                Response.Redirect("~/Proiect.aspx?id_proiect="+Request.Params["id_proiect"]);

            }
            catch (SqlException sqlex)
            {
                Raspuns.Text = sqlex.Message;
            }
           
            connection.Close();
        }
        catch (SqlException sqlex)
        {
            Raspuns.Text = sqlex.Message;
        }

       
    }
}