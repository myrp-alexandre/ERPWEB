using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Info.Helps;
using DevExpress.Web.Mvc;
using Core.Erp.Web.Helps;
using Core.Erp.Bus.Banco;
using Core.Erp.Info.Banco;
using DevExpress.Web;
using Core.Erp.Info.General;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class OrdenPagoController : Controller
    {

        #region variables
        cp_orden_pago_Bus bus_orden_pago = new cp_orden_pago_Bus();
        cp_orden_pago_tipo_x_empresa_Bus bus_orden_pago_tipo_x_empresa = new cp_orden_pago_tipo_x_empresa_Bus();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        cp_orden_pago_tipo_x_empresa_Info info_param_op = new cp_orden_pago_tipo_x_empresa_Info();
        cp_orden_pago_tipo_x_empresa_Bus bus_orden_pago_tipo = new cp_orden_pago_tipo_x_empresa_Bus();
        ct_cbtecble_det_List_op comprobante_contable_fp = new ct_cbtecble_det_List_op();
        tb_persona_tipo_Bus bus_persona_tipo = new tb_persona_tipo_Bus();
        cp_orden_pago_formapago_Bus bus_forma_pago = new cp_orden_pago_formapago_Bus();
        List<cp_orden_pago_det_Info> lst_detalle_op = new List<cp_orden_pago_det_Info>();
        List<cp_orden_pago_Info> lst_ordenes_pagos = new List<cp_orden_pago_Info>();
        cp_orden_pago_cancelaciones_Bus bus_cancelacion = new cp_orden_pago_cancelaciones_Bus();
        List<cp_orden_pago_tipo_x_empresa_Info> lst_tipo_orden_pago = new List<cp_orden_pago_tipo_x_empresa_Info>();
        int IdEmpresa = 0;
        cp_orden_pago_det_Info_list lis_cp_orden_pago_det_Info = new cp_orden_pago_det_Info_list();
        ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
        #endregion
        #region Index

        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa),
                IdSucursal = string.IsNullOrEmpty(SessionFixed.IdSucursal) ? 0 : Convert.ToInt32(SessionFixed.IdSucursal)
            };

            cargar_combos_consulta(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            model.IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa);
            cargar_combos_consulta(model.IdEmpresa);
            return View(model);
        }

        public ActionResult GridViewPartial_ordenes_pagos(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            ViewBag.IdSucursal = IdSucursal == 0 ? 0: Convert.ToInt32(IdSucursal);

            lst_ordenes_pagos = bus_orden_pago.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin, IdSucursal);
            return PartialView("_GridViewPartial_ordenes_pagos", lst_ordenes_pagos);
        }

    
        [ValidateInput(false)]
        public ActionResult GridViewPartial_detalle_op()
        {
            try
            {
                lst_detalle_op =lis_cp_orden_pago_det_Info.get_list();
                return PartialView("_GridViewPartial_detalle_op", lst_detalle_op);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult GridViewPartial_orden_pago_dc()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = comprobante_contable_fp.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_orden_pago_dc", model);
        }
        #endregion
        #region Metodos
        private void cargar_combos(int IdEmpresa )
        {
            var lst_proveedores = bus_proveedor.get_list(IdEmpresa, false);
            ViewBag.lst_proveedores = lst_proveedores;

            var lst_persona_tipo = bus_persona_tipo.get_list();
            ViewBag.lst_persona_tipo = lst_persona_tipo;

             var lst_forma_pago = bus_forma_pago.get_list();
            ViewBag.lst_forma_pago = lst_forma_pago;

            var lst_tipo_orden_pago = bus_orden_pago_tipo.get_list(IdEmpresa);
            ViewBag.lst_tipo_orden_pago = lst_tipo_orden_pago;

            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            //var lst_tipo_personas = bus_persona_tipo.get_list();
            //ViewBag.lst_tipo_personas = lst_tipo_personas;

            Dictionary<string, string> lst_tipo_personas = new Dictionary<string, string>();
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.PERSONA.ToString(), "Persona");
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.PROVEE.ToString(), "Proveedor");
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.EMPLEA.ToString(), "Empleado");
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.CLIENTE.ToString(), "Cliente");
            ViewBag.lst_tipo_personas = lst_tipo_personas;
        }

        private void cargar_combos_consulta(int IdEmpresa)
        {
            try
            {
                var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
                ViewBag.lst_sucursal = lst_sucursal;
            }
            catch (Exception)
            {
                throw;
            }
        }

        private bool validar(cp_orden_pago_Info i_validar, ref string msg)
        {
            if (!bus_periodo.ValidarFechaTransaccion(i_validar.IdEmpresa, i_validar.Fecha, cl_enumeradores.eModulo.CXP, ref msg))
            {
                return false;
            }
            if (!bus_periodo.ValidarFechaTransaccion(i_validar.IdEmpresa, i_validar.Fecha, cl_enumeradores.eModulo.CONTA, ref msg))
            {
                return false;
            }

            if (i_validar.IdEntidad == 0)
            {
                msg = "El campo beneficiario es obligatorio";
                return false;
            }

                return true;
        }
        #endregion

        #region Json
        public JsonResult CargarEstadoAprobacion(int IdEmpresa = 0, string IdTipo_op = "")
        {
            var resultado = bus_orden_pago_tipo_x_empresa.get_info(IdEmpresa, IdTipo_op);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region Acciones

        public ActionResult Nuevo(int IdEmpresa = 0 )
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            lis_cp_orden_pago_det_Info.set_list(new List<cp_orden_pago_det_Info>());
            comprobante_contable_fp.set_list(new List<ct_cbtecble_det_Info>());
            #endregion
            cp_orden_pago_Info model = new cp_orden_pago_Info
            {
                IdEmpresa = IdEmpresa,
                Fecha=DateTime.Now.Date
            };
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_orden_pago_Info model)
        {
            bus_orden_pago_tipo = new cp_orden_pago_tipo_x_empresa_Bus();
            bus_orden_pago = new cp_orden_pago_Bus();
            model.detalle =lis_cp_orden_pago_det_Info.get_list();
            model.info_comprobante.lst_ct_cbtecble_det = comprobante_contable_fp.get_list();
            info_param_op = bus_orden_pago_tipo.get_info(model.IdEmpresa, model.IdTipo_op);
            model.IdEmpresa =Convert.ToInt32( SessionFixed.IdEmpresa);
            model.info_comprobante.IdTipoCbte =(int) info_param_op.IdTipoCbte_OP;
            model.IdEstadoAprobacion = info_param_op.IdEstadoAprobacion;

            string mensaje = bus_orden_pago.validar(model);

            if (!validar(model, ref mensaje))
            {
                cargar_combos(model.IdEmpresa);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            if (mensaje != "")
            {
                cargar_combos(model.IdEmpresa);
                ViewBag.mensaje = mensaje;
                cargar_combos_detalle();
                return View(model);
            }
            else
            {
                if(bus_orden_pago.guardarDB(model))
                 return RedirectToAction("Index");
                else
                {
                    ViewBag.mensaje = mensaje;
                    cargar_combos(model.IdEmpresa);
                    cargar_combos_detalle();
                    return View(model);
                }
            }
        }

        public ActionResult Modificar(int IdEmpresa = 0 , int IdOrdenPago = 0)
        {

            bus_orden_pago = new cp_orden_pago_Bus();
            cargar_combos(IdEmpresa);
            cargar_combos_detalle();
            IdEmpresa =Convert.ToInt32( Session["IdEmpresa"]);

            cp_orden_pago_Info model = new cp_orden_pago_Info();
            model = bus_orden_pago.get_info(IdEmpresa, IdOrdenPago);
            SessionFixed.TipoPersona = model.IdTipo_Persona;
            comprobante_contable_fp.set_list(model.info_comprobante.lst_ct_cbtecble_det);
            lis_cp_orden_pago_det_Info.set_list(model.detalle);

            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_orden_pago_Info model)
        {
            string mensaje = "";
            bus_orden_pago_tipo = new cp_orden_pago_tipo_x_empresa_Bus();
            bus_orden_pago = new cp_orden_pago_Bus();
            bus_cancelacion = new cp_orden_pago_cancelaciones_Bus();
            if (bus_cancelacion.si_existe_cancelacion(IdEmpresa, model.IdOrdenPago))
            {
                mensaje = "La orden de pago tiene cancelaciones no se puede modificar";
                cargar_combos(model.IdEmpresa);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            if (model.IdTipo_op==cl_enumeradores.eTipoOrdenPago.FACT_PROVEE.ToString())
            {
                mensaje = "No se puede modificar una orden de pago de tipo factura por proveedor";
                cargar_combos(model.IdEmpresa);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }

            if (!validar(model, ref mensaje))
            {
                cargar_combos(model.IdEmpresa);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.detalle = lis_cp_orden_pago_det_Info.get_list();
            model.info_comprobante.lst_ct_cbtecble_det = comprobante_contable_fp.get_list();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            info_param_op = bus_orden_pago_tipo.get_info(model.IdEmpresa,model.IdTipo_op);
            model.info_comprobante.IdTipoCbte = (int)info_param_op.IdTipoCbte_OP;
            model.IdEstadoAprobacion = info_param_op.IdEstadoAprobacion;
            mensaje = bus_orden_pago.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model.IdEmpresa);
                ViewBag.mensaje = mensaje;
                cargar_combos_detalle();
                return View(model);
            }
            else
            {
                if (bus_orden_pago.modificarDB(model))
                    return RedirectToAction("Index");
                else
                {
                    ViewBag.mensaje = mensaje;
                    cargar_combos(model.IdEmpresa);
                    cargar_combos_detalle();
                    return View(model);
                }
            }
        }
        public ActionResult Anular(int IdEmpresa= 0, int IdOrdenPago =0)
        {
            
            cargar_combos(IdEmpresa);
            cargar_combos_detalle();
            IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cp_orden_pago_Info model = new cp_orden_pago_Info();
            model = bus_orden_pago.get_info(IdEmpresa, IdOrdenPago);
            SessionFixed.TipoPersona = model.IdTipo_Persona;
            Session["ct_cbtecble_Info"] = model.info_comprobante;
            Session["lst_detalle"] = model.detalle;
            comprobante_contable_fp.set_list( model.info_comprobante.lst_ct_cbtecble_det);
            return View(model);
        }


        [HttpPost]
        public ActionResult Anular(cp_orden_pago_Info model)
        {
            string mensaje = "";
            if (bus_cancelacion.si_existe_cancelacion(IdEmpresa, model.IdOrdenPago))
            {
                mensaje = "La orden de pago tiene cancelaciones no se puede anular";
                cargar_combos(model.IdEmpresa);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }


            bus_orden_pago = new cp_orden_pago_Bus();
            model.IdUsuarioUltAnu = SessionFixed.IdUsuario.ToString();
                if (bus_orden_pago.anularDB(model))
                    return RedirectToAction("Index");
                else
                {
                    cargar_combos(model.IdEmpresa);
                    cargar_combos_detalle();
                    return View(model);
                }
        }
        #endregion
        #region json
       
        public JsonResult armar_diario(string IdTipo_op = "", decimal IdEntidad = 0, double Valor_a_pagar = 0, string observacion="")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            info_param_op = bus_orden_pago_tipo.get_info(IdEmpresa, IdTipo_op);
            info_param_op = bus_orden_pago_tipo.get_info(IdEmpresa, IdTipo_op);

            comprobante_contable_fp.delete_detail_New_details(info_param_op, IdEntidad, Valor_a_pagar, observacion);
            // añadir detalle 
            cp_orden_pago_det_Info info_detalle = new cp_orden_pago_det_Info();
            info_detalle.Valor_a_pagar = Valor_a_pagar;
            info_detalle.Referencia = observacion;
            info_detalle.IdEstadoAprobacion = info_param_op.IdEstadoAprobacion;
            lst_detalle_op.Add(info_detalle);
            lis_cp_orden_pago_det_Info.set_list(lst_detalle_op);

            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarOP(decimal IdOrdenPago)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var mensaje = "";
           if( bus_cancelacion.si_existe_cancelacion(IdEmpresa, IdOrdenPago))
            {
                mensaje = "La orden de pago tiene cancelaciones no se puede modificar";
            }

            return Json(mensaje, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region DEtalles

        [ValidateInput(false)]
        public ActionResult GridViewPartial_deudas()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<cp_orden_pago_Info> model = new List<cp_orden_pago_Info>();
         
            return PartialView("_GridViewPartial_deudas", model);
        }

        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ct_plancta_Bus bus_cuenta = new ct_plancta_Bus();
            var lst_cuentas = bus_cuenta.get_list(IdEmpresa, false, true);
            ViewBag.lst_cuentas = lst_cuentas;
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                comprobante_contable_fp.AddRow(info_det);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = comprobante_contable_fp.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_orden_pago_dc", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                comprobante_contable_fp.UpdateRow(info_det);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = comprobante_contable_fp.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_orden_pago_dc", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            comprobante_contable_fp.DeleteRow(secuencia);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = comprobante_contable_fp.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_orden_pago_dc", model);
        }
        #endregion
        #region Metodos ComboBox bajo demanda flujo
        ba_TipoFlujo_Bus bus_tipo = new ba_TipoFlujo_Bus();
        public ActionResult CmbFlujo_OP()
        {
            decimal model = new decimal();
            return PartialView("_CmbFlujo_OP", model);
        }
        public List<ba_TipoFlujo_Info> get_list_bajo_demandaFlujo(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_tipo.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoIngEgr.EGR.ToString());
        }
        public ba_TipoFlujo_Info get_info_bajo_demandaFlujo(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_tipo.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion
        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbPersona_OP()
        {
            SessionFixed.TipoPersona = Request.Params["IdTipo_Persona"] != null ? Request.Params["IdTipo_Persona"].ToString() : SessionFixed.TipoPersona;
            decimal model = new decimal();
            return PartialView("_CmbPersona_OP", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), SessionFixed.TipoPersona);
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), SessionFixed.TipoPersona);
        }
        #endregion


    }
    #region Lista

    public class ct_cbtecble_det_List_op
    {
        public List<ct_cbtecble_det_Info> get_list( )
        {
            if (HttpContext.Current.Session["ct_cbtecble_det_Info"] == null)
            {
                List<ct_cbtecble_det_Info> list = new List<ct_cbtecble_det_Info>();

                HttpContext.Current.Session["ct_cbtecble_det_Info"] = list;
            }
            return (List<ct_cbtecble_det_Info>)HttpContext.Current.Session["ct_cbtecble_det_Info"];
        }

        public void set_list(List<ct_cbtecble_det_Info> list)
        {
            HttpContext.Current.Session["ct_cbtecble_det_Info"] = list;
        }

        public void AddRow(ct_cbtecble_det_Info info_det)
        {
            List<ct_cbtecble_det_Info> list = get_list();
            info_det.secuencia = list.Count == 0 ? 1 : list.Max(q => q.secuencia) + 1;
            info_det.dc_Valor = info_det.dc_Valor_debe > 0 ? info_det.dc_Valor_debe : info_det.dc_Valor_haber * -1;
            list.Add(info_det);
        }

        public void UpdateRow(ct_cbtecble_det_Info info_det)
        {
            ct_cbtecble_det_Info edited_info = get_list().Where(m => m.secuencia == info_det.secuencia).First();
            edited_info.IdCtaCble = info_det.IdCtaCble;
            edited_info.dc_para_conciliar = info_det.dc_para_conciliar;
            edited_info.dc_Valor = info_det.dc_Valor_debe > 0 ? info_det.dc_Valor_debe : info_det.dc_Valor_haber * -1;
            edited_info.dc_Valor_debe = info_det.dc_Valor_debe;
            edited_info.dc_Valor_haber = info_det.dc_Valor_haber;
        }

        public void DeleteRow(int secuencia)
        {
            List<ct_cbtecble_det_Info> list = get_list();
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }

        public void delete_detail_New_details(cp_orden_pago_tipo_x_empresa_Info info_param_op , decimal IdEntidad=0, double Valor_a_pagar=0, string observacion="")
        {
            try
            {
                set_list(new List<ct_cbtecble_det_Info>());

                // cuenta total
                ct_cbtecble_det_Info cbtecble_debe_Info = new ct_cbtecble_det_Info();
                cbtecble_debe_Info.secuencia = 1;
                cbtecble_debe_Info.IdEmpresa = info_param_op.IdEmpresa;
                cbtecble_debe_Info.IdTipoCbte =(int) info_param_op.IdTipoCbte_OP;
                cbtecble_debe_Info.IdCtaCble = info_param_op.IdCtaCble;
                cbtecble_debe_Info.dc_Valor_debe = Valor_a_pagar;
                cbtecble_debe_Info.dc_Valor = Valor_a_pagar;
                cbtecble_debe_Info.dc_Observacion= observacion;
                AddRow(cbtecble_debe_Info);


                // cuenta iva
                ct_cbtecble_det_Info cbtecble_haber_Info = new ct_cbtecble_det_Info();
                cbtecble_haber_Info.secuencia = 2;
                cbtecble_haber_Info.IdEmpresa = info_param_op.IdEmpresa;
                cbtecble_debe_Info.IdTipoCbte = (int)info_param_op.IdTipoCbte_OP;
                cbtecble_haber_Info.IdCtaCble = info_param_op.IdCtaCble_Credito;
                cbtecble_haber_Info.dc_Valor_haber = Valor_a_pagar ;
                cbtecble_haber_Info.dc_Valor = Valor_a_pagar * -1;
                cbtecble_haber_Info.dc_Observacion = observacion;
                AddRow(cbtecble_haber_Info);

                
            }
            catch (Exception)
            {
                throw;
            }
        }


    }

    public class cp_orden_pago_det_Info_list
    {
        public List<cp_orden_pago_det_Info> get_list()
        {
            if (HttpContext.Current.Session["cp_orden_pago_det_Info"] == null)
            {
                List<cp_orden_pago_det_Info> list = new List<cp_orden_pago_det_Info>();

                HttpContext.Current.Session["cp_orden_pago_det_Info"] = list;
            }
            return (List<cp_orden_pago_det_Info>)HttpContext.Current.Session["cp_orden_pago_det_Info"];
        }

        public void set_list(List<cp_orden_pago_det_Info> list)
        {
            HttpContext.Current.Session["cp_orden_pago_det_Info"] = list;
        }

      

    }
    #endregion

    
}