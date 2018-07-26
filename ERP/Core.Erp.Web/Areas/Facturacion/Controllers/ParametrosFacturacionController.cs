using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Facturacion;
using Core.Erp.Bus.Caja;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class ParametrosFacturacionController : Controller
    {
        fa_parametro_Bus bus_parametro = new fa_parametro_Bus();
        public ActionResult Index()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_parametro_Info model = bus_parametro.get_info(IdEmpresa);
            if (model == null)
                model = new fa_parametro_Info { IdEmpresa = IdEmpresa };
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(fa_parametro_Info model)
        {
            if (!bus_parametro.guardarDB(model))
                ViewBag.mensaje = "No se pudieron actualizar los registros";
            cargar_combos();
            return View(model);
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_cuentas = bus_plancta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuentas = lst_cuentas;

            ct_cbtecble_tipo_Bus bus_tipo_comprobante = new ct_cbtecble_tipo_Bus();
            var lst_tipo_comprobante = bus_tipo_comprobante.get_list(IdEmpresa, false);
            ViewBag.lst_tipo_comprobante = lst_tipo_comprobante;


            in_movi_inven_tipo_Bus bus_tipo_movimiento = new in_movi_inven_tipo_Bus();
            var lst_tipo_movimiento = bus_tipo_movimiento.get_list(IdEmpresa, false);
            ViewBag.lst_tipo_movimiento_egr = lst_tipo_movimiento.Where(q => q.cm_tipo_movi == "-").ToList();
            ViewBag.lst_tipo_movimiento_ing = lst_tipo_movimiento.Where(q => q.cm_tipo_movi == "+").ToList();

            caj_Caja_Bus bus_caja = new caj_Caja_Bus();
            var lst_caja = bus_caja.get_list(IdEmpresa, false);
            ViewBag.lst_caja = lst_caja;

            fa_TipoNota_Bus bus_nota = new fa_TipoNota_Bus();
            var lst_nota = bus_nota.get_list(false);
            ViewBag.lst_nota = lst_nota;
        }
    }
}