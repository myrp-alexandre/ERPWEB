using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    public class ParametroAFController : Controller
    {
        Af_Parametros_Bus bus_parametro = new Af_Parametros_Bus();
        public ActionResult Index()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Parametros_Info model = bus_parametro.get_info(IdEmpresa);
            if (model == null)
                model = new Af_Parametros_Info();
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(Af_Parametros_Info model)
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
            

            ct_plancta_Bus bus_cta = new ct_plancta_Bus();
            var lst_cta = bus_cta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cta = lst_cta;

            Dictionary<string, string> lst_forma = new Dictionary<string, string>();
            lst_forma.Add("Por_Activo", "Por activo");
            lst_forma.Add("Por_Tipo_CtaCble", "Por tipo cuenta cuentable");
            lst_forma.Add("¨Por_CtaCble", "Por cuenta cuentable");
            ViewBag.lst_forma = lst_forma;


        }
    }
}