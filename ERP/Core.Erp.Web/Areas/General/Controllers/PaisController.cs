using DevExpress.Web.Mvc;
using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class PaisController : Controller
    {
        tb_pais_Bus bus_pais = new tb_pais_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_pais()
        {
            List<tb_pais_Info> model = new List<tb_pais_Info>();
            model = bus_pais.get_list(true);
            return PartialView("_GridViewPartial_pais", model);
        }

        public ActionResult Nuevo()
        {
            tb_pais_Info model = new tb_pais_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo (tb_pais_Info model)
        {
            if (!bus_pais.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar (string IdPais = "")
        {
            tb_pais_Info model = bus_pais.get_info(IdPais);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar (tb_pais_Info model)
        {
            if(!bus_pais.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(string IdPais)
        {
            tb_pais_Info model = bus_pais.get_info(IdPais);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(tb_pais_Info model)
        {
            if (!bus_pais.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}