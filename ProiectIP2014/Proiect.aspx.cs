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

    private bool sunt_colaborator(string eu, string id_proiect) {
        try {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\ASPNETDB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();
            // vreau lista cu id-urile tututor colaboratorilor la acest proiect
            // SqlCommand getListCommand = new SqlCommand("SELECT cod_user FROM [User_are_Colaboratori] WHERE cod_proiect = " + id_proiect, connection);
            SqlCommand getListCommand = new SqlCommand("SELECT * FROM [User_are_Colaboratori]", connection);
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
}