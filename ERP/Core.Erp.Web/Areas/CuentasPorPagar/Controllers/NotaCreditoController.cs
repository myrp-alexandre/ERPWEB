using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.General;
using DevExpress.Web.Mvc;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using Core.Erp.Info.General;
using DevExpress.Web;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class NotaCreditoController : Controller
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
        ct_cbtecble_det_List_nc Lis_ct_cbtecble_det_List_nc = new ct_cbtecble_det_List_nc();
        cp_orden_pago_Bus bus_orden_pago = new cp_orden_pago_Bus();
        List<cp_orden_pago_det_Info> lst_detalle_op = new List<cp_orden_pago_det_Info>();
        cp_orden_pago_cancelaciones_Bus bus_orden_pago_cancelaciones = new cp_orden_pago_cancelaciones_Bus();
        List<cp_orden_pago_det_Info> list_op_seleccionadas = new List<cp_orden_pago_det_Info>();
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
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_nota_credito()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<cp_nota_DebCre_Info> model = new List<cp_nota_DebCre_Info>();
            model = bus_orden_giro.get_lst(IdEmpresa, DateTime.Now, DateTime.Now);
            return PartialView("_GridViewPartial_nota_credito", model);
        }

        public ActionResult GridViewPartial_nota_credito_dc()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det =Lis_ct_cbtecble_det_List_nc.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_credito_dc", model);
        }
        public ActionResult GridViewPartial_nota_credito_det()
        {
            List<cp_orden_pago_det_Info> lst_detalle_op = new List<cp_orden_pago_det_Info>();
            lst_detalle_op = Session["list_op_seleccionadas"] as List<cp_orden_pago_det_Info>;
            return PartialView("_GridViewPartial_nota_credito_det", lst_detalle_op);
        }
        public ActionResult GridViewPartial_ordenes_pagos_con_saldo()
        {
            lst_detalle_op = Session["list_op_por_proveedor"] as List<cp_orden_pago_det_Info>;
            return PartialView("_GridViewPartial_ordenes_pagos_con_saldo", lst_detalle_op);
        }

         #endregion
        #region funciones
        public ActionResult Nuevo(int IdEmpresa = 0 )
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            (Session["ct_cbtecble_det_Info"]) = null;
            Session["list_op_por_proveedor"] = null;
            Session["list_op_seleccionadas"] = null;
            cp_nota_DebCre_Info model = new cp_nota_DebCre_Info
            {
                IdEmpresa = IdEmpresa,
                Fecha_contable = DateTime.Now,
                cn_fecha = DateTime.Now,
                cn_Fecha_vcto = DateTime.Now,
                PaisPago = "593"
            };
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_nota_DebCre_Info model)
        {
            model.info_comrobante = new ct_cbtecble_Info();

            model.info_comrobante.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nc.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));

            if(model.info_comrobante.lst_ct_cbtecble_det==null)
            {
                ViewBag.mensaje = "Falta diario contable";
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdTipoNota);
                cargar_combos_detalle();
                return View(model);

            }
            if (Session["info_parametro"] != null)
            {
                info_parametro = Session["info_parametro"] as cp_parametros_Info;
                model.info_comrobante.IdTipoCbte = (int)info_parametro.pa_TipoCbte_NC;
            }
            else
            {
                ViewBag.mensaje = "Falta parametros del modulo cuenta por pagar";
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdTipoNota);
                cargar_combos_detalle();
                return View(model);
            }
            string mensaje = bus_orden_giro.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdTipoNota);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }


            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            if (!bus_orden_giro.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdTipoNota);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , int IdTipoCbte_Nota = 0, decimal IdCbteCble_Nota = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion

             Session["list_op_por_proveedor"] = null;
            Session["list_op_seleccionadas"] = null;
            
            cp_nota_DebCre_Info model = bus_orden_giro.get_info(IdEmpresa, IdTipoCbte_Nota, IdCbteCble_Nota);
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);

            if (model == null)
                return RedirectToAction("Index");
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
                model.info_comrobante.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            Lis_ct_cbtecble_det_List_nc.set_list(model.info_comrobante.lst_ct_cbtecble_det, model.IdTransaccionSession);

            list_op_seleccionadas = bus_orden_pago_cancelaciones.Get_list_Cancelacion_x_CXP(IdEmpresa,IdTipoCbte_Nota,IdCbteCble_Nota);
            if (list_op_seleccionadas == null)
                list_op_seleccionadas = new List<cp_orden_pago_det_Info>();
                Session["list_op_seleccionadas"] = list_op_seleccionadas;

            cargar_combos(IdEmpresa, model.IdProveedor, model.IdIden_credito.ToString());
            cargar_combos_detalle();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_nota_DebCre_Info model)
        {


           
            model.info_comrobante = new ct_cbtecble_Info();

            model.info_comrobante.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nc.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));

            if (Session["list_op_seleccionadas"] != null)
            {
                model.lst_detalle_op = Session["list_op_seleccionadas"] as List<cp_orden_pago_det_Info>;
            }
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
            {
                ViewBag.mensaje = "Falta detalle  de pago";
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdTipoNota);
                cargar_combos_detalle();
                return View(model);

            }
           
            string mensaje = bus_orden_giro.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdTipoNota);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }


            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            if (!bus_orden_giro.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa, model.IdProveedor, model.IdTipoNota);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0 , int IdTipoCbte_Nota = 0, decimal IdCbteCble_Nota = 0)
        {
            Session["list_op_por_proveedor"] = null;
            Session["list_op_seleccionadas"] = null;

            cp_nota_DebCre_Info model = bus_orden_giro.get_info(IdEmpresa, IdTipoCbte_Nota, IdCbteCble_Nota);
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);

            if (model == null)
                return RedirectToAction("Index");
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
                model.info_comrobante.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            Lis_ct_cbtecble_det_List_nc.set_list(model.info_comrobante.lst_ct_cbtecble_det, model.IdTransaccionSession);

            list_op_seleccionadas = bus_orden_pago_cancelaciones.Get_list_Cancelacion_x_CXP(IdEmpresa, IdTipoCbte_Nota, IdCbteCble_Nota);
            if (list_op_seleccionadas == null)
                list_op_seleccionadas = new List<cp_orden_pago_det_Info>();
            Session["list_op_seleccionadas"] = list_op_seleccionadas;

            cargar_combos(IdEmpresa, model.IdProveedor, model.IdIden_credito.ToString());
            cargar_combos_detalle();
            return View(model); ;
        }
        [HttpPost]
        public ActionResult Anular(cp_nota_DebCre_Info model)
        {

            bus_orden_giro = new cp_nota_DebCre_Bus();
            model.IdUsuario = SessionFixed.IdUsuario.ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            if (!bus_orden_giro.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
        #region json

        public JsonResult get_list_tipo_doc(int IdEmpresa =0,decimal IdProveedor = 0, string codigoSRI = "")
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


            Lis_ct_cbtecble_det_List_nc.delete_detail_New_details(info_proveedor, info_parametro, cn_subtotal_iva, cn_subtotal_siniva, valoriva, total, observacion);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult Buscar_op(int IdEmpresa , decimal IdProveedor)
        {
            try
            {
                string IdTipo_op = cl_enumeradores.eTipoOrdenPago.FACT_PROVEE.ToString();
                string IdEstado_Aprobacion = cl_enumeradores.eEstadoAprobacionOrdenPago.APRO.ToString();
                string IdUsuario = Session["IdUsuario"].ToString();
                lst_detalle_op = bus_orden_pago.Get_List_orden_pago_con_saldo(IdEmpresa, IdTipo_op, IdProveedor, IdEstado_Aprobacion, IdUsuario);
                Session["list_op_por_proveedor"] = lst_detalle_op as List<cp_orden_pago_det_Info>;
                return Json("", JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public JsonResult seleccionar_op(string Ids)
        {
            string[] array = Ids.Split(',');
            var output = array.GroupBy(q => q).ToList();
            List<cp_orden_pago_det_Info> model = new List<cp_orden_pago_det_Info>();
            List<cp_orden_pago_det_Info> list_op_seleccionadas = new List<cp_orden_pago_det_Info>();
            model = Session["list_op_por_proveedor"] as List<cp_orden_pago_det_Info>;
            list_op_seleccionadas = Session["list_op_seleccionadas"] as List<cp_orden_pago_det_Info>;
            if (list_op_seleccionadas == null)
                list_op_seleccionadas = new List<cp_orden_pago_det_Info>();
            foreach (var item in output)
            {
                if (item.Key != "")
                {
                    var lista_tmp = model.Where(v => v.IdOrdenPago == Convert.ToDecimal(item.Key));
                    if (lista_tmp.Count() == 1 & list_op_seleccionadas.Where(v => v.IdOrdenPago == Convert.ToDecimal(item.Key)).Count() == 0)// agrego si existe y no esta repetida
                    {
                        var info_add = lista_tmp.FirstOrDefault();
                        info_add.Valor_a_pagar = (double)info_add.Valor_a_pagar;
                        list_op_seleccionadas.Add(info_add);
                    }
                }
            }
            Session["list_op_seleccionadas"] = list_op_seleccionadas;
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion
        #region cargar combos
        private void cargar_combos(int IdEmpresa, decimal IdProveedor = 0, string IdTipoSRI = "")
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
            lst_tipo_nota.Add("T_TIP_NOTA_SRI", "Autorizado por SRI");
            lst_tipo_nota.Add("T_TIP_NOTA_INT", "Uso interno");
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
        #endregion
        #region Funcion diario contable
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                Lis_ct_cbtecble_det_List_nc.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nc.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_credito_dc", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                Lis_ct_cbtecble_det_List_nc.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nc.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_credito_dc", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            Lis_ct_cbtecble_det_List_nc.DeleteRow(secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Lis_ct_cbtecble_det_List_nc.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_credito_dc", model);
        }
        #endregion
        #region Editar y eliminar detalle
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate_op([ModelBinder(typeof(DevExpressEditorsBinder))] cp_orden_pago_det_Info info_det)
        {

            List<cp_orden_pago_det_Info> model = new List<cp_orden_pago_det_Info>();
            model = Session["list_op_seleccionadas"] as List<cp_orden_pago_det_Info>;
            if(model.Count()>0)
            {
                cp_orden_pago_det_Info edited_info = model.Where(m => m.IdOrdenPago == info_det.IdOrdenPago).First();
              
                edited_info.Valor_a_pagar = info_det.Valor_a_pagar;
            }
               
            return PartialView("_GridViewPartial_nota_credito_det", model);
        }

        public ActionResult EditingDelete_op(int IdOrdenPago)
        {

            List<cp_orden_pago_det_Info> model = new List<cp_orden_pago_det_Info>();
            model = Session["list_op_seleccionadas"] as List<cp_orden_pago_det_Info>;
            if (model.Count() > 0)
            {
                cp_orden_pago_det_Info edited_info = model.Where(m => m.IdOrdenPago == IdOrdenPago).First();
                model.Remove(edited_info);
                Session["list_op_seleccionadas"] = model;

            }

            return PartialView("_GridViewPartial_nota_credito_det", model);
        }
        #endregion
        
    }
    public class ct_cbtecble_det_List_nc
    {
        string Variable = "ct_cbtecble_det_Info";
        public List<ct_cbtecble_det_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[Variable +IdTransaccionSession.ToString()] == null)
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

                HttpContext.Current.Session["ct_cbtecble_det_Info"+Convert.ToString(SessionFixed.IdTransaccionSessionActual)] = null;

                // cuenta total
                ct_cbtecble_det_Info cbtecble_det_total_Info = new ct_cbtecble_det_Info();
                cbtecble_det_total_Info.secuencia = 3;
                cbtecble_det_total_Info.IdEmpresa = 0;
                cbtecble_det_total_Info.IdTipoCbte = 1;
                cbtecble_det_total_Info.IdCtaCble = info_proveedor.IdCtaCble_CXP;
                cbtecble_det_total_Info.dc_Valor_debe = cn_total;
                cbtecble_det_total_Info.dc_Valor = cn_total * -1;
                cbtecble_det_total_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_total_Info,Convert.ToDecimal( SessionFixed.IdTransaccionSession));


                // cuenta iva
                ct_cbtecble_det_Info cbtecble_det_iva_Info = new ct_cbtecble_det_Info();
                cbtecble_det_iva_Info.secuencia = 2;
                cbtecble_det_iva_Info.IdEmpresa = 0;
                cbtecble_det_iva_Info.IdTipoCbte = 1;
                cbtecble_det_iva_Info.IdCtaCble = info_parametro.pa_ctacble_iva;
                cbtecble_det_iva_Info.dc_Valor_haber = cn_valoriva;
                cbtecble_det_iva_Info.dc_Valor = cn_valoriva;
                cbtecble_det_iva_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_iva_Info, Convert.ToDecimal(SessionFixed.IdTransaccionSession));

                // cuenta sbtotal
                ct_cbtecble_det_Info cbtecble_det_sub_Info = new ct_cbtecble_det_Info();
                cbtecble_det_sub_Info.secuencia = 1;
                cbtecble_det_sub_Info.IdEmpresa = 0;
                cbtecble_det_sub_Info.IdTipoCbte = 1;
                cbtecble_det_sub_Info.IdCtaCble = info_parametro.pa_ctacble_deudora;
                cbtecble_det_sub_Info.dc_Valor_haber = cn_subtotal_iva + cn_subtotal_siniva;
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