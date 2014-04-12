<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Profil.aspx.cs" Inherits="Profil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/myCss.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlConnection %>" SelectCommand="SELECT [Email] FROM [vw_aspnet_MembershipUsers]"></asp:SqlDataSource>
    <br />
    <div class="container" style="max-width: 1000px;">
        <div class="container" style="background-color: ghostwhite; max-width: 1000px;">

            <asp:LoginView ID="LoginView1" runat="server">
                <LoggedInTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" Visible="false">Editează</asp:HyperLink>
                </LoggedInTemplate>
            </asp:LoginView>
            <%--  aici pun eu tot ce vreau sa vada lumea pe pagina mea; cam ce am completat la Inregistrare --%>
            <asp:Label ID="LabelMesaj" runat="server"></asp:Label>


            <div id="continutPagina" runat="server">
                Pagina de profil
        <asp:Label ID="LabelNumeONG" runat="server" Text="" Font-Bold="True"></asp:Label><br />

                <asp:Label ID="LabelUserName" runat="server" Text="Username: "></asp:Label>
                <asp:Label ID="LabelUserNameCamp" runat="server" Text=""></asp:Label><br />


                <asp:Label ID="LabelEmail" runat="server" Text="E-mail de contact: "></asp:Label>
                <asp:Label ID="LabelEmailCamp" runat="server" Text=""></asp:Label><br />

                <asp:Label ID="LabelDescriere" runat="server" Text="Descrierea activităţii "></asp:Label><br />
                <asp:Label ID="LabelDescriereCamp" runat="server" Text=""></asp:Label><br />

                <asp:Label ID="LabelNrInregistrare" runat="server" Text="Numărul de înregistrare: "></asp:Label>
                <asp:Label ID="LabelNrInregistrareCamp" runat="server" Text=""></asp:Label><br />

                <asp:Label ID="LabelTipONGCamp" runat="server" Text=""></asp:Label>
                înfiinţată în anul
    <asp:Label ID="LabelAnCamp" runat="server" Text=""></asp:Label><br />

                <asp:Label ID="LabelProfil" runat="server" Text="Profilul ONG-ului "></asp:Label>
                <br />
                <asp:Label ID="LabelProfilCamp" runat="server" Text=""></asp:Label>
                <br />

                <asp:SqlDataSource ID="SqlDataSourceProiectePersonale" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT Proiecte.nume, Proiecte.id_proiect FROM [Proiecte]"></asp:SqlDataSource>
                Proiecte iniţiate:
        <br />

                <asp:ListView ID="ListView1" DataSourceID="SqlDataSourceProiectePersonale" runat="server">
                    <LayoutTemplate>
                        <div class="row" id="itemPlaceholder" runat="server">
                        </div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <a href="Proiect.aspx?id_proiect=<%# DataBinder.Eval(Container.DataItem,"id_proiect") %> "><%# DataBinder.Eval(Container.DataItem,"nume") %> </a></p>
                    </ItemTemplate>
                </asp:ListView>



                Proiecte la care a participat
        <br />
                <asp:SqlDataSource ID="SqlDataSourceProiecteParticipant" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT Proiecte.nume, Proiecte.id_proiect FROM User_are_Colaboratori INNER JOIN Proiecte ON User_are_Colaboratori.cod_proiect = Proiecte.id_proiect"></asp:SqlDataSource>
                <asp:ListView ID="ListView2" DataSourceID="SqlDataSourceProiecteParticipant" runat="server">
                    <LayoutTemplate>
                        <div class="row" id="itemPlaceholder" runat="server">
                        </div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <a href="Proiect.aspx?id_proiect=<%# DataBinder.Eval(Container.DataItem,"id_proiect") %> "><%# DataBinder.Eval(Container.DataItem,"nume") %> </a></p>
                    </ItemTemplate>
                </asp:ListView>
                

            </div>
        </div>

        <footer>
            <p>&copy; Company 2014</p>
        </footer>

    </div>
</asp:Content>

