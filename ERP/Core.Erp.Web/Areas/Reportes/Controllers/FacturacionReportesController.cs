using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.CuentasPorCobrar;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using Core.Erp.Web.Reportes.Facturacion;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class FacturacionReportesController : Controller
    {
        tb_persona_Bus bus_persona = new tb_persona_Bus();

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbCliente_Facturacion()
        {
            cxc_cobro_Info model = new cxc_cobro_Info();
            return PartialView("_CmbCliente_Facturacion", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.CLIENTE.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.CLIENTE.ToString());
        }
        #endregion

        private void cargar_combos(cl_filtros_Info model)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            fa_cliente_Bus bus_cliente = new fa_cliente_Bus();
            var lst_cliente = bus_cliente.get_list(IdEmpresa, false);
            ViewBag.lst_cliente = lst_cliente;

            fa_cliente_contactos_Bus bus_contacto = new fa_cliente_contactos_Bus();
            var lst_contacto = bus_contacto.get_list(IdEmpresa, model.IdCliente);
            ViewBag.lst_contacto = lst_contacto;

            fa_Vendedor_Bus bus_vendedor = new fa_Vendedor_Bus();
            var lst_vendedor = bus_vendedor.get_list(IdEmpresa, false);
            ViewBag.lst_vendedor = lst_vendedor;

         
            in_Producto_Bus bus_producto = new in_Producto_Bus();
            var lst_producto = bus_producto.get_list_combo_padre(IdEmpresa);
            var lst_producto_padre = bus_producto.get_list_combo_hijo(IdEmpresa, model.IdProducto_padre);

            ViewBag.lst_producto_padre = lst_producto_padre;
            ViewBag.lst_producto = lst_producto;
            
        }


        public ActionResult FAC_001(DateTime? fecha_ini, DateTime? fecha_fin, int IdSucursal = 0, int IdVendedor = 0, decimal IdCliente = 0, int IdCliente_contacto = 0, decimal IdProducto = 0, decimal IdProducto_padre = 0,  bool mostrar_anulados = false)
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                fecha_ini = fecha_ini == null ? DateTime.Now : Convert.ToDateTime(fecha_ini),
                fecha_fin = fecha_fin == null ? DateTime.Now : Convert.ToDateTime(fecha_fin),
                IdSucursal = IdSucursal,
                IdCliente = IdCliente,
                IdClienteContacto = IdCliente_contacto,
                IdProducto = IdProducto,
                IdProducto_padre = IdProducto_padre,
                mostrar_anulados= mostrar_anulados
            };

            cargar_combos(model);
            FAC_001_Rpt report = new FAC_001_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fecha_ini.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.p_IdSucursal.Value = model.IdSucursal;
            report.p_IdCliente.Value = model.IdCliente;
            report.p_IdCliente_contacto.Value = model.IdClienteContacto;
            report.p_IdVendedor.Value = model.IdVendedor;
            report.p_IdProducto.Value = model.IdProducto;
            report.p_IdProducto_padre.Value = model.IdProducto_padre;
            report.p_mostrar_anulados.Value = model.mostrar_anulados;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        [HttpPost]
        public ActionResult FAC_001(cl_filtros_Info model)
        {
            FAC_001_Rpt report = new FAC_001_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fecha_ini.Value = model.fecha_ini;
            report.p_fecha_fin.Value = model.fecha_fin;
            report.p_IdSucursal.Value = model.IdSucursal;
            report.p_IdCliente.Value = model.IdCliente;
            report.p_IdCliente_contacto.Value = model.IdClienteContacto;
            report.p_IdVendedor.Value = model.IdVendedor;
            report.p_IdProducto.Value = model.IdProducto;
            report.p_IdProducto_padre.Value = model.IdProducto_padre;
            report.p_mostrar_anulados.Value = model.mostrar_anulados;
            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            cargar_combos(model);
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
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
            
            cargar_combos(model);
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
            cargar_combos(model);
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        public JsonResult cargar_cliente(decimal IdCliente = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_cliente_contactos_Bus bus_contacto = new fa_cliente_contactos_Bus();
            var resultado = bus_contacto.get_list(IdEmpresa, IdCliente);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
    }
}