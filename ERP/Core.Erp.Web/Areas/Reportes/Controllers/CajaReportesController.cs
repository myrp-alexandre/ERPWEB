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
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CAJ_002(decimal IdConciliacionCaja = 0)
        {
            CAJ_002_Rpt model = new CAJ_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdConciliacionCaja.Value = IdConciliacionCaja;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
                model.RequestParameters = false;
            return View(model);
        }
    }
}