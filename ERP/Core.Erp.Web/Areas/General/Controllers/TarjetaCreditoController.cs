using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using Core.Erp.Web.Helps;
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


        #region Acciones
        public ActionResult Nuevo()
        {
            tb_TarjetaCredito_Info model = new tb_TarjetaCredito_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(tb_TarjetaCredito_Info model)
        {
            model.IdUsuario = SessionFixed.IdUsuario;
            if (!bus_TarjetaCredito.GuardarBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdTarjeta = 0)
        {
            tb_TarjetaCredito_Info model = bus_TarjetaCredito.GetInfo(IdTarjeta);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(tb_TarjetaCredito_Info model)
        {
            model.IdUsuarioUltMod = SessionFixed.IdUsuario;
            if (!bus_TarjetaCredito.ModificarBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdTarjeta = 0)
        {
            tb_TarjetaCredito_Info model = bus_TarjetaCredito.GetInfo(IdTarjeta);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(tb_TarjetaCredito_Info model)
        {
            model.IdUsuarioUltAnu = SessionFixed.IdUsuario;
            if (!bus_TarjetaCredito.AnularBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion
    }
}