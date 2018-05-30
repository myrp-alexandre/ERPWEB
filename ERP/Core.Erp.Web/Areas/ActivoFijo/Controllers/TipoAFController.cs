using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.ActivoFijo;
using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Bus.Contabilidad;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    public class TipoAFController : Controller
    {
        Af_Activo_fijo_tipo_Bus bus_tipoactivo = new Af_Activo_fijo_tipo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipoactivo()
        {

            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<Af_Activo_fijo_tipo_Info> model = new List<Af_Activo_fijo_tipo_Info>();
            model = bus_tipoactivo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_tipoactivo", model);
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_cuentas = bus_plancta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuentas = lst_cuentas;
        }
        public ActionResult Nuevo()
        {
            Af_Activo_fijo_tipo_Info model = new Af_Activo_fijo_tipo_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Activo_fijo_tipo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_tipoactivo.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_tipo_Info model = bus_tipoactivo.get_info(IdEmpresa, IdActivoFijoTipo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(Af_Activo_fijo_tipo_Info model)
        {
            if (!bus_tipoactivo.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_tipo_Info model = bus_tipoactivo.get_info(IdEmpresa, IdActivoFijoTipo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(Af_Activo_fijo_tipo_Info model)
        {
            if (!bus_tipoactivo.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}