using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Facturacion;
using Core.Erp.Info.Facturacion;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class TipoNotaController : Controller
    {
        fa_TipoNota_Bus bus_tiponota = new fa_TipoNota_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tiponota()
        {
            List<fa_TipoNota_Info> model = bus_tiponota.get_list(true);
            return PartialView("_GridViewPartial_tiponota", model);
        }

        private void cargar_combos()
        {
            Dictionary<string, string> lst_tipos = new Dictionary<string, string>();
            lst_tipos.Add("C", "Credito");
            lst_tipos.Add("D", "Debito");
            ViewBag.lst_tipos = lst_tipos;
        }
        public ActionResult Nuevo()
        {
            fa_TipoNota_Info model = new fa_TipoNota_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(fa_TipoNota_Info model)
        {
            if (!bus_tiponota.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int  IdTipoNota = 0)
        {
            fa_TipoNota_Info model = bus_tiponota.get_info(IdTipoNota);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_TipoNota_Info model)
        {
            if (!bus_tiponota.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdTipoNota = 0)
        {
            fa_TipoNota_Info model = bus_tiponota.get_info(IdTipoNota);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_TipoNota_Info model)
        {
            if (!bus_tiponota.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipo_nota_sucursal()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_tipo_nota_sucursal", model);
        }
    }
}