using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Facturacion;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Info.Inventario;
using Core.Erp.Web.Areas.Inventario.Controllers;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class ProformaFacturacionController : Controller
    {
        #region Variables
        fa_factura_Bus bus_factura = new fa_factura_Bus();
        fa_PuntoVta_Bus bus_punto_venta = new fa_PuntoVta_Bus();
        fa_cliente_contactos_Bus bus_contactos = new fa_cliente_contactos_Bus();
        fa_Vendedor_Bus bus_vendedor = new fa_Vendedor_Bus();
        fa_TerminoPago_Bus bus_termino_pago = new fa_TerminoPago_Bus();
        fa_factura_det_List List_det = new fa_factura_det_List();
        string mensaje = string.Empty;
        in_Producto_List List_producto = new in_Producto_List();
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        tb_sis_Impuesto_Bus bus_impuesto = new tb_sis_Impuesto_Bus();
        fa_cliente_contactos_Bus bus_contacto = new fa_cliente_contactos_Bus();
        fa_cliente_Bus bus_cliente = new fa_cliente_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        fa_cliente_x_fa_Vendedor_x_sucursal_Bus bus_v_x_c = new fa_cliente_x_fa_Vendedor_x_sucursal_Bus();
        fa_formaPago_Bus bus_forma_pago = new fa_formaPago_Bus();
        fa_cuotas_x_doc_List List_cuotas = new fa_cuotas_x_doc_List();
        fa_TerminoPago_Distribucion_Bus bus_termino_pago_distribucion = new fa_TerminoPago_Distribucion_Bus();
        tb_sis_Documento_Tipo_Talonario_Bus bus_talonario = new tb_sis_Documento_Tipo_Talonario_Bus();
        fa_cuotas_x_doc_Bus bus_cuotas = new fa_cuotas_x_doc_Bus();
        fa_factura_det_Bus bus_det = new fa_factura_det_Bus();
        #endregion

        #region Metodos
        private void cargar_combos(fa_factura_Info model)
        {
            var lst_sucursal = bus_sucursal.get_list(model.IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_punto_venta = bus_punto_venta.get_list(model.IdEmpresa, model.IdSucursal, false);
            ViewBag.lst_punto_venta = lst_punto_venta;

            var lst_contacto = bus_contacto.get_list(model.IdEmpresa, model.IdCliente);
            ViewBag.lst_contacto = lst_contacto;

            var lst_vendedor = bus_vendedor.get_list(model.IdEmpresa, false);
            ViewBag.lst_vendedor = lst_vendedor;

            var lst_pago = bus_termino_pago.get_list(false);
            ViewBag.lst_pago = lst_pago;

            var lst_forma_pago = bus_forma_pago.get_list();
            ViewBag.lst_forma_pago = lst_forma_pago;
        }
        private bool validar(fa_factura_Info i_validar, ref string msg)
        {
            i_validar.lst_det = List_det.get_list();
            if (i_validar.lst_det.Count == 0)
            {
                msg = "No ha ingresado registros en el detalle de la proforma";
                return false;
            }
            if (i_validar.lst_det.Where(q => q.vt_cantidad == 0).Count() > 0)
            {
                msg = "Existen registros con cantidad 0 en el detalle de la proforma";
                return false;
            }
            if (i_validar.lst_det.Where(q => q.IdProducto == 0).Count() > 0)
            {
                msg = "Existen registros sin producto en el detalle de la proforma";
                return false;
            }

            i_validar.lst_cuota = List_cuotas.get_list();
            i_validar.IdBodega = (int)bus_punto_venta.get_info(i_validar.IdEmpresa, i_validar.IdSucursal, Convert.ToInt32(i_validar.IdPuntoVta)).IdBodega;
            i_validar.IdPeriodo = Convert.ToInt32(i_validar.vt_fecha.ToString("yyyyMM"));
            i_validar.vt_mes = i_validar.vt_fecha.Month;
            i_validar.vt_anio = i_validar.vt_fecha.Year;
            i_validar.IdCaja = 1;
            i_validar.IdUsuario = SessionFixed.IdUsuario;
            i_validar.IdUsuarioUltModi = SessionFixed.IdUsuario;

            if (i_validar.IdCbteVta == 0)
            {
                var talonario = bus_talonario.get_info(i_validar.IdEmpresa, i_validar.vt_tipoDoc, i_validar.vt_serie1, i_validar.vt_serie2, i_validar.vt_NumFactura);
                if (talonario == null)
                {
                    msg = "No existe un talonario creado con la numeración: " + i_validar.vt_serie1 + "-" + i_validar.vt_serie2 + "-" + i_validar.vt_NumFactura;
                    return false;
                }
                if (talonario.Usado == true)
                {
                    msg = "El talonario: " + i_validar.vt_serie1 + "-" + i_validar.vt_serie2 + "-" + i_validar.vt_NumFactura + " se encuentra utilizado.";
                    return false;
                }
                if (bus_factura.factura_existe(i_validar.IdEmpresa, i_validar.vt_serie1, i_validar.vt_serie2, i_validar.vt_NumFactura))
                {
                    msg = "Existe una factura con el talonario: " + i_validar.vt_serie1 + "-" + i_validar.vt_serie2 + "-" + i_validar.vt_NumFactura + " utilizado.";
                    return false;
                }
            }

            return true;
        }
        #endregion

        #region Metodos ComboBox bajo demanda cliente
        public ActionResult CmbCliente_Factura()
        {
            fa_proforma_Info model = new fa_proforma_Info();
            return PartialView("_CmbCliente_Factura", model);
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

        #region Metodos ComboBox bajo demanda producto
        public ActionResult ChangeValuePartial(decimal value = 0)
        {
            return PartialView("_CmbProducto_Factura", value);
        }
        public ActionResult CmbProducto_Factura()
        {
            fa_factura_det_Info model = new fa_factura_det_Info();
            return PartialView("_CmbProducto_Factura", model);
        }
        public List<in_Producto_Info> get_list_bajo_demandaProducto(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            List<in_Producto_Info> Lista = bus_producto.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoBusquedaProducto.PORMODULO, cl_enumeradores.eModulo.VTA, 0);
            return Lista;
        }
        public in_Producto_Info get_info_bajo_demandaProducto(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_producto.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion

        #region Index
        public ActionResult Index()
        {
            fa_factura_Info model = new fa_factura_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal),
                vt_fecha = DateTime.Now,
                vt_fech_venc = DateTime.Now,
                lst_det = new List<fa_factura_det_Info>(),
                lst_cuota = new List<fa_cuotas_x_doc_Info>(),
                vt_tipoDoc = "FACT"
            };
            List_det.set_list(model.lst_det);
            List_cuotas.set_list(model.lst_cuota);
            cargar_combos(model);
            return View(model);
        }

        [HttpPost]
        public ActionResult Index(fa_factura_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos(model);
                return View(model);
            }
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_factura.guardarDB(model))
            {
                ViewBag.mensaje = "No se ha podido guardar el registro";
                cargar_combos(model);
                return View(model);
            };
            return RedirectToAction("Index");
        }
        #endregion

        #region Cuotas
        public ActionResult GridViewPartial_factura_cuotas()
        {
            var model = List_cuotas.get_list();
            return PartialView("_GridViewPartial_factura_cuotas", model);
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdateCuota([ModelBinder(typeof(DevExpressEditorsBinder))] fa_cuotas_x_doc_Info info_det)
        {
            List_cuotas.UpdateRow(info_det);
            var model = List_cuotas.get_list();
            return PartialView("_GridViewPartial_factura_cuotas", model);
        }

        public ActionResult EditingDeleteCuota(int Secuencia)
        {
            List_cuotas.DeleteRow(Secuencia);
            var model = List_cuotas.get_list();
            return PartialView("_GridViewPartial_factura_cuotas", model);
        }
        #endregion

        #region funciones del detalle

        public ActionResult GridViewPartial_LoteFactura()
        {
            var model = List_producto.get_list();
            return PartialView("_GridViewPartial_LoteFactura", model);
        }

        private void cargar_combos_detalle()
        {
            var lst_impuesto = bus_impuesto.get_list("IVA", false);
            ViewBag.lst_impuesto = lst_impuesto;
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_factura_det()
        {
            var model = List_det.get_list();
            cargar_combos_detalle();
            SessionFixed.IdEntidad = !string.IsNullOrEmpty(Request.Params["IdCliente"]) ? Request.Params["IdCliente"].ToString() : "-1";
            return PartialView("_GridViewPartial_factura_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] fa_factura_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            decimal IdCliente = Convert.ToDecimal(SessionFixed.IdEntidad);
            if (info_det != null && info_det.IdProducto != 0 && IdCliente > 0)
            {
                var producto = bus_producto.get_info(IdEmpresa, info_det.IdProducto);
                if (producto != null)
                {
                    info_det.pr_descripcion = producto.pr_descripcion_combo;
                    var cliente = bus_cliente.get_info(IdEmpresa, IdCliente);
                    if (cliente != null)
                    {
                        int nivel_precio = (cliente.NivelPrecio == null || cliente.NivelPrecio == 0) ? 1 : Convert.ToInt32(cliente.NivelPrecio);
                        switch (nivel_precio)
                        {
                            case 1:
                                info_det.vt_Precio = producto.precio_1;
                                break;
                            case 2:
                                info_det.vt_Precio = producto.precio_2 == 0 ? producto.precio_1 : producto.precio_2;
                                break;
                            case 3:
                                info_det.vt_Precio = producto.precio_3 == 0 ? producto.precio_1 : producto.precio_3;
                                break;
                            case 4:
                                info_det.vt_Precio = producto.precio_4 == 0 ? producto.precio_1 : producto.precio_4;
                                break;
                            case 5:
                                info_det.vt_Precio = producto.precio_5 == 0 ? producto.precio_1 : producto.precio_5;
                                break;
                        }
                    }
                }
            }
            List_det.AddRow(info_det);
            var model = List_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_factura_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] fa_factura_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            decimal IdCliente = Convert.ToDecimal(SessionFixed.IdEntidad);
            if (info_det != null && info_det.IdProducto != 0 && IdCliente > 0)
            {
                var producto = bus_producto.get_info(IdEmpresa, info_det.IdProducto);
                if (producto != null)
                {
                    info_det.pr_descripcion = producto.pr_descripcion_combo;
                    var cliente = bus_cliente.get_info(IdEmpresa, IdCliente);
                    if (cliente != null)
                    {
                        int nivel_precio = (cliente.NivelPrecio == null || cliente.NivelPrecio == 0) ? 1 : Convert.ToInt32(cliente.NivelPrecio);
                        switch (nivel_precio)
                        {
                            case 1:
                                info_det.vt_Precio = producto.precio_1;
                                break;
                            case 2:
                                info_det.vt_Precio = producto.precio_2 == 0 ? producto.precio_1 : producto.precio_2;
                                break;
                            case 3:
                                info_det.vt_Precio = producto.precio_3 == 0 ? producto.precio_1 : producto.precio_3;
                                break;
                            case 4:
                                info_det.vt_Precio = producto.precio_4 == 0 ? producto.precio_1 : producto.precio_4;
                                break;
                            case 5:
                                info_det.vt_Precio = producto.precio_5 == 0 ? producto.precio_1 : producto.precio_5;
                                break;
                        }
                    }
                }
            }
            List_det.UpdateRow(info_det);
            var model = List_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_factura_det", model);
        }

        public ActionResult EditingDelete(int Secuencia)
        {
            List_det.DeleteRow(Secuencia);
            var model = List_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_factura_det", model);
        }
        #endregion
    }
}