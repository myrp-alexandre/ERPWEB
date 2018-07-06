using Core.Erp.Web.Reportes.CuentasPorCobrar;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class CuentasPorCobrarReportesController : Controller
    {
        public ActionResult CXC_001(int IdSucursal = 0, decimal IdCobro = 0)
        {
            CXC_001_Rpt model = new CXC_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdSucursal.Value = IdSucursal;
            model.p_IdCobro.Value = IdCobro;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXC_002(int IdSucursal, int IdBodega_Cbte = 0, decimal IdCbte_cta_nota =0, string dc_TipoDocumento ="")
        {
            CXC_002_Rpt model = new CXC_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdSucursal.Value = IdSucursal;
            model.p_IdBodega_Cbte.Value = IdBodega_Cbte;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            model.RequestParameters = false;
            return View(model);
        }
    }
}