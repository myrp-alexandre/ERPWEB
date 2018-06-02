using DevExpress.Web.Mvc;
using System;
using System.Web.Mvc;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    public class DepreciacionAFController : Controller
    {
        Af_Depreciacion_Bus bus_depreciacion = new Af_Depreciacion_Bus();
        Af_Depreciacion_Det_Bus bus_depreciacion_det = new Af_Depreciacion_Det_Bus();       
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

        public ActionResult Nuevo()
        {
            Af_Depreciacion_Info model = new Af_Depreciacion_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"])
            };
            return View();
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Depreciacion_Info model)
        {
            return View(model);
        }

        public ActionResult Modificar()
        {
            Af_Depreciacion_Info model = new Af_Depreciacion_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"])
            };
            return View();
        }

        [HttpPost]
        public ActionResult Modificar(Af_Depreciacion_Info model)
        {
            return View(model);
        }

        public ActionResult Anular()
        {
            Af_Depreciacion_Info model = new Af_Depreciacion_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"])
            };
            return View();
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
}