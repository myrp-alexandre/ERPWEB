﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Contabilidad.ATS.ATS_Info;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using System.IO;

namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    public class ATSController : Controller
    {
        ats_Bus bus_ats = new ats_Bus();
        // GET: CuentasPorPagar/ATS
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Nuevo()
        {

            ats_Info model = new ats_Info
            {
             
            };

            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(ats_Info model)
        {

           
            return View(model);
        }

        public ActionResult GridViewPartial_ventas()
        {
            List<ventas_Info> model = new List<ventas_Info>();
            model=Session["lst_ventas"] as List<ventas_Info>;
            return PartialView("_GridViewPartial_ventas", model);
        }
        public ActionResult GridViewPartial_compras()
        {
            List<compras_Info> model = new List<compras_Info>();
            model = Session["lst_compras"] as List<compras_Info>;

            return PartialView("_GridViewPartial_compras", model);
        }
        public ActionResult GridViewPartial_retenciones()
        {
            List<retenciones_Info> model = new List<retenciones_Info>();
          model=  Session["lst_retenciones"] as List<retenciones_Info>;

            return PartialView("_GridViewPartial_retenciones", model);
        }

        public ActionResult DownLoadFile()
        {
            MemoryStream memoryStream = new MemoryStream();
            TextWriter tw = new StreamWriter(memoryStream);

            tw.WriteLine("Hello World");
            tw.Flush();
            tw.Close();

            return File(memoryStream.GetBuffer(), "text/plain", "file.xml");
        }
        private void cargar_combos(string TipoPersona = "")
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
            var lst_periodos = bus_periodo.get_list(IdEmpresa,false);
            ViewBag.lst_periodos = lst_periodos;

        }


        #region json
        public JsonResult get_ats(int IdPeriodo)
        {
            ats_Info model = new ats_Info();
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            model = bus_ats.get_info(IdEmpresa, IdPeriodo);
            Session["lst_compras"] = model.lst_compras;
            Session["lst_ventas"] = model.lst_ventas;
            Session["lst_retenciones"] = model.lst_retenciones;


            return Json("", JsonRequestBehavior.AllowGet);
        }
      
        #endregion

    }
}