using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.General;
using Core.Erp.Info.General;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class RegionController : Controller
    {
        tb_region_Bus bus_region = new tb_region_Bus();
        tb_pais_Bus bus_pais = new tb_pais_Bus();
        public ActionResult Index(string IdPais = "")
        {
            ViewBag.IdPais = IdPais;
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_region(string IdPais = "")
        {
            ViewBag.IdPais = IdPais;
            List<tb_region_Info> model = bus_region.get_list(IdPais, true);
            return PartialView("_GridViewPartial_region", model);
        }
        private void cargar_combos()
        {
            var lst_pais = bus_pais.get_list( false);
            ViewBag.lst_pais = lst_pais;
        }
        public ActionResult Nuevo(string IdPais = "")
        {
            tb_region_Info model = new tb_region_Info
            {
                IdPais = IdPais
            };
            cargar_combos();
            return View(model);
        }
    
        [HttpPost]
        public ActionResult Nuevo(tb_region_Info model)
        {
            if(!bus_region.guardarDB(model))
            {
                ViewBag.IdPais = model.IdPais;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string IdPais = "", string codRegion = "")
        {
            tb_region_Info model = bus_region.get_info(IdPais, codRegion);
            if(model == null)
            {
                ViewBag.IdPais = IdPais;
                return RedirectToAction("Index", IdPais = model.IdPais);
            }
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(tb_region_Info model)
        {
            if (!bus_region.modificarDB(model))
            {
                ViewBag.IdPais = model.IdPais;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", ViewBag.IdPais = model.IdPais);
        }
        public ActionResult Anular(string IdPais = "", string codRegion = "")
        {
            tb_region_Info model = bus_region.get_info(IdPais, codRegion);
            if (model == null)
            {
                ViewBag.IdPais = IdPais;
                return RedirectToAction("Index", IdPais = model.IdPais);
            }
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(tb_region_Info model)
        {
            if (!bus_region.anularDB(model))
            {
                ViewBag.IdPais = model.IdPais;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", ViewBag.IdPais = model.IdPais);
        }
    }
}