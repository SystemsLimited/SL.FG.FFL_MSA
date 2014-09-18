<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddEventsToMSAScheduleUserControl.ascx.cs" Inherits="SL.FG.FFL.WebParts.AddEventsToMSASchedule.AddEventsToMSAScheduleUserControl" %>

<script type="text/javascript">

    function convertStringToDate(str) {
        try {
            var temp = str.split('/');

            if (temp.length > 2) {
                var d = new Date(temp[2], (parseInt(temp[1]) - 1), temp[0]);
                return d;
            }
        }
        catch (ex) {
        }
        return null;
    }

    function SaveMSASchedule() {        
        try {
            var flag = false;
            var message = null;
            var startDate = convertStringToDate($("[id$=startdate_WIDate]").val());
            var endDate = convertStringToDate($("[id$=enddate_WIDate]").val());

            if (startDate != null && endDate != null && endDate < startDate) {
                flag = true;
                message = 'Week I - End date must be greater than or equal to start date.';
            }

            startDate = convertStringToDate($("[id$=startdate_WIIDate]").val());
            endDate = convertStringToDate($("[id$=enddate_WIIDate]").val());
            if (startDate != null && endDate != null && endDate < startDate) {
                flag = true;
                message = message + '\n' +
                    'Week II - End date must be greater than or equal to start date.';
            }

            startDate = convertStringToDate($("[id$=startdate_WIIIDate]").val());
            endDate = convertStringToDate($("[id$=enddate_WIIIDate]").val());
            if (startDate != null && endDate != null && endDate < startDate) {
                flag = true;
                message = message + '\n' +
                    'Week III - End date must be greater than or equal to start date.';
            }

            startDate = convertStringToDate($("[id$=startdate_WIVDate]").val());
            endDate = convertStringToDate($("[id$=enddate_WIVDate]").val());
            if (startDate != null && endDate != null && endDate < startDate) {
                flag = true;
                message = message + '\n' +
                    'Week IV - End date must be greater than or equal to start date.';
            }

            if (flag) {
                alert(message);
                return false;
            }
            else {
                return true;
            }
        }
        catch (ex) {
        }
    }
</script>

<div class="container">
    <div class="row">
        <div id="message_div" runat="server" class="messageDiv">
        </div>
        <div class="col-lg-12">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-9">
                            <h5>Add schedule to MSA</h5>
                        </div>                                
                     </div>
                </div>
                <div class="panel-body">
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Auditor Name:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <SharePoint:ClientPeoplePicker runat="server" ID="cppAuditotName" Rows="1" VisibleSuggestions="3" AllowMultipleEntities="false" PrincipalAccountType="User" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Auditor Designation:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <input type="text" id="txtAuditorDesignation" runat="server" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Auditor Department:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlAuditorDepartment" runat="server" CssClass="form-control" AutoPostBack="false" />
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Auditor Section:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlAuditorSection" runat="server" CssClass="form-control" AutoPostBack="false" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Start Date:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <SharePoint:DateTimeControl ID="startdate_WI" runat="server" CssClassTextBox="form-control" AutoPostBack="false" IsRequiredField="true" DateOnly="true" LocaleId="2057"  />                                
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>End Date:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <SharePoint:DateTimeControl ID="enddate_WI" runat="server" CssClassTextBox="form-control" AutoPostBack="false" IsRequiredField="true" DateOnly="true" LocaleId="2057" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Area To be Audited:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlAreaToBeAudited_WI" runat="server" CssClass="form-control" AutoPostBack="false" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Start Date:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <SharePoint:DateTimeControl ID="startdate_WII" runat="server" CssClassTextBox="form-control" AutoPostBack="false" IsRequiredField="true" DateOnly="true" LocaleId="2057" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>End Date:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <SharePoint:DateTimeControl ID="enddate_WII" runat="server" CssClassTextBox="form-control" AutoPostBack="false" IsRequiredField="true" DateOnly="true" LocaleId="2057" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Area To be Audited:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlAreaToBeAudited_WII" runat="server" CssClass="form-control" AutoPostBack="false" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Start Date:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <SharePoint:DateTimeControl ID="startdate_WIII" runat="server" CssClassTextBox="form-control" AutoPostBack="false" IsRequiredField="true" DateOnly="true" LocaleId="2057" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>End Date:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <SharePoint:DateTimeControl ID="enddate_WIII" runat="server" CssClassTextBox="form-control" AutoPostBack="false" IsRequiredField="true" DateOnly="true" LocaleId="2057" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Area To be Audited:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlAreaToBeAudited_WIII" runat="server" CssClass="form-control" AutoPostBack="false" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Start Date:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <SharePoint:DateTimeControl ID="startdate_WIV" runat="server" CssClassTextBox="form-control" AutoPostBack="false" IsRequiredField="true" DateOnly="true" LocaleId="2057" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>End Date:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <SharePoint:DateTimeControl ID="enddate_WIV" runat="server" CssClassTextBox="form-control" AutoPostBack="false" IsRequiredField="true" DateOnly="true" LocaleId="2057" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Area To be Audited:</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlAreaToBeAudited_WIV" runat="server" CssClass="form-control" AutoPostBack="false" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="return SaveMSASchedule();" CssClass="btnSave" /> 
                            </div>
                        </div>
                    </div>

                </div>
            </div>
         </div>    
    </div>
</div>

<script src="/_layouts/15/SL.FG.FFL/Scripts/jQuery.js"></script>