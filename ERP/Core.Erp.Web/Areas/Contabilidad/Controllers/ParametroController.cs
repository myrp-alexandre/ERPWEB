using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    public class ParametroController : Controller
    {
        ct_parametro_Bus bus_parametro = new ct_parametro_Bus();

        private void cargar_combos()
        {
            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_ctacble = bus_plancta.get_list(Convert.ToInt32(Session["IdEmpresa"]), false, true);
            ViewBag.lst_cuentas = lst_ctacble;
        }
        public ActionResult Index()
        {
            ct_grupocble_Info model = new ct_grupocble_Info();
            cargar_combos();
            return View();
        }

        [HttpPost]
        public ActionResult Index(ct_parametro_Info model)
        {
            if(!bus_parametro.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_parametro()
        {
            ct_parametro_Info model = new ct_parametro_Info();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            return PartialView("_GridViewPartial_parametro", model);
        }

    }
}