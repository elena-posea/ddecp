<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Altcineva.aspx.cs" Inherits="Altcineva" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container" style="max-width: 1000px;">
        <div class="container" style="background-color: ghostwhite; max-width: 1000px;">
            De task-ul
            <asp:Label ID="LabelNrTask" runat="server" Text=""></asp:Label>
            propun să se ocupe
    <asp:TextBox ID="TextBoxUser" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Atribuie sarcina!" OnClick="Button1_Click" />
        <asp:Label ID="Raspuns" runat="server" Text=" "></asp:Label>
        </div>
    </div>
</asp:Content>

