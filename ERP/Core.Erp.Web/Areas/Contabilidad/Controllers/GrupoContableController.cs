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
    public class GrupoContableController : Controller
    {
        ct_grupocble_Bus bus_grupo_cble = new ct_grupocble_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_grupo_cble()
        {
            List<ct_grupocble_Info> model = new List<ct_grupocble_Info>();
            model = bus_grupo_cble.get_list(true);
            return PartialView("_GridViewPartial_grupo_cble", model);
        }

        private void cargar_combos()
        {
            Dictionary<string, string> lst_balances = new Dictionary<string, string>();
            lst_balances.Add("BG","Balance general");
            lst_balances.Add("ER", "Estado de resultados");
            ViewBag.lst_balances = lst_balances;
        }

        public ActionResult Nuevo()
        {
            ct_grupocble_Info model = new ct_grupocble_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ct_grupocble_Info model)
        {
            if(!bus_grupo_cble.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }   

        public ActionResult Modificar(string IdGrupoCble = "")
        {
            ct_grupocble_Info model = bus_grupo_cble.get_info(IdGrupoCble);
            if(model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(ct_grupocble_Info model)
        {
            if(!bus_grupo_cble.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(string IdGrupoCble = "")
        {
            ct_grupocble_Info model = bus_grupo_cble.get_info(IdGrupoCble);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(ct_grupocble_Info model)
        {
            if (!bus_grupo_cble.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}