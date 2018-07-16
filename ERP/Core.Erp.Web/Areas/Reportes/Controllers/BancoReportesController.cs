using Core.Erp.Web.Reportes.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class BancoReportesController : Controller
    {
        public ActionResult BAN_001( int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            BAN_001_Rpt model = new BAN_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipoCbte.Value = IdTipoCbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult BAN_002( int IdTipocbte = 0, decimal IdCbteCble = 0)
        {
            BAN_002_Rpt model = new BAN_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipocbte.Value = IdTipocbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult BAN_003( int IdTipocbte = 0, decimal IdCbteCble = 0)
        {
            BAN_003_Rpt model = new BAN_003_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipocbte.Value = IdTipocbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult BAN_004( int IdBanco = 0, decimal IdConciliacion = 0)
        {
            BAN_004_Rpt model = new BAN_004_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdBanco.Value = IdBanco;
            model.p_IdConciliacion.Value = IdConciliacion;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult BAN_005(int IdTipocbte = 0, decimal IdCbteCble = 0)
        {
            BAN_005_Rpt model = new BAN_005_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipocbte.Value = IdTipocbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.RequestParameters = false;
            return View(model);
        }
        public ActionResult BAN_006(int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            BAN_006_Rpt model = new BAN_006_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipoCbte.Value = IdTipoCbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.RequestParameters = false;
            return View(model);
        }


    }
}