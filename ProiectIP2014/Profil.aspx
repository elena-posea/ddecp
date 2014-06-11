<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Profil.aspx.cs" Inherits="Profil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/myCss.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlConnection %>" SelectCommand="SELECT [Email] FROM [vw_aspnet_MembershipUsers]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="GETProfil" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand=""></asp:SqlDataSource>
    <br />
    <div class="container" style="max-width: 1000px;">
        <div class="jumbotron" style="max-width: 1000px;">
            <div style="padding-left:11px;">
                <asp:LoginView ID="LoginView1" runat="server">
                    <LoggedInTemplate>
                        <asp:HyperLink ID="HyperLink1"  class="btn btn-warning" runat="server" Visible="false">Editează</asp:HyperLink>
                    </LoggedInTemplate>
                </asp:LoginView>
            </div>
        <%--  aici pun eu tot ce vreau sa vada lumea pe pagina mea; cam ce am completat la Inregistrare --%>
            
            <asp:Label ID="LabelMesaj" runat="server"></asp:Label>
                <div id="continutPagina" runat="server">
                    <br />
                    <div class="col-xs-6 col-sm-3 placeholder" style="min-height:1000px;">
                        <img id="img_profil" data-src="holder.js/200x200/auto/sky" runat="server" class="img-responsive" src="profil_images/default.jpg" />
                    </div>
                    <div runat="server" style="max-width:700px;">
                        <form class="form-horizontal">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="LabelNumeONG" runat="server" Text="" Font-Bold="True"></asp:Label><br />
                                </legend>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-lg-4 control-label">Email</label> 
                                    <div class="col-lg-8">
                                        <asp:Label ID="inputEmail" class="form-control" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="UserName" class="col-lg-4 control-label">UserName</label> 
                                    <div class="col-lg-8">
                                        <asp:Label ID="userName" class="form-control" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="TipONG" class="col-lg-4 control-label">Tip ONG</label> 
                                    <div class="col-lg-8">
                                        <asp:Label ID="tipONG" class="form-control" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="Descriere" class="col-lg-4 control-label">Descriere</label> 
                                    <div class="col-lg-8">
                                        <asp:TextBox ID="descriere"  runat="server" TextMode="MultiLine"  ReadOnly="true" style='background-color:white' class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="anCamp" class="col-lg-4 control-label">Anul infiintarii</label> 
                                    <div class="col-lg-8">
                                        <asp:Label ID="anCamp" class="form-control" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="profilCamp" class="col-lg-4 control-label">Profil</label> 
                                    <div class="col-lg-8">
                                        <asp:Label ID="profilCamp" class="form-control" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="nrCamp" class="col-lg-4 control-label">Profil</label> 
                                    <div class="col-lg-8">
                                        <asp:Label ID="nrCamp" class="form-control" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                        <asp:SqlDataSource ID="SqlDataSourceProiectePersonale" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT Proiecte.nume, Proiecte.id_proiect FROM [Proiecte]"></asp:SqlDataSource>
                          <br />
                          <label class="control-label">    Proiecte iniţiate: </label>
                                              
                        <asp:ListView ID="ListView1" DataSourceID="SqlDataSourceProiectePersonale" runat="server">
                           <LayoutTemplate>    
                               <div id="itemPlaceholder" runat ="server">
                                   <br />
                                </div>
                             </LayoutTemplate>
                          <ItemTemplate>   
                              <div id="itemPlaceholder" runat ="server">
                                  <span class="glyphicon glyphicon-ok"></span>
                                <a href="Proiect.aspx?id_proiect=<%# DataBinder.Eval(Container.DataItem,"id_proiect") %> "><%# DataBinder.Eval(Container.DataItem,"nume") %> </a>
                                <br />  
                              </div>
                              </ItemTemplate>
                         </asp:ListView>
                                
                       
                        

                        <label class="control-label">Proiecte la care a participat </label>
                        <br />
                        <asp:SqlDataSource ID="SqlDataSourceProiecteParticipant" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT Proiecte.nume, Proiecte.id_proiect FROM User_are_Colaboratori INNER JOIN Proiecte ON User_are_Colaboratori.cod_proiect = Proiecte.id_proiect"></asp:SqlDataSource>
                        <asp:ListView ID="ListView2" DataSourceID="SqlDataSourceProiecteParticipant" runat="server">
                            <LayoutTemplate>
                                <div class="row" id="itemPlaceholder" runat="server">
                                    <br />
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <div id="itemPlaceholder" runat="server">
                                    <span class="glyphicon glyphicon-ok"></span>
                                    <a href="Proiect.aspx?id_proiect=<%# DataBinder.Eval(Container.DataItem,"id_proiect") %> "><%# DataBinder.Eval(Container.DataItem,"nume") %> </a></p>
                                    <br />
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <p>&copy; Company 2014</p>
        </footer>

</asp:Content>

