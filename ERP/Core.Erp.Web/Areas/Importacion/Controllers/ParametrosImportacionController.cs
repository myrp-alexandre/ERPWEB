using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Importacion;
using Core.Erp.Info.Importacion;

namespace Core.Erp.Web.Areas.Importacion.Controllers
{
    public class ParametrosImportacionController : Controller
    {
        imp_parametro_Bus bus_parametro = new imp_parametro_Bus();
        public ActionResult Index()
        {
            return View();
        }

    }
}