using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Proiect : System.Web.UI.Page {
    private static string id_proiect;
    protected void Page_Load(object sender, EventArgs e) {
        if (!Page.IsPostBack) {
            id_proiect = Request.Params["id_proiect"];
            if (id_proiect != null) {
                SqlDataSource1.SelectCommand = "SELECT Proiecte.id_proiect, Proiecte.cod_user, CONVERT (Date, Proiecte.data_inceput) AS data_i, CONVERT (Date, Proiecte.data_sfarsit) AS data_sfarsit, Proiecte.nume, Proiecte.descriere, Proiecte.continut, Proiecte.domeniu, aspnet_Users.UserName FROM Proiecte INNER JOIN aspnet_Users ON Proiecte.cod_user = aspnet_Users.UserId where id_proiect = " + Server.UrlDecode(id_proiect) + ";";
                // SqlDataSourceTask.SelectCommand = "SELECT * FROM [Tasks] WHERE cod_proiect = " + id_proiect + "ORDER BY [deadline]";
                SqlDataSourceTask.SelectCommand = "SELECT t.id_task, t.cod_initiator, t.cod_asignat, t.cod_proiect, t.descriere, t.nr_voluntari, t.deadline, stare FROM Tasks AS t WHERE t.cod_proiect = " + id_proiect + "ORDER BY [deadline]";
                // daca sunt logat
                if (HttpContext.Current.User.Identity.IsAuthenticated) {
                    SqlDataSourceListaComentarii.SelectCommand = "SELECT * FROM [Comentarii_Proiect] WHERE cod_proiect = " + id_proiect;
                    SqlDataSourceListaComentarii.DataBind();
                    string eu = Membership.GetUser(Profile.UserName).ProviderUserKey.ToString();
                    if (eu_am_propus_proiectul(eu, id_proiect)) {
                        // scriu cu o culoare mai tare, eu am propus proiectul
                        Raspuns.Text = "eu l-am propus";
                    }
                    else {
                        // daca sunt colaborator acceptat/sunt in bd 
                        if (sunt_colaborator(eu, id_proiect)) {
                            // scriu cu o anumita culoare, de colaborator
                            Raspuns.Text = "eu sunt colaborator";
                        }
                        else LoginViewComentarii.Visible = false;
                        // Raspuns.Text = "eu sunt " + eu;
                    }


                }
                else {
                    LoginViewComentarii.Visible = false;
                }
            }
        }

    }

    private bool eu_am_propus_proiectul(string eu, string id_proiect) {
        SqlConnection connection = new SqlConnection();
        connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.MDF;Integrated Security=True;User Instance=True";
        connection.Open();
        // vreau sa stiu id-ul celui care a propus proiectul
        SqlCommand getIDCommand = new SqlCommand("SELECT cod_user FROM [Proiecte] WHERE id_proiect = " + id_proiect, connection);
        SqlDataReader dr = getIDCommand.ExecuteReader();

        if (dr.Read()) { // daca exista proiect cu id-ul dat
            //Raspuns.Text = dr[0].ToString() + " a propus proiectul";
            if (dr[0].ToString() == eu) return true;
        }
        // Debug.Write(dr[0].ToString() + " a propus proiectul");
        dr.Close();
        connection.Close();
        return false;

    }


    protected bool eu_am_propus_taskul(string eu, string id_task) {
        SqlConnection connection = new SqlConnection();
        connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.MDF;Integrated Security=True;User Instance=True";
        connection.Open();
        // vreau sa stiu id-ul celui care a propus proiectul
        SqlCommand getIDCommand = new SqlCommand("SELECT cod_initiator FROM [Tasks] WHERE id_task = " + id_task, connection);
        SqlDataReader dr = getIDCommand.ExecuteReader();

        if (dr.Read()) { // daca exista proiect cu id-ul dat
            //Raspuns.Text = dr[0].ToString() + " a propus proiectul";
            if (dr[0].ToString() == eu) return true;
        }
        // Debug.Write(dr[0].ToString() + " a propus proiectul");
        dr.Close();
        connection.Close();
        return false;

    }


    private bool sunt_colaborator(string eu, string id_proiect) {
        try { // si sunt si acceptat
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();
            // vreau lista cu id-urile tututor colaboratorilor la acest proiect
            SqlCommand getListCommand = new SqlCommand("SELECT cod_user FROM [User_are_Colaboratori] WHERE cod_proiect = " + id_proiect + " AND stare='activ'", connection);
            SqlDataReader dr = getListCommand.ExecuteReader();
            while (dr.Read()) { // daca mai am colaboratori
                // Debug.Write(dr[0].ToString() + " e colaborator\n");
                //Raspuns.Text += "<br /> " + dr[0].ToString();
                if (dr[0].ToString() == eu) return true;
            }
            dr.Close();
            connection.Close();
            // Debug.Write("id_proiect = " + id_proiect);
        }
        catch (Exception ex) {
            Debug.Write("am prins " + ex);
        }
        return false;
    }

    protected void adaugaComentariu(object sender, EventArgs e) {
        SqlConnection connection = new SqlConnection();
        connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.MDF;Integrated Security=True;User Instance=True";
        connection.Open();
        String q;
        q = "INSERT INTO [Comentarii_Proiect] ([cod_user], [cod_proiect], [continut], [data]) VALUES (@cod_user, @cod_proiect, @continut, @data);";
        SqlCommand commandComentariu = new SqlCommand(q, connection);
        //if (HttpContext.Current.User.Identity.IsAuthenticated) {
        commandComentariu.Parameters.AddWithValue("cod_user", Membership.GetUser(Profile.UserName).ProviderUserKey);
        //}
        commandComentariu.Parameters.AddWithValue("cod_proiect", id_proiect);
        string continut = (LoginViewComentarii.FindControl("TextBoxContinut") as TextBox).Text;

        commandComentariu.Parameters.AddWithValue("continut", continut);
        commandComentariu.Parameters.AddWithValue("data", System.DateTime.Now);

        commandComentariu.ExecuteNonQuery();

        connection.Close();
        //Raspuns.Text = "Articolul a fost inserat cu succes! ";
        //Raspuns.CssClass = "ok";
        SqlDataSourceListaComentarii.SelectCommand = "SELECT * FROM [Comentarii_Proiect] WHERE cod_proiect = " + id_proiect;
        SqlDataSourceListaComentarii.DataBind();
        (LoginViewComentarii.FindControl("RepeaterComentarii") as Repeater).DataBind();


    }

    protected String getUserNameFromID(String id_user_editor) {
        SqlConnection connection = new SqlConnection();
        connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.MDF;Integrated Security=True;User Instance=True";
        connection.Open();
        SqlCommand commandGetUser = new SqlCommand("SELECT UserName FROM aspnet_Users where CAST(UserId AS VARCHAR(50)) = '" + id_user_editor + "'", connection);
        if (commandGetUser.ExecuteScalar() == null) return "***";
        return (commandGetUser.ExecuteScalar()).ToString();
    }

    protected bool seOcupaDejaCinevaDeTask(int id_task) {
        SqlConnection connection = new SqlConnection();
        connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.MDF;Integrated Security=True;User Instance=True";
        connection.Open();
        SqlCommand command = new SqlCommand("SELECT cod_asignat FROM Tasks where id_task = " + id_task + " AND cod_asignat is not null", connection);
        if (command.ExecuteScalar() != null) return true;
        return false;
    }

    protected void adauga_task_Click(object sender, EventArgs e) {
        id_proiect = Request.Params["id_proiect"];

        Response.Redirect("~/AdaugaTask.aspx?id_proiect=" + id_proiect);
        //Raspuns1.Text = Membership.GetUser().ProviderUserKey.ToString();

    }

    protected void editeaza_task_Command(object sender, CommandEventArgs e) {
        Response.Redirect("EditareTask.aspx?id_task=" + e.CommandArgument + "&id_proiect=" + id_proiect);
    }
    protected void sterge_task_Command(object sender, CommandEventArgs e) {
        try {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            SqlCommand command = new SqlCommand("DELETE FROM [Tasks] WHERE @id_task = id_task;", connection);
            command.Parameters.AddWithValue("id_task", Convert.ToInt32(e.CommandArgument));

            try {
                command.ExecuteNonQuery();
                Response.Redirect("~/Proiect.aspx?id_proiect=" + id_proiect);


            }
            catch (SqlException ex) {
                Raspuns.Text = ex.Message;
            }
        }
        catch (Exception ex) {
            Raspuns.Text = ex.Message.ToString();
        }
    }

    protected void ma_ocup_eu_Command(object sender, CommandEventArgs e) {
        try {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            SqlCommand command = new SqlCommand("UPDATE Tasks SET [cod_asignat]=@cod_asignat where [id_task] = @id_task ;", connection);
            command.Parameters.AddWithValue("id_task", Convert.ToInt32(e.CommandArgument));
            command.Parameters.AddWithValue("cod_asignat", Membership.GetUser(Profile.UserName).ProviderUserKey);

            try {
                command.ExecuteNonQuery();
                Response.Redirect("~/Proiect.aspx?id_proiect=" + Request.Params["id_proiect"]);
            }
            catch (SqlException sqlex) {
                Raspuns.Text = sqlex.Message;
            }

            connection.Close();
        }
        catch (SqlException sqlex) {
            Raspuns.Text = sqlex.Message;
        }
    }

    protected bool nu_e_terminat(string id_task) {

        try {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            SqlCommand command = new SqlCommand("SELECT stare, deadline FROM Tasks WHERE deadline <= GETDATE() AND id_task=" + id_task, connection);

            try {

                SqlDataReader r = command.ExecuteReader();
                if (!r.Read()) return false;
                if (r["stare"].ToString().Equals("inactiv")) {
                    return false;
                }
            }
            catch (SqlException ex) {
                Raspuns1.Text = ex.Message;
            }
            connection.Close();

        }

        catch (SqlException sqlex) {
            Raspuns1.Text = sqlex.Message;
        }


        return true;
    }

    protected void terminat_Command(object sender, CommandEventArgs e) {
        try {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            int id_task = Convert.ToInt32(Request.Params["id_task"]);
            SqlCommand command = new SqlCommand("UPDATE Tasks SET [stare]='inactiv'where [id_task] = @id_task ;", connection);
            command.Parameters.AddWithValue("id_task", Convert.ToInt32(e.CommandArgument));

            try {
                command.ExecuteNonQuery();

                //Repeater rp = (Repeater)LoginViewComentarii.FindControl("Repeater2");
                //Raspuns1.Text = rp.ID.ToString();

                //Button bt = (Button)rp.FindControl("Button1");

                //Raspuns1.Text = bt.ID.ToString();


                Response.Redirect("~/Proiect.aspx?id_proiect=" + Request.Params["id_proiect"]);

            }
            catch (SqlException sqlex) {
                Raspuns.Text = sqlex.Message;
            }

            connection.Close();
        }
        catch (SqlException sqlex) {
            Raspuns.Text = sqlex.Message;
        }
    }
}