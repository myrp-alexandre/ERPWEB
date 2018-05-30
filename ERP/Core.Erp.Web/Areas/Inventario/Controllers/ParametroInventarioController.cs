using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Inventario;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class ParametroInventarioController : Controller
    {
        in_parametro_Bus bus_param_in = new in_parametro_Bus();
        public ActionResult Index()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_parametro_Info model = bus_param_in.get_info(IdEmpresa);
            if (model == null)
                model = new in_parametro_Info { IdEmpresa = IdEmpresa};
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(in_parametro_Info model)
        {
            if (!bus_param_in.guardarDB(model))
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

            in_movi_inven_tipo_Bus bus_tipo_movimiento = new in_movi_inven_tipo_Bus();
            var lst_tipo_movimiento = bus_tipo_movimiento.get_list(IdEmpresa, false);
            ViewBag.lst_tipo_movimiento_ing = lst_tipo_movimiento.Where(q => q.cm_tipo_movi == "+").ToList();
            ViewBag.lst_tipo_movimiento_egr = lst_tipo_movimiento.Where(q => q.cm_tipo_movi == "-").ToList();

            in_Catalogo_Bus bus_catalogo = new in_Catalogo_Bus();
            var lst_aprobacion = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoInventario.EST_APROB),false);
            ViewBag.lst_aprobacion = lst_aprobacion;

            var lst_tipo_conta = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoInventario.TIPO_CONTA_CTA), false);
            ViewBag.lst_tipo_conta = lst_tipo_conta;

            var lst_fecha_contab = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoInventario.FECH_CONTA), false);
            ViewBag.lst_fecha_contab = lst_fecha_contab;

            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_cuentas = bus_plancta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuentas = lst_cuentas;

            in_ProductoTipo_Bus bus_producto_tipo = new in_ProductoTipo_Bus();
            var lst_producto_tipo = bus_producto_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_producto_tipo = lst_producto_tipo;
        }
    }
}