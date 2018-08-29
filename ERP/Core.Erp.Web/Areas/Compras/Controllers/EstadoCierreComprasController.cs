using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Compras;
using Core.Erp.Info.Compras;

namespace Core.Erp.Web.Areas.Compras.Controllers
{
    public class EstadoCierreComprasController : Controller
    {
        com_estado_cierre_Bus bus_estado = new com_estado_cierre_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_estadocierre()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_estadocierre", model);
        }
    }
}