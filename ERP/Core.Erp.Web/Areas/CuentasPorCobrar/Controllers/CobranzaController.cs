using Core.Erp.Bus.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class CobranzaController : Controller
    {
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal)
            };
            cargar_combos();
            return View();
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            cargar_combos();
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

        public ActionResult Anular()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_cobranza", model);
        }
    }
}