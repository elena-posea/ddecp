<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Notificari.aspx.cs" Inherits="Notificari" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT aspnet_Users_1.UserId, aspnet_Users_1.UserName AS propus, Proiecte.id_proiect, Proiecte.nume, (SELECT UserName FROM aspnet_Users WHERE (UserId = User_are_Colaboratori.cod_user)) AS nume_colab, User_are_Colaboratori.cod_user, User_are_Colaboratori.cod_proiect FROM aspnet_Users AS aspnet_Users_1 INNER JOIN Proiecte ON aspnet_Users_1.UserId = Proiecte.cod_user INNER JOIN User_are_Colaboratori ON Proiecte.id_proiect = User_are_Colaboratori.cod_proiect where stare='inactiv'"></asp:SqlDataSource>
    <div class="container" style="background-color: #EEE; max-width: 1000px;">
        <asp:LoginView ID="LoginView1" runat="server">
            <RoleGroups>
                <asp:RoleGroup Roles="ONG">
                    <ContentTemplate>
                        <asp:Label ID="Raspuns" runat="server" Text=" "></asp:Label><br />
                        <br />
                        <asp:Button ID="ok" runat="server" OnClick="ok_Click" Visible="false" Text="OK" />

                        <asp:ListView ID="ListView1" DataSourceID="SqlDataSource1" runat="server">
                            <LayoutTemplate>
                                <div id="itemPlaceholder" runat="server"></div>
                            </LayoutTemplate>
                            <ItemSeparatorTemplate>
                                <hr />
                            </ItemSeparatorTemplate>
                            <ItemTemplate>
                                <p id="itemPlaceholder" runat="server">
                                    Organizatia 
                                    <a href="Profil.aspx?username=<%# DataBinder.Eval(Container.DataItem,"nume_colab") %>"><%# DataBinder.Eval(Container.DataItem,"nume_colab") %></a> 
                                    vrea sa devina colaborator la proiectul 
                                    <a href="Proiect.aspx?id_proiect=<%# DataBinder.Eval(Container.DataItem,"id_proiect") %>"><%# DataBinder.Eval(Container.DataItem,"nume") %></a></p>
                                <div class="btn-group">
                                    <asp:Button ID="acepta" runat="server" Text="Accepta" OnCommand="acepta_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_proiect") %>' CommandName='<%# DataBinder.Eval(Container.DataItem,"cod_user") %>' CssClass="btn btn-primary" />
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                        <asp:Label ID="Raspuns1" runat="server" Text=" "></asp:Label>

                    </ContentTemplate>
                </asp:RoleGroup>
            </RoleGroups>
        </asp:LoginView>
    </div>
</asp:Content>

