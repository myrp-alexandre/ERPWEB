using Core.Erp.Info.Facturacion;
using Core.Erp.Bus.Facturacion;
using Core.Erp.Info.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Inventario;
using Core.Erp.Web.Helps;
using Core.Erp.Info.Inventario;
using Core.Erp.Web.Areas.Inventario.Controllers;
using Core.Erp.Info.General;
using Core.Erp.Bus.General;
using DevExpress.Web.Mvc;
using DevExpress.Web;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class NotaDeCreditoFacturacionController : Controller
    {
        #region Variables
        fa_notaCreDeb_Bus bus_nota = new fa_notaCreDeb_Bus();
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        fa_cliente_contactos_Bus bus_contacto = new fa_cliente_contactos_Bus();
        fa_PuntoVta_Bus bus_punto_venta = new fa_PuntoVta_Bus();
        in_Producto_List List_producto = new in_Producto_List();
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        fa_cliente_x_fa_Vendedor_x_sucursal_Bus bus_v_x_c = new fa_cliente_x_fa_Vendedor_x_sucursal_Bus();
        fa_TerminoPago_Bus bus_termino_pago = new fa_TerminoPago_Bus();
        fa_TerminoPago_Distribucion_Bus bus_termino_pago_distribucion = new fa_TerminoPago_Distribucion_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        tb_sis_Documento_Tipo_Talonario_Bus bus_talonario = new tb_sis_Documento_Tipo_Talonario_Bus();
        fa_notaCreDeb_det_List List_det = new fa_notaCreDeb_det_List();
        tb_sis_Impuesto_Bus bus_impuesto = new tb_sis_Impuesto_Bus();
        fa_cliente_Bus bus_cliente = new fa_cliente_Bus();
        string mensaje = string.Empty;
        fa_notaCreDeb_det_Bus bus_det = new fa_notaCreDeb_det_Bus();
        fa_TipoNota_Bus bus_tipo_nota = new fa_TipoNota_Bus();
        fa_notaCreDeb_x_fa_factura_NotaDeb_Bus bus_cruce = new fa_notaCreDeb_x_fa_factura_NotaDeb_Bus();
        fa_notaCreDeb_x_fa_factura_NotaDeb_List List_cruce = new fa_notaCreDeb_x_fa_factura_NotaDeb_List();
        fa_factura_det_Bus bus_det_fact = new fa_factura_det_Bus();
        #endregion

        #region Index
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
        public ActionResult GridViewPartial_NotaCreditoFacturacion(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            var model = bus_nota.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin, "C");
            return PartialView("_GridViewPartial_NotaCrebitoFacturacion", model);
        }
        #endregion

        #region Metodos ComboBox bajo demanda cliente
        public ActionResult CmbCliente_NotaCredito()
        {
            fa_proforma_Info model = new fa_proforma_Info();
            return PartialView("_CmbCliente_NotaCrebitoFacturacion", model);
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
            return PartialView("_CmbProducto_NotaCrebitoFacturacion", value);
        }
        public ActionResult CmbProducto_NotaCredito()
        {
            fa_notaCreDeb_det_Info model = new fa_notaCreDeb_det_Info();
            return PartialView("_CmbProducto_NotaCrebitoFacturacion", model);
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
        public JsonResult GetUltimoDocumento(int IdSucursal = 0, int IdPuntoVta = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            tb_sis_Documento_Tipo_Talonario_Info resultado;
            var punto_venta = bus_punto_venta.get_info(IdEmpresa, IdSucursal, IdPuntoVta);
            if (punto_venta != null)
            {
                tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
                var bodega = bus_bodega.get_info(IdEmpresa, IdSucursal, Convert.ToInt32(punto_venta.IdBodega));
                var sucursal = bus_sucursal.get_info(IdEmpresa, IdSucursal);
                resultado = bus_talonario.get_info_ultimo_no_usado(IdEmpresa, sucursal.Su_CodigoEstablecimiento, bodega.cod_punto_emision, "NTCR");
            }
            else
                resultado = new tb_sis_Documento_Tipo_Talonario_Info();
            if (resultado == null)
                resultado = new tb_sis_Documento_Tipo_Talonario_Info();
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetDocumentosPorCobrar(int IdSucursal = 0, decimal IdCliente = 0)
        {
            bool resultado = true;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var List = List_cruce.get_list().Where(q=>q.seleccionado == true).ToList();
            var ListPorCruzar = bus_cruce.get_list_cartera(IdEmpresa, IdSucursal, IdCliente, false);

            foreach (var item in List)
            {
                ListPorCruzar.Remove(ListPorCruzar.Where(q => q.secuencial == item.secuencial).FirstOrDefault());
            }

            List.AddRange(ListPorCruzar);
            List_cruce.set_list(List);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult VaciarListas()
        {
            bool resultado = true;
            List_cruce.set_list(new List<fa_notaCreDeb_x_fa_factura_NotaDeb_Info>());
            List_det.set_list(new List<fa_notaCreDeb_det_Info>());
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Grillas de cruce
        public ActionResult GridViewPartial_CruceNC_x_cruzar()
        {
            var model = List_cruce.get_list().Where(q=>q.seleccionado == false).ToList();
            return PartialView("_GridViewPartial_CruceNC_x_cruzar", model);
        }

        public ActionResult GridViewPartial_CruceNC()
        {
            var model = List_cruce.get_list().Where(q => q.seleccionado == true).ToList();
            return PartialView("_GridViewPartial_CruceNC", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNewFacturas(string IDs = "")
        {
            if (IDs != "")
            {
                string[] array = IDs.Split(',');
                foreach (var item in array)
                {
                    List_cruce.DeleteRow(item);
                }
            }
            var list = List_cruce.get_list().Where(q => q.seleccionado == true).ToList();
            var lst_det = new List<fa_notaCreDeb_det_Info>();
            foreach (var item in list)
            {
                
                lst_det.Add(new fa_notaCreDeb_det_Info
                {

                });
            }

            var model = list;
            return PartialView("_GridViewPartial_CruceNC", model);
        }

        public ActionResult EditingUpdateFactura([ModelBinder(typeof(DevExpressEditorsBinder))] fa_notaCreDeb_x_fa_factura_NotaDeb_Info info_det)
        {
            List_cruce.UpdateRow(info_det);
            var model = List_cruce.get_list().Where(q=>q.seleccionado == true).ToList();
            return PartialView("_GridViewPartial_CruceNC", model);
        }
        public ActionResult EditingDeleteFactura(string secuencial)
        {
            List_cruce.DeleteRow(secuencial);
            var model = List_cruce.get_list().Where(q => q.seleccionado == true).ToList();
            return PartialView("_GridViewPartial_CruceNC", model);
        }

        #endregion

        #region funciones del detalle

        public ActionResult GridViewPartial_LoteCreditoFacturacion()
        {
            var model = List_producto.get_list();
            return PartialView("_GridViewPartial_LoteNotaCrebitoFacturacion", model);
        }

        private void cargar_combos_detalle()
        {
            var lst_impuesto = bus_impuesto.get_list("IVA", false);
            ViewBag.lst_impuesto = lst_impuesto;
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_notaCredito_det()
        {
            var model = List_det.get_list();
            cargar_combos_detalle();
            SessionFixed.IdEntidad = !string.IsNullOrEmpty(Request.Params["IdCliente"]) ? Request.Params["IdCliente"].ToString() : "-1";
            return PartialView("_GridViewPartial_NotaCrebitoFacturacion_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] fa_notaCreDeb_det_Info info_det)
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
                                info_det.sc_Precio = producto.precio_1;
                                break;
                            case 2:
                                info_det.sc_Precio = producto.precio_2 == 0 ? producto.precio_1 : producto.precio_2;
                                break;
                            case 3:
                                info_det.sc_Precio = producto.precio_3 == 0 ? producto.precio_1 : producto.precio_3;
                                break;
                            case 4:
                                info_det.sc_Precio = producto.precio_4 == 0 ? producto.precio_1 : producto.precio_4;
                                break;
                            case 5:
                                info_det.sc_Precio = producto.precio_5 == 0 ? producto.precio_1 : producto.precio_5;
                                break;
                        }
                    }
                }
            }
            List_det.AddRow(info_det);
            var model = List_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_NotaCrebitoFacturacion_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] fa_notaCreDeb_det_Info info_det)
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
                                info_det.sc_Precio = producto.precio_1;
                                break;
                            case 2:
                                info_det.sc_Precio = producto.precio_2 == 0 ? producto.precio_1 : producto.precio_2;
                                break;
                            case 3:
                                info_det.sc_Precio = producto.precio_3 == 0 ? producto.precio_1 : producto.precio_3;
                                break;
                            case 4:
                                info_det.sc_Precio = producto.precio_4 == 0 ? producto.precio_1 : producto.precio_4;
                                break;
                            case 5:
                                info_det.sc_Precio = producto.precio_5 == 0 ? producto.precio_1 : producto.precio_5;
                                break;
                        }
                    }
                }
            }
            List_det.UpdateRow(info_det);
            var model = List_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_NotaCrebitoFacturacion_det", model);
        }

        public ActionResult EditingDelete(int Secuencia)
        {
            List_det.DeleteRow(Secuencia);
            var model = List_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_NotaCrebitoFacturacion_det", model);
        }
        #endregion

        #region Metodos
        private void cargar_combos(fa_notaCreDeb_Info model)
        {
            var lst_sucursal = bus_sucursal.get_list(model.IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_punto_venta = bus_punto_venta.get_list(model.IdEmpresa, model.IdSucursal, false);
            ViewBag.lst_punto_venta = lst_punto_venta;

            var lst_contacto = bus_contacto.get_list(model.IdEmpresa, model.IdCliente);
            ViewBag.lst_contacto = lst_contacto;

            Dictionary<string, string> lst_naturaleza = new Dictionary<string, string>();
            lst_naturaleza.Add("INT", "Interno");
            lst_naturaleza.Add("SRI", "Autorizado por el SRI");            
            ViewBag.lst_naturaleza = lst_naturaleza;

            var lst_tipo_nota = bus_tipo_nota.get_list("C",false);
            ViewBag.lst_tipo_nota = lst_tipo_nota;
        }
        private bool validar(fa_notaCreDeb_Info i_validar, ref string msg)
        {
            i_validar.lst_det = List_det.get_list();
            if (i_validar.lst_det.Count == 0)
            {
                msg = "No ha ingresado registros en el detalle";
                return false;
            }
            if (i_validar.lst_det.Where(q => q.sc_cantidad == 0).Count() > 0)
            {
                msg = "Existen registros con cantidad 0 en el detalle";
                return false;
            }
            if (i_validar.lst_det.Where(q => q.IdProducto == 0).Count() > 0)
            {
                msg = "Existen registros sin producto en el detalle";
                return false;
            }

            i_validar.IdBodega = (int)bus_punto_venta.get_info(i_validar.IdEmpresa, i_validar.IdSucursal, Convert.ToInt32(i_validar.IdPuntoVta)).IdBodega;
            i_validar.IdUsuario = SessionFixed.IdUsuario;
            i_validar.IdUsuarioUltMod = SessionFixed.IdUsuario;

            if (i_validar.IdNota == 0 && i_validar.NaturalezaNota == "SRI")
            {
                var talonario = bus_talonario.get_info(i_validar.IdEmpresa, i_validar.CodDocumentoTipo, i_validar.Serie1, i_validar.Serie2, i_validar.NumNota_Impresa);
                if (talonario == null)
                {
                    msg = "No existe un talonario creado con la numeración: " + i_validar.Serie1 + "-" + i_validar.Serie2 + "-" + i_validar.NumNota_Impresa;
                    return false;
                }
                if (talonario.Usado == true)
                {
                    msg = "El talonario: " + i_validar.Serie1 + "-" + i_validar.Serie2 + "-" + i_validar.NumNota_Impresa + " se encuentra utilizado.";
                    return false;
                }
                if (bus_nota.DocumentoExiste(i_validar.IdEmpresa, i_validar.CodDocumentoTipo,i_validar.Serie1, i_validar.Serie2, i_validar.NumNota_Impresa))
                {
                    msg = "Existe una nota de crédito con el talonario: " + i_validar.Serie1 + "-" + i_validar.Serie2 + "-" + i_validar.NumNota_Impresa + " utilizado.";
                    return false;
                }
                if (talonario.es_Documento_Electronico == false)
                {
                    i_validar.NumAutorizacion = talonario.NumAutorizacion;                    
                }
            }            

            if (i_validar.NaturalezaNota != "SRI")
            {
                i_validar.Serie1 = null;
                i_validar.Serie2 = null;
                i_validar.NumNota_Impresa = null;
            }

            return true;
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo()
        {
            fa_notaCreDeb_Info model = new fa_notaCreDeb_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal),
                no_fecha = DateTime.Now,
                no_fecha_venc = DateTime.Now,
                lst_det = new List<fa_notaCreDeb_det_Info>(),
                lst_cruce = new List<fa_notaCreDeb_x_fa_factura_NotaDeb_Info>(),
                CodDocumentoTipo = "NTCR",
                CreDeb = "C"
            };
            List_det.set_list(model.lst_det);
            List_cruce.set_list(model.lst_cruce);
            cargar_combos(model);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(fa_notaCreDeb_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos(model);
                return View(model);
            }
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_nota.guardarDB(model))
            {
                ViewBag.mensaje = "No se ha podido guardar el registro";
                cargar_combos(model);
                return View(model);
            };
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdSucursal = 0, int IdBodega = 0, decimal IdNota = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            fa_notaCreDeb_Info model = bus_nota.get_info(IdEmpresa, IdSucursal, IdBodega, IdNota);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_det = bus_det.get_list(IdEmpresa, IdSucursal, IdBodega, IdNota);
            List_det.set_list(model.lst_det);
            cargar_combos(model);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_notaCreDeb_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos(model);
                return View(model);
            }
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_nota.modificarDB(model))
            {
                ViewBag.mensaje = "No se ha podido modificar el registro";
                cargar_combos(model);
                return View(model);
            };
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdSucursal = 0, int IdBodega = 0, decimal IdNota = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            fa_notaCreDeb_Info model = bus_nota.get_info(IdEmpresa, IdSucursal, IdBodega, IdNota);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_det = bus_det.get_list(IdEmpresa, IdSucursal, IdBodega, IdNota);
            List_det.set_list(model.lst_det);
            cargar_combos(model);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_notaCreDeb_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            if (!bus_nota.anularDB(model))
            {
                ViewBag.mensaje = "No se ha podido anular el registro";
                cargar_combos(model);
                return View(model);
            };
            return RedirectToAction("Index");
        }
        #endregion
    }

    public class fa_notaCreDeb_det_List
    {
        tb_sis_Impuesto_Bus bus_impuesto = new tb_sis_Impuesto_Bus();
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        public List<fa_notaCreDeb_det_Info> get_list()
        {
            if (HttpContext.Current.Session["fa_notaCreDeb_det_Info"] == null)
            {
                List<fa_notaCreDeb_det_Info> list = new List<fa_notaCreDeb_det_Info>();

                HttpContext.Current.Session["fa_notaCreDeb_det_Info"] = list;
            }
            return (List<fa_notaCreDeb_det_Info>)HttpContext.Current.Session["fa_notaCreDeb_det_Info"];
        }

        public void set_list(List<fa_notaCreDeb_det_Info> list)
        {
            HttpContext.Current.Session["fa_notaCreDeb_det_Info"] = list;
        }

        public void AddRow(fa_notaCreDeb_det_Info info_det)
        {
            List<fa_notaCreDeb_det_Info> list = get_list();
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            info_det.IdProducto = info_det.IdProducto;
            info_det.pr_descripcion = info_det.pr_descripcion;
            info_det.sc_descUni = Math.Round(info_det.sc_Precio * (info_det.sc_PordescUni / 100), 2, MidpointRounding.AwayFromZero);
            info_det.sc_precioFinal = Math.Round(info_det.sc_Precio - info_det.sc_descUni, 2, MidpointRounding.AwayFromZero);
            info_det.sc_subtotal = Math.Round(info_det.sc_cantidad * info_det.sc_precioFinal, 2, MidpointRounding.AwayFromZero);
            var impuesto = bus_impuesto.get_info(info_det.IdCod_Impuesto_Iva);
            if (impuesto != null)
                info_det.vt_por_iva = impuesto.porcentaje;
            info_det.sc_iva = Math.Round(info_det.sc_subtotal * (info_det.vt_por_iva / 100), 2, MidpointRounding.AwayFromZero);
            info_det.sc_total = Math.Round(info_det.sc_subtotal + info_det.sc_iva, 2, MidpointRounding.AwayFromZero);
            list.Add(info_det);
        }

        public void UpdateRow(fa_notaCreDeb_det_Info info_det)
        {
            fa_notaCreDeb_det_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.pr_descripcion = info_det.pr_descripcion;
            edited_info.sc_cantidad = info_det.sc_cantidad;
            edited_info.sc_PordescUni = info_det.sc_PordescUni;
            edited_info.sc_Precio = info_det.sc_Precio;
            edited_info.sc_descUni = Math.Round(info_det.sc_Precio * (info_det.sc_PordescUni / 100), 2, MidpointRounding.AwayFromZero);
            edited_info.sc_precioFinal = Math.Round(info_det.sc_Precio - edited_info.sc_descUni, 2, MidpointRounding.AwayFromZero);
            edited_info.sc_subtotal = Math.Round(info_det.sc_cantidad * edited_info.sc_precioFinal, 2, MidpointRounding.AwayFromZero);
            edited_info.IdCod_Impuesto_Iva = info_det.IdCod_Impuesto_Iva;
            if (!string.IsNullOrEmpty(info_det.IdCod_Impuesto_Iva) && info_det.IdCod_Impuesto_Iva != edited_info.IdCod_Impuesto_Iva)
            {
                var impuesto = bus_impuesto.get_info(info_det.IdCod_Impuesto_Iva);
                if (impuesto != null)
                    edited_info.vt_por_iva = impuesto.porcentaje;
            }
            edited_info.sc_iva = Math.Round(edited_info.sc_subtotal * (edited_info.vt_por_iva / 100), 2, MidpointRounding.AwayFromZero);
            edited_info.sc_total = Math.Round(edited_info.sc_subtotal + edited_info.sc_iva, 2, MidpointRounding.AwayFromZero);
        }

        public void DeleteRow(int Secuencia)
        {
            List<fa_notaCreDeb_det_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }

    public class fa_notaCreDeb_x_fa_factura_NotaDeb_List
    {
        public List<fa_notaCreDeb_x_fa_factura_NotaDeb_Info> get_list()
        {
            if (HttpContext.Current.Session["fa_notaCreDeb_x_fa_factura_NotaDeb_Info"] == null)
            {
                List<fa_notaCreDeb_x_fa_factura_NotaDeb_Info> list = new List<fa_notaCreDeb_x_fa_factura_NotaDeb_Info>();

                HttpContext.Current.Session["fa_notaCreDeb_x_fa_factura_NotaDeb_Info"] = list;
            }
            return (List<fa_notaCreDeb_x_fa_factura_NotaDeb_Info>)HttpContext.Current.Session["fa_notaCreDeb_x_fa_factura_NotaDeb_Info"];
        }

        public void set_list(List<fa_notaCreDeb_x_fa_factura_NotaDeb_Info> list)
        {
            HttpContext.Current.Session["fa_notaCreDeb_x_fa_factura_NotaDeb_Info"] = list;
        }

        public void AddRow(fa_notaCreDeb_x_fa_factura_NotaDeb_Info info_det)
        {
            List<fa_notaCreDeb_x_fa_factura_NotaDeb_Info> list = get_list();
            list.Add(info_det);            
        }

        public void UpdateRow(fa_notaCreDeb_x_fa_factura_NotaDeb_Info info_det)
        {
            List<fa_notaCreDeb_x_fa_factura_NotaDeb_Info> list = get_list();
            fa_notaCreDeb_x_fa_factura_NotaDeb_Info edited_info = list.Where(m => m.secuencial == info_det.secuencial).FirstOrDefault();
            edited_info.Saldo_final = Convert.ToDouble(edited_info.Saldo) - info_det.Valor_Aplicado;
            edited_info.Valor_Aplicado = info_det.Valor_Aplicado;
        }

        public void DeleteRow(string secuencial)
        {
            List<fa_notaCreDeb_x_fa_factura_NotaDeb_Info> list = get_list();
            fa_notaCreDeb_x_fa_factura_NotaDeb_Info info = list.Where(m => m.secuencial == secuencial).FirstOrDefault();
            if (info != null)
                info.seleccionado = !info.seleccionado;
        }
    }
}