using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Caja;
using Core.Erp.Bus.Caja;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Areas.Caja.Controllers
{
    public class ConciliacionCajaController : Controller
    {
        cp_conciliacion_Caja_Bus bus_conciliacion = new cp_conciliacion_Caja_Bus();
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

        public ActionResult Nuevo()
        {
            return View();
        }

        public ActionResult Modificar()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_caja(DateTime fecha_ini, DateTime fecha_fin)
        {
            ViewBag.fecha_ini = fecha_ini;
            ViewBag.fecha_fin = fecha_fin;
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var model = bus_conciliacion.get_list(IdEmpresa, fecha_ini, fecha_fin);
            return PartialView("_GridViewPartial_conciliacion_caja", model);
        }
    }
}