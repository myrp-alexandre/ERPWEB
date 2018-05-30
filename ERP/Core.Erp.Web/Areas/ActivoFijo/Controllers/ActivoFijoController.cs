using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.General;
using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
using Core.Erp.Info.Helps;
namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    public class ActivoFijoController : Controller
    {
        Af_Activo_fijo_Bus bus_activo = new Af_Activo_fijo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_activo_fijo()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<Af_Activo_fijo_Info> model = new List<Af_Activo_fijo_Info>();
            model = bus_activo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_activo_fijo", model);
        }

        private void cargar_combos(int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_tipo_Bus bus_tipo = new Af_Activo_fijo_tipo_Bus();
            var lst_tipo= bus_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;

            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
            var lst_categoria = bus_categoria.get_list(IdEmpresa, IdActivoFijoTipo, false);
            ViewBag.lst_categoria = lst_categoria;

            Af_Catalogo_Bus bus_catalogo = new Af_Catalogo_Bus();
            var lst_color = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_COLOR), false);
            ViewBag.lst_color = lst_color;

            var lst_modelo = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_MODELO), false);
            ViewBag.lst_modelo = lst_modelo;

            var lst_estado = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_ESTADO_AF), false);
            ViewBag.lst_estado = lst_estado;

            var lst_marca = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_MARCA), false);
            ViewBag.lst_marca = lst_marca;

            var lst_ubicacion = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_UBICACION), false);
            ViewBag.lst_ubicacion = lst_ubicacion;
        }

        public ActionResult Nuevo()
        {
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                Af_fecha_compra = DateTime.Now,
                Af_fecha_fin_depre = DateTime.Now,
                Af_fecha_ini_depre = DateTime.Now

            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Activo_fijo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_activo.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdActivoFijo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_Info model = bus_activo.get_info(IdEmpresa, IdActivoFijo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(Af_Activo_fijo_Info model)
        {
            if(!bus_activo.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdActivoFijo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_Info model = bus_activo.get_info(IdEmpresa, IdActivoFijo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(Af_Activo_fijo_Info model)
        {
            if (!bus_activo.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #region Json
        public JsonResult cargar_categoria(int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
            var resultado = bus_categoria.get_list(IdEmpresa, IdActivoFijoTipo, false);
            
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult get_info_tipo(int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_tipo_Bus bus_tipo  = new Af_Activo_fijo_tipo_Bus();
            var resultado = bus_tipo.get_info(IdEmpresa, IdActivoFijoTipo);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion

    }
}