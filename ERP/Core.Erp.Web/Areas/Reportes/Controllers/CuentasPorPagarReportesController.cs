using Core.Erp.Web.Reportes.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class CuentasPorPagarReportesController : Controller
    {
        // GET: Reportes/CuentasPorPagarReportes
        public ActionResult CXP_001(int IdTipoCbte_Ogiro = 0, decimal IdCbteCble_Ogiro = 0)
        {
            CXP_001_Rpt model = new CXP_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipoCbte_Ogiro.Value = IdTipoCbte_Ogiro;
            model.p_IdCbteCble_Ogiro.Value = IdCbteCble_Ogiro;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdTipoCbte_Ogiro == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_002(int IdEmpresa_Ogiro = 0, int IdTipoCbte_Ogiro = 0, decimal IdCbteCble_Ogiro = 0)
        {
            CXP_002_Rpt model = new CXP_002_Rpt();
            model.p_IdEmpresa_Ogiro.Value = IdEmpresa_Ogiro;
            model.p_IdTipoCbte_Ogiro.Value = IdTipoCbte_Ogiro;
            model.p_IdCbteCble_Ogiro.Value = IdCbteCble_Ogiro;
            model.usuario = Session["IdUsuario"].ToString();
            if (IdTipoCbte_Ogiro == 0)
                model.RequestParameters = false;
            return View(model);
        }
    }
}