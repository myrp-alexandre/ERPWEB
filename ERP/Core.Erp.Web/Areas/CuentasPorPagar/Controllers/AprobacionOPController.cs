using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Bus.General;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class AprobacionOPController : Controller
    {
        // GET: Inventario/AprobarOrdenPago
        cp_orden_pago_Bus bus_orden_pago = new cp_orden_pago_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        List<cp_orden_pago_Info> lst_ordenes_pagos_aprobacion = new List<cp_orden_pago_Info>();

        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa),
                IdSucursal = string.IsNullOrEmpty(SessionFixed.IdSucursal) ? 0 : Convert.ToInt32(SessionFixed.IdSucursal)
            };

            cargar_combos_consulta(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            model.IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa);
            cargar_combos_consulta(model.IdEmpresa);
            return View(model);
        }

        #region Metodos
        private void cargar_combos_consulta(int IdEmpresa)
        {
            try
            {
                var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
                ViewBag.lst_sucursal = lst_sucursal;
            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion
        public ActionResult GridViewPartial_AprobacionOP(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            ViewBag.IdSucursal = IdSucursal == 0 ? 0 : Convert.ToInt32(IdSucursal);

            lst_ordenes_pagos_aprobacion = bus_orden_pago.get_list_aprobacion(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin, IdSucursal);
            return PartialView("_GridViewPartial_AprobacionOP", lst_ordenes_pagos_aprobacion);
        }
    }
}