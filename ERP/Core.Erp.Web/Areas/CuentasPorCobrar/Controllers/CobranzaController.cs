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
        // GET: CuentasPorCobrar/Cobranza
        public ActionResult Index()
        {
            return View();
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