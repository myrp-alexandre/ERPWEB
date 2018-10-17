using Core.Erp.Bus.Banco;
using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using Core.Erp.Web.Reportes.Banco;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    [SessionTimeout]
    public class BancoReportesController : Controller
    {
        ba_Cbte_Ban_Bus bus_cbte = new ba_Cbte_Ban_Bus();
        #region Metodos ComboBox bajo demanda

        public ActionResult CmbPersona_Banco()
        {
            cl_filtros_banco_Info model = new cl_filtros_banco_Info();
            return PartialView("_CmbPersona_Banco", model);
        }
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.PERSONA.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.PERSONA.ToString());
        }


        #endregion
        public ActionResult BAN_001( int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            BAN_001_Rpt model = new BAN_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.p_IdTipoCbte.Value = IdTipoCbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = SessionFixed.IdUsuario.ToString();
            model.empresa = SessionFixed.NomEmpresa.ToString();
            return View(model);
        }
        public ActionResult BAN_002( int IdTipocbte = 0, decimal IdCbteCble = 0)
        {
            BAN_002_Rpt model = new BAN_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.p_IdTipocbte.Value = IdTipocbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = SessionFixed.IdUsuario.ToString();
            model.empresa = SessionFixed.NomEmpresa.ToString();
            return View(model);
        }
        public ActionResult BAN_003( int IdTipocbte = 0, decimal IdCbteCble = 0)
        {
            BAN_003_Rpt model = new BAN_003_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.p_IdTipocbte.Value = IdTipocbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            model.usuario = SessionFixed.IdUsuario.ToString();
            model.empresa = SessionFixed.NomEmpresa.ToString();
            return View(model);
        }
        public ActionResult BAN_004( int IdBanco = 0, decimal IdConciliacion = 0)
        {
            BAN_004_Rpt model = new BAN_004_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.p_IdBanco.Value = IdBanco;
            model.p_IdConciliacion.Value = IdConciliacion;
            model.usuario = SessionFixed.IdUsuario.ToString();
            model.empresa = SessionFixed.NomEmpresa.ToString();
            return View(model);
        }
        public ActionResult BAN_005(int IdTipocbte = 0, decimal IdCbteCble = 0)
        {
            BAN_005_Rpt model = new BAN_005_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.p_IdTipocbte.Value = IdTipocbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            bus_cbte.modificarDB_EstadoCheque(Convert.ToInt32(SessionFixed.IdEmpresa), IdTipocbte, IdCbteCble, "ESTCBENT");
            return View(model);
        }
        public ActionResult BAN_006(int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            BAN_006_Rpt model = new BAN_006_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.p_IdTipoCbte.Value = IdTipoCbte;
            model.p_IdCbteCble.Value = IdCbteCble;
            bus_cbte.modificarDB_EstadoCheque(Convert.ToInt32(SessionFixed.IdEmpresa), IdTipoCbte, IdCbteCble, "ESTCBENT");
            return View(model);
        }
        private void cargar_banco(int IdEmpresa)
        {
            ba_Banco_Cuenta_Bus bus_banco = new ba_Banco_Cuenta_Bus();
            var lst_banco = bus_banco.get_list(IdEmpresa, false);
            lst_banco.Add(new Info.Banco.ba_Banco_Cuenta_Info
            {
                IdBanco = 0,
                ba_descripcion = "Todos"

            });
            ViewBag.lst_banco = lst_banco;

            tb_persona_Bus bus_persona = new tb_persona_Bus();
            var lst_persona = bus_persona.get_list(false);
            ViewBag.lst_persona = lst_persona;

            ba_Catalogo_Bus bus_catalogo = new ba_Catalogo_Bus();
            var lst_catalogo = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoBanco.EST_CB_BA.ToString()), false);
            lst_catalogo.Add(new Info.Banco.ba_Catalogo_Info
            {
                IdCatalogo = "",
                ca_descripcion = "Todos"

            });
            ViewBag.lst_catalogo = lst_catalogo;
        }
        public ActionResult BAN_007()
        {
            cl_filtros_banco_Info model = new cl_filtros_banco_Info
            {
                Estado = "",
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                IdPersona = 0,
                IdBanco = 0
            };
            cargar_banco(model.IdEmpresa);
            BAN_007_Rpt report = new BAN_007_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_IdBanco.Value = model.IdBanco;
            report.p_IdPersona.Value = model.IdPersona;
            report.p_fecha_ini.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.p_Estado.Value = model.Estado;
            report.usuario = SessionFixed.IdUsuario.ToString();
            report.empresa = SessionFixed.NomEmpresa.ToString();
            ViewBag.Report = report;
            return View(model);
        }
        [HttpPost]
        public ActionResult BAN_007(cl_filtros_banco_Info model)
        {
            BAN_007_Rpt report = new BAN_007_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_IdBanco.Value = model.IdBanco;
            report.p_IdPersona.Value = model.IdPersona;
            report.p_fecha_ini.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.p_Estado.Value = model.Estado;
            report.usuario = SessionFixed.IdUsuario.ToString();
            report.empresa = SessionFixed.NomEmpresa.ToString();
            cargar_banco(model.IdEmpresa);
            ViewBag.Report = report;

            return View(model);
        }
    }
}