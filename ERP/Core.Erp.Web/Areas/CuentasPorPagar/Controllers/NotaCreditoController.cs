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
namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class NotaCreditoController : Controller
    {
        #region variables
       cp_nota_DebCre_Bus bus_orden_giro = new cp_nota_DebCre_Bus();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        cp_codigo_SRI_x_CtaCble_Bus bus_codigo_sri = new cp_codigo_SRI_x_CtaCble_Bus();
        cp_pagos_sri_Bus bus_forma_paogo = new cp_pagos_sri_Bus();
        tb_pais_Bus bus_pais = new tb_pais_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        cp_TipoDocumento_Bus bus_tipo_documento = new cp_TipoDocumento_Bus();
        cp_proveedor_Info info_proveedor = new cp_proveedor_Info();
        cp_proveedor_Bus bus_prov = new cp_proveedor_Bus();
        cp_parametros_Info info_parametro = new cp_parametros_Info();
        cp_parametros_Bus bus_param = new cp_parametros_Bus();
        ct_cbtecble_det_List_nc comprobante_contable_fp = new ct_cbtecble_det_List_nc();
        int IdEmpresa = 0;


        #endregion
        public ActionResult Index()
        {
            return View();
        }
        
        public ActionResult GridViewPartial_nota_credito_dc()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_credito_dc", model);
        }

        private void cargar_combos(decimal IdProveedor = 0, string IdTipoSRI = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var lst_proveedores = bus_proveedor.get_list(IdEmpresa, false);
            ViewBag.lst_proveedores = lst_proveedores;

            var lst_codigos_sri = bus_codigo_sri.get_list(IdEmpresa);
            ViewBag.lst_codigos_sri = lst_codigos_sri;

            var lst_forma_pago = bus_forma_paogo.get_list();
            ViewBag.lst_forma_pago = lst_forma_pago;

            var lst_paises = bus_pais.get_list(false);
            ViewBag.lst_paises = lst_paises;

            var lst_sucursales = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursales = lst_sucursales;
            if (IdProveedor != 0)
            {
                var list_tipo_doc = bus_tipo_documento.get_list(IdEmpresa, IdProveedor, IdTipoSRI);
                ViewBag.lst_tipo_doc = list_tipo_doc;
            }
            else
            {
                ViewBag.lst_tipo_doc = new List<cp_TipoDocumento_Info>();

            }
            List<string> lst_tipo_nota=new  List<string>();
            lst_tipo_nota.Add(cl_enumeradores.eTipoNotaCXP.T_TIP_NOTA_INT.ToString());
            lst_tipo_nota.Add(cl_enumeradores.eTipoNotaCXP.T_TIP_NOTA_SRI.ToString());
            ViewBag.lst_tipo_nota = lst_tipo_nota;


            List<string> lst_tipo_servicio = new List<string>();
            lst_tipo_servicio.Add(cl_enumeradores.eTipoServicioCXP.SERVI.ToString());
            lst_tipo_servicio.Add(cl_enumeradores.eTipoServicioCXP.BIEN.ToString());
            lst_tipo_servicio.Add(cl_enumeradores.eTipoServicioCXP.AMBAS.ToString());
            ViewBag.lst_tipo_servicio = lst_tipo_servicio;

            List<string> lst_localizacion = new List<string>();
            lst_localizacion.Add(cl_enumeradores.eTiLocalizacionCXP.LOC.ToString());
            lst_localizacion.Add(cl_enumeradores.eTiLocalizacionCXP.EXT.ToString());
            ViewBag.lst_localizacion = lst_localizacion;

        }

        public ActionResult Nuevo()
        {
            (Session["ct_cbtecble_det_Info"]) = null;
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_nota_DebCre_Info model = new cp_nota_DebCre_Info();
            model = bus_orden_giro.get_info_nuevo(IdEmpresa);
            
               
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_nota_DebCre_Info model)
        {
            model.info_comrobante = new ct_cbtecble_Info();

            if (Session["lst_detalle_op"] != null)
            {
                model.lst_detalle_op = Session["lst_detalle_op"] as List<cp_orden_pago_det_Info>;
            }
            if (Session["ct_cbtecble_det_Info"] != null)
            {
                model.info_comrobante.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            }
            else
            {
                ViewBag.mensaje = "Falta diario contable";
                cargar_combos(model.IdProveedor, model.IdTipoNota);
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
                cargar_combos(model.IdProveedor, model.IdTipoNota);
                cargar_combos_detalle();
                return View(model);
            }
            string mensaje = bus_orden_giro.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model.IdProveedor, model.IdTipoNota);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }


            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            if (!bus_orden_giro.guardarDB(model))
            {
                cargar_combos(model.IdProveedor, model.IdTipoNota);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdTipoCbte_Nota = 0, decimal IdCbteCble_Nota = 0)
        {

            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
           cp_nota_DebCre_Info model = bus_orden_giro.get_info(IdEmpresa, IdTipoCbte_Nota, IdCbteCble_Nota);
            if (model == null)
                return RedirectToAction("Index");
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
                model.info_comrobante.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            Session["ct_cbtecble_det_Info"] = model.info_comrobante.lst_ct_cbtecble_det;
           
            cargar_combos(model.IdProveedor, model.IdTipoNota);
            cargar_combos_detalle();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_nota_DebCre_Info model)
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
            
            if (Session["ct_cbtecble_det_Info"] != null)
            {
                model.info_comrobante.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            }
            else
            {
                ViewBag.mensaje = "Falta diario contable";
                cargar_combos(model.IdProveedor, model.IdTipoNota);
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
                cargar_combos(model.IdProveedor, model.IdTipoNota);
                cargar_combos_detalle();
                return View(model);
            }
            string mensaje = bus_orden_giro.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model.IdProveedor, model.IdTipoNota);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }


            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            if (!bus_orden_giro.modificarDB(model))
            {
                cargar_combos(model.IdProveedor, model.IdTipoNota);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdTipoCbte_Nota = 0, decimal IdCbteCble_Nota = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
           cp_nota_DebCre_Info model = bus_orden_giro.get_info(IdEmpresa, IdTipoCbte_Nota, IdCbteCble_Nota);
            if (model == null)
                return RedirectToAction("Index");
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
                model.info_comrobante.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            Session["ct_cbtecble_det_Info"] = model.info_comrobante.lst_ct_cbtecble_det;
           
            cargar_combos(model.IdProveedor, model.IdTipoNota);
            cargar_combos_detalle();
            return View(model);
        }


        [HttpPost]
        public ActionResult Anular(cp_nota_DebCre_Info model)
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
           
            if (Session["ct_cbtecble_det_Info"] != null)
            {
                model.info_comrobante.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            }
            else
            {
                ViewBag.mensaje = "Falta diario contable";
                cargar_combos();
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
                cargar_combos();
                cargar_combos_detalle();
                return View(model);
            }
            string mensaje = bus_orden_giro.validar(model);
            if (mensaje != "")
            {
                cargar_combos();
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }


            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            if (!bus_orden_giro.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #region json
       
        public JsonResult get_list_tipo_doc(decimal IdProveedor = 0, string codigoSRI = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var list_tipo_doc = bus_tipo_documento.get_list(IdEmpresa, IdProveedor, codigoSRI);
            return Json(list_tipo_doc, JsonRequestBehavior.AllowGet);
        }

        public JsonResult armar_diario(decimal IdProveedor = 0, double cn_subtotal_iva = 0, double cn_subtotal_siniva = 0, double cn_valoriva = 0, double cn_total = 0, string observacion = "")
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


            comprobante_contable_fp.delete_detail_New_details(info_proveedor, info_parametro, cn_subtotal_iva, cn_subtotal_siniva, cn_valoriva, cn_total, observacion);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion


        [ValidateInput(false)]
        public ActionResult GridViewPartial_nota_credito()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<cp_nota_DebCre_Info> model = new List<cp_nota_DebCre_Info>();
            model = bus_orden_giro.get_lst(IdEmpresa, DateTime.Now, DateTime.Now);
            return PartialView("_GridViewPartial_nota_credito", model);
        }
       
        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
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
            return PartialView("_GridViewPartial_nota_credito_dc", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                comprobante_contable_fp.UpdateRow(info_det);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = comprobante_contable_fp.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_credito_dc", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            comprobante_contable_fp.DeleteRow(secuencia);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = comprobante_contable_fp.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_nota_credito_dc", model);
        }


    }


    public class ct_cbtecble_det_List_nc
    {
        public List<ct_cbtecble_det_Info> get_list()
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

        public void delete_detail_New_details(cp_proveedor_Info info_proveedor, cp_parametros_Info info_parametro, double cn_subtotal_iva = 0,
            double cn_subtotal_siniva = 0, double cn_valoriva = 0, double cn_total = 0, string observacion = "")
        {
            try
            {

                HttpContext.Current.Session["ct_cbtecble_det_Info"] = null;

                // cuenta total
                ct_cbtecble_det_Info cbtecble_det_total_Info = new ct_cbtecble_det_Info();
                cbtecble_det_total_Info.secuencia = 3;
                cbtecble_det_total_Info.IdEmpresa = 0;
                cbtecble_det_total_Info.IdTipoCbte = 1;
                cbtecble_det_total_Info.IdCtaCble = info_proveedor.IdCtaCble_CXP;
                cbtecble_det_total_Info.dc_Valor_haber = cn_total;
                cbtecble_det_total_Info.dc_Valor = cn_total * -1;
                cbtecble_det_total_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_total_Info);


                // cuenta iva
                ct_cbtecble_det_Info cbtecble_det_iva_Info = new ct_cbtecble_det_Info();
                cbtecble_det_iva_Info.secuencia = 2;
                cbtecble_det_iva_Info.IdEmpresa = 0;
                cbtecble_det_iva_Info.IdTipoCbte = 1;
                cbtecble_det_iva_Info.IdCtaCble = info_parametro.pa_ctacble_iva;
                cbtecble_det_iva_Info.dc_Valor_debe = cn_valoriva;
                cbtecble_det_iva_Info.dc_Valor = cn_valoriva;
                cbtecble_det_iva_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_iva_Info);

                // cuenta sbtotal
                ct_cbtecble_det_Info cbtecble_det_sub_Info = new ct_cbtecble_det_Info();
                cbtecble_det_sub_Info.secuencia = 1;
                cbtecble_det_sub_Info.IdEmpresa = 0;
                cbtecble_det_sub_Info.IdTipoCbte = 1;
                cbtecble_det_sub_Info.IdCtaCble = info_parametro.pa_ctacble_deudora;
                cbtecble_det_sub_Info.dc_Valor_debe = cn_subtotal_iva + cn_subtotal_siniva;
                cbtecble_det_sub_Info.dc_Valor = cn_subtotal_iva + cn_subtotal_siniva;
                cbtecble_det_sub_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_sub_Info);



            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}