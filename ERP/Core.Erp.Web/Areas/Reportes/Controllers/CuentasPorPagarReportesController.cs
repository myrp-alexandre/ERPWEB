using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using Core.Erp.Web.Reportes.CuentasPorPagar;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    [SessionTimeout]
    public class CuentasPorPagarReportesController : Controller
    {
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        #region Metodos ComboBox bajo demanda
        public ActionResult CmbProveedor_CXP()
        {
           cl_filtros_Info model = new cl_filtros_Info();
            return PartialView("_CmbProveedor_CXP", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.PROVEE.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.PROVEE.ToString());
        }
        #endregion
        public ActionResult CXP_001(int IdTipoCbte_Ogiro = 0, decimal IdCbteCble_Ogiro = 0)
        {
            CXP_001_Rpt model = new CXP_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipoCbte_Ogiro.Value = IdTipoCbte_Ogiro;
            model.p_IdCbteCble_Ogiro.Value = IdCbteCble_Ogiro;
            model.usuario = SessionFixed.IdUsuario;
            model.empresa = SessionFixed.NomEmpresa;
            model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_002(int IdEmpresa_Ogiro = 0, int IdTipoCbte_Ogiro = 0, decimal IdCbteCble_Ogiro = 0)
        {
            CXP_002_Rpt model = new CXP_002_Rpt();
            model.p_IdEmpresa_Ogiro.Value = IdEmpresa_Ogiro;
            model.p_IdTipoCbte_Ogiro.Value = IdTipoCbte_Ogiro;
            model.p_IdCbteCble_Ogiro.Value = IdCbteCble_Ogiro;
            model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_003( int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            CXP_003_Rpt model = new CXP_003_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipoCbte.Value = IdTipoCbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = SessionFixed.IdUsuario;
            model.empresa = SessionFixed.NomEmpresa;
            model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_004( int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            CXP_004_Rpt model = new CXP_004_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdTipoCbte.Value = IdTipoCbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = SessionFixed.IdUsuario;
            model.empresa = SessionFixed.NomEmpresa;
            model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_005( decimal IdConciliacion = 0)
        {
            CXP_005_Rpt model = new CXP_005_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdConciliacion.Value = IdConciliacion;
            model.usuario = SessionFixed.IdUsuario;
            model.empresa = SessionFixed.NomEmpresa;
            model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_006( decimal IdRetencion = 0)
        {
            CXP_006_Rpt model = new CXP_006_Rpt();
            model.p_IdEmpresa.Value = SessionFixed.IdEmpresa;
            model.p_IdRetencion.Value = IdRetencion;
            model.usuario = SessionFixed.IdUsuario;
            model.empresa = SessionFixed.NomEmpresa;
            model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXP_007()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa)
            };
            CXP_007_Rpt report = new CXP_007_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_fecha_ini.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.p_mostrar_agrupado.Value = model.mostrar_agrupado;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
        [HttpPost]
        public ActionResult CXP_007(cl_filtros_Info model)
        {
            CXP_007_Rpt report = new CXP_007_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_fecha_ini.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.p_mostrar_agrupado.Value = model.mostrar_agrupado;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
            var lst_proveedor = bus_proveedor.get_list(IdEmpresa, false);
            ViewBag.lst_proveedor = lst_proveedor;

        }
        public ActionResult CXP_008(DateTime? fecha,  bool no_mostrar_en_conciliacion = false, bool no_mostrar_saldo_en_0 = false, decimal IdProveedor = 0)
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                fecha = fecha == null ? DateTime.Now : Convert.ToDateTime(fecha),
                IdProveedor = IdProveedor,
                no_mostrar_en_conciliacion = no_mostrar_en_conciliacion,
                no_mostrar_saldo_en_0 = no_mostrar_saldo_en_0
            };
            cargar_combos();
            CXP_008_Rpt report = new CXP_008_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_fecha.Value = model.fecha;
            report.p_IdProveedor.Value = model.IdProveedor;
            report.p_no_mostrar_en_conciliacion.Value = model.no_mostrar_en_conciliacion;
            report.p_no_mostrar_saldo_0.Value = model.no_mostrar_saldo_en_0;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
        [HttpPost]
        public ActionResult CXP_008(cl_filtros_Info model)
        {
            CXP_008_Rpt report = new CXP_008_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_fecha.Value = model.fecha;
            report.p_IdProveedor.Value = model.IdProveedor;
            report.p_no_mostrar_en_conciliacion.Value = model.no_mostrar_en_conciliacion;
            report.p_no_mostrar_saldo_0.Value = model.no_mostrar_saldo_en_0;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            cargar_combos();
            report.RequestParameters = false;
                ViewBag.Report = report;
            return View(model);
        }
        public ActionResult CXP_009()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa)
            };

            CXP_009_Rpt report = new CXP_009_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_Fecha_ini.Value = model.fecha_ini;
            report.p_Fecha_fin.Value = model.fecha_fin;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
        [HttpPost]
        public ActionResult CXP_009(cl_filtros_Info model)
        {
            CXP_009_Rpt report = new CXP_009_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_Fecha_ini.Value = model.fecha_ini;
            report.p_Fecha_fin.Value = model.fecha_fin;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
        public ActionResult CXP_010()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                IdProveedor = 0
            };
            cargar_combos();
            CXP_010_Rpt report = new CXP_010_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_IdProveedor.Value = model.IdProveedor;
            report.p_fechaIni.Value = model.fecha_ini;
            report.p_fechaFin.Value = model.fecha_fin;
            report.p_mostrarAnulados.Value = model.mostrarAnulados;
            report.p_mostrar_observacion_completa.Value = model.mostrar_observacion_completa;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
        [HttpPost]
        public ActionResult CXP_010(cl_filtros_Info model)
        {
            CXP_010_Rpt report = new CXP_010_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_IdProveedor.Value = model.IdProveedor;
            report.p_fechaIni.Value = model.fecha_ini;
            report.p_fechaFin.Value = model.fecha_fin;
            report.p_mostrarAnulados.Value = model.mostrarAnulados;
            report.p_mostrar_observacion_completa.Value = model.mostrar_observacion_completa;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            cargar_combos();
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }


    }
}