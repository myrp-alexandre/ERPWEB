using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Reportes.RRHH;
using Core.Erp.Bus.Reportes.RRHH;
using Core.Erp.Web.Reportes.RRHH;
using DevExpress.Web.Mvc;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class RRHHReportesController : Controller
    {


        public ActionResult ROL_001(int IdEmpresa=0, int IdNomina_Tipo = 0, int IdNomina_TipoLiqui= 0, int IdPeriodo=0)
        {
            ROL_001_Rpt model = new ROL_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdNomina.Value = IdNomina_Tipo;
            model.p_IdNominaTipo.Value = IdNomina_TipoLiqui;
            model.p_IdPeriodo.Value = IdPeriodo;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdPeriodo == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult ROL_002(int IdEmpresa = 0, int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0)
        {
            ROL_002_Rpt model = new ROL_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdNomina.Value = IdNomina_Tipo;
            model.p_IdNominaTipo.Value = IdNomina_TipoLiqui;
            model.p_IdPeriodo.Value = IdPeriodo;
            model.empresa.Value = Session["nom_empresa"].ToString();
            if (IdPeriodo == 0)
                model.RequestParameters = false;
            return View(model);
        }

        public ActionResult ROL_003(decimal IdEmpleado=0, decimal IdNovedad=0)
        {
            ROL_003_Rpt model = new ROL_003_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdEmpleado.Value = IdEmpleado;
            model.p_IdNovedad.Value = IdNovedad;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdEmpleado == 0)
                model.RequestParameters = false;
            return View(model);
        }

        public ActionResult ROL_004(int IdUtilidad=0)
        {
            ROL_004_Rpt model = new ROL_004_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdUtilidad.Value = IdUtilidad;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdUtilidad == 0)
                model.RequestParameters = false;
            return View(model);
        }
   
        public ActionResult ROL_005(decimal IdActaFiniquito = 0)
        {
            ROL_005_Rpt model = new ROL_005_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdActaFiniquito.Value = IdActaFiniquito;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdActaFiniquito == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult ROL_006( decimal IdEmpleado = 0)
        {
            ROL_006_Rpt model = new ROL_006_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdEmpleado.Value = IdEmpleado;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdEmpleado == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult ROL_007(decimal IdEmpleado = 0, int IdSolicitud = 0)
        {
            ROL_007_Rpt model = new ROL_007_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdEmpleado.Value = IdEmpleado;
            model.p_IdSolicitud.Value = IdSolicitud;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdEmpleado == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult ROL_008(decimal IdPrestamo = 0 )
        {
            ROL_008_Rpt model = new ROL_008_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdPrestamo.Value = IdPrestamo;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdPrestamo == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult ROL_009(int IdEmpresa = 0)
        {
            ROL_009_Rpt model = new ROL_009_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdEmpresa == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult ROL_010(int IdEmpresa = 0)
        {
            ROL_010_Rpt model = new ROL_010_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdEmpresa == 0)
                model.RequestParameters = false;
            return View(model);
        }

        
            public ActionResult ROL_011(int IdEmpresa = 0, int IdHorasExtras =0)
        {
            ROL_011_Rpt model = new ROL_011_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdHorasExtras.Value = IdHorasExtras;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdHorasExtras == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult ROL_012(DateTime? fecha_inicio, DateTime? fecha_fin, int IdNomina= 0 )
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                fecha_ini = fecha_inicio == null ? DateTime.Now : Convert.ToDateTime(fecha_inicio),
                fecha_fin = fecha_fin == null ? DateTime.Now : Convert.ToDateTime(fecha_fin),
                IdNomina = IdNomina
            };
            ROL_012_Rpt report = new ROL_012_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_IdNomina.Value = model.IdNomina;
            report.p_fecha_inicio.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            if (IdNomina == 0)
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
        [HttpPost]

        public ActionResult ROl_012(cl_filtros_Info model)
        {
            ROL_012_Rpt report = new ROL_012_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_IdNomina.Value = model.IdNomina;
            report.p_fecha_inicio.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            if (model.IdNomina == 0)
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        public ActionResult ROL_013(DateTime? fecha_inicio, DateTime? fecha_fin, int IdNomina = 0)
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                fecha_ini = fecha_inicio == null ? DateTime.Now : Convert.ToDateTime(fecha_inicio),
                fecha_fin = fecha_fin == null ? DateTime.Now : Convert.ToDateTime(fecha_fin),
                IdNomina = IdNomina
            };
            ROL_012_Rpt report = new ROL_012_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_IdNomina.Value = model.IdNomina;
            report.p_fecha_inicio.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            if (IdNomina == 0)
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        [HttpPost]
        public ActionResult ROl_013(cl_filtros_Info model)
        {
            ROL_013_Rpt report = new ROL_013_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_IdNomina.Value = model.IdNomina;
            report.p_fecha_inicio.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            if (model.IdNomina == 0)
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
    }
}