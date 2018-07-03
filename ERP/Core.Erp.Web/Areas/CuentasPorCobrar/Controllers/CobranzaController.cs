using Core.Erp.Bus.Caja;
using Core.Erp.Bus.CuentasPorCobrar;
using Core.Erp.Bus.General;
using Core.Erp.Info.CuentasPorCobrar;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class CobranzaController : Controller
    {
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        cxc_cobro_Bus bus_cobro = new cxc_cobro_Bus();
        caj_Caja_Bus bus_caja = new caj_Caja_Bus();
        caj_parametro_Bus bus_param_caja = new caj_parametro_Bus();
        cxc_cobro_tipo_Bus bus_cobro_tipo = new cxc_cobro_tipo_Bus();
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal)
            };
            cargar_combos_consulta();
            return View(model);
        }
        private void cargar_combos_consulta()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
        }

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_caja = bus_caja.get_list(IdEmpresa, false);
            ViewBag.lst_caja = lst_caja;

            var lst_cobro_tipo = bus_cobro_tipo.get_list(false);
            ViewBag.lst_cobro_tipo = lst_cobro_tipo;
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            cargar_combos_consulta();
            return View(model);
        }

        public ActionResult Nuevo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            int IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            var param_caja = bus_param_caja.get_info(IdEmpresa);
            cxc_cobro_Info model = new cxc_cobro_Info
            {
                IdEmpresa = IdEmpresa,
                IdSucursal = IdSucursal,
                IdCaja = 1
            };
            cargar_combos();
            return View(model);
        }

        public ActionResult Modificar()
        {
            cargar_combos();
            return View();
        }

        public ActionResult Anular()
        {
            cargar_combos();
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            ViewBag.IdSucursal = IdSucursal;
            var model = bus_cobro.get_list(IdEmpresa,IdSucursal, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_cobranza", model);
        }
    }
}