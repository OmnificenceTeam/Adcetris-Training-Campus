using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QuickLinks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String url_1 = "http://www.nlm.nih.gov/medlineplus/feeds/topics/hodgkindisease.xml";
        String url_2 = "http://www.hematology.org/RSS.aspx?parenttaxid=102";
        String url_3 = "http://jco.ascopubs.org/rss/Hematologic_Malignancies.xml";
        String url_4 = "http://www.esmo.org/rss/feed/esmo-news";
        String sUrl = String.Empty;

        for (int Index = 1; Index < 5; Index++)
        {
            if (Index == 1)
            {
                sUrl = url_1;
            }
            else if (Index == 2)
            {
                sUrl = url_2;
            }
            else if (Index == 3)
            {
                sUrl = url_3;
            }
            else if (Index == 4)
            {
                sUrl = url_4;
            }

            HttpWebRequest req = (HttpWebRequest)WebRequest.Create(sUrl);
            req.Method = "GET";
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3;
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            try
            {
                WebResponse respon = req.GetResponse();
                Stream res = respon.GetResponseStream();

                String ret = "";
                byte[] buffer = new byte[2048];
                int read = 0;
                while ((read = res.Read(buffer, 0, buffer.Length)) > 0)
                {
                    Console.Write(Encoding.ASCII.GetString(buffer, 0, read));
                    ret += Encoding.ASCII.GetString(buffer, 0, read);
                }

                if (Index == 1)
                {
                    data1.Value = ret;
                }
                else if (Index == 2)
                {
                    data2.Value = ret;
                }
                else if (Index == 3)
                {
                    data3.Value = ret;
                }
                else if (Index == 4)
                {
                    data4.Value = ret;
                }
            }
            catch (WebException wx)
            {
                String _statusCode;
                using (WebResponse response = wx.Response)
                {
                    HttpWebResponse httpResponse = (HttpWebResponse)response;
                    _statusCode = httpResponse.StatusCode.ToString();
                    Omnificence.Trace.Logger.Log("Quick Links Page Error: " + "Error Code: " + _statusCode);
                    Omnificence.Trace.Logger.Log("Page Link: " + sUrl);
                    using (Stream data = response.GetResponseStream())
                    using (var reader = new StreamReader(data))
                    {
                        String text = reader.ReadToEnd();
                        Omnificence.Trace.Logger.Log("HTML Code: " + text);
                    }
                }

                if (sUrl.Equals("http://www.nlm.nih.gov/medlineplus/feeds/topics/hodgkindisease.xml"))
                {
                    MedPlus.InnerText = "No Content Available";
                }
                else if (sUrl.Equals("http://www.hematology.org/RSS.aspx?parenttaxid=102"))
                {
                    ASOH.InnerText = "No Content Available";
                }
                else if (sUrl.Equals("http://jco.ascopubs.org/rss/Hematologic_Malignancies.xml"))
                {
                    ASC.InnerText = "No Content Available";
                }
                else if (sUrl.Equals("http://www.esmo.org/rss/feed/esmo-news"))
                {
                    ESM.InnerText = "No Content Available";
                }
            }
        }
    }
}