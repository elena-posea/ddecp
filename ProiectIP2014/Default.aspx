<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">

      <div class="row row-offcanvas row-offcanvas-right">

        <div class="col-xs-12 col-sm-9">
          <p class="pull-right visible-xs">
            <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>
          </p>
          <div class="jumbotron">
            <h1>Bine ati venit!</h1>
            <p>Aici va fi descrierea aplicatiei</p>
          </div>
          
        </div><!--/span-->
        <asp:LoginView ID="LoginView1" runat="server">
           <RoleGroups>
               <asp:RoleGroup Roles="ONG">
                   <ContentTemplate>
                        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar" role="navigation">
                          <div class="list-group">
                            <a href="#" class="list-group-item active">Proiectele aflate in desfasurare</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item active">Mesaje</a>
                            <a href="#" class="list-group-item">Mesaje primte</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                          </div>
                        </div><!--/span-->
                </ContentTemplate>
            </asp:RoleGroup>
            </RoleGroups>
        </asp:LoginView>
      </div><!--/row-->

      <hr />

      <footer>
        <p>&copy; Company 2014</p>
      </footer>

    </div><!--/.container-->
</asp:Content>

