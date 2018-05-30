using Core.Erp.Bus.Caja;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Caja;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Caja.Controllers
{
    public class ParametroCajaController : Controller
    {
        caj_parametro_Bus bus_parametro = new caj_parametro_Bus();
        public ActionResult Index()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            caj_parametro_Info model = bus_parametro.get_info(IdEmpresa);
            if (model == null)
                model = new caj_parametro_Info();
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(caj_parametro_Info model)
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

            caj_Caja_Movimiento_Tipo_Bus bus_tipomovimiento = new caj_Caja_Movimiento_Tipo_Bus();
            var lst_tipomovimiento = bus_tipomovimiento.get_list(IdEmpresa, false);
            ViewBag.lst_tipomovimiento = lst_tipomovimiento;
           
        }
    }
}