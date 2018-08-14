using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using Core.Erp.Web.Reportes.CuentasPorCobrar;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class CuentasPorCobrarReportesController : Controller
    {
        public ActionResult CXC_001(int IdSucursal = 0, decimal IdCobro = 0)
        {
            CXC_001_Rpt model = new CXC_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdSucursal.Value = IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            model.p_IdCobro.Value = IdCobro;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXC_002(int IdSucursal = 0, int IdBodega_Cbte = 0, decimal IdCbte_vta_nota =0, string dc_TipoDocumento ="")
        {
            CXC_002_Rpt model = new CXC_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdSucursal.Value = IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            model.p_IdBodega_Cbte.Value = IdBodega_Cbte;
            model.p_IdCbte_vta_nota.Value = IdCbte_vta_nota;
            model.p_dc_TipoDocumento.Value = dc_TipoDocumento;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            model.RequestParameters = false;
            return View(model);
        }
        public ActionResult CXC_003(DateTime? fecha_ini, DateTime? fecha_fin,  decimal IdCliente = 0)
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdCliente = IdCliente,
                fecha_ini = fecha_ini == null ? DateTime.Now : Convert.ToDateTime(fecha_ini),
                fecha_fin = fecha_fin == null ? DateTime.Now : Convert.ToDateTime(fecha_fin)
            };

            CXC_003_Rpt report = new CXC_003_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            report.p_IdCliente.Value = model.IdCliente;
            report.p_Fecha_ini.Value = model.fecha_ini;
            report.p_Fecha_fin.Value = model.fecha_fin;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();


            return View();
        }

        [HttpPost]
        public ActionResult CXC_003(cl_filtros_Info model)
        {

            CXC_003_Rpt report = new CXC_003_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            report.p_IdCliente.Value = model.IdCliente;
            report.p_Fecha_ini.Value = model.fecha_ini;
            report.p_Fecha_fin.Value = model.fecha_fin;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString(); 

            
            return View(model);
        }
    }
}