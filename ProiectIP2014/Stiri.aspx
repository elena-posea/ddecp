<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Stiri.aspx.cs" Inherits="Stiri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/myCss.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="GETstiri" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT Stiri.id_stire, Stiri.cod_user, Stiri.titlu, Stiri.descriere FROM Stiri INNER JOIN aspnet_Users ON Stiri.cod_user = aspnet_Users.UserId"></asp:SqlDataSource>
    <div class="container" style="max-width: 1000px;">
        <div class="container" style="background-color:#EEE; max-width: 1000px;">        
            <asp:ListView ID="ListStiri" DataSourceID="GETstiri" runat="server">            
                <LayoutTemplate>
                    <div class="row" id="itemPlaceholder" runat="server">
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                        <div class="col-lg-6" style="padding-bottom:10px;" id="itemPlaceholder" runat="server">
                            <h2><%# DataBinder.Eval(Container.DataItem,"Titlu") %></h2>
                            <p>
                                <img runat="server" class="thumb_small_img"  visible='<%# imgExists( DataBinder.Eval(Container.DataItem,"id_stire").ToString() ) %>' src='<%# getImgSrc( DataBinder.Eval(Container.DataItem,"id_stire").ToString() ) %>'/>
                                <%# DataBinder.Eval(Container.DataItem,"Descriere") %> 
                            </p>
                            <div class="clearfix"> </div>
                            <div class="btn-group">
                                <asp:Button ID="Vizualizeaza_stire" runat="server" Text="Vezi detalii &raquo;" OnCommand="Vizualizeaza_Stire_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_stire") %>' CssClass="btn btn-info" />
                           
                            </div>
                                <br />
                        </div>
                </ItemTemplate>
            </asp:ListView>
            </div>
            <div class="pagination" runat="server">
            <asp:DataPager runat="server" PagedControlID="ListStiri" ID="DataPager" PageSize="4">
                <Fields>
                    <asp:NumericPagerField
                                ButtonCount="5"
                                PreviousPageText="<--"
                                NextPageText="-->" />
                </Fields>
            
            </asp:DataPager>
                    </div>
        <br />
        <asp:Label ID="Raspuns" runat="server" Text=" "></asp:Label>
        <hr />
        <footer>
            <p>&copy; Company 2014</p>
        </footer>
        </div>

</asp:Content>

