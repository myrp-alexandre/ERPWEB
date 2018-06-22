using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.General;
using Core.Erp.Bus.General;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class ProvinciaController : Controller
    {
        tb_provincia_Bus bus_provincia = new tb_provincia_Bus();
        tb_pais_Bus bus_pais = new tb_pais_Bus();
        tb_region_Bus bus_region = new tb_region_Bus();
        public ActionResult Index()
        {
            return View();
        }

        private void cargar_combos()
        {
            List<tb_pais_Info> lst_pais = bus_pais.get_list(false);
           // List<tb_region_Info> lst_region = bus_region.get_list(false);

            ViewBag.lst_paises = lst_pais;
         //   ViewBag.lst_regiones = lst_region;
        }

        public ActionResult Nuevo()
        {
            cargar_combos();
            tb_provincia_Info model = new tb_provincia_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(tb_provincia_Info model)
        {
            if (!bus_provincia.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string IdProvincia = "")
        {
            tb_provincia_Info model = bus_provincia.get_info(IdProvincia);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();            
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(tb_provincia_Info model)
        {
            if (!bus_provincia.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(string IdProvincia = "")
        {
            tb_provincia_Info model = bus_provincia.get_info(IdProvincia);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(tb_provincia_Info model)
        {
            if (!bus_provincia.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_provincia()
        {
            List<tb_provincia_Info> model = bus_provincia.get_list(true);
            return PartialView("_GridViewPartial_provincia", model);
        }

        public JsonResult get_lst_provincia_pais(string IdPais)
        {
            try
            {
                List<tb_provincia_Info> lst_provincia =new List<tb_provincia_Info>();

                lst_provincia = bus_provincia.get_list(IdPais);
                return Json(lst_provincia, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}