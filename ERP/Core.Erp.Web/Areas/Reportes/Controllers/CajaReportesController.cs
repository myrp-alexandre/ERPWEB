using Core.Erp.Web.Reportes.Caja;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class CajaReportesController : Controller
    {
        public ActionResult CAJ_001(int IdTipoCbte = 0 , decimal IdCbteCble = 0)
        {
            CAJ_001_Rpt model = new CAJ_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipoCbte.Value = IdTipoCbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdCbteCble == 0)
                model.RequestParameters = false;
            return View(model);
        }
    }
}