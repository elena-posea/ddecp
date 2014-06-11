<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Mesaje_main.aspx.cs" Inherits="Mesaje1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container" style="max-width: 1000px;">
        <div id="asd" runat="server">

        </div>
        <asp:LoginView ID="LoginView2" runat="server">
            <AnonymousTemplate>
                  <div class="jumbotron">
                    <p>Trebuie sa fii logat pentru a putea trimite mesaje!</p>
                  </div>
            </AnonymousTemplate>

            <RoleGroups>
                <asp:RoleGroup Roles="ONG">
                    <ContentTemplate>
                        <%--SideBar - Stanga--%>
                        <div class="col-xs-3 container" id="sidebar_left" role="navigation">
                          <div class="list-group">
                                <%--conv cu mesaje necitite--%>
                                <a href="#" class="list-group-item active"">Mesaje necitite:</a>
                                <asp:ListView ID="ListView2" runat="server" DataSourceID="SqlDataSourceNeCitite">
                                  <ItemTemplate>
                                      <asp:HyperLink ID="HyperLink1" CssClass="list-group-item" ForeColor="#a94442" runat="server"
                                          NavigateUrl='<%# String.Format("Mesaje_new.aspx?to={0}", (DataBinder.Eval(Container.DataItem,"UserN").ToString())) %>' > 
                                           <%# DataBinder.Eval(Container.DataItem, "UserN").ToString() + " (" + DataBinder.Eval(Container.DataItem, "nrC").ToString() + "/" + DataBinder.Eval(Container.DataItem, "nrC2").ToString() + ")" %>  
                                      </asp:HyperLink>
                                  </ItemTemplate>
                                  <EmptyDataTemplate>
                                      <a href="#" class="list-group-item">Niciun mesaj necitit!</a>
                                  </EmptyDataTemplate>
                              </asp:ListView>

                              <%--conversatii vechi--%>
                              <a href="#" class="list-group-item active">Conversatii vechi:</a>
                              <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSourceCitite">
                                  <ItemTemplate>
                                      <asp:HyperLink ID="HyperLink1" CssClass="list-group-item" runat="server"
                                          NavigateUrl='<%# String.Format("Mesaje_new.aspx?to={0}", (DataBinder.Eval(Container.DataItem,"UserN").ToString())) %>' > 
                                           <%# DataBinder.Eval(Container.DataItem, "UserN").ToString() + " (" + DataBinder.Eval(Container.DataItem, "nrC2").ToString() + ")" %>  
                                      </asp:HyperLink>
                                  </ItemTemplate>
                                  <EmptyDataTemplate>
                                      <a href="#" class="list-group-item">Nicio conversatie veche!</a>
                                  </EmptyDataTemplate>
                              </asp:ListView>
                              <asp:SqlDataSource runat="server" ID="SqlDataSourceNeCitite" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT aspnet_Users.UserName as UserN, COUNT(*) AS nrC FROM aspnet_Users INNER JOIN Conversatii ON aspnet_Users.UserId = Conversatii.cod_receiver GROUP BY aspnet_Users.UserName"> </asp:SqlDataSource>
                              <asp:SqlDataSource runat="server" ID="SqlDataSourceCitite" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT aspnet_Users.UserName as UserN, COUNT(*) AS nrC FROM aspnet_Users INNER JOIN Conversatii ON aspnet_Users.UserId = Conversatii.cod_receiver GROUP BY aspnet_Users.UserName"> </asp:SqlDataSource>
                              
                            
                          </div>
                        </div><!--/span-->

                        <%--Main - centru--%>
                        <div class="col-xs-6 container" style="background-color: ghostwhite; padding-bottom:10px;">
                           
                            <%--<h3> Niciun mesaj nou! </h3>--%>

                            <h3> Alege o conversatie existenta din stanga sau incepe una noua! </h3>

                        </div>

                        <%--SideBar - Dreapta--%>
                        <%--<div class="col-xs-3 container" id="sidebar" role="navigation">
                          <div class="list-group">
                            <a href="#" class="list-group-item active">Proiectele aflate in desfasurare</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item active">Mesaje</a>
                            <a href="Mesaje_main.aspx" class="list-group-item">Conversatiile mele</a>
                            <a href="Mesaje_new.aspx" class="list-group-item">Conversatie noua</a>
                            <a href="Mesaje_caut.aspx" class="list-group-item">Cauta in conversatii</a>
                            <a href="#" class="list-group-item">Link</a>
                          </div>
                        </div><!--/span-->--%>

                        <%--SideBar - Dreapta + proiecte aflate in desf--%>
                        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" runat="server" id="sidebar" role="navigation">
                            <div id="Div1" class="list-group" runat="server">
                                <a href="#" class="list-group-item active">Proiectele aflate in desfasurare</a>
                                <asp:SqlDataSource ID="SqlDataSourceProiecteParticipant" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT SUBSTRING(Proiecte.nume,0,30) as nume, Proiecte.id_proiect FROM User_are_Colaboratori INNER JOIN Proiecte ON User_are_Colaboratori.cod_proiect = Proiecte.id_proiect"></asp:SqlDataSource>
                                    <asp:ListView ID="ListView3" DataSourceID="SqlDataSourceProiecteParticipant" runat="server">
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

