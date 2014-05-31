<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Proiect.aspx.cs" Inherits="Proiect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/myCss.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT id_proiect, Proiecte.cod_user, CONVERT (Date, Proiecte.data_inceput) AS data_i, CONVERT (Date, Proiecte.data_sfarsit) AS data_sfarsit, Proiecte.nume, Proiecte.descriere, Proiecte.continut, Proiecte.domeniu, aspnet_Users.UserName FROM Proiecte INNER JOIN aspnet_Users ON Proiecte.cod_user = aspnet_Users.UserId"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceListaComentarii" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>'></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTask" runat="server" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT * FROM [Tasks] ORDER BY [deadline]"></asp:SqlDataSource>

    <div class="container" style="max-width: 1000px;">
        <div class="container" style="background-color: ghostwhite; max-width: 1000px;">

            <asp:Repeater ID="Repeater1" DataSourceID="SqlDataSource1" runat="server">
                <ItemTemplate>
                    <h2><%# DataBinder.Eval(Container.DataItem,"nume") %></h2>
                    <p class="text-danger"><%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem,"data_i")).ToShortDateString()%> -- <%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem,"data_sfarsit")).ToShortDateString() %></p>
                    <p><%# DataBinder.Eval(Container.DataItem,"descriere") %> </p>
                    <p><%# DataBinder.Eval(Container.DataItem,"continut") %></p>

                </ItemTemplate>
            </asp:Repeater>
            <asp:Label ID="Raspuns1" runat="server" Text=""></asp:Label>

            <asp:LoginView ID="LoginViewComentarii" runat="server">
                <LoggedInTemplate>

                    <hr />
                    <%--<button type="button" class="btn btn-primary btn-xs">Mini button</button>--%>
                    <asp:Button ID="adauga_task" runat="server" class="btn btn-primary btn-xs" OnClick="adauga_task_Click" Text="Adauga task" />
                    <br />
                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSourceTask">
                        <HeaderTemplate>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Descriere</th>
                                        <th>Numar de voluntari</th>
                                        <th>Deadline</th>
                                        <th>ONG iniţiator</th>
                                        <th>ONG asignat</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                        <ItemTemplate>

                            <tr>
                                <td class="col-md-4"><%# DataBinder.Eval(Container.DataItem,"descriere") %></td>
                                <td class="col-md-2"><%# DataBinder.Eval(Container.DataItem,"nr_voluntari") %></td>
                                <td class="success col-md-2"><%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem,"deadline")).ToShortDateString() %></td>
                                <td class="col-md-2"><a href="Profil.aspx?username=<%# getUserNameFromID((DataBinder.Eval(Container.DataItem,"cod_initiator")).ToString()) %> "><%# getUserNameFromID((DataBinder.Eval(Container.DataItem,"cod_initiator")).ToString()) %> </a></td>

                                <td class="col-md-2">
                                    <%# getUserNameFromID((DataBinder.Eval(Container.DataItem,"cod_asignat")).ToString()) %>

                                    <asp:Button Visible='<%# !seOcupaDejaCinevaDeTask(Convert.ToInt32(DataBinder.Eval(Container.DataItem,"id_task")))  %>' class="btn btn-primary btn-xs" ID="ma_ocup_eu" OnCommand="ma_ocup_eu_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_task") %>' runat="server" Text="Mă ocup eu!" />
                                    <br />
                                    <asp:Panel ID="Panel1" runat="server" Visible='<%# eu_am_propus_taskul(Membership.GetUser().ProviderUserKey.ToString(), DataBinder.Eval(Container.DataItem,"id_task").ToString())  %>'>
                                        <a href="Altcineva.aspx?id_task=<%# DataBinder.Eval(Container.DataItem,"id_task") %>&id_proiect=<%# DataBinder.Eval(Container.DataItem,"cod_proiect") %>">Să se ocupe altcineva</a>
                                    </asp:Panel>

                                </td>
                                <td class="col-md-2">
                                    <asp:Panel ID="Panel2" runat="server" Visible='<%# nu_e_terminat(DataBinder.Eval(Container.DataItem,"id_task").ToString()) %>' >
                                        <asp:Button class="btn btn-primary btn-xs" ID="editeaza_task" OnCommand="editeaza_task_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_task") %>' runat="server" Text="Editeaza" />
                                        <br />
                                        <br />
                                        <asp:Button class="btn btn-success btn-xs" OnCommand="terminat_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_task") %>' ID="terminat" runat="server" Text="Marcheaza ca terminat" />

                                    </asp:Panel>
                                    <asp:Button class="btn btn-primary btn-xs" ID="sterge_task" OnCommand="sterge_task_Command" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id_task") %>' runat="server" Text="Sterge" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>

                    <hr />
                    <asp:TextBox ID="TextBoxContinut" runat="server" Width="100%" Height="100px" TextMode="MultiLine"></asp:TextBox><br />
                    <asp:Button CssClass="btn-default" ID="AddCommentButton" runat="server" Text="Adauga un comentariu" OnClick="adaugaComentariu" />

                    <hr />
                    <!-- lista comentariilor deja postate -->
                    <asp:Repeater ID="RepeaterComentarii" runat="server" DataSourceID="SqlDataSourceListaComentarii">
                        <ItemTemplate>
                            <div class="comment">
                                <div class="titlu">
                                    <span class="autor">
                                        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# String.Format("~/Profil.aspx?username={0}", getUserNameFromID((DataBinder.Eval(Container.DataItem,"cod_user")).ToString())) %>'>
                                            <%# getUserNameFromID((DataBinder.Eval(Container.DataItem,"cod_user")).ToString())  %>
                                        </asp:HyperLink>
                                        said: 
                                    </span>
                                    <div class="alignRight" style="font-size: 15px; font-weight: normal;">
                                        Ultima editare:
                                        <%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "data")).ToShortDateString() %>
                                    </div>
                                    <br />
                                </div>
                                <div class="continut">
                                    <%# DataBinder.Eval(Container.DataItem,"continut")  %><br />
                                </div>
                            </div>


                            <br />
                            <hr style='border-color: #428BCA' />
                        </ItemTemplate>
                    </asp:Repeater>
                </LoggedInTemplate>
            </asp:LoginView>
            <asp:Label ID="Raspuns" runat="server" Text=" "></asp:Label>
        </div>

        <footer>
            <p>&copy; Company 2014</p>
        </footer>
    </div>
</asp:Content>

