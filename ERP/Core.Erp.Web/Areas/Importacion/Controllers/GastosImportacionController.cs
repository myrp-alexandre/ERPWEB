using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Importacion.Controllers
{
    public class GastosImportacionController : Controller
    {
        // GET: Importacion/GastosImportacion
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_gastos_imp()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_gastos_imp", model);
        }
    }
}