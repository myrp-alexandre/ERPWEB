using Core.Erp.Info.CuentasPorCobrar;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class CobranzaRetencionesController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AplicarRetencion(int IdSucursal = 0, int IdBodega = 0, decimal IdCbteVta = 0, string CodTipoDocumento = "")
        {
            cxc_cobro_Info model = new cxc_cobro_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa)
            };
            if (CodTipoDocumento == "FACT")
            {
                
            }else
            {

            }
            return View(model);
        }
    }
}