using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.RRHH;
using Core.Erp.Bus.RRHH;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class PermisoEmpleadoController : Controller
    {
        ro_permiso_x_empleado_Bus bus_permiso = new ro_permiso_x_empleado_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_permiso_emp()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_permiso.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_permiso_emp", model);
        }

        public ActionResult Nuevo()
        {
            ro_permiso_x_empleado_Info model = new ro_permiso_x_empleado_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa)
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(ro_permiso_x_empleado_Info model)
        {
            if (!bus_permiso.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}