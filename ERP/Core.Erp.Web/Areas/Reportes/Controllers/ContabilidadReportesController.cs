using Core.Erp.Info.Helps;
using Core.Erp.Web.Reportes.Contabilidad;
using Core.Erp.Bus.Contabilidad;
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
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_plancta_Bus bus_cta = new ct_plancta_Bus();
            var lst_cta = bus_cta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cta = lst_cta;
        }

        public ActionResult CONTA_002(DateTime? fechaIni, DateTime? fechaFin, string IdCtaCble = "")
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                fecha_ini = fechaIni == null ? DateTime.Now : Convert.ToDateTime(fechaIni),
                fecha_fin = fechaFin == null ? DateTime.Now : Convert.ToDateTime(fechaFin),
                IdCtaCble = IdCtaCble
            };
            cargar_combos();
            CONTA_002_Rpt report = new CONTA_002_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_IdCtaCble.Value = model.IdCtaCble;
            report.p_fechaIni.Value = model.fecha_ini;
            report.p_fechaFin.Value = model.fecha_fin;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        [HttpPost]
        public ActionResult CONTA_002(cl_filtros_Info model)
        {
            CONTA_002_Rpt report = new CONTA_002_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_IdCtaCble.Value = model.IdCtaCble;
            report.p_fechaIni.Value = model.fecha_ini;
            report.p_fechaFin.Value = model.fecha_fin;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            cargar_combos();
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
    }
}