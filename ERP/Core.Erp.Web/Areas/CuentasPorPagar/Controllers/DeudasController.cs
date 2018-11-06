using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Bus.General;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using Core.Erp.Info.General;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Inventario;
using Core.Erp.Info.Banco;
using Core.Erp.Bus.Banco;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    [SessionTimeout]
    public class DeudasController : Controller
    {
        #region variables
        cp_orden_giro_Bus bus_orden_giro = new cp_orden_giro_Bus();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        cp_codigo_SRI_x_CtaCble_Bus bus_codigo_sri = new cp_codigo_SRI_x_CtaCble_Bus();
        cp_pagos_sri_Bus bus_forma_paogo = new cp_pagos_sri_Bus();
        cp_pais_sri_Bus bus_pais = new cp_pais_sri_Bus();
        List<cp_cuotas_x_doc_det_Info> lst_detalle_cuotas = new List<cp_cuotas_x_doc_det_Info>();
        cp_cuotas_x_doc_det_Bus bus_detalle_cuotas = new cp_cuotas_x_doc_det_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        cp_TipoDocumento_Bus bus_tipo_documento = new cp_TipoDocumento_Bus();
        cp_proveedor_Info info_proveedor = new cp_proveedor_Info();
        cp_proveedor_Bus bus_prov = new cp_proveedor_Bus();
        cp_parametros_Info info_parametro = new cp_parametros_Info();
        cp_parametros_Bus bus_param = new cp_parametros_Bus();
        ct_cbtecble_det_List_fp Lis_ct_cbtecble_det_List = new ct_cbtecble_det_List_fp();
        cp_cuotas_x_doc_det_Info_lst Lis_cp_cuotas_x_doc_det_Info = new cp_cuotas_x_doc_det_Info_lst();
        cp_orden_giro_det_Info_List List_det = new cp_orden_giro_det_Info_List();
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
        cp_orden_giro_det_Bus bus_det = new cp_orden_giro_det_Bus();
        #endregion

        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbProveedor_CXP()
        {
            cp_orden_giro_Info model = new cp_orden_giro_Info();
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

        #region Metodos ComboBox bajo demanda flujo
        ba_TipoFlujo_Bus bus_tipo = new ba_TipoFlujo_Bus();
        public ActionResult CmbFlujo_Deudas()
        {
            decimal model = new decimal();
            return PartialView("_CmbFlujo_Deudas", model);
        }
        public List<ba_TipoFlujo_Info> get_list_bajo_demandaFlujo(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_tipo.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        public ba_TipoFlujo_Info get_info_bajo_demandaFlujo(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_tipo.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion

        #region Metodos ComboBox bajo demanda de producto
        public ActionResult CmbProducto_deudas()
        {
            decimal model = new decimal();
            return PartialView("_CmbProducto_deudas", model);
        }
        public List<in_Producto_Info> get_list_bajo_demanda_producto(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_producto.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoBusquedaProducto.PORMODULO, cl_enumeradores.eModulo.COM, 0);
        }
        public in_Producto_Info get_info_bajo_demanda_producto(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_producto.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion

        #region Facturas por proveedor
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal)
            };
            cargar_combos_consulta();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            cargar_combos_consulta();
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_deudas(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            if (IdSucursal == 0)
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            ViewBag.IdSucursal = IdSucursal;
            var model = bus_orden_giro.get_lst(IdEmpresa, IdSucursal, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_deudas", model);
        }

        #endregion

        #region Facturas sin retencion
        public ActionResult Index2()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_deudas_sin_ret()
        {
            int IdEmpresa =Convert.ToInt32( SessionFixed.IdEmpresa);
            var model = bus_orden_giro.get_lst_sin_ret(IdEmpresa, DateTime.Now, DateTime.Now);
            return PartialView("_GridViewPartial_deudas_sin_ret", model);
        }

        #endregion

        #region Aprobacion de facturas por proveedor
        public ActionResult Index3()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_aprobacion_facturas()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<cp_orden_giro_Info> model = new List<cp_orden_giro_Info>();
            model = Session["list_facturas_seleccionadas"] as List<cp_orden_giro_Info>;
            return PartialView("_GridViewPartial_aprobacion_facturas", model);
        }
        public ActionResult GridViewPartial_facturas_con_saldos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<cp_orden_giro_Info> model = new List<cp_orden_giro_Info>();
            model = bus_orden_giro.get_lst_orden_giro_x_pagar(IdEmpresa);
            Session["list_ordenes_giro"] = model;
            return PartialView("_GridViewPartial_facturas_con_saldos", model);
        }
        #endregion

        #region vista de Detalle de cuotas y diario contable
        [ValidateInput(false)]
        public ActionResult GridViewPartial_documento_cuotas_det()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            try
            {
                lst_detalle_cuotas = Lis_cp_cuotas_x_doc_det_Info.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
                return PartialView("_GridViewPartial_documento_cuotas_det", lst_detalle_cuotas);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult GridViewPartial_deudas_dc()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_deudas_dc", model);
        }
     
        #endregion

        #region Funciones cargar combos
        private void cargar_combos(cp_orden_giro_Info model)
        {
            var lst_codigos_sri = bus_codigo_sri.get_list(model.IdEmpresa);
            ViewBag.lst_codigos_sri = lst_codigos_sri;

            var lst_forma_pago = bus_forma_paogo.get_list();
            ViewBag.lst_forma_pago = lst_forma_pago;

            var lst_paises = bus_pais.get_list();
            ViewBag.lst_paises = lst_paises;

            var lst_doc_tipo = bus_tipo_documento.get_list(false);
            ViewBag.lst_doc_tipo = lst_doc_tipo;

            var lst_sucursales = bus_sucursal.get_list(model.IdEmpresa, false);
            ViewBag.lst_sucursales = lst_sucursales;

            var lst_bodega = bus_bodega.get_list(model.IdEmpresa, model.IdSucursal == null ? 0 : (int)model.IdSucursal, false);
            ViewBag.lst_bodega = lst_bodega;

            if (model.IdProveedor != 0)
            {
                var list_tipo_doc = bus_tipo_documento.get_list(model.IdEmpresa, model.IdProveedor, model.IdOrden_giro_Tipo);
                ViewBag.lst_tipo_doc = list_tipo_doc;
            }
            else
            {
                ViewBag.lst_tipo_doc = new List<cp_TipoDocumento_Info>();

            }


            Dictionary<string, string> lst_pagos = new Dictionary<string, string>();
            lst_pagos.Add("LOC", "LOCAL");
            lst_pagos.Add("EXT", "EXTERIOR");
            ViewBag.lst_pagos = lst_pagos;

        }

        private void cargar_combos_consulta()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
        }
        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ct_plancta_Bus bus_cuenta = new ct_plancta_Bus();
            var lst_cuentas = bus_cuenta.get_list(IdEmpresa, false, true);
            ViewBag.lst_cuentas = lst_cuentas;
        }

        #endregion
        
        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion

            cp_orden_giro_Info model = new cp_orden_giro_Info
            {
                IdEmpresa = IdEmpresa,
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession),
                co_FechaFactura = DateTime.Now.Date,
                co_FechaContabilizacion = DateTime.Now.Date,
                co_FechaFactura_vct = DateTime.Now.Date,
                PaisPago = "593",
                IdTipoServicio = cl_enumeradores.eTipoServicioCXP.SERVI.ToString(),
                info_cuota = new cp_cuotas_x_doc_Info
                {
                    Fecha_inicio = DateTime.Now.Date
                },

            };
            Lis_ct_cbtecble_det_List.set_list(new List<ct_cbtecble_det_Info>(), model.IdTransaccionSession);
            Lis_cp_cuotas_x_doc_det_Info.set_list(new List<cp_cuotas_x_doc_det_Info>(), model.IdTransaccionSession);
            List_det.set_list(new List<cp_orden_giro_det_Info>(), model.IdTransaccionSession);
            cargar_combos(model);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_orden_giro_Info model)
        {
            if(bus_orden_giro.si_existe(model))
            {
                ViewBag.mensaje = "El documento "+model.co_serie+" "+ model.co_factura+", ya se encuentra registrado";
                cargar_combos(model);
                cargar_combos_detalle();
                if (model.info_cuota.Fecha_inicio.Year == 1)
                    model.info_cuota.Fecha_inicio = DateTime.Now;
                return View(model);
            }
             model.info_comrobante = new ct_cbtecble_Info();
             model.info_cuota.lst_cuotas_det = Lis_cp_cuotas_x_doc_det_Info.get_list(model.IdTransaccionSession);
            model.info_comrobante.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List.get_list(model.IdTransaccionSession);
            if(Lis_ct_cbtecble_det_List.get_list(model.IdTransaccionSession).Count()==0)
            {
                ViewBag.mensaje = "Falta diario contable";
                cargar_combos(model);
                cargar_combos_detalle();
                if (model.info_cuota.Fecha_inicio.Year == 1)
                    model.info_cuota.Fecha_inicio = DateTime.Now;
                return View(model);

            }
            if (Session["info_parametro"] != null)
            {
                info_parametro = Session["info_parametro"] as cp_parametros_Info;
                model.info_comrobante.IdTipoCbte = (int)info_parametro.pa_TipoCbte_OG;
            }
            else
            {
                ViewBag.mensaje = "Falta parametrizar el módulo de cuentas por pagar";
                cargar_combos(model);
                cargar_combos_detalle();
                if (model.info_cuota.Fecha_inicio.Year == 1)
                    model.info_cuota.Fecha_inicio = DateTime.Now;
                return View(model);
            }
            string mensaje = bus_orden_giro.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                if (model.info_cuota.Fecha_inicio.Year == 1)
                    model.info_cuota.Fecha_inicio = DateTime.Now;
                return View(model);
            }

            model.IdUsuario = SessionFixed.IdUsuario;
            model.lst_det = List_det.get_list(model.IdTransaccionSession);
            if (!bus_orden_giro.guardarDB(model))
            {
                cargar_combos(model);
                if (model.info_cuota.Fecha_inicio.Year == 1)
                    model.info_cuota.Fecha_inicio = DateTime.Now;
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , int IdTipoCbte_Ogiro = 0, decimal IdCbteCble_Ogiro = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            cp_orden_giro_Info model = bus_orden_giro.get_info(IdEmpresa, IdTipoCbte_Ogiro, IdCbteCble_Ogiro);
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            if (model == null)
                return RedirectToAction("Index");
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
                model.info_comrobante.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            Lis_ct_cbtecble_det_List.set_list( model.info_comrobante.lst_ct_cbtecble_det, model.IdTransaccionSession);
            if (model.info_cuota.lst_cuotas_det == null)
                model.info_cuota.lst_cuotas_det = new List<cp_cuotas_x_doc_det_Info>();
            Lis_cp_cuotas_x_doc_det_Info.set_list( model.info_cuota.lst_cuotas_det, model.IdTransaccionSession);
            List_det.set_list(bus_det.get_list(model.IdEmpresa, model.IdTipoCbte_Ogiro, model.IdCbteCble_Ogiro), model.IdTransaccionSession);
            cargar_combos(model);
            cargar_combos_detalle();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_orden_giro_Info model)
        {
           
            if (Session["info_proveedor"] == null)
            {
                info_proveedor = bus_prov.get_info(model.IdEmpresa, model.IdProveedor);
                Session["info_proveedor"] = info_proveedor;
            }
            else
                info_proveedor = Session["info_proveedor"] as cp_proveedor_Info;


            if (Session["info_parametro"] == null)
            {
                info_parametro = bus_param.get_info(model.IdEmpresa);
                Session["info_parametro"] = info_parametro;
            }
            else
                info_parametro = Session["info_parametro"] as cp_parametros_Info;



               model.info_comrobante = new ct_cbtecble_Info();
               model.info_cuota.lst_cuotas_det = Lis_cp_cuotas_x_doc_det_Info.get_list(model.IdTransaccionSession);
            
                model.info_comrobante.lst_ct_cbtecble_det =Lis_ct_cbtecble_det_List.get_list(model.IdTransaccionSession);
            
            if(model.info_comrobante.lst_ct_cbtecble_det.Count()==0)
            {
                ViewBag.mensaje = "Falta diario contable";
                cargar_combos(model);
                cargar_combos_detalle();
                return View(model);

            }
            if (Session["info_parametro"] != null)
            {
                info_parametro = Session["info_parametro"] as cp_parametros_Info;
                model.info_comrobante.IdTipoCbte = (int)info_parametro.pa_TipoCbte_OG;
            }
            else
            {
                ViewBag.mensaje = "Falta parametros del modulo cuenta por pagar";
                cargar_combos(model);
                cargar_combos_detalle();
                return View(model);
            }
            string mensaje = bus_orden_giro.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }


            model.IdUsuario = SessionFixed.IdUsuario;
            model.lst_det = List_det.get_list(model.IdTransaccionSession);

            if (!bus_orden_giro.modificarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa= 0 , int IdTipoCbte_Ogiro = 0, decimal IdCbteCble_Ogiro = 0)
        {
           

            cp_orden_giro_Info model = bus_orden_giro.get_info(IdEmpresa, IdTipoCbte_Ogiro, IdCbteCble_Ogiro);
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual);
            #endregion
            if (model == null)
                return RedirectToAction("Index");
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
                model.info_comrobante.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            Lis_ct_cbtecble_det_List.set_list(model.info_comrobante.lst_ct_cbtecble_det, model.IdTransaccionSession);
            if (model.info_cuota.lst_cuotas_det == null)
                model.info_cuota.lst_cuotas_det = new List<cp_cuotas_x_doc_det_Info>();
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            Lis_cp_cuotas_x_doc_det_Info.set_list(model.info_cuota.lst_cuotas_det, model.IdTransaccionSession);
            List_det.set_list(bus_det.get_list(model.IdEmpresa, model.IdTipoCbte_Ogiro, model.IdCbteCble_Ogiro), model.IdTransaccionSession);
            cargar_combos(model);
            cargar_combos_detalle();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(cp_orden_giro_Info model)
        {
            if (Session["info_proveedor"] == null)
            {
                info_proveedor = bus_prov.get_info(model.IdEmpresa, model.IdProveedor);
                Session["info_proveedor"] = info_proveedor;
            }
            else
                info_proveedor = Session["info_proveedor"] as cp_proveedor_Info;


            if (Session["info_parametro"] == null)
            {
                info_parametro = bus_param.get_info(model.IdEmpresa);
                Session["info_parametro"] = info_parametro;
            }
            else
                info_parametro = Session["info_parametro"] as cp_parametros_Info;



                model.info_comrobante = new ct_cbtecble_Info();
                model.info_cuota.lst_cuotas_det = Lis_cp_cuotas_x_doc_det_Info.get_list(model.IdTransaccionSession);
            
                model.info_comrobante.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List.get_list(model.IdTransaccionSession);
            
            
            if (Session["info_parametro"] != null)
            {
                info_parametro = Session["info_parametro"] as cp_parametros_Info;
                model.info_comrobante.IdTipoCbte = (int)info_parametro.pa_TipoCbte_OG;
            }
            else
            {
                ViewBag.mensaje = "Falta parametros del modulo cuenta por pagar";
                cargar_combos(model);
                cargar_combos_detalle();
                return View(model);
            }
            string mensaje = bus_orden_giro.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }


            model.IdUsuario = SessionFixed.IdUsuario;
            model.lst_det = List_det.get_list(model.IdTransaccionSession);

            if (!bus_orden_giro.anularDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion

        #region json
        public JsonResult calcular_cuotas(DateTime Fecha_inicio,int Num_cuotas=0, int Dias_plazo = 0, double Total_a_pagar=0, decimal IdTransaccionSession = 0)
        {

            lst_detalle_cuotas = bus_detalle_cuotas.calcular_cuotas(Fecha_inicio, Num_cuotas,Dias_plazo, Total_a_pagar);
            Lis_cp_cuotas_x_doc_det_Info.set_list(lst_detalle_cuotas,IdTransaccionSession);

            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_list_tipo_doc(int IdEmpresa= 0 , decimal IdProveedor = 0, string codigoSRI = "")
        {
            var list_tipo_doc = bus_tipo_documento.get_list(IdEmpresa, IdProveedor, codigoSRI);
            return Json(list_tipo_doc, JsonRequestBehavior.AllowGet);
        }

        public JsonResult armar_diario(decimal IdProveedor = 0, double co_subtotal_iva = 0, double co_subtotal_siniva = 0, double co_valoriva = 0, double co_total = 0, string observacion="", decimal IdTransaccionSession = 0)
        {
            int IdEmpresa=Convert.ToInt32( SessionFixed.IdEmpresa);
            if (Session["info_proveedor"] == null)
            {
                info_proveedor = bus_prov.get_info(IdEmpresa, IdProveedor);
                Session["info_proveedor"] = info_proveedor;
            }
            else
                info_proveedor = Session["info_proveedor"] as cp_proveedor_Info;


            if (Session["info_parametro"] == null)
            {
                info_parametro = bus_param.get_info(IdEmpresa);
                Session["info_parametro"]=info_parametro ;
            }
            else
                info_parametro = Session["info_parametro"] as cp_parametros_Info;

            info_parametro = bus_param.get_info(IdEmpresa);


            Lis_ct_cbtecble_det_List.delete_detail_New_details(info_proveedor, info_parametro, co_subtotal_iva, co_subtotal_siniva, co_valoriva, co_total, observacion, IdTransaccionSession);
            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult guardar_aprobacion(string Ids)
        {
           
            List<cp_orden_giro_Info> model = new List<cp_orden_giro_Info>();
            model = Session["list_facturas_seleccionadas"] as List<cp_orden_giro_Info>;
            foreach (var item in model)
            {
                bus_orden_giro.Generar_OP_x_orden_giro(item);
            }
            Session["list_facturas_seleccionadas"] = null;
            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult seleccionar_aprobacion(string Ids)
        {
            if (Ids != null)
            {
                string[] array = Ids.Split(',');
                var output = array.GroupBy(q => q).ToList();
                List<cp_orden_giro_Info> model = new List<cp_orden_giro_Info>();
                List<cp_orden_giro_Info> list_facturas_seleccionadas = new List<cp_orden_giro_Info>();
                model = Session["list_ordenes_giro"] as List<cp_orden_giro_Info>;
                list_facturas_seleccionadas = Session["list_facturas_seleccionadas"] as List<cp_orden_giro_Info>;
                if (list_facturas_seleccionadas == null)
                    list_facturas_seleccionadas = new List<cp_orden_giro_Info>();
                foreach (var item in output)
                {
                    if (item.Key != "")
                    {
                        var lista_tmp = model.Where(v => v.IdCbteCble_Ogiro == Convert.ToDecimal(item.Key));
                        if (lista_tmp.Count() == 1 & list_facturas_seleccionadas.Where(v => v.IdCbteCble_Ogiro == Convert.ToDecimal(item.Key)).Count() == 0)// agrego si existe y no esta repetida
                        {
                            var info_add = lista_tmp.FirstOrDefault();
                            info_add.co_valorpagar = (double)info_add.Saldo_OG;
                            list_facturas_seleccionadas.Add(info_add);
                        }
                    }
                }
                Session["list_facturas_seleccionadas"] = list_facturas_seleccionadas;
            }
            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetInfo_Producto(int IdEmpresa = 0, decimal IdProducto = 0)
        {
            in_Producto_Bus bus_producto = new in_Producto_Bus();
            var resultado = bus_producto.get_info(IdEmpresa, IdProducto);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Detalle de inventario
        public ActionResult GridViewPartial_deudas_det()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            cp_orden_giro_Info model = new cp_orden_giro_Info();
            model.lst_det = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();            
            return PartialView("_GridViewPartial_deudas_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNewDetalle([ModelBinder(typeof(DevExpressEditorsBinder))] cp_orden_giro_det_Info info_det)
        {
            var producto = bus_producto.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdProducto);
            if (producto != null)
                info_det.pr_descripcion = producto.pr_descripcion_combo;

            if (ModelState.IsValid)
                List_det.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cp_orden_giro_Info model = new cp_orden_giro_Info();
            model.lst_det = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_deudas_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdateDetalle([ModelBinder(typeof(DevExpressEditorsBinder))] cp_orden_giro_det_Info info_det)
        {
            var producto = bus_producto.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdProducto);
            if (producto != null)
                info_det.pr_descripcion = producto.pr_descripcion_combo;

            if (ModelState.IsValid)
                List_det.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cp_orden_giro_Info model = new cp_orden_giro_Info();
            model.lst_det = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_deudas_det", model);
        }

        public ActionResult EditingDeleteDetalle(int secuencia)
        {
            List_det.DeleteRow(secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cp_orden_giro_Info model = new cp_orden_giro_Info();
            model.lst_det = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_deudas_det", model);
        }
        #endregion

        #region Diario contable

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                Lis_ct_cbtecble_det_List.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List.get_list( Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_deudas_dc", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                Lis_ct_cbtecble_det_List.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_deudas_dc", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            Lis_ct_cbtecble_det_List.DeleteRow(secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List.get_list( Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_deudas_dc", model);
        }

        #endregion

        #region editar y eliminar detalle lista de aprobacion
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate_og([ModelBinder(typeof(DevExpressEditorsBinder))] cp_orden_giro_Info info_det)
        {


            List<cp_orden_giro_Info> model = new List<cp_orden_giro_Info>();
            model = Session["list_facturas_seleccionadas"] as List<cp_orden_giro_Info>;
            if (model.Count() > 0)
            {
                cp_orden_giro_Info edited_info = model.Where(m => m.IdCbteCble_Ogiro == info_det.IdCbteCble_Ogiro).First();

                edited_info.co_valorpagar = info_det.co_valorpagar;
            }
            
            return PartialView("_GridViewPartial_aprobacion_facturas", model);
        }
        public ActionResult EditingDelete_og(decimal IdCbteCble_Ogiro)
        {
            List<cp_orden_giro_Info> model = new List<cp_orden_giro_Info>();
            model = Session["list_facturas_seleccionadas"] as List<cp_orden_giro_Info>;
            if (model.Count() > 0)
            {
                cp_orden_giro_Info edited_info = model.Where(m => m.IdCbteCble_Ogiro == IdCbteCble_Ogiro).First();
                model.Remove(edited_info);
                Session["list_facturas_seleccionadas"] = model;
            }

            return PartialView("_GridViewPartial_aprobacion_facturas", model);


        }

        #endregion

        #region cuotas
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew_cuota([ModelBinder(typeof(DevExpressEditorsBinder))] cp_cuotas_x_doc_det_Info info_det)
        {
            if (ModelState.IsValid)
                Lis_cp_cuotas_x_doc_det_Info.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            lst_detalle_cuotas = Lis_cp_cuotas_x_doc_det_Info.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_documento_cuotas_det", lst_detalle_cuotas);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate_cuota([ModelBinder(typeof(DevExpressEditorsBinder))] cp_cuotas_x_doc_det_Info info_det)
        {
            if (ModelState.IsValid)
                Lis_cp_cuotas_x_doc_det_Info.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            lst_detalle_cuotas = Lis_cp_cuotas_x_doc_det_Info.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_documento_cuotas_det", lst_detalle_cuotas);
        }

        public ActionResult EditingDelete_cuota(int secuencia)
        {
            Lis_cp_cuotas_x_doc_det_Info.DeleteRow(secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            lst_detalle_cuotas = Lis_cp_cuotas_x_doc_det_Info.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_documento_cuotas_det", lst_detalle_cuotas);
        }
        #endregion
    }


    public class ct_cbtecble_det_List_fp
    {
        string Variable = "ct_cbtecble_det_Info";
        public List<ct_cbtecble_det_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<ct_cbtecble_det_Info> list = new List<ct_cbtecble_det_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<ct_cbtecble_det_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<ct_cbtecble_det_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(ct_cbtecble_det_Info info_det, decimal IdTransaccionSession)
        {
            List<ct_cbtecble_det_Info> list = get_list(IdTransaccionSession);
            info_det.secuencia = list.Count == 0 ? 1 : list.Max(q => q.secuencia) + 1;
            info_det.dc_Valor = info_det.dc_Valor_debe > 0 ? info_det.dc_Valor_debe : info_det.dc_Valor_haber * -1;
            list.Add(info_det);
        }

        public void UpdateRow(ct_cbtecble_det_Info info_det, decimal IdTransaccionSession)
        {
            ct_cbtecble_det_Info edited_info = get_list(IdTransaccionSession).Where(m => m.secuencia == info_det.secuencia).First();
            edited_info.IdCtaCble = info_det.IdCtaCble;
            edited_info.dc_para_conciliar = info_det.dc_para_conciliar;
            edited_info.dc_Valor = info_det.dc_Valor_debe > 0 ? info_det.dc_Valor_debe : info_det.dc_Valor_haber * -1;
            edited_info.dc_Valor_debe = info_det.dc_Valor_debe;
            edited_info.dc_Valor_haber = info_det.dc_Valor_haber;
        }

        public void DeleteRow(int secuencia, decimal IdTransaccionSession)
        {
            List<ct_cbtecble_det_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }

        public void delete_detail_New_details(cp_proveedor_Info info_proveedor, cp_parametros_Info info_parametro , double co_subtotal_iva = 0, 
            double co_subtotal_siniva = 0, double co_valoriva = 0, double co_total = 0, string observacion="", decimal IdTransaccionSession = 0)
        {
            try
            {
                if (info_proveedor == null)
                {
                    return;
                }
                set_list(new List<ct_cbtecble_det_Info>(), IdTransaccionSession);

                // cuenta total
                ct_cbtecble_det_Info cbtecble_det_total_Info = new ct_cbtecble_det_Info();
                cbtecble_det_total_Info.secuencia = 3;
                cbtecble_det_total_Info.IdEmpresa = 0;
                cbtecble_det_total_Info.IdTipoCbte = 1;
                cbtecble_det_total_Info.IdCtaCble = info_proveedor.IdCtaCble_CXP;
                cbtecble_det_total_Info.dc_Valor_haber = Math.Round(co_total, 2);
                cbtecble_det_total_Info.dc_Valor =Math.Round( co_total * -1,2);
                cbtecble_det_total_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_total_Info, IdTransaccionSession);

                if (co_valoriva != 0)
                {
                    // cuenta iva
                    ct_cbtecble_det_Info cbtecble_det_iva_Info = new ct_cbtecble_det_Info();
                    cbtecble_det_iva_Info.secuencia = 2;
                    cbtecble_det_iva_Info.IdEmpresa = 0;
                    cbtecble_det_iva_Info.IdTipoCbte = 1;
                    cbtecble_det_iva_Info.IdCtaCble = info_parametro.pa_ctacble_iva;
                    cbtecble_det_iva_Info.dc_Valor_debe =  Math.Round(co_valoriva, 2);
                    cbtecble_det_iva_Info.dc_Valor =Math.Round( co_valoriva,2);
                    cbtecble_det_iva_Info.dc_Observacion = observacion;
                    AddRow(cbtecble_det_iva_Info, IdTransaccionSession);
                }
                // cuenta sbtotal
                ct_cbtecble_det_Info cbtecble_det_sub_Info = new ct_cbtecble_det_Info();
                cbtecble_det_sub_Info.secuencia = 1;
                cbtecble_det_sub_Info.IdEmpresa = 0;
                cbtecble_det_sub_Info.IdTipoCbte = 1;
                cbtecble_det_sub_Info.IdCtaCble = info_parametro.pa_ctacble_deudora;
                cbtecble_det_sub_Info.dc_Valor_debe =Math.Round( co_subtotal_iva + co_subtotal_siniva,2);              
                cbtecble_det_sub_Info.dc_Valor = Math.Round(co_subtotal_iva + co_subtotal_siniva, 2);
                cbtecble_det_sub_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_sub_Info, IdTransaccionSession);
               
              

            }
            catch (Exception)
            {
                
                throw;
            }
        }
    }

    public class cp_orden_giro_det_Info_List
    {
        tb_sis_Impuesto_Bus bus_impuesto = new tb_sis_Impuesto_Bus();
        string Variable = "cp_orden_giro_det_Info";
        public List<cp_orden_giro_det_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<cp_orden_giro_det_Info> list = new List<cp_orden_giro_det_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<cp_orden_giro_det_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<cp_orden_giro_det_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(cp_orden_giro_det_Info info_det, decimal IdTransaccionSession)
        {
            List<cp_orden_giro_det_Info> list = get_list(IdTransaccionSession);
            info_det.Secuencia = list.Count == 0 ? 1 : (list.Max(q => q.Secuencia) + 1);
            info_det.DescuentoUni = Math.Round(info_det.CostoUni * (info_det.PorDescuento / 100), 2, MidpointRounding.AwayFromZero);
            info_det.CostoUniFinal = Math.Round(info_det.CostoUni - info_det.DescuentoUni,2,MidpointRounding.AwayFromZero);
            info_det.Subtotal = Math.Round(info_det.Cantidad * info_det.CostoUniFinal, 2, MidpointRounding.AwayFromZero);
            var impuesto = bus_impuesto.get_info(info_det.IdCod_Impuesto_Iva);
            if (impuesto != null)
                info_det.PorIva = impuesto.porcentaje;                
            else
                info_det.PorIva = 0;
            info_det.ValorIva = Math.Round(info_det.Subtotal * (info_det.PorIva / 100), 2, MidpointRounding.AwayFromZero);
            info_det.Total = Math.Round(info_det.Subtotal + info_det.ValorIva,2,MidpointRounding.AwayFromZero);
            list.Add(info_det);
        }

        public void UpdateRow(cp_orden_giro_det_Info info_det, decimal IdTransaccionSession)
        {
            cp_orden_giro_det_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.pr_descripcion = info_det.pr_descripcion;
            edited_info.Cantidad = info_det.Cantidad;
            edited_info.CostoUni = info_det.CostoUni;
            edited_info.PorDescuento = info_det.PorDescuento;
            edited_info.IdCod_Impuesto_Iva = info_det.IdCod_Impuesto_Iva;
            edited_info.pr_descripcion = info_det.pr_descripcion;
            edited_info.DescuentoUni = Math.Round(info_det.CostoUni * (info_det.PorDescuento / 100), 2, MidpointRounding.AwayFromZero);
            edited_info.CostoUniFinal = Math.Round(info_det.CostoUni - info_det.DescuentoUni, 2, MidpointRounding.AwayFromZero);
            edited_info.Subtotal = Math.Round(info_det.Cantidad * edited_info.CostoUniFinal, 2, MidpointRounding.AwayFromZero);
            var impuesto = bus_impuesto.get_info(edited_info.IdCod_Impuesto_Iva);
            if (impuesto != null)
                edited_info.PorIva = impuesto.porcentaje;
            else
                edited_info.PorIva = 0;
            edited_info.ValorIva = Math.Round(edited_info.Subtotal * (edited_info.PorIva / 100), 2, MidpointRounding.AwayFromZero);
            edited_info.Total = Math.Round(edited_info.Subtotal + edited_info.ValorIva, 2, MidpointRounding.AwayFromZero);


        }

        public void DeleteRow(int secuencia, decimal IdTransaccionSession)
        {
            List<cp_orden_giro_det_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == secuencia).First());
        }
    }

    public class cp_cuotas_x_doc_det_Info_lst
    {
        string Variable = "lst_cuotas";
        public List<cp_cuotas_x_doc_det_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<cp_cuotas_x_doc_det_Info> list = new List<cp_cuotas_x_doc_det_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<cp_cuotas_x_doc_det_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<cp_cuotas_x_doc_det_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(cp_cuotas_x_doc_det_Info info_det, decimal IdTransaccionSession)
        {
            List<cp_cuotas_x_doc_det_Info> list = get_list(IdTransaccionSession);
            list.Add(info_det);
        }

        public void UpdateRow(cp_cuotas_x_doc_det_Info info_det, decimal IdTransaccionSession)
        {
            cp_cuotas_x_doc_det_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.Fecha_vcto_cuota = info_det.Fecha_vcto_cuota;
            edited_info.Valor_cuota = info_det.Valor_cuota;
            edited_info.Observacion = info_det.Observacion;
        }

        public void DeleteRow(int secuencia, decimal IdTransaccionSession)
        {
            List<cp_cuotas_x_doc_det_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == secuencia).First());
        }
        
    }
}