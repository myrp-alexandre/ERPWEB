using DevExpress.Web.Mvc;
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
        #region Index
        public ActionResult Index()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza_ret()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_cobranza_ret", model);
        }
        #endregion

        #region Aplicar retención
        public ActionResult AplicarRetencion(int IdSucursal = 0, int IdBodega = 0, decimal IdCbteVta = 0, string CodTipoDocumento = "")
        {
            cxc_cobro_Info model = new cxc_cobro_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa)
            };
            if (CodTipoDocumento == "FACT")
            {

            }
            else
            {

            }
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza_ret_fte()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_cobranza_ret_fte", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza_ret_iva()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_cobranza_ret_iva", model);
        }
        #endregion
    }
}