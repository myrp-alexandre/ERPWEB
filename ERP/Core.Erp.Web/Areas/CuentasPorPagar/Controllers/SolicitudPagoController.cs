using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class SolicitudPagoController : Controller
    {
        // GET: CuentasPorPagar/SolicitudPago
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_solicitud_pago()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_solicitud_pago", model);
        }
    }
}