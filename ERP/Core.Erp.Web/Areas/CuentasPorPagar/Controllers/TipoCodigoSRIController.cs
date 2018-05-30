using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Info.CuentasPorPagar;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class TipoCodigoSRIController : Controller
    {
        cp_codigo_SRI_tipo_Bus bus_tipo_codigo = new cp_codigo_SRI_tipo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipo_codigo_sri()
        {
            List<cp_codigo_SRI_tipo_Info> model = new List<cp_codigo_SRI_tipo_Info>();
            model = bus_tipo_codigo.get_list(true);
            return PartialView("_GridViewPartial_tipo_codigo_sri", model);
        }
        public ActionResult Nuevo()
        {
            cp_codigo_SRI_tipo_Info model = new cp_codigo_SRI_tipo_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_codigo_SRI_tipo_Info model)
        {
            if(bus_tipo_codigo.validar_existe_codigo_tipo(model.IdTipoSRI))
            {
                ViewBag.mensaje = "El código ya se encuentra registrado";
                return View(model);
            }

            if (!bus_tipo_codigo.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string IdTipoSRI = "")
        {
            cp_codigo_SRI_tipo_Info model = bus_tipo_codigo.get_info(IdTipoSRI);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_codigo_SRI_tipo_Info model)
        {
            if (!bus_tipo_codigo.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(string IdTipoSRI = "")
        {
            cp_codigo_SRI_tipo_Info model = bus_tipo_codigo.get_info(IdTipoSRI);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(cp_codigo_SRI_tipo_Info model)
        {
            if (!bus_tipo_codigo.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}