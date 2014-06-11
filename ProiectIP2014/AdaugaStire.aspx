<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AdaugaStire.aspx.cs" Inherits="AdaugaStire" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container" style="background-color: ghostwhite;max-width: 1000px;">

         <asp:Label ID="StireLabel" runat="server" Text="Titlu"></asp:Label><br/>
         <asp:TextBox ID="titlu_stire" runat="server" Height="70px"  Width="60%" Rows="2" TextMode="MultiLine" ClientIDMode="Inherit"></asp:TextBox><br />
         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="titlu_stire" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator><br />

         <asp:Label ID="DescriereLabel" runat="server" Text="Descriere"></asp:Label><br />
         <asp:TextBox ID="descriere_stire" runat="server" Height="70px"  Width="60%" Rows="2" TextMode="MultiLine" ClientIDMode="Inherit"></asp:TextBox><br />
         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="descriere_stire" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator><br />

         <asp:Label ID="ContinutLabel" runat="server" Text="Continut"></asp:Label><br />
         <asp:TextBox ID="continut_stire" runat="server" Height="70px"  Width="60%" Rows="2" TextMode="MultiLine" ClientIDMode="Inherit"></asp:TextBox><br />
         <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="continut_stire" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator><br />
         
         <%--upload img--%>
         <asp:Label ID="Label7" runat="server" Text="Poza"></asp:Label><br />
            <form id="Form1" method="post" enctype="multipart/form-data" />
                <label for="Image">Se accepta doar imagini .jpg sub 4MB</label>
                <input type="file" id="File1" name="File1" runat="server">
                <br />
                <literal id="rasp_up" runat="server" text="asd"></literal>
            </form>
        <%--upload img--%>

         <asp:Button ID="AdaugaStireButton" runat="server" Text="Adauga stire" OnClick="Adauga_Stire" /><br />
         <asp:Literal ID="Raspuns" runat="server" Text=" "></asp:Literal>
         <br />
         <hr/>
         <footer>
           <p>&copy; Company 2014</p>
         </footer>
    </div>
</asp:Content>

