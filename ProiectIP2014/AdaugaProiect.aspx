<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AdaugaProiect.aspx.cs" Inherits="AdaugaProiect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container" style="background-color: ghostwhite;max-width: 1000px;">
         <asp:Label ID="Label1" runat="server" Text="Titlu"></asp:Label><br/>
         <asp:TextBox ID="titlu_proiect" runat="server" Height="70px"  Width="60%" Rows="2" TextMode="MultiLine" ClientIDMode="Inherit"></asp:TextBox><br />
         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="titlu_proiect" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator><br />

         <asp:Label ID="Label2" runat="server" Text="Descriere"></asp:Label><br />
         <asp:TextBox ID="descriere_proiect" runat="server" Height="70px"  Width="60%" Rows="2" TextMode="MultiLine" ClientIDMode="Inherit"></asp:TextBox><br />
         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="descriere_proiect" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator><br />

         <asp:Label ID="Label6" runat="server" Text="Continut"></asp:Label><br />
         <asp:TextBox ID="continut_proiect" runat="server" Height="70px"  Width="60%" Rows="2" TextMode="MultiLine" ClientIDMode="Inherit"></asp:TextBox><br />
         <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="continut_proiect" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator><br />

         
         <asp:Label ID="Label3" runat="server" Text="Domeniu"></asp:Label><br />
         <asp:TextBox ID="domeniu_proiect" runat="server" Height="70px"  Width="60%" Rows="2" TextMode="MultiLine" ClientIDMode="Inherit"></asp:TextBox><br />
         <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="domeniu_proiect" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator><br />

         <asp:Label ID="Label4" runat="server" Text="Data inceput"></asp:Label><br />
         <asp:Calendar ID="data_inceput" runat="server" ></asp:Calendar><br />
        <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="data_inceput" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>--%>

         <asp:Label ID="Label5" runat="server" Text="Data sfarsit"></asp:Label><br />
         <asp:Calendar ID="data_sfarsit" runat="server" ></asp:Calendar><br />
         <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="data_sfarsit" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>--%>


         <%--upload img--%>
         <asp:Label ID="Label7" runat="server" Text="Poza"></asp:Label><br />
            <form id="Form1" method="post" enctype="multipart/form-data" />
                <label for="Image">Se accepta doar imagini .jpg sub 4MB</label>
                <input type="file" id="File1" name="File1" runat="server">
                <br />
                <literal id="rasp_up" runat="server" text="asd"></literal>
            </form>
        <%--upload img--%>
         
         <asp:Button ID="Button1" runat="server" Text="Adauga proiectul" OnClick="Button1_Click" /><br />
          <asp:Literal ID="Raspuns" runat="server" Text=" "></asp:Literal>
         <br />

         <hr/>

          <footer>
            <p>&copy; Company 2014</p>
          </footer>


    </div>
</asp:Content>

