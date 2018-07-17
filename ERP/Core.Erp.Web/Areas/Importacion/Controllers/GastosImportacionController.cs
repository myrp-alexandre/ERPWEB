using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Importacion;
using Core.Erp.Info.Importacion;
using Core.Erp.Bus.Contabilidad;

namespace Core.Erp.Web.Areas.Importacion.Controllers
{
    public class GastosImportacionController : Controller
    {
        imp_gasto_Bus bus_gasto = new imp_gasto_Bus();
        imp_gasto_x_ct_plancta_Bus bus_gasto_ct = new imp_gasto_x_ct_plancta_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_gastos_imp()
        {
            List<imp_gasto_Info> model = bus_gasto.get_list();
            return PartialView("_GridViewPartial_gastos_imp", model);
        }
        private void cargar_combos()
        {
            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_ctacble = bus_plancta.get_list(Convert.ToInt32(Session["IdEmpresa"]), false, false);
            ViewBag.lst_cuentas = lst_ctacble;
        }

        public ActionResult Nuevo(int IdGasto_tipo = 0)
        {
            imp_gasto_Info model = new imp_gasto_Info
            {
                info_gasto_cta = new imp_gasto_x_ct_plancta_Info()
            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(imp_gasto_Info model)
        {
            if (!bus_gasto.guardarDB(model))
            {
                model.info_gasto_cta.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
                model.info_gasto_cta.IdGasto_tipo = model.IdGasto_tipo;
                bus_gasto_ct.guardarDB(model.info_gasto_cta);
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdGasto_tipo = 0)
        {
            imp_gasto_Info model = bus_gasto.get_info(IdGasto_tipo);
            if (model == null)
                return RedirectToAction("Index");
            model.info_gasto_cta = bus_gasto_ct.get_info(IdGasto_tipo, Convert.ToInt32(Session["IdEmpresa"]));
            if (model.info_gasto_cta == null)
                model.info_gasto_cta = new imp_gasto_x_ct_plancta_Info
                {
                    IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                    IdGasto_tipo = model.IdGasto_tipo
                };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(imp_gasto_Info model)
        {
            if (!bus_gasto.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdGasto_tipo = 0)
        {
            imp_gasto_Info model = bus_gasto.get_info(IdGasto_tipo);
            if (model == null)
                return RedirectToAction("Index");
            model.info_gasto_cta = bus_gasto_ct.get_info(IdGasto_tipo, Convert.ToInt32(Session["IdEmpresa"]));
            if (model.info_gasto_cta == null)
                model.info_gasto_cta = new imp_gasto_x_ct_plancta_Info
                {
                    IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                    IdGasto_tipo = model.IdGasto_tipo
                };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(imp_gasto_Info model)
        {
            if (!bus_gasto.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}