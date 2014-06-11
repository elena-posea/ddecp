<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Proiecte.aspx.cs" Inherits="Proiecte" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/myCss.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT Proiecte.id_proiect, Proiecte.cod_user, CONVERT (Date, Proiecte.data_inceput) AS data_i, CONVERT (Date, Proiecte.data_sfarsit) AS data_sfarsit, Proiecte.nume, Proiecte.descriere, Proiecte.domeniu, aspnet_Users.UserName FROM Proiecte INNER JOIN aspnet_Users ON Proiecte.cod_user = aspnet_Users.UserId"></asp:SqlDataSource>
    <div class="container" style="max-width: 1000px;">
        <div class="container" style="background-color: #EEE; max-width: 1000px;">

            <asp:LoginView ID="LoginView1" runat="server">
                <AnonymousTemplate>
                    <asp:ListView ID="ListView1" DataSourceID="SqlDataSource1" runat="server">
                        <LayoutTemplate>
                            <div class="row" id="itemPlaceholder" runat="server">
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="col-lg-6" id="itemPlaceholder" style="padding-bottom:10px;" runat="server">
                                <h2><%# DataBinder.Eval(Container.DataItem,"Nume") %></h2>
                                <p class="text-danger"><%# DataBinder.Eval(Container.DataItem,"data_i") %> -- <%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem,"data_sfarsit")).ToShortDateString() %></p>
                                <p>
                                    <img runat="server" class="thumb_small_img"  visible='<%# imgExists( DataBinder.Eval(Container.DataItem,"id_proiect").ToString() ) %>' src='<%# getImgSrc( DataBinder.Eval(Container.DataItem,"id_proiect").ToString() ) %>'/>
                                    <%# DataBinder.Eval(Container.DataItem,"Descriere").ToString() %> 
                                </p>
                                <div class="clearfix"> </div>
                                <div class="btn-group">
                                    <asp:Button ID="Detalii_Proiect" runat="server" Text="Vezi detalii &raquo;" OnCommand="Detalii_Proiect_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_proiect") %>' CssClass="btn btn-info" />
                                </div>
                
                            </div>


                        </ItemTemplate>

                    </asp:ListView>

                    </div>
                    <asp:DataPager runat="server" PagedControlID="ListView1" ID="DataPager" PageSize="4">
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
                                    <div class="row" id="itemPlaceholder" runat="server">
                                    </div>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div class="col-lg-6" id="itemPlaceholder" style="padding-bottom:10px;" runat="server">
                                        <h2><%# DataBinder.Eval(Container.DataItem,"Nume") %></h2>
                                        <p class="text-danger"><%# DataBinder.Eval(Container.DataItem,"data_i") %> -- <%# DataBinder.Eval(Container.DataItem,"data_sfarsit") %></p>
                                        <p class="text-danger">Propus de: <a href="Profil.aspx?username=<%# DataBinder.Eval(Container.DataItem,"UserName") %> "><%# DataBinder.Eval(Container.DataItem,"UserName") %> </a></p>
                                        <p>
                                            <img id="Img1" runat="server" class="thumb_small_img"  visible='<%# imgExists( DataBinder.Eval(Container.DataItem,"id_proiect").ToString() ) %>' src='<%# getImgSrc( DataBinder.Eval(Container.DataItem,"id_proiect").ToString() ) %>'/>
                                            <%# DataBinder.Eval(Container.DataItem,"Descriere").ToString() %> 
                                        </p>
                                        <div class="clearfix"> </div>
                                        <div class="btn-group">
                                            <asp:Button ID="Detalii_Proiect" runat="server" Text="Vezi detalii &raquo;" OnCommand="Detalii_Proiect_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_proiect") %>' CssClass="btn btn-info" />
                                            <asp:Button ID="Colaborator" runat="server" Text="Vreau sa particip" OnCommand="Colaborator_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_proiect") %>' CssClass="btn btn-info" />
                                        </div>
                                        <br />
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>

                            </div>
                        <asp:DataPager runat="server" PagedControlID="ListView1" ID="DataPager" PageSize="4">
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
            <br />
            <asp:Label ID="Raspuns" runat="server" Text=" "></asp:Label>

            <hr />

            <footer>
                <p>&copy; Company 2014</p>
            </footer>
        </div>
    </div>
</asp:Content>

