using Core.Erp.Bus.CuentasPorCobrar;
using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class LiquidacionTarjetaCreditoController : Controller
    {
        #region Variables
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        cxc_LiquidacionTarjeta_Bus bus_LiquidacionTarjeta = new cxc_LiquidacionTarjeta_Bus();
        string mensaje = string.Empty;
        #endregion

        #region Index
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal)
            };
            cargar_combos_consulta();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            cargar_combos_consulta();
            return View(model);
        }
        private void cargar_combos_consulta()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            lst_sucursal.Add(new tb_sucursal_Info
            {
                IdEmpresa = IdEmpresa,
                IdSucursal = 0,
                Su_Descripcion = "Todos"
            });
            ViewBag.lst_sucursal = lst_sucursal;
        }
        public ActionResult GridViewPartial_LiquidacionTarjetaCredito(int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.IdEmpresa = IdEmpresa;
            ViewBag.IdSucursal = IdSucursal;
            var model = bus_LiquidacionTarjeta.GetList(IdEmpresa, IdSucursal,true);
            return PartialView("_GridViewPartial_LiquidacionTarjetaCredito", model);
        }
        #endregion
    }
}