using Core.Erp.Bus.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class TarjetaCreditoController : Controller
    {
        // GET: General/TarjetaCredito
        #region Variables
        tb_TarjetaCredito_Bus bus_TarjetaCredito;
        #endregion

        public TarjetaCreditoController()
        {
            bus_TarjetaCredito = new tb_TarjetaCredito_Bus();
        }

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GridViewPartial_TarjetaCredito()
        {
            var model = bus_TarjetaCredito.GetList(true);
            return PartialView("_GridViewPartial_TarjetaCredito", model);

        }
    }
}