using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.ActivoFijo;
using Core.Erp.Web.Helps;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    [SessionTimeout]

    public class TipoAFController : Controller
    {
        #region Variables
        Af_Activo_fijo_tipo_Bus bus_tipoactivo = new Af_Activo_fijo_tipo_Bus();
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipoactivo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_tipoactivo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_tipoactivo", model);
        }
        #endregion

        #region Metodos
        private void cargar_combos(int IdEmpresa)
        {
            var lst_cuentas = bus_plancta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuentas = lst_cuentas;
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            Af_Activo_fijo_tipo_Info model = new Af_Activo_fijo_tipo_Info
            {
                IdEmpresa = IdEmpresa
            };
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Activo_fijo_tipo_Info model)
        {            
            if (!bus_tipoactivo.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdActivoFijoTipo = 0)
        {            
            Af_Activo_fijo_tipo_Info model = bus_tipoactivo.get_info(IdEmpresa, IdActivoFijoTipo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(Af_Activo_fijo_tipo_Info model)
        {
            if (!bus_tipoactivo.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0, int IdActivoFijoTipo = 0)
        {
            Af_Activo_fijo_tipo_Info model = bus_tipoactivo.get_info(IdEmpresa, IdActivoFijoTipo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(Af_Activo_fijo_tipo_Info model)
        {
            if (!bus_tipoactivo.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
    }
}