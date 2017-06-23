using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ionic.Zip;
using System.Xml;
using LearningManagementSystem.Service;
using System.Web.Script.Serialization;
using System.IO;

public partial class downloadCourse : System.Web.UI.Page
{
    public class ModuleVersion
    {
        public string version = "0";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string CourseID = Request.QueryString["cid"];
        string Version = Request.QueryString["version"];
        string XmlPath = "";

        DownloadStatus Ds = new DownloadStatus();
        JavaScriptSerializer _json = new JavaScriptSerializer();

        if ((!string.IsNullOrEmpty(CourseID) && !string.IsNullOrEmpty(Version)) && !string.IsNullOrEmpty(Version))
        {
            if (!string.IsNullOrEmpty(CourseID) && Convert.ToInt64(CourseID) == 0)
                XmlPath = System.Configuration.ConfigurationManager.AppSettings["commonSource"].ToString();
            else if (!string.IsNullOrEmpty(CourseID) && Convert.ToInt64(CourseID) > 0)
                XmlPath = System.Configuration.ConfigurationManager.AppSettings["emoduleSource"].ToString() + CourseID;

            ModuleVersion version = _json.Deserialize<ModuleVersion>(System.IO.File.ReadAllText( XmlPath + "/version.xml"));

            Ds.CourseID = Convert.ToUInt32(CourseID);
            string versionNumber = version.version;
            if (versionNumber != null && Convert.ToInt64(Version) == Convert.ToInt64(versionNumber))
            {
                Ds.Status = "Uptodate";
                Response.Write(_json.Serialize(Ds));
                return;
            }
            else if(versionNumber != null && Convert.ToInt64(Version) < Convert.ToInt64(versionNumber))
            {
                Ds.Status = "Outofdate";
                Response.Write(_json.Serialize(Ds));
                return;
            }

           
        }
        string FilePath = string.Empty;
        if (!string.IsNullOrEmpty(CourseID) && Convert.ToInt32(CourseID) == 0)
        {
            FilePath = System.Configuration.ConfigurationManager.AppSettings["commonSource"].ToString();
            if (!File.Exists(FilePath + ".zip"))
            {
                using (ZipFile zip = new ZipFile())
                {
                    zip.AddDirectory(FilePath);
                    zip.Save(FilePath + ".zip");
                }
            }

            
        }
        else if (!string.IsNullOrEmpty(CourseID))
        {
            FilePath = System.Configuration.ConfigurationManager.AppSettings["emoduleSource"].ToString() + CourseID;
            if (!File.Exists(FilePath + ".zip"))
            {
                using (ZipFile zip = new ZipFile())
                {
                    zip.AddDirectory(FilePath);
                    zip.Save(FilePath + ".zip");
                }
            }
               /* byte[] Content = File.ReadAllBytes(FilePath + ".zip");
                Response.AddHeader("content-disposition", "attachment; filename=Module.zip");
                Response.BufferOutput = true;
                Response.OutputStream.Write(Content, 0, Content.Length);
                Response.End();*/
        }
        if (!String.IsNullOrEmpty(Request.Headers["Range"]))
        {
            long fp = 0;
            using (StreamReader reader = new StreamReader(FilePath + ".zip"))
            {
                long length = reader.BaseStream.Length;
                fp = reader.BaseStream.Seek( Convert.ToUInt32(Request.Headers["Range"]), SeekOrigin.Begin);

                byte[] Content = File.ReadAllBytes(FilePath + ".zip");
                Response.AddHeader("content-disposition", "attachment; filename=Common.zip");
                Response.BufferOutput = true;
                Response.AddHeader("content-length", "" + (length-fp));
                Response.WriteFile(FilePath + ".zip", fp, length - fp);

                Response.End();
            }
        }
        else
        {
            byte[] Content = File.ReadAllBytes(FilePath + ".zip");
            Response.AddHeader("content-disposition", "attachment; filename=Common.zip");
            Response.BufferOutput = true;
            Response.OutputStream.Write(Content, 0, Content.Length);
            Response.End();
        }

    }
}