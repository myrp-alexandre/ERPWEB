using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.ActivoFijo;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    [SessionTimeout]
    public class ParametroAFController : Controller
    {
        #region Variables
        Af_Parametros_Bus bus_parametro = new Af_Parametros_Bus();
        ct_cbtecble_tipo_Bus bus_tipo_comprobante = new ct_cbtecble_tipo_Bus();
        ct_plancta_Bus bus_cta = new ct_plancta_Bus();
        #endregion

        #region Index
        public ActionResult Index()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            Af_Parametros_Info model = bus_parametro.get_info(IdEmpresa);
            if (model == null)
                model = new Af_Parametros_Info();
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(Af_Parametros_Info model)
        {
            if (!bus_parametro.guardarDB(model))
                ViewBag.mensaje = "No se pudieron actualizar los registros";
            cargar_combos(model.IdEmpresa);
            return View(model);
        }

        #endregion

        #region Metodos
        private void cargar_combos(int IdEmpresa)
        {

            var lst_tipo_comprobante = bus_tipo_comprobante.get_list(IdEmpresa, false);
            ViewBag.lst_tipo_comprobante = lst_tipo_comprobante;
            
            var lst_cta = bus_cta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cta = lst_cta;

            Dictionary<string, string> lst_forma = new Dictionary<string, string>();
            lst_forma.Add("Por_Activo", "Por activo");
            lst_forma.Add("Por_Tipo_CtaCble", "Por tipo");
            lst_forma.Add("¨Por_CtaCble", "Por parámetros");
            ViewBag.lst_forma = lst_forma;


        }

        #endregion
    }
}