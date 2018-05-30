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
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_region()
        {
            List<tb_region_Info> model = bus_region.get_list(true);
            return PartialView("_GridViewPartial_region", model);
        }

        public ActionResult Nuevo()
        {
            tb_region_Info model = new tb_region_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(tb_region_Info model)
        {
            if(!bus_region.guardarDB(model))
                return View(model);

            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string codRegion = "")
        {
            tb_region_Info model = bus_region.get_info(codRegion);
            if(model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(tb_region_Info model)
        {
            if (!bus_region.modificarDB(model))
                return View(model);

            return RedirectToAction("Index");
        }

        public ActionResult Anular(string codRegion = "")
        {
            tb_region_Info model = bus_region.get_info(codRegion);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(tb_region_Info model)
        {
            if (!bus_region.anularDB(model))
                return View(model);

            return RedirectToAction("Index");
        }
    }
}