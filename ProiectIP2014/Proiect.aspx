<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Proiect.aspx.cs" Inherits="Proiect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT Proiecte.id_proiect, Proiecte.cod_user, CONVERT (Date, Proiecte.data_inceput) AS data_i, CONVERT (Date, Proiecte.data_sfarsit) AS data_sfarsit, Proiecte.nume, Proiecte.descriere, Proiecte.continut, Proiecte.domeniu, aspnet_Users.UserName FROM Proiecte INNER JOIN aspnet_Users ON Proiecte.cod_user = aspnet_Users.UserId"></asp:SqlDataSource>
    <div class="container" style=" max-width: 1000px;">
    <div class="container" style="background-color: ghostwhite; max-width: 1000px;">
        <asp:Repeater ID="Repeater1" DataSourceID="SqlDataSource1" runat="server">
            <ItemTemplate>
                <h2><%# DataBinder.Eval(Container.DataItem,"nume") %></h2>
                <p class="text-danger"><%# DataBinder.Eval(Container.DataItem,"data_i") %> -- <%# DataBinder.Eval(Container.DataItem,"data_sfarsit") %></p>
                <p><%# DataBinder.Eval(Container.DataItem,"descriere") %> </p>
                p><%# DataBinder.Eval(Container.DataItem,"continut") %> </p>
                
             </ItemTemplate>
         </asp:Repeater> 
       
        <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
            
                 <hr />
                 <asp:TextBox ID="TextBox1" runat="server" Width="50%" Height="50px" TextMode="MultiLine"></asp:TextBox><br />
                 <asp:Button CssClass="btn-default" ID="AddCommentButton"  runat="server" Text="Adauga un comentariu" />
                 <hr />
                    
            </LoggedInTemplate>
          </asp:LoginView>
        
        <asp:Label ID="Raspuns" runat="server" Text=" "></asp:Label> 
    </div>
    
         <footer>
        <p>&copy; Company 2014</p>
      </footer>
    </div>
</asp:Content>

