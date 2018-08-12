using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    public class CategoriaAFController : Controller
    {
        Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
        public ActionResult Index(int IdActivoFijoTipo = 0)
        {
            ViewBag.IdActivoFijoTipo = IdActivoFijoTipo;
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_categoria_activo(int IdEmpresa = 0, int IdActivoFijoTipo = 0)
        {
            List<Af_Activo_fijo_Categoria_Info> model = new List<Af_Activo_fijo_Categoria_Info>();
            model = bus_categoria.get_list(IdEmpresa, IdActivoFijoTipo, true);
            ViewBag.IdActivoFijoTipo = IdActivoFijoTipo;
            return PartialView("_GridViewPartial_categoria_activo", model);
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_tipo_Bus bus_tipo = new Af_Activo_fijo_tipo_Bus();
            var lst_tipo= bus_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;
        }
        public ActionResult Nuevo(int IdActivoFijoTipo = 0)
        {
            Af_Activo_fijo_Categoria_Info model = new Af_Activo_fijo_Categoria_Info
            {

            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
            IdActivoFijoTipo = IdActivoFijoTipo

            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Activo_fijo_Categoria_Info model)
        {
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_categoria.guardarDB(model))
            {
                ViewBag.IdActivoFijoTipo = model.IdActivoFijoTipo;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdActivoFijoTipo = model.IdActivoFijoTipo });
        }

        public ActionResult Modificar(int IdActivoFijoTipo = 0, int IdCategoriaAF = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_Categoria_Info model = bus_categoria.get_info(IdEmpresa, IdCategoriaAF);
            if (model == null)
                return RedirectToAction("Index", new { IdActivoFijoTipo = IdActivoFijoTipo });
            ViewBag.IdActivoFijoTipo = IdActivoFijoTipo;
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(Af_Activo_fijo_Categoria_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_categoria.modificarDB(model))
            {
                ViewBag.IdActivoFijoTipo = model.IdActivoFijoTipo;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdActivoFijoTipo = model.IdActivoFijoTipo });
        }

        public ActionResult Anular(int IdActivoFijoTipo = 0, int IdCategoriaAF = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_Categoria_Info model = bus_categoria.get_info(IdEmpresa, IdCategoriaAF);
            if (model == null)
                return RedirectToAction("Index", new { IdActivoFijoTipo = IdActivoFijoTipo });
            ViewBag.IdActivoFijoTipo = IdActivoFijoTipo;
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(Af_Activo_fijo_Categoria_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            if (!bus_categoria.anularDB(model))
            {
                ViewBag.IdActivoFijoTipo = model.IdActivoFijoTipo;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdActivoFijoTipo = model.IdActivoFijoTipo });
        }
    }
}