using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    public class GastoController : Controller
    {
        // GET: Contabilidad/Gasto
        #region Variables
        ct_gasto_Bus bus_gasto;
        #endregion

        public GastoController()
        {
            bus_gasto = new ct_gasto_Bus();
            string mensaje = string.Empty;
        }

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_Gasto()
        {
            var model = bus_gasto.GetList(true);
            return PartialView("_GridViewPartial_Gasto", model);

        }

        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            #endregion

            ct_gasto_Info model = new ct_gasto_Info
            {
                IdEmpresa = IdEmpresa,
            };

            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ct_gasto_Info model)
        {
            if (!bus_gasto.GuardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}