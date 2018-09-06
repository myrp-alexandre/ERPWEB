using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
using Core.Erp.Web.Helps;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    [SessionTimeout]

    public class CategoriaAFController : Controller
    {
        #region variables
        Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
        Af_Activo_fijo_tipo_Bus bus_tipo = new Af_Activo_fijo_tipo_Bus();

        #endregion

        #region Index
        public ActionResult Index(int IdEmpresa = 0 ,int IdActivoFijoTipo = 0)
        {
            ViewBag.IdEmpresa = IdEmpresa;
            ViewBag.IdActivoFijoTipo = IdActivoFijoTipo;
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_categoria_activo(int IdEmpresa = 0, int IdActivoFijoTipo = 0)
        {
            var model = bus_categoria.get_list(IdEmpresa, IdActivoFijoTipo, true);
            ViewBag.IdEmpresa = IdEmpresa;
            ViewBag.IdActivoFijoTipo = IdActivoFijoTipo;
            return PartialView("_GridViewPartial_categoria_activo", model);
        }
        #endregion

        #region Metodos
        private void cargar_combos(int IdEmpresa)
        {
            var lst_tipo= bus_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;
        }

        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0, int IdActivoFijoTipo = 0)
        {
            Af_Activo_fijo_Categoria_Info model = new Af_Activo_fijo_Categoria_Info
            {

                IdEmpresa = IdEmpresa,
                IdActivoFijoTipo = IdActivoFijoTipo

            };
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Activo_fijo_Categoria_Info model)
        {
            if (!bus_categoria.guardarDB(model))
            {
                ViewBag.IdActivoFijoTipo = model.IdActivoFijoTipo;
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index", new { IdEmpresa = model.IdEmpresa, IdActivoFijoTipo = model.IdActivoFijoTipo });
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdActivoFijoTipo = 0, int IdCategoriaAF = 0)
        {
            Af_Activo_fijo_Categoria_Info model = bus_categoria.get_info(IdEmpresa, IdCategoriaAF);
            if (model == null)
                return RedirectToAction("Index", new { IdEmpresa = IdEmpresa, IdActivoFijoTipo = IdActivoFijoTipo });
            ViewBag.IdActivoFijoTipo = IdActivoFijoTipo;
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(Af_Activo_fijo_Categoria_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_categoria.modificarDB(model))
            {
                ViewBag.IdActivoFijoTipo = model.IdActivoFijoTipo;
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index", new { IdEmpresa = model.IdEmpresa, IdActivoFijoTipo = model.IdActivoFijoTipo });
        }

        public ActionResult Anular(int IdEmpresa = 0, int IdActivoFijoTipo = 0, int IdCategoriaAF = 0)
        {
            Af_Activo_fijo_Categoria_Info model = bus_categoria.get_info(IdEmpresa, IdCategoriaAF);
            if (model == null)
                return RedirectToAction("Index", new { IdEmpresa = IdEmpresa, IdActivoFijoTipo = IdActivoFijoTipo });
            ViewBag.IdActivoFijoTipo = IdActivoFijoTipo;
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(Af_Activo_fijo_Categoria_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            if (!bus_categoria.anularDB(model))
            {
                ViewBag.IdActivoFijoTipo = model.IdActivoFijoTipo;
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index", new { IdEmpresa = model.IdEmpresa, IdActivoFijoTipo = model.IdActivoFijoTipo });
        }
    }
    #endregion

}