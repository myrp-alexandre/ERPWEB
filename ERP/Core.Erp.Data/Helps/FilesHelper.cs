using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Helps
{
   public class FilesHelper
    {
        /*
        public static void FtpUploadFile(UploadedFile file, string nom_archivo, string IdQueja)
        {
            try
            {
                tbl_parametros_correo_Data odata = new tbl_parametros_correo_Data();
                tbl_parametros_correo_Info info = odata.get_info();
                if (info == null)
                    return;

                string ftpurl = String.Format("{0}/{1}/{2}", info.ftp_url, IdQueja, nom_archivo);

                #region Crear directorio
                try
                {
                    WebRequest request = WebRequest.Create(String.Format("{0}/{1}/", info.ftp_url, IdQueja));
                    request.Method = WebRequestMethods.Ftp.MakeDirectory;
                    request.Credentials = new NetworkCredential(info.ftp_usuario, info.ftp_contrasenia);
                    WebResponse response = request.GetResponse();
                }
                catch (Exception)
                {
                    //Si existe se cae
                }
                #endregion

                #region Enviar imágen
                Stream streamObj = file.FileContent;
                byte[] buffer = new byte[file.ContentLength];
                streamObj.Read(buffer, 0, buffer.Length);
                streamObj.Close();
                streamObj = null;
                var requestObj = FtpWebRequest.Create(ftpurl) as FtpWebRequest;
                requestObj.Method = WebRequestMethods.Ftp.UploadFile;
                requestObj.Credentials = new NetworkCredential(info.ftp_usuario, info.ftp_contrasenia);
                Stream requestStream = requestObj.GetRequestStream();
                requestStream.Write(buffer, 0, buffer.Length);
                requestStream.Flush();
                requestStream.Close();
                requestObj = null;
                #endregion
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static List<tbl_queja_imagen> get_list_directory(decimal IdQueja)
        {
            try
            {
                List<tbl_queja_imagen> Lista = new List<tbl_queja_imagen>();
                tbl_parametros_correo_Data odata = new tbl_parametros_correo_Data();
                tbl_parametros_correo_Info info = odata.get_info();
                if (info == null)
                    return new List<tbl_queja_imagen>();

                string url_pagina_web = "http://quejas.degeremcia.com";

                string ftpurl = String.Format("{0}/{1}", info.ftp_url, IdQueja);
                FtpWebRequest ftpRequest = (FtpWebRequest)WebRequest.Create(ftpurl);
                ftpRequest.Credentials = new NetworkCredential(info.ftp_usuario, info.ftp_contrasenia);
                ftpRequest.Method = WebRequestMethods.Ftp.ListDirectory;
                try
                {
                    FtpWebResponse response = (FtpWebResponse)ftpRequest.GetResponse();
                    StreamReader streamReader = new StreamReader(response.GetResponseStream());

                    string line = streamReader.ReadLine();
                    string url_imagen = "";
                    while (!string.IsNullOrEmpty(line))
                    {
                        url_imagen = String.Format("{0}/Content/Documentos/{1}/{2}", url_pagina_web, IdQueja, line);
                        Lista.Add(new tbl_queja_imagen { MediumImageUrl = url_imagen, ThumbnailUrl = url_imagen });
                        line = streamReader.ReadLine();
                    }
                    streamReader.Close();
                }
                catch (Exception)
                {

                }

                return Lista;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        */
    }
}
