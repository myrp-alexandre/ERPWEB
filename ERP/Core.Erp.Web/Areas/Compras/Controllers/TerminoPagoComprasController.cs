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
    public class TerminoPagoComprasController : Controller
    {
        com_TerminoPago_Bus bus_termino = new com_TerminoPago_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_terminopago_com()
        {
            var model = bus_termino.get_list(true);
            return PartialView("_GridViewPartial_terminopago_com", model);
        }

        public ActionResult Nuevo ()
        {
            com_TerminoPago_Info model = new com_TerminoPago_Info();
            return View(model);
        }


    }
}