using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.General;
using Core.Erp.Bus.General;
namespace Core.Erp.Web.Areas.General.Controllers
{
    public class CiudadController : Controller
    {
        tb_ciudad_Bus bus_ciudad = new tb_ciudad_Bus();
        tb_region_Bus bus_region = new tb_region_Bus();
        List<tb_ciudad_Info> lst_ciudad = new List<tb_ciudad_Info>();
        List<tb_region_Info> lst_region = new List<tb_region_Info>();

        public ActionResult Index()
        {
            return View();
        }

        private void cargar_combos()
        {
           lst_region = bus_region.get_list(false);
            ViewBag.lst_region = lst_region;
        }

        public ActionResult Nuevo()
        {
            cargar_combos();
            tb_ciudad_Info model = new tb_ciudad_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(tb_ciudad_Info model)
        {
            if (!bus_ciudad.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string IdProvincia = "", string IdCiudad="")
        {
            tb_ciudad_Info model = bus_ciudad.get_info(IdProvincia, IdCiudad);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(tb_ciudad_Info model)
        {
            if (!bus_ciudad.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(string IdProvincia = "", string IdCiudad="")
        {
            tb_ciudad_Info model = bus_ciudad.get_info(IdProvincia,  IdCiudad);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(tb_ciudad_Info model)
        {
            if (!bus_ciudad.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public JsonResult get_lst_ciudad_x_provincia(string IdProvincia)
        {
            try
            {
                lst_ciudad = bus_ciudad.get_list(IdProvincia);
                return Json(lst_ciudad, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}