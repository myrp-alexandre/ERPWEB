using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.General;
using Core.Erp.Bus.General;
namespace Core.Erp.Web.Areas.General.Controllers
{
    public class ParroquiaController : Controller
    {
        tb_parroquia_Bus bus_parroquia = new tb_parroquia_Bus();
        tb_ciudad_Bus bus_ciudad = new tb_ciudad_Bus();

        public ActionResult Index(string IdCiudad_Canton = "")
        {
            ViewBag.IdCiudad_Canton = IdCiudad_Canton;
            return View();
        }


        [ValidateInput(false)]
        public ActionResult GridViewPartial_parroquia()
        {
            var lst_parroquia = bus_parroquia.get_list(true);
            return PartialView("_GridViewPartial_parroquia", lst_parroquia);
        }
        private void cargar_combos()
        {
            var lst_ciudades = bus_ciudad.get_list(false);
            ViewBag.lst_ciudades = lst_ciudades;
        }

        public ActionResult Nuevo(string IdCiudad_Canton = "")
        {
            tb_parroquia_Info model = new tb_parroquia_Info
            {
                IdCiudad_Canton = IdCiudad_Canton
            };
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(tb_parroquia_Info model)
        {
            if (!bus_parroquia.guardarDB(model))
            {
                ViewBag.IdCiudad = model.IdCiudad_Canton;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdCiudad = model.IdCiudad_Canton });
        }

        public ActionResult Modificar(string IdCiudad_Canton = "", string IdParroquia = "")
        {
            tb_parroquia_Info model = bus_parroquia.get_info(IdCiudad_Canton, IdParroquia);
            if (model == null)
            {
                ViewBag.IdCiudad = model.IdCiudad_Canton;
                return RedirectToAction("Index", new { IdCiudad = model.IdCiudad_Canton });
            }
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(tb_parroquia_Info model)
        {
            if (!bus_parroquia.modificarDB(model))
            {
                ViewBag.IdCiudad = model.IdCiudad_Canton;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdCiudad = model.IdCiudad_Canton });
        }


        public ActionResult Anular(string IdCiudad_Canton = "", string IdParroquia = "")
        {
            tb_parroquia_Info model = bus_parroquia.get_info(IdCiudad_Canton, IdParroquia);
            if (model == null)
            {
                ViewBag.IdCiudad = model.IdCiudad_Canton;
                return RedirectToAction("Index", new { IdCiudad = model.IdCiudad_Canton });
            }
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(tb_parroquia_Info model)
        {
            if (!bus_parroquia.anularDB(model))
            {
                ViewBag.IdCiudad = model.IdCiudad_Canton;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdCiudad = model.IdCiudad_Canton });
        }

   public JsonResult get_lst_ciudad_x_provincia(string IdCiudad_Canton)
        {
            try
            {
               var lst_parroquia = bus_parroquia.get_list(true);
                return Json(lst_parroquia, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {

               throw;
            }
        }
    }
}