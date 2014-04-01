<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EditareProfil.aspx.cs" Inherits="EditareProfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <%-- trebuie sa fie cam aceleasi campuri ca si pr profil de vazut, doar ca aici pot sa le si editez; in plus aici pot sa-mi schimb si parola --%>
    <table class="formular">
        <tr>
            <td colspan="2">Editare profil
                <asp:Label ID="LabelUserName" runat="server" Text=""></asp:Label>
            
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelNumeONG" runat="server" Text="Nume ONG "></asp:Label>            
            </td>
            <td>
                <asp:Label ID="LabelNumeONGCamp" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelEmail" runat="server" Text="E-mail "></asp:Label></td>
            <td>
                <asp:Label ID="LabelEmailCamp" runat="server"></asp:Label>
            </td>
        </tr>

        <tr>
            <td>
                <asp:Label ID="LabelDescriere" runat="server" Text="Descrierea activităţii "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxDescriere" runat="server" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorDescriere" runat="server" ErrorMessage="Descrierea activităţii ONG-ului este obligatorie" ControlToValidate="TextBoxDescriere"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelNrInregistrare" runat="server" Text="Numărul de înregistrare "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxNrInregistrare" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorNrInregistrare" runat="server" ErrorMessage="Numărul de înregistrare este obligatoriu" ControlToValidate="TextBoxNrInregistrare" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidatorNrInregistrare" runat="server" ErrorMessage="Trebuie să fie număr" ControlToValidate="TextBoxNrInregistrare" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td>Tip ONG
            </td>
            <td>
                <asp:DropDownList ID="DropDownListTip" runat="server">
                    <asp:ListItem Text="Asociaţie" Value="1"> Asociaţie </asp:ListItem>
                    <asp:ListItem Text="Fundaţie" Value="2"> Fundaţie </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelAn" runat="server" Text="Anul înfiinţării "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxAn" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorAn" runat="server" ErrorMessage="Anul înfiinţării este obligatoriu" ControlToValidate="TextBoxAn" ViewStateMode="Disabled" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidatorAn" runat="server" ErrorMessage="Trebuie să fie an" ControlToValidate="TextBoxAn" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td></td>
            <td></td>
        </tr>

        <tr>
            <td>
                <asp:Label ID="LabelProfil" runat="server" Text="Profil ONG "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxProfil" runat="server"></asp:TextBox>
            </td>
        </tr>

    </table>
    <asp:Button ID="ButtonUpdate" runat="server" Text="Actualizează!" OnClick="ButtonUpdate_Click" />
</asp:Content>

