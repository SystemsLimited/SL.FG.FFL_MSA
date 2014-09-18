using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Data;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;
using System.Collections;
using Microsoft.SharePoint.WebControls;

namespace SL.FG.FFL.WebParts.AddEventsToMSASchedule
{
    public partial class AddEventsToMSAScheduleUserControl : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                fillDropDowns();
                //txtAuditorDesignation.Value = Convert.ToString(DateTime.Now.Date);
                startdate_WI.MinDate = DateTime.Now.Date;
                startdate_WII.MinDate = DateTime.Now.Date;
                startdate_WIII.MinDate = DateTime.Now.Date;
                startdate_WIV.MinDate = DateTime.Now.Date;
                enddate_WI.MinDate = DateTime.Now.Date;
                enddate_WII.MinDate = DateTime.Now.Date;
                enddate_WIII.MinDate = DateTime.Now.Date;
                enddate_WIV.MinDate = DateTime.Now.Date;
            }
        }

        private void fillDropDowns()
        {
            try
            {
                using (SPSite spSite = new SPSite(SPContext.Current.Web.Url))
                {
                    using (SPWeb spWeb = spSite.OpenWeb())
                    {
                        SPList spList = spWeb.Lists["Department"];

                        SPQuery spQuery = new SPQuery();
                        spQuery.ViewFields = "<FieldRef Name='Title' /><FieldRef Name='ID' />";
                        spQuery.ViewFieldsOnly = true;
                        spQuery.Query = "<OrderBy><FieldRef Name='Title' /></OrderBy>";


                        DataTable dt = spList.GetItems(spQuery).GetDataTable();
                        DataView dv = new DataView(dt);                        
                        dt = dv.ToTable(true, "Title");
                        this.ddlAuditorDepartment.DataSource = dt;
                        this.ddlAuditorDepartment.DataTextField = "Title";
                        this.ddlAuditorDepartment.DataValueField = "Title";
                        this.ddlAuditorDepartment.DataBind();

                        spList = spWeb.Lists["Section"];
                        SPListItemCollection listtItemCollec = spList.GetItems(spQuery);
                        this.ddlAuditorSection.DataSource = listtItemCollec;
                        this.ddlAuditorSection.DataTextField = "Title";
                        this.ddlAuditorSection.DataValueField = "ID";
                        this.ddlAuditorSection.DataBind();

                        spList = spWeb.Lists["Area"];
                        listtItemCollec = null;
                        listtItemCollec = spList.GetItems(spQuery);
                        this.ddlAreaToBeAudited_WI.DataSource = listtItemCollec;
                        this.ddlAreaToBeAudited_WI.DataTextField = "Title";
                        this.ddlAreaToBeAudited_WI.DataValueField = "ID";
                        this.ddlAreaToBeAudited_WI.DataBind();

                        this.ddlAreaToBeAudited_WII.DataSource = listtItemCollec;
                        this.ddlAreaToBeAudited_WII.DataTextField = "Title";
                        this.ddlAreaToBeAudited_WII.DataValueField = "ID";
                        this.ddlAreaToBeAudited_WII.DataBind();

                        this.ddlAreaToBeAudited_WIII.DataSource = listtItemCollec;
                        this.ddlAreaToBeAudited_WIII.DataTextField = "Title";
                        this.ddlAreaToBeAudited_WIII.DataValueField = "ID";
                        this.ddlAreaToBeAudited_WIII.DataBind();

                        this.ddlAreaToBeAudited_WIV.DataSource = listtItemCollec;
                        this.ddlAreaToBeAudited_WIV.DataTextField = "Title";
                        this.ddlAreaToBeAudited_WIV.DataValueField = "ID";
                        this.ddlAreaToBeAudited_WIV.DataBind();
                    }
                }

            }catch(Exception ex)
            {
                SPDiagnosticsService.Local.WriteTrace(0, new SPDiagnosticsCategory("SL.FG.FFL-Add)", TraceSeverity.Unexpected, EventSeverity.Error), TraceSeverity.Unexpected, ex.Message, ex.StackTrace);
                message_div.InnerHtml = "Something went wrong!!! Please Contact the administrator.";
            }

            
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            ArrayList resolve = cppAuditotName.ResolvedEntities;
            SPUser spUserAuditorName = null;
            string loginName = string.Empty;           

            try
            {
                foreach (PickerEntity entiry in resolve)
                {
                    loginName = entiry.Key;

                    if (loginName.Contains("i:0#.w|"))
                    {
                        loginName = loginName.Replace("i:0#.w|", "");
                    }
                    spUserAuditorName = SPContext.Current.Web.EnsureUser(loginName);
                    break;
                }
                using (SPSite spSite = new SPSite(SPContext.Current.Web.Url))
                {
                    using (SPWeb spWeb = spSite.OpenWeb())
                    {
                        SPList spList = spWeb.Lists["MSA Schedule"];
                        SPListItem listItem = spList.AddItem();

                        listItem["Title"] = spUserAuditorName.Name + " - " + txtAuditorDesignation.Value;
                        listItem["FFLScheduleName"] = new SPFieldUserValue(spWeb, spUserAuditorName.ID, spUserAuditorName.Name);
                        listItem["FFLScheduleDesignation"] = txtAuditorDesignation.Value;
                        listItem["FFLDepartments"] = ddlAuditorDepartment.SelectedItem.Text;
                        listItem["FFLSection"] = ddlAuditorSection.SelectedItem.Text; //new SPFieldLookupValue(Convert.ToInt32(ddlAuditorSection.SelectedItem.Value), ddlAuditorSection.SelectedItem.Text);
                        listItem["FFLArea"] = ddlAreaToBeAudited_WI.SelectedItem.Text; //new SPFieldLookupValue(Convert.ToInt32(ddlAreaToBeAudited_WI.SelectedItem.Value), ddlAreaToBeAudited_WI.SelectedItem.Text);
                        listItem["EventDate"] = startdate_WI.SelectedDate; //DateTime.Now;
                        listItem["EndDate"] = enddate_WI.SelectedDate.AddHours(23).AddMinutes(55); //DateTime.Now.AddDays(2);
                        listItem["FFLEmailAddress"] = spUserAuditorName.Email;
                        listItem.Update();

                        listItem = null;
                        listItem = spList.AddItem();

                        listItem["Title"] = spUserAuditorName.Name + " - " + txtAuditorDesignation.Value;
                        listItem["FFLScheduleName"] = new SPFieldUserValue(spWeb, spUserAuditorName.ID, spUserAuditorName.Name);
                        listItem["FFLScheduleDesignation"] = txtAuditorDesignation.Value;
                        listItem["FFLDepartments"] = ddlAuditorDepartment.SelectedItem.Text;
                        listItem["FFLSection"] = ddlAuditorSection.SelectedItem.Text; //new SPFieldLookupValue(Convert.ToInt32(ddlAuditorSection.SelectedItem.Value), ddlAuditorSection.SelectedItem.Text);
                        listItem["FFLArea"] = ddlAreaToBeAudited_WII.SelectedItem.Text; //new SPFieldLookupValue(Convert.ToInt32(ddlAreaToBeAudited_WI.SelectedItem.Value), ddlAreaToBeAudited_WI.SelectedItem.Text);
                        listItem["EventDate"] = startdate_WII.SelectedDate; //DateTime.Now;
                        listItem["EndDate"] = enddate_WII.SelectedDate.AddHours(23).AddMinutes(55); //DateTime.Now.AddDays(2);
                        listItem["FFLEmailAddress"] = spUserAuditorName.Email;
                        listItem.Update();

                        listItem = null;
                        listItem = spList.AddItem();

                        listItem["Title"] = spUserAuditorName.Name + " - " + txtAuditorDesignation.Value;
                        listItem["FFLScheduleName"] = new SPFieldUserValue(spWeb, spUserAuditorName.ID, spUserAuditorName.Name);
                        listItem["FFLScheduleDesignation"] = txtAuditorDesignation.Value;
                        listItem["FFLDepartments"] = ddlAuditorDepartment.SelectedItem.Text;
                        listItem["FFLSection"] = ddlAuditorSection.SelectedItem.Text; //new SPFieldLookupValue(Convert.ToInt32(ddlAuditorSection.SelectedItem.Value), ddlAuditorSection.SelectedItem.Text);
                        listItem["FFLArea"] = ddlAreaToBeAudited_WIII.SelectedItem.Text; //new SPFieldLookupValue(Convert.ToInt32(ddlAreaToBeAudited_WI.SelectedItem.Value), ddlAreaToBeAudited_WI.SelectedItem.Text);
                        listItem["EventDate"] = startdate_WIII.SelectedDate; //DateTime.Now;
                        listItem["EndDate"] = enddate_WIII.SelectedDate.AddHours(23).AddMinutes(55); //DateTime.Now.AddDays(2);
                        listItem["FFLEmailAddress"] = spUserAuditorName.Email;
                        listItem.Update();

                        listItem = null;
                        listItem = spList.AddItem();

                        listItem["Title"] = spUserAuditorName.Name + " - " + txtAuditorDesignation.Value;
                        listItem["FFLScheduleName"] = new SPFieldUserValue(spWeb, spUserAuditorName.ID, spUserAuditorName.Name);
                        listItem["FFLScheduleDesignation"] = txtAuditorDesignation.Value;
                        listItem["FFLDepartments"] = ddlAuditorDepartment.SelectedItem.Text;
                        listItem["FFLSection"] = ddlAuditorSection.SelectedItem.Text; //new SPFieldLookupValue(Convert.ToInt32(ddlAuditorSection.SelectedItem.Value), ddlAuditorSection.SelectedItem.Text);
                        listItem["FFLArea"] = ddlAreaToBeAudited_WIV.SelectedItem.Text; //new SPFieldLookupValue(Convert.ToInt32(ddlAreaToBeAudited_WI.SelectedItem.Value), ddlAreaToBeAudited_WI.SelectedItem.Text);
                        listItem["EventDate"] = startdate_WIV.SelectedDate; //DateTime.Now;
                        listItem["EndDate"] = enddate_WIV.SelectedDate.AddHours(23).AddMinutes(55); //DateTime.Now.AddDays(2);
                        listItem["FFLEmailAddress"] = spUserAuditorName.Email;
                        listItem.Update();
                    }
                }
            }catch(Exception ex)
            {
                SPDiagnosticsService.Local.WriteTrace(0, new SPDiagnosticsCategory("SL.FG.FFL-AddMSA)", TraceSeverity.Unexpected, EventSeverity.Error), TraceSeverity.Unexpected, ex.Message, ex.StackTrace);
                message_div.InnerHtml = "Something went wrong!!! Please Contact the administrator.";
            }
        }
    }
}
