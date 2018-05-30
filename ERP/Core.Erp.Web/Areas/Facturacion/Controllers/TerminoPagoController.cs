using Core.Erp.Bus.Facturacion;
using Core.Erp.Info.Facturacion;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class TerminoPagoController : Controller
    {
        fa_TerminoPago_Bus bus_terminopago = new fa_TerminoPago_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_terminopago()
        {
            List<fa_TerminoPago_Info> model = bus_terminopago.get_list(true);
            return PartialView("_GridViewPartial_terminopago", model);
        }

        public ActionResult Nuevo()
        {
            fa_TerminoPago_Info model = new fa_TerminoPago_Info();
            return View();
        }

        [HttpPost]
        public ActionResult Nuevo(fa_TerminoPago_Info model)
        {
            if (bus_terminopago.validar_existe_IdTerminoPago(model.IdTerminoPago))
            {
                ViewBag.mensaje = "El código ya se encuentra registrado";
                return View(model);
            }
            if (!bus_terminopago.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string IdTerminoPago = "")
        {
            fa_TerminoPago_Info model = bus_terminopago.get_info(IdTerminoPago);
            if (model == null)
            {
                return RedirectToAction("Index");
                
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_TerminoPago_Info model)
        {
            if (!bus_terminopago.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(string IdTerminoPago = "")
        {
            fa_TerminoPago_Info model = bus_terminopago.get_info(IdTerminoPago);
            if (model == null)
            {
                return RedirectToAction("Index");

            }
            return View(model);
        }


        [HttpPost]
        public ActionResult Anular(fa_TerminoPago_Info model)
        {
            if (!bus_terminopago.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}