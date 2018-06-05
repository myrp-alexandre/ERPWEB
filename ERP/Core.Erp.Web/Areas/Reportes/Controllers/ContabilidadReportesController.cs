using Core.Erp.Web.Reportes.Contabilidad;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class ContabilidadReportesController : Controller
    {
        public ActionResult CONTA_001(int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            CONTA_001_Rpt model = new CONTA_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipoCbte.Value = IdTipoCbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdCbteCble != 0)
            {
                model.p_IdEmpresa.Visible = false;
                model.p_IdTipoCbte.Visible = false;
                model.p_IdCbteCble.Visible = false;
            }
            else
                model.RequestParameters = false;
            return View(model);
        }
    }
}