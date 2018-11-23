using Core.Erp.Bus.Banco;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Bus.General;
using Core.Erp.Info.Banco;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class NotaDebitoController : Controller
    {

        #region variables
        cp_nota_DebCre_Bus bus_orden_giro = new cp_nota_DebCre_Bus();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        cp_codigo_SRI_x_CtaCble_Bus bus_codigo_sri = new cp_codigo_SRI_x_CtaCble_Bus();
        cp_pagos_sri_Bus bus_forma_paogo = new cp_pagos_sri_Bus();
        cp_pais_sri_Bus bus_pais = new cp_pais_sri_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        cp_TipoDocumento_Bus bus_tipo_documento = new cp_TipoDocumento_Bus();
        cp_proveedor_Info info_proveedor = new cp_proveedor_Info();
        cp_proveedor_Bus bus_prov = new cp_proveedor_Bus();
        cp_parametros_Info info_parametro = new cp_parametros_Info();
        cp_parametros_Bus bus_param = new cp_parametros_Bus();
        ct_cbtecble_det_List_nd Lis_ct_cbtecble_det_List_nd = new ct_cbtecble_det_List_nd();
        cp_orden_pago_Bus bus_orden_pago = new cp_orden_pago_Bus();
        List<cp_orden_pago_det_Info> lst_detalle_op = new List<cp_orden_pago_det_Info>();
        cp_orden_pago_cancelaciones_Bus bus_orden_pago_cancelaciones = new cp_orden_pago_cancelaciones_Bus();
        List<cp_orden_pago_det_Info> list_op_seleccionadas = new List<cp_orden_pago_det_Info>();
        ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
        string mensaje = string.Empty;
        #endregion
        #region Metodos ComboBox bajo demanda flujo
        ba_TipoFlujo_Bus bus_tipo = new ba_TipoFlujo_Bus();
        public ActionResult CmbFlujo_ND()
        {
            decimal model = new decimal();
            return PartialView("_CmbFlujo_ND", model);
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
        public ActionResult CmbProveedor_CXP()
        {
            decimal model = new decimal();
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
        #region vistas partial
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal)
            };
            cargar_combos_sucursal();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            cargar_combos_sucursal();
            return View(model);
        }
        private void cargar_combos_sucursal()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursales = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursales = lst_sucursales;
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_nota_debito(DateTime? fecha_ini, DateTime? fecha_fin, int IdSucursal = 0)
        {
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : fecha_ini;
            ViewBag.fecha_fin = fecha_fin == null ? DateTime.Now.Date : fecha_fin;
            ViewBag.IdSucursal = IdSucursal;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_orden_giro.get_lst(IdEmpresa, IdSucursal, "D", Convert.ToDateTime(fecha_ini), Convert.ToDateTime(fecha_fin));
            return PartialView("_GridViewPartial_nota_debito", model);
        }

        public ActionResult GridViewPartial_nota_debito_dc()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nd.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_debito_dc", model);
        }

        #endregion
        #region cargar combos
        private void cargar_combos(int IdEmpresa, decimal IdProveedor , string IdTipoSRI )
        {
            var lst_codigos_sri = bus_codigo_sri.get_list(IdEmpresa);
            ViewBag.lst_codigos_sri = lst_codigos_sri;

            var lst_forma_pago = bus_forma_paogo.get_list();
            ViewBag.lst_forma_pago = lst_forma_pago;

            var lst_paises = bus_pais.get_list();
            ViewBag.lst_paises = lst_paises;

            var lst_sucursales = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursales = lst_sucursales;
            if (IdProveedor != 0)
            {
                if (IdTipoSRI == "")
                    IdTipoSRI = "01";
                var list_tipo_doc = bus_tipo_documento.get_list(IdEmpresa, IdProveedor, IdTipoSRI);
                ViewBag.lst_tipo_doc = list_tipo_doc;
            }
            else
            {
                ViewBag.lst_tipo_doc = new List<cp_TipoDocumento_Info>();

            }
            Dictionary<string, string> lst_tipo_nota = new Dictionary<string, string>();
            lst_tipo_nota.Add("T_TIP_NOTA_INT", "Uso interno");
            lst_tipo_nota.Add("T_TIP_NOTA_SRI", "Autorizado por SRI");
            ViewBag.lst_tipo_nota = lst_tipo_nota;
            
            List<string> lst_tipo_servicio = new List<string>();
            lst_tipo_servicio.Add(cl_enumeradores.eTipoServicioCXP.SERVI.ToString());
            lst_tipo_servicio.Add(cl_enumeradores.eTipoServicioCXP.BIEN.ToString());
            lst_tipo_servicio.Add(cl_enumeradores.eTipoServicioCXP.AMBAS.ToString());
            ViewBag.lst_tipo_servicio = lst_tipo_servicio;
            
            Dictionary<string, string> lst_localizacion = new Dictionary<string, string>();
            lst_localizacion.Add("LOC", "LOCAL");
            lst_localizacion.Add("EXT", "EXTERIOR");
            ViewBag.lst_localizacion = lst_localizacion;

        }
        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ct_plancta_Bus bus_cuenta = new ct_plancta_Bus();
            var lst_cuentas = bus_cuenta.get_list(IdEmpresa, false, true);
            ViewBag.lst_cuentas = lst_cuentas;
        }
        private bool validar(cp_nota_DebCre_Info i_validar, ref string msg)
        {
            i_validar.lst_detalle_ct = Lis_ct_cbtecble_det_List_nd.get_list(i_validar.IdTransaccionSession);

            foreach (var item in i_validar.lst_detalle_ct)
            {
                if (string.IsNullOrEmpty(item.IdCtaCble))
                {
                    mensaje = "Faltan cuentas contables, por favor verifique";
                    return false;
                }
            }

            if (i_validar.lst_detalle_ct.Where(q => q.dc_Valor == 0).Count() > 0)
            {
                mensaje = "Existen detalles con valor 0 en el debe o haber";
                return false;
            }

            if (i_validar.lst_detalle_ct.Count == 0)
            {
                mensaje = "Debe ingresar registros en el detalle";
                return false;
            }

            if (i_validar.lst_detalle_ct.Sum(q => q.dc_Valor) != 0)
            {
                mensaje = "La suma de los detalles debe ser 0";
                return false;
            }
            if (!bus_periodo.ValidarFechaTransaccion(i_validar.IdEmpresa, i_validar.cn_fecha, cl_enumeradores.eModulo.CXP, ref msg))
            {
                return false;
            }
            if (!bus_periodo.ValidarFechaTransaccion(i_validar.IdEmpresa, i_validar.cn_fecha, cl_enumeradores.eModulo.CONTA, ref msg))
            {
                return false;
            }
            return true;
        }


        #endregion
        #region json

        public JsonResult get_list_tipo_doc(int IdEmpresa = 0, decimal IdProveedor = 0, string codigoSRI = "")
        {
            var list_tipo_doc = bus_tipo_documento.get_list(IdEmpresa, IdProveedor, codigoSRI);
            return Json(list_tipo_doc, JsonRequestBehavior.AllowGet);
        }

        public JsonResult armar_diario(decimal IdProveedor = 0, double cn_subtotal_iva = 0, double cn_subtotal_siniva = 0,
            double valoriva = 0, double total = 0, string observacion = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
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
                Session["info_parametro"] = info_parametro;
            }
            else
                info_parametro = Session["info_parametro"] as cp_parametros_Info;


            Lis_ct_cbtecble_det_List_nd.delete_detail_New_details(info_proveedor, info_parametro, cn_subtotal_iva, cn_subtotal_siniva, valoriva, total, observacion);
            return Json("", JsonRequestBehavior.AllowGet);
        }
       
        #endregion
        #region funciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            cp_nota_DebCre_Info model = new cp_nota_DebCre_Info
            {
                IdEmpresa = IdEmpresa,
                Fecha_contable = DateTime.Now,
                cn_fecha = DateTime.Now,
                cn_Fecha_vcto = DateTime.Now,
                PaisPago = "593",
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession)
            };
            cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdIden_credito.ToString());
            Lis_ct_cbtecble_det_List_nd.set_list(new List<ct_cbtecble_det_Info>(), model.IdTransaccionSession);
            return View(model);

        }

        [HttpPost]
        public ActionResult Nuevo(cp_nota_DebCre_Info model)
        {
            model.DebCre = "D";
            model.info_comrobante = new ct_cbtecble_Info();
            if (Session["info_parametro"] != null)
            {
                info_parametro = Session["info_parametro"] as cp_parametros_Info;
                model.info_comrobante.IdTipoCbte = (int)info_parametro.pa_TipoCbte_ND;
            }
            model.info_comrobante.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nd.get_list(model.IdTransaccionSession);

            model.IdUsuario = SessionFixed.IdUsuario.ToString();
            if (!validar(model, ref mensaje))
            {
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdIden_credito.ToString());
                ViewBag.mensaje = mensaje;
                cargar_combos_detalle();
                return View(model);
            }
            if (!bus_orden_giro.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdIden_credito.ToString());
                cargar_combos_detalle();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdTipoCbte_Nota = 0, decimal IdCbteCble_Nota = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            cp_nota_DebCre_Info model = bus_orden_giro.get_info(IdEmpresa, IdTipoCbte_Nota, IdCbteCble_Nota);
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            if (model == null)
                return RedirectToAction("Index");
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
                model.info_comrobante.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            Lis_ct_cbtecble_det_List_nd.set_list(model.info_comrobante.lst_ct_cbtecble_det, model.IdTransaccionSession);
            cargar_combos(IdEmpresa, model.IdProveedor, model.IdIden_credito.ToString());
            cargar_combos_detalle();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_nota_DebCre_Info model)
        {
            model.IdUsuario = SessionFixed.IdUsuario.ToString();
            model.info_comrobante.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nd.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            if (!validar(model, ref mensaje))
            {
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdIden_credito.ToString());
                ViewBag.mensaje = mensaje;
                cargar_combos_detalle();
                return View(model);
            }
            if (!bus_orden_giro.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdIden_credito.ToString());
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, int IdTipoCbte_Nota = 0, decimal IdCbteCble_Nota = 0)
        {
            cp_nota_DebCre_Info model = bus_orden_giro.get_info(IdEmpresa, IdTipoCbte_Nota, IdCbteCble_Nota);
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            if (model == null)
                return RedirectToAction("Index");
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
                model.info_comrobante.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            Lis_ct_cbtecble_det_List_nd.set_list(model.info_comrobante.lst_ct_cbtecble_det, model.IdTransaccionSession);
            cargar_combos(IdEmpresa, model.IdProveedor, model.IdIden_credito.ToString());
            cargar_combos_detalle();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(cp_nota_DebCre_Info model)
        {

            model.IdUsuario = SessionFixed.IdUsuario.ToString();
            model.info_comrobante.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nd.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            if (!bus_orden_giro.anularDB(model))
            {
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdIden_credito.ToString());
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
        #region Funcion diario contable
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                Lis_ct_cbtecble_det_List_nd.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nd.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_debito_dc", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                Lis_ct_cbtecble_det_List_nd.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nd.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_debito_dc", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            Lis_ct_cbtecble_det_List_nd.DeleteRow(secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nd.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_debito_dc", model);
        }
        #endregion

    }

    public class ct_cbtecble_det_List_nd
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

        public void delete_detail_New_details(cp_proveedor_Info info_proveedor, cp_parametros_Info info_parametro, double cn_subtotal_iva = 0,
            double cn_subtotal_siniva = 0, double cn_valoriva = 0, double cn_total = 0, string observacion = "")
        {
            try
            {

                HttpContext.Current.Session["ct_cbtecble_det_Info" + Convert.ToString(SessionFixed.IdTransaccionSessionActual)] = null;

                // cuenta total
                ct_cbtecble_det_Info cbtecble_det_total_Info = new ct_cbtecble_det_Info();
                cbtecble_det_total_Info.secuencia = 3;
                cbtecble_det_total_Info.IdEmpresa = 0;
                cbtecble_det_total_Info.IdTipoCbte = 1;
                cbtecble_det_total_Info.IdCtaCble = info_proveedor.IdCtaCble_CXP;
                cbtecble_det_total_Info.dc_Valor_haber = cn_total;
                cbtecble_det_total_Info.dc_Valor = cn_total * -1;
                cbtecble_det_total_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_total_Info, Convert.ToDecimal(SessionFixed.IdTransaccionSession));


                // cuenta iva
                ct_cbtecble_det_Info cbtecble_det_iva_Info = new ct_cbtecble_det_Info();
                cbtecble_det_iva_Info.secuencia = 2;
                cbtecble_det_iva_Info.IdEmpresa = 0;
                cbtecble_det_iva_Info.IdTipoCbte = 1;
                cbtecble_det_iva_Info.IdCtaCble = info_parametro.pa_ctacble_iva;
                cbtecble_det_iva_Info.dc_Valor_debe = cn_valoriva;
                cbtecble_det_iva_Info.dc_Valor = cn_valoriva;
                cbtecble_det_iva_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_iva_Info, Convert.ToDecimal(SessionFixed.IdTransaccionSession));

                // cuenta sbtotal
                ct_cbtecble_det_Info cbtecble_det_sub_Info = new ct_cbtecble_det_Info();
                cbtecble_det_sub_Info.secuencia = 1;
                cbtecble_det_sub_Info.IdEmpresa = 0;
                cbtecble_det_sub_Info.IdTipoCbte = 1;
                cbtecble_det_sub_Info.IdCtaCble = info_parametro.pa_ctacble_deudora;
                cbtecble_det_sub_Info.dc_Valor_debe = cn_subtotal_iva + cn_subtotal_siniva;
                cbtecble_det_sub_Info.dc_Valor = cn_subtotal_iva + cn_subtotal_siniva;
                cbtecble_det_sub_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_sub_Info, Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            }
            catch (Exception)
            {

                throw;
            }
        }

    }

}