
using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.CuentasPorCobrar;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Info.Inventario;
using Core.Erp.Info.Reportes.Facturacion;
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
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        fa_factura_Bus bus_factura = new fa_factura_Bus();

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbCliente_Facturacion()
        {
            cl_filtros_facturacion_Info model = new cl_filtros_facturacion_Info();
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

        public ActionResult CmbProductoPadre_Facturacion()
        {
            cl_filtros_facturacion_Info model = new cl_filtros_facturacion_Info();
            return PartialView("_CmbProductoPadre_Facturacion", model);
        }
        public ActionResult CmbProductoHijo_Facturacion()
        {
            SessionFixed.IdProducto_padre_dist = (!string.IsNullOrEmpty(Request.Params["IdProductoPadre"])) ? Request.Params["IdProductoPadre"].ToString() : "-1";
            cl_filtros_facturacion_Info model = new cl_filtros_facturacion_Info();
            return PartialView("_CmbProductoHijo_Facturacion", model);
        }
        public List<in_Producto_Info> get_list_ProductoPadre_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_producto.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa),cl_enumeradores.eTipoBusquedaProducto.SOLOPADRES,cl_enumeradores.eModulo.INV,0);
        }
        public List<in_Producto_Info> get_list_ProductoHijo_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_producto.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoBusquedaProducto.SOLOHIJOS, cl_enumeradores.eModulo.INV, (string.IsNullOrEmpty(SessionFixed.IdProducto_padre_dist) ? -1 : decimal.Parse(SessionFixed.IdProducto_padre_dist)));
        }
        public in_Producto_Info get_info_producto_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_producto.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion

        private void cargar_combos(cl_filtros_facturacion_Info model)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            lst_sucursal.Add(new tb_sucursal_Info
            {
                IdSucursal = 0,
                Su_Descripcion = "Todas"
            });
            ViewBag.lst_sucursal = lst_sucursal;

            fa_cliente_Bus bus_cliente = new fa_cliente_Bus();
            var lst_cliente = bus_cliente.get_list(IdEmpresa, false);
            ViewBag.lst_cliente = lst_cliente;

            fa_cliente_contactos_Bus bus_contacto = new fa_cliente_contactos_Bus();
            var lst_contacto = bus_contacto.get_list(IdEmpresa, model.IdCliente == null ? 0 : Convert.ToDecimal(model.IdCliente));
            lst_contacto.Add(new Info.Facturacion.fa_cliente_contactos_Info
            {
                IdContacto = 0,
                Nombres = "Todos"
            });
            ViewBag.lst_contacto = lst_contacto;

            fa_Vendedor_Bus bus_vendedor = new fa_Vendedor_Bus();
            var lst_vendedor = bus_vendedor.get_list(IdEmpresa, false);
            lst_vendedor.Add(new Info.Facturacion.fa_Vendedor_Info
            {
                IdVendedor = 0,
                Ve_Vendedor = "Todos"
            });
            ViewBag.lst_vendedor = lst_vendedor;

            fa_proforma_Bus bus_proforma = new fa_proforma_Bus();
            var lst_proforma = bus_proforma.get_list(IdEmpresa, model.fecha_ini, model.fecha_fin);
            lst_proforma.Add(new Info.Facturacion.fa_proforma_Info
            {
                IdProforma = 0,
                pf_codigo = "Todos"
            });
            ViewBag.lst_proforma = lst_proforma;
        }


        public ActionResult FAC_001()
        {
            cl_filtros_facturacion_Info model = new cl_filtros_facturacion_Info
            {
                Check1 = false
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
            report.p_IdProducto_padre.Value = model.IdProductoPadre;
            report.p_mostrar_anulados.Value = model.Check1;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        [HttpPost]
        public ActionResult FAC_001(cl_filtros_facturacion_Info model)
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
            report.p_IdProducto_padre.Value = model.IdProductoPadre;
            report.p_mostrar_anulados.Value = model.Check1;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            cargar_combos(model);
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        public ActionResult FAC_002()
        {
            cl_filtros_facturacion_Info model = new cl_filtros_facturacion_Info();
            
            cargar_combos(model);
            FAC_002_Rpt report = new FAC_002_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fechaCorte.Value = model.fecha_fin;
            report.p_IdSucursal.Value = model.IdSucursal;
            report.p_IdCliente.Value = model.IdCliente;
            report.p_IdClienteContacto.Value = model.IdClienteContacto;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        [HttpPost]
        public ActionResult FAC_002(cl_filtros_facturacion_Info model)
        {
            FAC_002_Rpt report = new FAC_002_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_fechaCorte.Value = model.fecha_fin;
            report.p_IdSucursal.Value = model.IdSucursal;
            report.p_IdCliente.Value = model.IdCliente;
            report.p_IdClienteContacto.Value = model.IdClienteContacto;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
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
            resultado.Add(new Info.Facturacion.fa_cliente_contactos_Info
            {
                IdContacto = 0,
                Nombres = "Todos"
            });
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public ActionResult FAC_003(int IdSucursal = 0, int IdBodega= 0, decimal IdCbteVta= 0)
        {
            FAC_003_Rpt model = new FAC_003_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdBodega.Value = IdBodega;
            model.p_IdSucursal.Value = IdSucursal;
            model.p_IdCbteVta.Value = IdCbteVta;
            model.p_mostrar_cuotas.Value = bus_factura.MostrarCuotasRpt(Convert.ToInt32(Session["IdEmpresa"]),IdSucursal,IdBodega,IdCbteVta);
            model.RequestParameters = false;
            model.DefaultPrinterSettingsUsing.UsePaperKind = false;
            bus_factura.modificarEstadoImpresion(Convert.ToInt32(SessionFixed.IdEmpresa), IdSucursal, IdBodega, IdCbteVta, true);
            return View(model);
        }

        public ActionResult FAC_004(int IdSucursal = 0, int IdBodega = 0, decimal IdNota = 0)
        {
            FAC_004_Rpt model = new FAC_004_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdBodega.Value = IdBodega;
            model.p_IdSucursal.Value = IdSucursal;
            model.p_IdNota.Value = IdNota;
            model.RequestParameters = false;
            return View(model);
        }

        public ActionResult FAC_005()
        {
            cl_filtros_facturacion_Info model = new cl_filtros_facturacion_Info
            {
                Check1 = true,
                Check2 = false
            };

            cargar_combos(model);
            FAC_005_Rpt report = new FAC_005_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_Fecha_ini.Value = model.fecha_ini;
            report.p_Fecha_fin.Value = model.fecha_fin;
            report.p_IdSucursal.Value = model.IdSucursal;
            report.p_IdCliente.Value = model.IdCliente == null ? 0 : Convert.ToDecimal(model.IdCliente);
            report.p_MostrarSaldo0.Value = model.Check1;
            report.p_MostrarContactos.Value = model.Check2;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        [HttpPost]
        public ActionResult FAC_005(cl_filtros_facturacion_Info model)
        {
            FAC_005_Rpt report = new FAC_005_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_Fecha_ini.Value = model.fecha_ini;
            report.p_Fecha_fin.Value = model.fecha_fin;
            report.p_IdSucursal.Value = model.IdSucursal;
            report.p_IdCliente.Value = model.IdCliente == null ? 0 : Convert.ToDecimal(model.IdCliente);
            report.p_MostrarSaldo0.Value = model.Check1;
            report.p_MostrarContactos.Value = model.Check2;
            report.usuario = SessionFixed.IdUsuario;
            report.empresa = SessionFixed.NomEmpresa;
            cargar_combos(model);
            report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        public ActionResult FAC_006(int IdSucursal = 0, decimal IdProforma = 0, bool mostrar_imagen = false)
        {
            if(mostrar_imagen)
            {
                FAC_006_imagen_Rpt model_ = new FAC_006_imagen_Rpt();
                model_.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                model_.p_IdSucursal.Value = IdSucursal;
                model_.p_IdProforma.Value = IdProforma;
                model_.RequestParameters = false;
                return View(model_);
            }
            else
            {
                FAC_006_Rpt model = new FAC_006_Rpt();
                model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                model.p_IdSucursal.Value = IdSucursal;
                model.p_IdProforma.Value = IdProforma;
                model.RequestParameters = false;
                return View(model);
            }
        }

        public ActionResult FAC_007(int IdSucursal = 0, int IdBodega = 0, decimal IdCbteVta = 0)
        {
            FAC_007_Rpt model = new FAC_007_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdBodega.Value = IdBodega;
            model.p_IdSucursal.Value = IdSucursal;
            model.p_IdCbteVta.Value = IdCbteVta;
            model.usuario = SessionFixed.IdUsuario;
            model.empresa = SessionFixed.NomEmpresa;
            model.RequestParameters = false;
            return View(model);
        }
        public ActionResult FAC_008(int IdSucursal = 0, int IdBodega = 0, decimal IdNota = 0)
        {
            FAC_008_Rpt model = new FAC_008_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdBodega.Value = IdBodega;
            model.p_IdSucursal.Value = IdSucursal;
            model.p_IdNota.Value = IdNota;
            model.usuario = SessionFixed.IdUsuario;
            model.empresa = SessionFixed.NomEmpresa;
            model.RequestParameters = false;
            return View(model);
        }

        public ActionResult FAC_009(int IdSucursal = 0, int IdBodega = 0, decimal IdGuiaRemision = 0)
        {
            FAC_009_Rpt model = new FAC_009_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdBodega.Value = IdBodega;
            model.p_IdSucursal.Value = IdSucursal;
            model.p_IdGuiaRemision.Value = IdGuiaRemision;
            model.RequestParameters = false;
            return View(model);
        }


    }
}