using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Info.ActivoFijo;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    public class CatalogoTipoAFController : Controller
    {
        Af_CatalogoTipo_Bus bus_catalogo = new Af_CatalogoTipo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_catalogotipo_af()
        {
            var model = bus_catalogo.get_list();
            return PartialView("_GridViewPartial_catalogotipo_af", model);
        }
        public ActionResult Nuevo()
        {
            Af_CatalogoTipo_Info model = new Af_CatalogoTipo_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(Af_CatalogoTipo_Info model)
        {
            if (bus_catalogo.validar_existe_IdTipoCatalogo(model.IdTipoCatalogo))
            {
                ViewBag.mensaje = "El código ya se encuentra registrado";
                ViewBag.IdTipoCatalogo = model.IdTipoCatalogo;
                return View(model);
            }
            if (!bus_catalogo.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string IdTipoCatalogo = "")
        {
            Af_CatalogoTipo_Info model = bus_catalogo.get_info(IdTipoCatalogo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(Af_CatalogoTipo_Info model)
        {
            if (!bus_catalogo.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}