﻿using Core.Erp.Bus.General;
using Core.Erp.Bus.Helps;
using Core.Erp.Bus.RRHH;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Info.RRHH;
using Core.Erp.Info.RRHH.RDEP;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Xml;
using System.Xml.Serialization;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class RdepController : Controller
    {
        #region variables
        Rdep_Info_lis Lis_Rdep_Info_lis = new Rdep_Info_lis();
        Rdep_Bus bus_rpde = new Rdep_Bus();
        FilesHelper_Bus FilesHelper_B = new FilesHelper_Bus();

        #endregion

        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbEmpleado_rdep()
        {
            Rdep_Info model = new Rdep_Info();
            return PartialView("_CmbEmpleado_rdep", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        #endregion

        #region vistas
        public ActionResult Index()
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            return View();
        }
        [HttpPost]
        public ActionResult Index(Rdep_Info model)
        {
            string nombre_file ="RDEP";
            
            string xml = "";
            rdep rdep = new rdep();
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            int IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            rdep = bus_rpde.get_list(IdEmpresa,Convert.ToInt32( model.pe_anio), " ");
            var ms = new MemoryStream();
            var xw = XmlWriter.Create(ms);
            string patch = Path.Combine(Server.MapPath("~/Content/file"), nombre_file);


            var serializer = new XmlSerializer(rdep.GetType());
            XmlSerializerNamespaces ns = new XmlSerializerNamespaces();
            ns.Add("", "");
            serializer.Serialize(xw, rdep, ns);
            xw.Flush();
            ms.Seek(0, SeekOrigin.Begin);
            using (var sr = new StreamReader(ms, Encoding.UTF8))
            {
                xml = sr.ReadToEnd();
            }


            if (System.IO.File.Exists(patch + ".xml"))
                System.IO.File.Delete(patch + ".xml");
            using (System.IO.StreamWriter file = new System.IO.StreamWriter(patch + ".xml", true))
            {
                file.WriteLine(xml);
                file.Close();
                byte[] fileBytes = System.IO.File.ReadAllBytes(patch + ".xml");
                FilesHelper_B.Guardar_xml(fileBytes, nombre_file, "", "", "");
                patch = patch + ".xml";
                return File(Encoding.UTF8.GetBytes(xml), "application/xml", nombre_file + ".xml");
            }
        }
        public ActionResult GridViewPartial_rdep_det()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;

            List<Rdep_Info> model = new List<Rdep_Info>();
            model = Lis_Rdep_Info_lis.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return View(model);
        }
        #endregion

        #region Funciones Json

        public JsonResult Mostrar(int Anio, decimal IdEmpleado)
        {

            int IdEmpresa= Convert.ToInt32( SessionFixed.IdEmpresa);
            List<Rdep_Info> model = new List<Rdep_Info>();
            model = bus_rpde.get_list(IdEmpresa, Anio);
            Lis_Rdep_Info_lis.set_list(model,Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual) );
            return Json("", JsonRequestBehavior.AllowGet);
        }
        #endregion
    }


    public class  Rdep_Info_lis
  {
        string variable = "Rdep_Info";
        public List<Rdep_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[variable+IdTransaccionSession.ToString()] == null)
            {
                List<Rdep_Info> list = new List<Rdep_Info>();

                HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<Rdep_Info>)HttpContext.Current.Session[variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<Rdep_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[variable+IdTransaccionSession.ToString()] = list;
        }

    }
}