using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Caja;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.Banco;
using Core.Erp.Info.Banco;

namespace Core.Erp.Web.Areas.Banco.Controllers
{
    public class ParametroBancoController : Controller
    {
        ba_parametros_Bus bus_parametro = new ba_parametros_Bus();
        public ActionResult Index()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ba_parametros_Info model = bus_parametro.get_info(IdEmpresa);
            if (model == null)
                model = new ba_parametros_Info();
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(ba_parametros_Info model)
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

             fa_TipoNota_Bus bus_tipo = new fa_TipoNota_Bus();
            var lst_tipo = bus_tipo.get_list(false);
            ViewBag.lst_tipo = lst_tipo;

            ct_plancta_Bus bus_cta = new ct_plancta_Bus();
            var lst_cta = bus_cta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cta = lst_cta;

            tb_provincia_Bus bus_provincia = new tb_provincia_Bus();
            var lst_provincia = bus_provincia.get_list(false);
            ViewBag.lst_provincia = lst_provincia;



        }
    }
}