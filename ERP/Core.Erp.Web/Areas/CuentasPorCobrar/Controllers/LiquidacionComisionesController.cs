using Core.Erp.Bus.CuentasPorCobrar;
using Core.Erp.Bus.Facturacion;
using Core.Erp.Info.CuentasPorCobrar;
using Core.Erp.Web.Helps;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    [SessionTimeout]
    public class LiquidacionComisionesController : Controller
    {
        #region Variables
        cxc_liquidacion_comisiones_Bus bus_liq = new cxc_liquidacion_comisiones_Bus();
        fa_Vendedor_Bus bus_vendedor = new fa_Vendedor_Bus();
        #endregion
        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_liquidacion_com()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_liq.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_liquidacion_com", model);
        }

        #endregion
        #region Metodos
        private void cargar_combos(int IdEmpresa)
        {
            var lst_vendedor = bus_vendedor.get_list(IdEmpresa, false);
            ViewBag.lst_vendedor = lst_vendedor;
        }

        #endregion
        #region Acciones

        public ActionResult Nuevo(int IdEmpresa = 0 )
        {
            cxc_liquidacion_comisiones_Info model = new cxc_liquidacion_comisiones_Info
            {
                IdEmpresa = IdEmpresa,
                Fecha = DateTime.Now
            };
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(cxc_liquidacion_comisiones_Info model)
        {
            if (!bus_liq.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , decimal IdLiquidacion = 0)
        {
            cxc_liquidacion_comisiones_Info model = bus_liq.get_info(IdEmpresa, IdLiquidacion);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cxc_liquidacion_comisiones_Info model)
        {
            if (!bus_liq.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, decimal IdLiquidacion = 0)
        {
            cxc_liquidacion_comisiones_Info model = bus_liq.get_info(IdEmpresa, IdLiquidacion);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(cxc_liquidacion_comisiones_Info model)
        {
            if (!bus_liq.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
    }
}