using DevExpress.Web.Mvc;
using System;
using System.Web.Mvc;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
using System.Collections.Generic;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.Contabilidad;
using System.Web;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    public class DepreciacionAFController : Controller
    {
        Af_Depreciacion_Bus bus_depreciacion = new Af_Depreciacion_Bus();
        Af_Depreciacion_Det_Bus bus_depreciacion_det = new Af_Depreciacion_Det_Bus();
        Af_Depreciacion_Det_list lst_depreciacion_det = new Af_Depreciacion_Det_list();
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_depreciacion(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.fecha_ini = Fecha_ini == null ? DateTime.Now : Fecha_ini;
            ViewBag.fecha_fin = Fecha_fin == null ? DateTime.Now : Fecha_fin;
            var model = bus_depreciacion.get_list(IdEmpresa,true,ViewBag.fecha_ini, ViewBag.fecha_fin);
            return PartialView("_GridViewPartial_depreciacion", model);
        }

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
            var lst_periodo = bus_periodo.get_list(IdEmpresa, false);
            ViewBag.lst_periodo = lst_periodo;
        }

        public ActionResult Nuevo()
        {
            Af_Depreciacion_Info model = new Af_Depreciacion_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                Fecha_Depreciacion = DateTime.Now.Date,
                IdPeriodo = Convert.ToInt32(DateTime.Now.Date.ToString("yyyyMM")),
                lst_detalle = new List<Af_Depreciacion_Det_Info>()
            };
            lst_depreciacion_det.set_list(model.lst_detalle);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Depreciacion_Info model)
        {
            return View(model);
        }

        public ActionResult Modificar(decimal IdDepreciacion = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Depreciacion_Info model = bus_depreciacion.get_info(IdEmpresa, IdDepreciacion);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_detalle = bus_depreciacion_det.get_list(IdEmpresa, IdDepreciacion);
            lst_depreciacion_det.set_list(model.lst_detalle);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(Af_Depreciacion_Info model)
        {
            return View(model);
        }

        public ActionResult Anular(decimal IdDepreciacion = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Depreciacion_Info model = bus_depreciacion.get_info(IdEmpresa, IdDepreciacion);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_detalle = bus_depreciacion_det.get_list(IdEmpresa, IdDepreciacion);
            lst_depreciacion_det.set_list(model.lst_detalle);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(Af_Depreciacion_Info model)
        {
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_depreciacion_det(decimal IdDepreciacion = 0)
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_depreciacion_det", model);
        }
    }

    public class Af_Depreciacion_Det_list
    {
        public List<Af_Depreciacion_Det_Info> get_list()
        {
            if (HttpContext.Current.Session["Af_Depreciacion_Det_Info"] == null)
            {
                List<Af_Depreciacion_Det_Info> list = new List<Af_Depreciacion_Det_Info>();

                HttpContext.Current.Session["Af_Depreciacion_Det_Info"] = list;
            }
            return (List<Af_Depreciacion_Det_Info>)HttpContext.Current.Session["Af_Depreciacion_Det_Info"];
        }

        public void set_list(List<Af_Depreciacion_Det_Info> list)
        {
            HttpContext.Current.Session["Af_Depreciacion_Det_Info"] = list;
        }
    }
}