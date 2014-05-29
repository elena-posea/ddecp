<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Inregistrare.aspx.cs" Inherits="SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/myCss.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container" style="padding:10px; background-color: #EEE;">


        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" OnCreatedUser="CreateUserWizard1_CreatedUser" OnContinueButtonClick="CreateUserWizard1_ContinueButtonClick">
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                    <ContentTemplate>
                        <table class="formular">
                            <tr>

                                <td colspan="2" style="padding-top:20px;"><legend>Formular înscriere
                                </legend>
                                    </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="LabelUserName"  runat="server" Text="Username "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="LabelNumeONG" runat="server" Text="Nume ONG "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxNumeONG" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="LabelParola" runat="server" Text="Parola "></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="LabelParolaConfirm" runat="server" Text="Confirmă parola "></asp:Label></td>
                                <td>
                                    <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" />
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidatorConfirm" ControlToValidate="ConfirmPassword"
                                        ErrorMessage="Confirmarea parolei este obligatorie" Display="Dynamic" />
                                    <asp:CompareValidator ID="CompareValidatorConfirm" runat="server" ErrorMessage="Cele două parole nu coincid" ControlToValidate="ConfirmPassword" ControlToCompare="Password"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="LabelEmail" runat="server" Text="E-mail "></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="Email" runat="server" TextMode="Email"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="E-mailul este obligatoriu" ControlToValidate="Email"></asp:RequiredFieldValidator>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="LabelDescriere" runat="server" Text="Descrierea activităţii "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxDescriere" raws='3' runat="server" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorDescriere" runat="server" ErrorMessage="Descrierea activităţii ONG-ului este obligatorie" ControlToValidate="TextBoxDescriere"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="LabelNrInregistrare" runat="server" Text="Numărul de înregistrare "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxNrInregistrare" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorNrInregistrare" runat="server" ErrorMessage="Numărul de înregistrare este obligatoriu" ControlToValidate="TextBoxNrInregistrare" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidatorNrInregistrare" runat="server" ErrorMessage="Trebuie să fie număr" ControlToValidate="TextBoxNrInregistrare" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Tip ONG
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownListTip" runat="server">
                                        <asp:ListItem Text="Asociaţie" Value="1"> Asociaţie </asp:ListItem>
                                        <asp:ListItem Text="Fundaţie" Value="2"> Fundaţie </asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="LabelAn" runat="server" Text="Anul înfiinţării "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxAn" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorAn" runat="server" ErrorMessage="Anul înfiinţării este obligatoriu" ControlToValidate="TextBoxAn" ViewStateMode="Disabled" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidatorAn" runat="server" ErrorMessage="Trebuie să fie an" ControlToValidate="TextBoxAn" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="LabelProfil" runat="server" Text="Profil ONG "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxProfil" runat="server"></asp:TextBox>
                                </td>
                            </tr>

                        </table>
                        <%--
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorNumeONG" runat="server" ErrorMessage="Numele ONG-ului este obligatoriu" ControlToValidate="UserName"></asp:RequiredFieldValidator>
                        --%>

                        <br />

                        <asp:Button ID="StepNextButton" runat="server"
                            CommandName="MoveNext" Text="Create User"
                            ValidationGroup="CreateUserWizard1" />
                    </ContentTemplate>
                    <CustomNavigationTemplate>
                        <%--
                        <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Create User" ValidationGroup="CreateUserWizard1" />
                        --%>
                    </CustomNavigationTemplate>
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" />
            </WizardSteps>
        </asp:CreateUserWizard>
    </div>
    <!-- /container -->


</asp:Content>

