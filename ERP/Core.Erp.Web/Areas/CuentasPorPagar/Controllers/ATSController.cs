using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.CuentasPorPagar.ATS.ATS_Info;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class ATSController : Controller
    {
        // GET: CuentasPorPagar/ATS
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Nuevo()
        {

            ats_Info model = new ats_Info
            {
             
            };
            cargar_combos();
            return View(model);
        }
        public ActionResult GridViewPartial_ventas()
        {
            List<ventas_Info> model = new List<ventas_Info>();
            return PartialView("_GridViewPartial_ventas", model);
        }

        private void cargar_combos(string TipoPersona = "")
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdSucursal);
            ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
            var lst_periodos = bus_periodo.get_list(IdEmpresa,false);


        }
    }
}