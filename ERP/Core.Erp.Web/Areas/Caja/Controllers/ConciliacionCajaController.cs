using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Caja.Controllers
{
    public class ConciliacionCajaController : Controller
    {
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

        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_caja()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_conciliacion_caja", model);
        }
    }
}