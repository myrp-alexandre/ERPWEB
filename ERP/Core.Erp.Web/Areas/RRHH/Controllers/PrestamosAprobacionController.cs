using Core.Erp.Bus.RRHH;
using Core.Erp.Info.Helps;
using Core.Erp.Info.RRHH;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class PrestamosAprobacionController : Controller
    {
        ro_prestamo_Bus bus_prestamos = new ro_prestamo_Bus();
        // GET: RRHH/PrestamosAprobacion
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            return View(model);
        }


        [ValidateInput(false)]
        public ActionResult GridViewPartial_prestamos_aprobacion(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            List<ro_prestamo_Info> model = bus_prestamos.get_list_aprobacion(IdEmpresa, Convert.ToDateTime(Fecha_ini), Convert.ToDateTime(Fecha_fin));
            return PartialView("_GridViewPartial_prestamos_aprobacion", model);
        }

        public JsonResult aprobar(int IdEmpresa = 0, string Ids = "")
        {
            string[] array = Ids.Split(',');
            string IdUsuarioAprueba = SessionFixed.IdUsuario;
            if (string.IsNullOrEmpty(Ids))
            {
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var resultado_orden = bus_prestamos.aprobar_prestamo(IdEmpresa, array, IdUsuarioAprueba);
                return Json(resultado_orden, JsonRequestBehavior.AllowGet);
            }
        }
    }
}