<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Organizatii.aspx.cs" Inherits="Organizatii" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="GETorganizatii" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT dbo.GetProfilePropertyValue('NumeONG', PropertyNames, PropertyValuesString) AS NumeONG, dbo.GetProfilePropertyValue('DescriereActivitate', PropertyNames, PropertyValuesString) AS Descriere, dbo.GetProfilePropertyValue('Profil', PropertyNames, PropertyValuesString) AS Profil, dbo.GetProfilePropertyValue('TipONG', PropertyNames, PropertyValuesString) AS TipONG, aspnet_Users.username AS username from aspnet_Profile, aspnet_Users where aspnet_Users.UserId = aspnet_Profile.UserId"></asp:SqlDataSource>
    <div class="container" style="max-width: 1000px;">
        <div class="container" style="background-color:#EEE; max-width: 1000px;">        
            <asp:ListView ID="ListOrganizatii" DataSourceID="GETorganizatii" runat="server">            
                <LayoutTemplate>
                    <div class="row" id="itemPlaceholder" runat="server">
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                        <div class="col-md-4" style="padding-bottom:10px;" id="itemPlaceholder" runat="server">
                            <h4><%# DataBinder.Eval(Container.DataItem,"NumeONG") %></h4>
                            <p><%# DataBinder.Eval(Container.DataItem,"TipONG") %>
                            <%# DataBinder.Eval(Container.DataItem,"Profil") %>
                            <asp:Button ID="detaliiONG" runat="server" Text="Detalii ONG &raquo;" OnCommand="Detalii_ONG" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"username") %>' CssClass="btn btn-info" />
                            </p>
                        </div>
                </ItemTemplate>
            </asp:ListView>
            </div>
            <div id="Div1" class="pagination" runat="server">
            <asp:DataPager runat="server" PagedControlID="ListOrganizatii" ID="DataPager" PageSize="4">
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

