using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.CuentasPorCobrar;
using Core.Erp.Info.CuentasPorCobrar;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.Caja;
using Core.Erp.Bus.Facturacion;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class ParametroCXCController : Controller
    {
        cxc_Parametro_Bus bus_parametro = new cxc_Parametro_Bus();
        public ActionResult Index()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cxc_Parametro_Info model = bus_parametro.get_info(IdEmpresa);
            if (model == null)
                model = new cxc_Parametro_Info { IdEmpresa = IdEmpresa };
                cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cxc_Parametro_Info model)
        {
            if (!bus_parametro.guardarDB(model))
                ViewBag.mensaje = "No se pudieron actualizar los registros";
            cargar_combos();
            return View(model);
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            ct_cbtecble_tipo_Bus bus_tipo_comprobante = new ct_cbtecble_tipo_Bus();
            var lst_tipo_comprobante = bus_tipo_comprobante.get_list(IdEmpresa, false);
            ViewBag.lst_tipo_comprobante = lst_tipo_comprobante;

            cxc_cobro_tipo_Bus bus_cobrotipo = new cxc_cobro_tipo_Bus();
            var lst_cobrotipo = bus_cobrotipo.get_list(false);
            ViewBag.lst_cobrotipo = lst_cobrotipo;
            
            caj_Caja_Movimiento_Tipo_Bus bus_movimiento = new caj_Caja_Movimiento_Tipo_Bus();
            var lst_movimiento = bus_movimiento.get_list(IdEmpresa, false);
            ViewBag.lst_movimiento = lst_movimiento;

            caj_Caja_Bus bus_caja = new caj_Caja_Bus();
            var lst_caja = bus_caja.get_list(IdEmpresa, false);
            ViewBag.lst_caja= lst_caja;


            fa_TipoNota_Bus bus_tiponota = new fa_TipoNota_Bus();
            var lst_tiponota = bus_tiponota.get_list("D", false);
            ViewBag.lst_tiponota = lst_tiponota;
        }
    }
}