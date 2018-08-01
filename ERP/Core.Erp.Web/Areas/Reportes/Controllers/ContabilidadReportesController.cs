using Core.Erp.Info.Helps;
using Core.Erp.Web.Reportes.Contabilidad;
using Core.Erp.Bus.Contabilidad;
using System;
using System.Web.Mvc;
using System.Collections.Generic;
using Core.Erp.Web.Helps;

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

            Dictionary<int, string> lst_nivel = new Dictionary<int, string>();
            lst_nivel.Add(6, "Nivel 6");
            lst_nivel.Add(5, "Nivel 5");
            lst_nivel.Add(4, "Nivel 4");
            lst_nivel.Add(3, "Nivel 3");
            lst_nivel.Add(2, "Nivel 2");
            lst_nivel.Add(1, "Nivel 1");
            ViewBag.lst_nivel = lst_nivel;

            Dictionary<string, string> lst_balance = new Dictionary<string, string>();
            lst_balance.Add("BG", "Balance general");
            lst_balance.Add("ER", "Estado de resultado");
            lst_balance.Add("", "Balance de comprobación");
            ViewBag.lst_balance = lst_balance;
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

        public ActionResult CONTA_003()
        {
            cl_filtros_contabilidad_Info model = new cl_filtros_contabilidad_Info
            {
                IdNivel = 6
            };
            cargar_combos();
            switch (model.balance)
            {
                case "BG":
                    CONTA_003_BG_Rpt report = new CONTA_003_BG_Rpt();
                    report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                    report.p_IdAnio.Value = model.IdAnio;
                    report.p_fechaIni.Value = model.fecha_ini;
                    report.p_fechaFin.Value = model.fecha_fin;
                    report.p_IdUsuario.Value = SessionFixed.IdUsuario;
                    report.p_IdNivel.Value = model.IdNivel;
                    report.p_mostrarSaldo0.Value = model.mostrar_saldos_en_0;
                    report.p_balance.Value = model.balance;
                    report.usuario = Session["IdUsuario"].ToString();
                    report.empresa = Session["nom_empresa"].ToString();
                    report.RequestParameters = false;
                    ViewBag.Report = report;

                    break;
                case "BC":
                    CONTA_003_BC_Rpt report_ = new CONTA_003_BC_Rpt();
                    report_.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                    report_.p_IdAnio.Value = model.IdAnio;
                    report_.p_fechaIni.Value = model.fecha_ini;
                    report_.p_fechaFin.Value = model.fecha_fin;
                    report_.p_IdUsuario.Value = SessionFixed.IdUsuario;
                    report_.p_IdNivel.Value = model.IdNivel;
                    report_.p_mostrarSaldo0.Value = model.mostrar_saldos_en_0;
                    report_.p_balance.Value = model.balance;
                    report_.usuario = Session["IdUsuario"].ToString();
                    report_.empresa = Session["nom_empresa"].ToString();
                    report_.RequestParameters = false;
                    ViewBag.Report = report_;

                    break;
                case "ER":
                    CONTA_003_ER_Rpt reporte = new CONTA_003_ER_Rpt();
                    reporte.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                    reporte.p_IdAnio.Value = model.IdAnio;
                    reporte.p_fechaIni.Value = model.fecha_ini;
                    reporte.p_fechaFin.Value = model.fecha_fin;
                    reporte.p_IdUsuario.Value = SessionFixed.IdUsuario;
                    reporte.p_IdNivel.Value = model.IdNivel;
                    reporte.p_mostrarSaldo0.Value = model.mostrar_saldos_en_0;
                    reporte.p_balance.Value = model.balance;
                    reporte.usuario = Session["IdUsuario"].ToString();
                    reporte.empresa = Session["nom_empresa"].ToString();
                    reporte.RequestParameters = false;
                    ViewBag.Report = reporte;

                    break;
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult CONTA_003(cl_filtros_contabilidad_Info model)
        {
               CONTA_003_BG_Rpt report = new CONTA_003_BG_Rpt();
                report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                report.p_IdAnio.Value = model.IdAnio;
                report.p_fechaIni.Value = model.fecha_ini;
                report.p_fechaFin.Value = model.fecha_fin;
                report.p_IdUsuario.Value = SessionFixed.IdUsuario;
                report.p_IdNivel.Value = model.IdNivel;
                report.p_mostrarSaldo0.Value = model.mostrar_saldos_en_0;
                report.p_balance.Value = model.balance;
                report.usuario = Session["IdUsuario"].ToString();
                report.empresa = Session["nom_empresa"].ToString();
                report.RequestParameters = false;
                ViewBag.Report = report;

            return View(model);
        }
    }
}