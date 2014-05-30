<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Stire.aspx.cs" Inherits="Stire" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/myCss.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT Stiri.id_stire, Stiri.cod_user, Stiri.titlu, Stiri.descriere, Stiri.continut, aspnet_Users.UserName FROM Stiri INNER JOIN aspnet_Users ON Stiri.cod_user = aspnet_Users.UserId"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceListaComentarii" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>'></asp:SqlDataSource>
    <div class="container" style="max-width: 1000px;">
        <div class="container" style="background-color: #EEE; max-width: 1000px;">
            <asp:Repeater ID="Repeater1" DataSourceID="SqlDataSource1" runat="server">
                <ItemTemplate>
                    <h2><%# DataBinder.Eval(Container.DataItem,"titlu") %></h2>
                    <p><%# DataBinder.Eval(Container.DataItem,"descriere") %> </p>
                    <p>
                        <img id="img_p" runat="server" class="project_img"  visible="<%# imgExists() %>" src="<%# getImgSrc() %>"/>
                        <%# DataBinder.Eval(Container.DataItem,"continut") %>
                    </p>
                
                </ItemTemplate>
            </asp:Repeater>

            
            <asp:Label ID="Raspuns" runat="server" Text=" "></asp:Label>
            </div>

            <footer>
                 <p>&copy; Company 2014</p>
             </footer>
    </div>
</asp:Content>

