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
    public class FacturaController : Controller
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
        #endregion

        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_factura(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);            
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            var model = bus_factura.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_factura", model);
        }

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
            fa_proforma_det_Info model = new fa_proforma_det_Info();
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

        #region Metodos
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_punto_venta = new List<fa_PuntoVta_Info>();
            ViewBag.lst_punto_venta = lst_punto_venta;

            ViewBag.lst_contacto = new List<fa_cliente_contactos_Info>();

            var lst_vendedor = bus_vendedor.get_list(IdEmpresa, false);
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
            return true;
        }
        #endregion

        #region Json
        public JsonResult cargar_contactos(decimal IdCliente = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);            
            var resultado = bus_contacto.get_list(IdEmpresa, IdCliente);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult CargarPuntosDeVenta(int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var resultado = bus_punto_venta.get_list(IdEmpresa, IdSucursal, false);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetLotesPorProducto(int IdSucursal = 0, int IdPuntoVta = 0, decimal IdProducto = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var resultado = bus_producto.get_info(IdEmpresa, IdProducto);
            if (resultado == null)
                resultado = new in_Producto_Info();

            var punto_venta = bus_punto_venta.get_info(IdEmpresa, IdSucursal, IdPuntoVta);
            if (punto_venta != null)
            {
                if (resultado.IdProducto_padre > 0)
                    List_producto.set_list(bus_producto.get_list_stock_lotes(IdEmpresa, IdSucursal, Convert.ToInt32(punto_venta.IdBodega), Convert.ToDecimal(resultado.IdProducto_padre)));
            }
            else
                List_producto.set_list(new List<in_Producto_Info>());
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_info_cliente(decimal IdCliente = 0, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_cliente_Bus bus_cliente = new fa_cliente_Bus();
            fa_cliente_Info resultado = bus_cliente.get_info(IdEmpresa, IdCliente);
            if (resultado == null)
            {
                resultado = new fa_cliente_Info
                {
                    info_persona = new tb_persona_Info()
                };
            }
            else
            {
                var vendedor = bus_v_x_c.get_info(IdEmpresa, IdCliente, IdSucursal);
                if (vendedor != null)
                    resultado.IdVendedor = vendedor.IdVendedor;
                else
                    resultado.IdVendedor = 1;
            }

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_info_termino_pago(string IdTerminoPago = "")
        {            
            var resultado = bus_termino_pago.get_info(IdTerminoPago);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public void CargarCuotas(DateTime? FechaPrimerPago, string IdTerminoPago = "", double PrimerPago = 0)
        {
            List<fa_cuotas_x_doc_Info> lst_cuotas = new List<fa_cuotas_x_doc_Info>();
            if (FechaPrimerPago != null)
            {
                var lst_distribucion = bus_termino_pago_distribucion.get_list(IdTerminoPago);
                int Secuencia = 1;
                int NumCuotas = lst_distribucion.Count;
                double totalAux = Math.Round(List_det.get_list().Sum(q => q.vt_total) - PrimerPago, 2, MidpointRounding.AwayFromZero);
                DateTime FechaPagosAcum = Convert.ToDateTime(FechaPrimerPago);
                foreach (var item in lst_distribucion)
                {
                    lst_cuotas.Add(new fa_cuotas_x_doc_Info
                    {
                        secuencia = Secuencia,
                        num_cuota = Secuencia++,
                        valor_a_cobrar = Math.Round(totalAux * (item.Por_distribucion / 100), 2, MidpointRounding.AwayFromZero),
                        fecha_vcto_cuota = FechaPagosAcum.AddDays(item.Num_Dias_Vcto)
                    });
                }
            }            
            List_cuotas.set_list(lst_cuotas);
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo()
        {
            fa_factura_Info model = new fa_factura_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal),
                vt_fecha = DateTime.Now,
                vt_fech_venc = DateTime.Now,
                lst_det = new List<fa_factura_det_Info>()
            };
            List_det.set_list(model.lst_det);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(fa_factura_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_factura.guardarDB(model))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
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

    public class fa_factura_det_List
    {
        tb_sis_Impuesto_Bus bus_impuesto = new tb_sis_Impuesto_Bus();
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        public List<fa_factura_det_Info> get_list()
        {
            if (HttpContext.Current.Session["fa_factura_det_Info"] == null)
            {
                List<fa_factura_det_Info> list = new List<fa_factura_det_Info>();

                HttpContext.Current.Session["fa_factura_det_Info"] = list;
            }
            return (List<fa_factura_det_Info>)HttpContext.Current.Session["fa_factura_det_Info"];
        }

        public void set_list(List<fa_factura_det_Info> list)
        {
            HttpContext.Current.Session["fa_factura_det_Info"] = list;
        }

        public void AddRow(fa_factura_det_Info info_det)
        {
            List<fa_factura_det_Info> list = get_list();
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            info_det.IdProducto = info_det.IdProducto;
            info_det.pr_descripcion = info_det.pr_descripcion;
            info_det.vt_DescUnitario = Math.Round(info_det.vt_Precio * (info_det.vt_PorDescUnitario / 100), 2, MidpointRounding.AwayFromZero);
            info_det.vt_PrecioFinal = Math.Round(info_det.vt_Precio - info_det.vt_DescUnitario, 2, MidpointRounding.AwayFromZero);
            info_det.vt_Subtotal = Math.Round(info_det.vt_cantidad * info_det.vt_PrecioFinal, 2, MidpointRounding.AwayFromZero);
            var impuesto = bus_impuesto.get_info(info_det.IdCod_Impuesto_Iva);
            if (impuesto != null)
                info_det.vt_por_iva = impuesto.porcentaje;
            info_det.vt_iva = Math.Round(info_det.vt_Subtotal * (info_det.vt_por_iva / 100), 2, MidpointRounding.AwayFromZero);
            info_det.vt_total = Math.Round(info_det.vt_Subtotal + info_det.vt_iva, 2, MidpointRounding.AwayFromZero);
            list.Add(info_det);
        }

        public void UpdateRow(fa_factura_det_Info info_det)
        {
            fa_factura_det_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.pr_descripcion = info_det.pr_descripcion;
            edited_info.vt_cantidad = info_det.vt_cantidad;
            edited_info.vt_PorDescUnitario = info_det.vt_PorDescUnitario;
            edited_info.vt_Precio = info_det.vt_Precio;
            edited_info.vt_DescUnitario = Math.Round(info_det.vt_Precio * (info_det.vt_PorDescUnitario / 100), 2, MidpointRounding.AwayFromZero);
            edited_info.vt_PrecioFinal = Math.Round(info_det.vt_Precio - edited_info.vt_DescUnitario, 2, MidpointRounding.AwayFromZero);
            edited_info.vt_Subtotal = Math.Round(info_det.vt_cantidad * edited_info.vt_PrecioFinal, 2, MidpointRounding.AwayFromZero);
            if (!string.IsNullOrEmpty(info_det.IdCod_Impuesto_Iva) && info_det.IdCod_Impuesto_Iva != edited_info.IdCod_Impuesto_Iva)
            {
                var impuesto = bus_impuesto.get_info(info_det.IdCod_Impuesto_Iva);
                if (impuesto != null)
                    edited_info.vt_por_iva = impuesto.porcentaje;
            }
            edited_info.vt_iva = Math.Round(edited_info.vt_Subtotal * (edited_info.vt_por_iva / 100), 2, MidpointRounding.AwayFromZero);
            edited_info.vt_total = Math.Round(edited_info.vt_Subtotal + edited_info.vt_iva, 2, MidpointRounding.AwayFromZero);
        }

        public void DeleteRow(int Secuencia)
        {
            List<fa_factura_det_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }

    public class fa_cuotas_x_doc_List
    {
        public List<fa_cuotas_x_doc_Info> get_list()
        {
            if (HttpContext.Current.Session["fa_cuotas_x_doc_Info"] == null)
            {
                List<fa_cuotas_x_doc_Info> list = new List<fa_cuotas_x_doc_Info>();

                HttpContext.Current.Session["fa_cuotas_x_doc_Info"] = list;
            }
            return (List<fa_cuotas_x_doc_Info>)HttpContext.Current.Session["fa_cuotas_x_doc_Info"];
        }

        public void set_list(List<fa_cuotas_x_doc_Info> list)
        {
            HttpContext.Current.Session["fa_cuotas_x_doc_Info"] = list;
        }

        public void AddRow(fa_cuotas_x_doc_Info info_det)
        {
            List<fa_cuotas_x_doc_Info> list = get_list();
            info_det.secuencia = list.Count == 0 ? 1 : list.Max(q => q.secuencia) + 1;
            list.Add(info_det);
        }

        public void UpdateRow(fa_cuotas_x_doc_Info info_det)
        {
            fa_cuotas_x_doc_Info edited_info = get_list().Where(m => m.secuencia == info_det.secuencia).First();
        }

        public void DeleteRow(int secuencia)
        {
            List<fa_cuotas_x_doc_Info> list = get_list();
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }
    }
}