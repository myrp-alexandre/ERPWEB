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
        tb_provincia_Bus bus_provincia = new tb_provincia_Bus();
        List<tb_ciudad_Info> lst_ciudad = new List<tb_ciudad_Info>();
        List<tb_provincia_Info> lst_provincia = new List<tb_provincia_Info>();

        public ActionResult Index(string IdProvincia = "")
        {
            ViewBag.IdProvincia = IdProvincia;
            return View();
        }


        [ValidateInput(false)]
        public ActionResult GridViewPartial_Ciudad()
        {
          lst_ciudad = bus_ciudad.get_list(true);
            return PartialView("_GridViewPartial_Ciudad", lst_ciudad);
        }
        private void cargar_combos()
        {
           lst_provincia = bus_provincia.get_list(false);
            ViewBag.lst_provincias = lst_provincia;
        }

        public ActionResult Nuevo(string IdProvincia)
        {
            tb_ciudad_Info model = new tb_ciudad_Info
            {
                IdProvincia = IdProvincia
            };
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(tb_ciudad_Info model)
        {
            if (!bus_ciudad.guardarDB(model))
            {
                ViewBag.IdProvincia = model.IdProvincia;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", ViewBag.IdProvincia = model.IdProvincia );
        }

        public ActionResult Modificar(string IdProvincia = "", string IdCiudad="")
        {
            tb_ciudad_Info model = bus_ciudad.get_info(IdProvincia, IdCiudad);
            if (model == null)
            {
                ViewBag.IdProvincia = IdProvincia;
                return RedirectToAction("Index", IdProvincia = model.IdProvincia);
            }
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(tb_ciudad_Info model)
        {
            if (!bus_ciudad.modificarDB(model))
            {
                ViewBag.IdProvincia = model.IdProvincia;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdProvincia = model.IdProvincia });
        }

        public ActionResult Anular(string IdProvincia = "", string IdCiudad="")
        {
            tb_ciudad_Info model = bus_ciudad.get_info(IdProvincia,  IdCiudad);
            if (model == null)
            {
                ViewBag.IdProvincia = IdProvincia;
                return RedirectToAction("Index", new { IdProvincia = model.IdProvincia });
            }
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(tb_ciudad_Info model)
        {
            if (!bus_ciudad.anularDB(model))
            {
                ViewBag.IdProvincia = model.IdProvincia;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdProvincia = model.IdProvincia });
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