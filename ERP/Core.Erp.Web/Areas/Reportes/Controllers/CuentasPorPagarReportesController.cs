﻿using Core.Erp.Bus.CuentasPorPagar;
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
        public ActionResult CXP_007( DateTime? fecha_ini, DateTime? fecha_fin, bool mostrar_agrupado = false)
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                fecha_ini = fecha_ini == null ? DateTime.Now : Convert.ToDateTime(fecha_ini),
                fecha_fin = fecha_fin == null ? DateTime.Now : Convert.ToDateTime(fecha_fin),
                mostrar_agrupado = mostrar_agrupado 
            };
            CXP_007_Rpt report = new CXP_007_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fecha_ini.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.p_mostrar_agrupado.Value = model.mostrar_agrupado;
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
            report.p_mostrar_agrupado.Value = model.mostrar_agrupado;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }


        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_proveedor_clase_Bus bus_proveedor = new cp_proveedor_clase_Bus();
            var lst_proveedor = bus_proveedor.get_list(IdEmpresa, false);
            ViewBag.lst_proveedor = lst_proveedor;

        }
        public ActionResult CXP_008(DateTime? fecha,  bool no_mostrar_en_conciliacion = false, bool no_mostrar_saldo_en_0 = false, decimal IdProveedor = 0)
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                fecha = fecha == null ? DateTime.Now : Convert.ToDateTime(fecha),
                IdProveedor = IdProveedor,
                no_mostrar_en_conciliacion = no_mostrar_en_conciliacion,
                no_mostrar_saldo_en_0 = no_mostrar_saldo_en_0
            };
            cargar_combos();
            CXP_008_Rpt report = new CXP_008_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fecha.Value = model.fecha;
            report.p_IdProveedor.Value = model.IdProveedor;
            report.p_no_mostrar_en_conciliacion.Value = model.no_mostrar_en_conciliacion;
            report.p_no_mostrar_saldo_0.Value = model.no_mostrar_saldo_en_0;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        [HttpPost]
        public ActionResult CXP_008(cl_filtros_Info model)
        {
            CXP_008_Rpt report = new CXP_008_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fecha.Value = model.fecha;
            report.p_IdProveedor.Value = model.IdProveedor;
            report.p_no_mostrar_en_conciliacion.Value = model.no_mostrar_en_conciliacion;
            report.p_no_mostrar_saldo_0.Value = model.no_mostrar_saldo_en_0;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            cargar_combos();
            report.RequestParameters = false;
            if (model.IdProveedor == 0)
                ViewBag.Report = report;
            return View(model);
        }
    }
}