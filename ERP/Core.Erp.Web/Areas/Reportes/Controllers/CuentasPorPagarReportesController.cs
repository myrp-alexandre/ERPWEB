using Core.Erp.Info.Helps;
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
            if (IdTipoCbte_Ogiro == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_003(int IdEmpresa = 0, int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            CXP_003_Rpt model = new CXP_003_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipoCbte.Value = IdTipoCbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdTipoCbte == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_004(int IdEmpresa = 0, int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            CXP_004_Rpt model = new CXP_004_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipoCbte.Value = IdTipoCbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdTipoCbte == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_005( decimal IdConciliacion = 0)
        {
            CXP_005_Rpt model = new CXP_005_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdConciliacion.Value = IdConciliacion;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdConciliacion == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_006( decimal IdRetencion = 0)
        {
            CXP_006_Rpt model = new CXP_006_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdRetencion.Value = IdRetencion;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdRetencion == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_007( DateTime? fecha_ini, DateTime? fecha_fin, bool Mostrar_agrupado = false)
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                fecha_ini = fecha_ini == null ? DateTime.Now : Convert.ToDateTime(fecha_ini),
                fecha_fin = fecha_fin == null ? DateTime.Now : Convert.ToDateTime(fecha_fin),
                Mostrar_agrupado = Mostrar_agrupado 
            };
            CXP_007_Rpt report = new CXP_007_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fecha_ini.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.p_Mostrar_agrupado.Value = model.Mostrar_agrupado;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        [HttpPost]
        public ActionResult CXP_007(cl_filtros_Info model)
        {
            CXP_007_Rpt report = new CXP_007_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fecha_ini.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.p_Mostrar_agrupado.Value = model.Mostrar_agrupado;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
    }
}