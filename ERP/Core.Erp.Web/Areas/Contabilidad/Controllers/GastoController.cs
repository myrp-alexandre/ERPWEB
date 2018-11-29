using Core.Erp.Bus.Contabilidad;
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
        public ActionResult Index()
        {
            return View();
        }

        ct_gasto_Bus bus_gasto = new ct_gasto_Bus();

        [ValidateInput(false)]
        public ActionResult GridViewPartial_Gasto()
        {
            var model = bus_gasto.GetList(true);
            return PartialView("GridViewPartial_Gasto", model);
        }        
    }
}