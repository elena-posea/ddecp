<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EditareProfil.aspx.cs" Inherits="EditareProfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlConnection %>" SelectCommand="SELECT [Email] FROM [vw_aspnet_MembershipUsers]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="GETProfil" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand=""></asp:SqlDataSource>
    <br />
    <div class="container" style="max-width: 1000px;">
        <div class="jumbotron" style="max-width: 1000px;">
     
        <%--  aici pun eu tot ce vreau sa vada lumea pe pagina mea; cam ce am completat la Inregistrare --%>
            
            <asp:Label ID="LabelMesaj" runat="server"></asp:Label>
                <div id="continutPagina" runat="server">
                    <br />
                    <div class="col-xs-6 col-sm-3 placeholder" style="min-height:1000px;" >
                        <img id="img_profil" data-src="holder.js/200x200/auto/sky" runat="server" class="img-responsive" src="profil_images/default.jpg" />
                        <%--upload img--%>
                        <%--<form id="Form1" method="post" enctype="multipart/form-data" />
                            <legend>Schimba poza:</legend>
                            <label for="Image">Se accepta doar imagini .jpg sub 4MB</label>
                            <input type="file" id="File1" name="File1" runat="server">
                            <br />0
                            <asp:Button ID="b_upload_img" runat="server" Text="Upload" onclick="upload_pic" />
                            <literal id="rasp_up" runat="server" text="asd"></literal>
                        </form>--%>
                        <form id="Form1" method="post" enctype="multipart/form-data" />
                            <label for="Image">Se accepta doar imagini .jpg sub 4MB</label>
                            <input type="file" id="File1" name="File1" runat="server">
                            <br />
                            <literal id="rasp_up" runat="server" text="">Schimbarea pozei poate dura cateva minute in functie de cache!</literal>
                        </form>
                        <%--upload img--%>
                    </div>
                    <div id="Div1" runat="server" style="max-width:700px;">
                        <div class="form-horizontal">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="LabelNumeONG" runat="server" Text="" Font-Bold="True"></asp:Label><br />
                                </legend>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-lg-4 control-label">Email</label> 
                                    <div class="col-lg-8">
                                        <asp:Label ID="inputEmail" class="form-control" runat="server"></asp:Label>
                                        <br />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="UserName" class="col-lg-4 control-label">UserName</label> 
                                    <div class="col-lg-8">
                                        <asp:Label ID="userName" class="form-control" runat="server"></asp:Label>
                                           <br />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="TipONG" class="col-lg-4 control-label">Tip ONG</label> 
                                    <div class="col-lg-8">
                                        <asp:TextBox ID="tipONG" class="form-control" runat="server"></asp:TextBox>
                                           <br />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="Descriere" class="col-lg-4 control-label">Descriere</label> 
                                    <div class="col-lg-8">
                                        <asp:TextBox ID="descriere" class="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorDescriere" runat="server" ErrorMessage="Descrierea activităţii ONG-ului este obligatorie" ControlToValidate="descriere"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="anCamp" class="col-lg-4 control-label">Anul infiintarii</label> 
                                    <div class="col-lg-8">
                                        <asp:TextBox ID="anCamp" class="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorAn" runat="server" ErrorMessage="Anul înfiinţării este obligatoriu" ControlToValidate="anCamp" ViewStateMode="Disabled" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareValidatorAn" runat="server" ErrorMessage="Trebuie să fie an" ControlToValidate="anCamp" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="profilCamp" class="col-lg-4 control-label">Profil</label> 
                                    <div class="col-lg-8">
                                        <asp:TextBox ID="profilCamp" class="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Profilul ONG-ului este obligatoriu" ControlToValidate="profilCamp"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="nrCamp" class="col-lg-4 control-label">Profil</label> 
                                    <div class="col-lg-8">
                                        <asp:TextBox ID="nrCamp" class="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorNrInregistrare" runat="server" ErrorMessage="Numărul de înregistrare este obligatoriu" ControlToValidate="nrCamp" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareValidatorNrInregistrare" runat="server" ErrorMessage="Trebuie să fie număr" ControlToValidate="nrCamp" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
            
                                    </div>
                                </div>
                                <div>    
                                    <asp:Button ID="ButtonUpdate" runat="server" Text="Actualizează!" OnClick="ButtonUpdate_Click" />

                                </div>
                            </fieldset>
                        </div> 
                                         
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <p>&copy; Company 2014</p>
        </footer>

</asp:Content>



