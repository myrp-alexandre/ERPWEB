using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Facturacion;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Info.Inventario;
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
    public class ProformaController : Controller
    {
        #region Variables
        fa_proforma_Bus bus_proforma = new fa_proforma_Bus();
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        fa_cliente_x_fa_Vendedor_x_sucursal_Bus bus_v_x_c = new fa_cliente_x_fa_Vendedor_x_sucursal_Bus();
        fa_proforma_det_List List_det = new fa_proforma_det_List();
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        tb_sis_Impuesto_Bus bus_impuesto = new tb_sis_Impuesto_Bus();
        fa_cliente_Bus bus_cliente = new fa_cliente_Bus();
        string mensaje = string.Empty;
        #endregion

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_proforma()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<fa_proforma_Info> model = new List<fa_proforma_Info>();
            model = bus_proforma.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_proforma", model);
        }

        #region Metodos ComboBox bajo demanda cliente
        public ActionResult CmbCliente_Proforma()
        {
            fa_proforma_Info model = new fa_proforma_Info();
            return PartialView("_CmbCliente_Proforma", model);
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
        public ActionResult CmbProducto_Proforma()
        {
            SessionFixed.IdEntidad = !string.IsNullOrEmpty(Request.Params["IdCliente"]) ? Request.Params["IdCliente"].ToString() : "-1";
            fa_proforma_det_Info model = new fa_proforma_det_Info();
            return PartialView("_CmbProducto_Proforma", model);
        }
        public List<in_Producto_Info> get_list_bajo_demandaProducto(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_producto.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoBusquedaProducto.PORMODULO, cl_enumeradores.eModulo.VTA, 0);
        }
        public in_Producto_Info get_info_bajo_demandaProducto(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_producto.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion

        #region acciones
        private bool validar(fa_proforma_Info i_validar, ref string msg)
        {
            i_validar.IdEntidad = i_validar.IdCliente;
            return true;
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
            var lst_bodega = bus_bodega.get_list(IdEmpresa, false);
            ViewBag.lst_bodega = lst_bodega;

            fa_Vendedor_Bus bus_vendedor = new fa_Vendedor_Bus();
            var lst_vendedor = bus_vendedor.get_list(IdEmpresa, false);
            ViewBag.lst_vendedor = lst_vendedor;

            fa_TerminoPago_Bus bus_pago = new fa_TerminoPago_Bus();
            var lst_pago = bus_pago.get_list(false);
            ViewBag.lst_pago = lst_pago;
        }
        public ActionResult Nuevo()
        {
            fa_proforma_Info model = new fa_proforma_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal),
                pf_fecha = DateTime.Now,
                pf_fecha_vcto = DateTime.Now
            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(fa_proforma_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }
            model.IdUsuario_creacion = Session["IdUsuario"].ToString();
            if (!bus_proforma.guardarDB(model))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            };
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdSucursal = 0, decimal IdProforma = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_proforma_Info model = bus_proforma.get_info(IdEmpresa, IdSucursal, IdProforma);
            if (model == null)
                return RedirectToAction("Index");
            model.IdEntidad = model.IdCliente;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_proforma_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }
            model.IdUsuario_modificacion = Session["IdUsuario"].ToString();

            if (!bus_proforma.modificarDB(model))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            };
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdSucursal = 0, decimal IdProforma = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_proforma_Info model = bus_proforma.get_info(IdEmpresa, IdSucursal, IdProforma);
            if (model == null)
                return RedirectToAction("Index");
            model.IdEntidad = model.IdCliente;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_proforma_Info model)
        {
            model.IdUsuario_anulacion = Session["IdUsuario"].ToString();

            if (!bus_proforma.anularDB(model))
            {
                cargar_combos();
                return View(model);
            };
            return RedirectToAction("Index");
        }
        #endregion

        #region json
        public JsonResult get_info_termino_pago(string IdTerminoPago = "")
        {
            fa_TerminoPago_Bus bus_termino_pago = new fa_TerminoPago_Bus();
            var resultado = bus_termino_pago.get_info(IdTerminoPago);

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
            }else
            {
                var vendedor = bus_v_x_c.get_info(IdEmpresa, IdCliente, IdSucursal);
                if (vendedor != null)
                    resultado.IdVendedor = vendedor.IdVendedor;
                else
                    resultado.IdVendedor = 1;
            }

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }


        #endregion

        #region funciones del detalle
        private void cargar_combos_detalle()
        {
            var lst_impuesto = bus_impuesto.get_list("IVA", false);
            ViewBag.lst_impuesto = lst_impuesto;
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_proforma_det()
        {
            var model = List_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_proforma_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] fa_proforma_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            decimal IdCliente = Convert.ToDecimal(SessionFixed.IdEntidad);
            if (info_det != null && info_det.IdProducto != 0 && IdCliente > 0)
            {
                var producto = bus_producto.get_info(info_det.IdEmpresa, info_det.IdProducto);
                if (producto != null)
                {
                    info_det.pr_descripcion = producto.pr_descripcion_combo;
                    var cliente = bus_cliente.get_info(IdEmpresa, IdCliente);
                    if (cliente != null)
                    {
                        
                    }
                }
            }
            List_det.AddRow(info_det);
            var model = List_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_proforma_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] fa_proforma_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            
            List_det.UpdateRow(info_det);
            var model = List_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_proforma_det", model);
        }

        public ActionResult EditingDelete(int Secuencia)
        {
            List_det.DeleteRow(Secuencia);
            var model = List_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_proforma_det", model);
        }
        #endregion
    }

    public class fa_proforma_det_List
    {
        tb_sis_Impuesto_Bus bus_impuesto = new tb_sis_Impuesto_Bus();
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        public List<fa_proforma_det_Info> get_list()
        {
            if (HttpContext.Current.Session["fa_proforma_det_Info"] == null)
            {
                List<fa_proforma_det_Info> list = new List<fa_proforma_det_Info>();

                HttpContext.Current.Session["fa_proforma_det_Info"] = list;
            }
            return (List<fa_proforma_det_Info>)HttpContext.Current.Session["fa_proforma_det_Info"];
        }

        public void set_list(List<fa_proforma_det_Info> list)
        {
            HttpContext.Current.Session["fa_proforma_det_Info"] = list;
        }

        public void AddRow(fa_proforma_det_Info info_det)
        {
            List<fa_proforma_det_Info> list = get_list();
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            info_det.IdProducto = info_det.IdProducto;            
            info_det.pd_precio_final = Math.Round(info_det.pd_precio * (info_det.pd_por_iva / 100), 2, MidpointRounding.AwayFromZero);
            info_det.pd_subtotal = Math.Round(info_det.pd_cantidad * info_det.pd_precio_final, 2, MidpointRounding.AwayFromZero);
            var impuesto = bus_impuesto.get_info(info_det.IdCod_Impuesto);
            if (impuesto != null)
                info_det.pd_por_iva = impuesto.porcentaje;
            info_det.pd_iva = Math.Round(info_det.pd_subtotal * (info_det.pd_por_iva / 100), 2, MidpointRounding.AwayFromZero);
            info_det.pd_total = Math.Round(info_det.pd_subtotal + info_det.pd_iva, 2, MidpointRounding.AwayFromZero);
            list.Add(info_det);
        }

        public void UpdateRow(fa_proforma_det_Info info_det)
        {
            fa_proforma_det_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.pd_cantidad = info_det.pd_cantidad;
            edited_info.pd_precio = info_det.pd_precio;
            edited_info.pd_precio_final = Math.Round(info_det.pd_precio * (info_det.pd_por_iva / 100),2,MidpointRounding.AwayFromZero);
            edited_info.pd_subtotal = Math.Round(info_det.pd_cantidad * edited_info.pd_precio_final,2,MidpointRounding.AwayFromZero);
            if(!string.IsNullOrEmpty(info_det.IdCod_Impuesto) && info_det.IdCod_Impuesto != edited_info.IdCod_Impuesto)
            {
                var impuesto = bus_impuesto.get_info(info_det.IdCod_Impuesto);
                if (impuesto != null)
                    edited_info.pd_por_iva = impuesto.porcentaje;
            }
            edited_info.pd_iva = Math.Round(edited_info.pd_subtotal * (edited_info.pd_por_iva / 100),2,MidpointRounding.AwayFromZero);
            edited_info.pd_total = Math.Round(edited_info.pd_subtotal + edited_info.pd_iva,2,MidpointRounding.AwayFromZero);
        }

        public void DeleteRow(int Secuencia)
        {
            List<fa_proforma_det_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }
}