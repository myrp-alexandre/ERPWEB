using Core.Erp.Bus.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Reportes.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class FacturacionReportesController : Controller
    {

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

        }

        public ActionResult FAC_002(DateTime? fechaCorte, int IdSucursal = 0, decimal IdCliente= 0,int IdClienteContacto = 0)
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                fechaCorte = fechaCorte == null ? DateTime.Now : Convert.ToDateTime(fechaCorte),
                IdSucursal = IdSucursal,
                IdCliente = IdCliente,
                IdClienteContacto = IdClienteContacto
            };
            
            cargar_combos();
            FAC_002_Rpt report = new FAC_002_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fechaCorte.Value = model.fechaCorte;
            report.p_IdSucursal.Value = model.IdSucursal;
            report.p_IdCliente.Value = model.IdCliente;
            report.p_IdClienteContacto.Value = model.IdClienteContacto;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        [HttpPost]
        public ActionResult FAC_002(cl_filtros_Info model)
        {
            FAC_002_Rpt report = new FAC_002_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fechaCorte.Value = model.fechaCorte;
            report.p_IdSucursal.Value = model.IdSucursal;
            report.p_IdCliente.Value = model.IdCliente;
            report.p_IdClienteContacto.Value = model.IdClienteContacto;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
    }
}