<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/myCss.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="GETProiectePersonale" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand=""></asp:SqlDataSource>
    <asp:SqlDataSource ID="GETProiecteParticip" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand=""></asp:SqlDataSource>
    <div class="container" runat="server" style="max-width: 1000px;">
        <asp:LoginView ID="LoginView1" runat="server">
            <AnonymousTemplate>
                <div class="row row-offcanvas row-offcanvas-right" runat="server">
                    <div class="col-xs-12 col-sm-9" runat="server">
                        <p class="pull-right visible-xs">
                            <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>
                        </p>
                    <div class="jumbotron">
                        <h2>Bine ati venit!</h2>
                        <p>Obiectivul acestui proiect este acela de a coagula organizațiile non-guvernamentale românești de tineret oferind 
                           baza necesară pentru susținerea comunităților de români de 
                           pretutindeni. Scopul va fi atins prin dezvoltarea unui instrument online ușor accesibil și interactiv 
                           orientat spre promovarea imaginii României și a valorilor naționale. 
                           Asociațiilor românești se vor inregistra în cadrul acestei platforme și vor putea participa continuu 
                           la dezvoltarea acesteia prin adaugare sau modificare de conținut. Totodata proiectul va conduce la 
                           o mai bună comunicare între organizații, respectiv între comunitățile românești de pretutindeni.
                        </p>
                        <a class="btn btn-primary btn-lg" href="LogIn.aspx">Log in</a>
                        <a class="btn btn-danger btn-lg" href="Inregistrare.aspx">Inregistrare</a>
                    </div>
                </div><!--/span--> 
            </div> 
            </AnonymousTemplate>  
            
            <RoleGroups>
                <asp:RoleGroup Roles="ONG">
                    <ContentTemplate>
                        <div class="row row-offcanvas row-offcanvas-right" runat="server"> 
                            <div class="col-xs-12 col-sm-9">
                                <p class="pull-right visible-xs">
                                <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>
                                </p>
                                <div class="jumbotron">                                 
                                    <h3 class= "alert alert-danger">Proiectele tale</h3>
                                    <div class="row">
                                        <asp:ListView ID="ListProiecteInitiate" DataSourceID="GETProiectePersonale" runat="server">
                                            <LayoutTemplate>
                                                <div class="row" id="itemPlaceholder" runat="server">
                                                Nu ai participat la nici un proiect.
                                                </div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="col-6 col-sm-6 col-lg-4" id="itemPlaceholder" runat="server">
                                                   <div class="panel panel-primary" runat="server">
                                                       <div class="panel-heading"  runat="server">
                                                           <%# DataBinder.Eval(Container.DataItem,"nume") %>
                                                       </div>
                                                       <div class="panel-body" runat="server">
                                                           <img runat="server" class="thumb_small_img"  visible='<%# imgExists( DataBinder.Eval(Container.DataItem,"id_proiect").ToString() ) %>' src='<%# getImgSrc( DataBinder.Eval(Container.DataItem,"id_proiect").ToString() ) %>'/>
                                                            <%# DataBinder.Eval(Container.DataItem,"descriere") %>
                                                            <div class="clearfix"> </div>
                                                            <div class="btn-group">
                                                                <asp:Button ID="Vizualizeaza_proiect" runat="server" Text="Vezi detalii &raquo;" OnCommand="Vizualizeaza_Proiect_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_proiect") %>' CssClass="btn btn-primary" />
                                                            </div>
                                                        </div>
                                                   </div>
                                                   <br /> 
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>
                                     </div>
                                </div> 
                            </div> 
                           
                            <div class="col-xs-6 col-sm-3 sidebar-offcanvas" runat="server" id="sidebar" role="navigation">
                                <div class="list-group" runat="server">
                                    <a href="#" class="list-group-item active">Proiectele aflate in desfasurare</a>
                                    <asp:SqlDataSource ID="SqlDataSourceProiecteParticipant" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT SUBSTRING(Proiecte.nume,0,30) as nume, Proiecte.id_proiect FROM User_are_Colaboratori INNER JOIN Proiecte ON User_are_Colaboratori.cod_proiect = Proiecte.id_proiect"></asp:SqlDataSource>
                                        <asp:ListView ID="ListView2" DataSourceID="SqlDataSourceProiecteParticipant" runat="server">
                                            <LayoutTemplate>
                                                <a id="itemPlaceholder" runat="server">
                                                        
                                                </a>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <a class="list-group-item" href="Proiect.aspx?id_proiect=<%# DataBinder.Eval(Container.DataItem,"id_proiect") %> "><%# DataBinder.Eval(Container.DataItem,"nume") %> ...</a>
                                            </ItemTemplate>
                                    </asp:ListView>
                                    <a href="#" class="list-group-item active">Mesaje</a>
                                    <a href="Mesaje_main.aspx" class="list-group-item">Conversatiile mele</a>
                                    <a href="Mesaje_new.aspx" class="list-group-item">Conversatie noua</a>
                                    <a href="Mesaje_caut.aspx" class="list-group-item">Cauta in conversatii</a>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:RoleGroup>
            </RoleGroups>
        </asp:LoginView>
        <hr />
        <footer>
            <p>&copy; Company 2014</p>
        </footer>
    </div><!--/.container-->
</asp:Content>

