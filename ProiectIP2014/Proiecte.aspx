<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Proiecte.aspx.cs" Inherits="Proiecte" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT Proiecte.id_proiect, Proiecte.cod_user, CONVERT (Date, Proiecte.data_inceput) AS data_i, CONVERT (Date, Proiecte.data_sfarsit) AS data_sfarsit, Proiecte.nume, Proiecte.descriere, Proiecte.domeniu, aspnet_Users.UserName FROM Proiecte INNER JOIN aspnet_Users ON Proiecte.cod_user = aspnet_Users.UserId"></asp:SqlDataSource>
    <div class="container" style=" max-width: 1000px;">
    <div class="container" style="background-color: ghostwhite; max-width: 1000px;">
        
         <asp:LoginView ID="LoginView1" runat="server">
             <AnonymousTemplate>
                 <asp:ListView ID="ListView1" DataSourceID="SqlDataSource1" runat="server">
                            <LayoutTemplate>
                                <div class="row" id="itemPlaceholder" runat="server" >

                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <div class="col-lg-6" id="itemPlaceholder" runat="server">
                                      <h2><%# DataBinder.Eval(Container.DataItem,"Nume") %></h2>
                                      <p class="text-danger"><%# DataBinder.Eval(Container.DataItem,"data_i") %> -- <%# DataBinder.Eval(Container.DataItem,"data_sfarsit") %></p>
                                      <p><%# DataBinder.Eval(Container.DataItem,"Descriere") %> </p>
                                     <div class="btn-group">
                                            <asp:Button ID="Detalii_Stire"  runat="server" Text="Vezi detalii &raquo;" OnCommand="Detalii_Stire_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_proiect") %>'  class="btn btn-primary" />
                                      </div>
                                </div>

               
                            </ItemTemplate>

                        </asp:ListView>

                    </div>
                    <asp:DataPager runat="server" PagedControlID="ListView1" ID="DataPager"  PageSize="4">
                       <Fields>
                          <asp:NumericPagerField
                            ButtonCount="5"
                            PreviousPageText="<--"
                            NextPageText="-->" />
                       </Fields>
                   </asp:DataPager>
             </AnonymousTemplate>
                  <RoleGroups>
                    <asp:RoleGroup Roles="ONG">
                       <ContentTemplate> 
                                <asp:ListView ID="ListView1" DataSourceID="SqlDataSource1" runat="server">
                                    <LayoutTemplate>
                                        <div class="row" id="itemPlaceholder" runat="server" >

                                        </div>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div class="col-lg-6" id="itemPlaceholder" runat="server">
                                              <h2><%# DataBinder.Eval(Container.DataItem,"Nume") %></h2>
                                              <p class="text-danger"><%# DataBinder.Eval(Container.DataItem,"data_i") %> -- <%# DataBinder.Eval(Container.DataItem,"data_sfarsit") %></p>
                                              <p><%# DataBinder.Eval(Container.DataItem,"Descriere") %> </p>
                                             <div class="btn-group">
                                                    <asp:Button ID="Detalii_Stire"  runat="server" Text="Vezi detalii &raquo;" OnCommand="Detalii_Stire_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_proiect") %>'  class="btn btn-primary" />
                                                    <asp:Button ID="Colaborator"  runat="server" Text="Vreau sa particip" OnCommand="Colaborator_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_proiect") %>'  class="btn btn-primary" />
                                               </div>
                                        </div>

               
                                    </ItemTemplate>

                                </asp:ListView>

                            </div>
                        <asp:DataPager runat="server" PagedControlID="ListView1" ID="DataPager"  PageSize="4">
                           <Fields>
                              <asp:NumericPagerField
                                ButtonCount="5"
                                PreviousPageText="<--"
                                NextPageText="-->" />
                           </Fields>
                      </asp:DataPager>
                    </ContentTemplate>
                 </asp:RoleGroup>
              </RoleGroups> 
      </asp:LoginView>                               

       
   
        <hr/>

      <footer>
        <p>&copy; Company 2014</p>
      </footer>
    </div>
</asp:Content>

