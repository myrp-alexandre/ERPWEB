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
using Core.Erp.Info.General;
namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class DeudasController : Controller
    {
        #region variables
        cp_orden_giro_Bus bus_orden_giro = new cp_orden_giro_Bus();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        cp_codigo_SRI_x_CtaCble_Bus bus_codigo_sri = new cp_codigo_SRI_x_CtaCble_Bus();
        cp_pagos_sri_Bus bus_forma_paogo = new cp_pagos_sri_Bus();
        tb_pais_Bus bus_pais = new tb_pais_Bus();
        List<cp_cuotas_x_doc_det_Info> lst_detalle_cuotas = new List<cp_cuotas_x_doc_det_Info>();
        cp_cuotas_x_doc_det_Bus bus_detalle_cuotas = new cp_cuotas_x_doc_det_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        cp_TipoDocumento_Bus bus_tipo_documento = new cp_TipoDocumento_Bus();
        cp_proveedor_Info info_proveedor = new cp_proveedor_Info();
        cp_proveedor_Bus bus_prov = new cp_proveedor_Bus();
        cp_parametros_Info info_parametro = new cp_parametros_Info();
        cp_parametros_Bus bus_param = new cp_parametros_Bus();
        ct_cbtecble_det_List_fp comprobante_contable_fp = new ct_cbtecble_det_List_fp();

         
        #endregion
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Index2()
        {
            return View();
        }
        public ActionResult Index3()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_documento_cuotas_det()
        {
            try
            {
                lst_detalle_cuotas = Session["lst_cuotas"] as List<cp_cuotas_x_doc_det_Info>;
                return PartialView("_GridViewPartial_documento_cuotas_det", lst_detalle_cuotas);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult GridViewPartial_deudas_dc()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_deudas_dc", model);
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_deudas()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<cp_orden_giro_Info> model = new List<cp_orden_giro_Info>();
            model = bus_orden_giro.get_lst(IdEmpresa, DateTime.Now, DateTime.Now);
            return PartialView("_GridViewPartial_deudas", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_aprobacion_facturas()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<cp_orden_giro_Info> model = new List<cp_orden_giro_Info>();
            model = bus_orden_giro.get_lst_orden_giro_x_pagar(IdEmpresa);
            return PartialView("_GridViewPartial_aprobacion_facturas", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_deudas_sin_ret()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<cp_orden_giro_Info> model = new List<cp_orden_giro_Info>();
            model = bus_orden_giro.get_lst_sin_ret(IdEmpresa, DateTime.Now, DateTime.Now);
            return PartialView("_GridViewPartial_deudas_sin_ret", model);
        }

        private void cargar_combos(decimal IdProveedor=0, string IdTipoSRI = "")
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


        }

        public ActionResult Nuevo()
        {
            Session["lst_cuotas"] = null;
            (Session["ct_cbtecble_det_Info"]) = null;
            cp_orden_giro_Info model = new cp_orden_giro_Info
            {
                co_FechaFactura = DateTime.Now,
                co_FechaContabilizacion = DateTime.Now,
                info_cuota = new cp_cuotas_x_doc_Info
                {
                    Fecha_inicio = DateTime.Now
                },
                
            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_orden_giro_Info model)
        {
            model.info_comrobante = new ct_cbtecble_Info();
            if (Session["lst_cuotas"] != null)
                model.info_cuota.lst_cuotas_det = Session["lst_cuotas"] as List<cp_cuotas_x_doc_det_Info>;
            if (Session["ct_cbtecble_det_Info"] != null)
            {
                model.info_comrobante.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            }
            else
            {
                ViewBag.mensaje = "Falta diario contable";
                cargar_combos(model.IdProveedor, model.IdOrden_giro_Tipo);
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
                cargar_combos(model.IdProveedor, model.IdOrden_giro_Tipo);
                cargar_combos_detalle();
                return View(model);
            }
            string mensaje = bus_orden_giro.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model.IdProveedor, model.IdOrden_giro_Tipo);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }
           
            
            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
           
            if (!bus_orden_giro.guardarDB(model))
            {
                cargar_combos(model.IdProveedor, model.IdOrden_giro_Tipo);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdTipoCbte_Ogiro = 0, decimal IdCbteCble_Ogiro = 0)
        {

            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_orden_giro_Info model = bus_orden_giro.get_info(IdEmpresa, IdTipoCbte_Ogiro, IdCbteCble_Ogiro);
            if (model == null)
                return RedirectToAction("Index");
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
                model.info_comrobante.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
                    Session["ct_cbtecble_det_Info"] = model.info_comrobante.lst_ct_cbtecble_det;
            if (model.info_cuota.lst_cuotas_det == null)
                model.info_cuota.lst_cuotas_det = new List<cp_cuotas_x_doc_det_Info>();
            Session["lst_cuotas"] = model.info_cuota.lst_cuotas_det;
            cargar_combos(model.IdProveedor, model.IdOrden_giro_Tipo);
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
            if (Session["lst_cuotas"] != null)
                model.info_cuota.lst_cuotas_det = Session["lst_cuotas"] as List<cp_cuotas_x_doc_det_Info>;
            if (Session["ct_cbtecble_det_Info"] != null)
            {
                model.info_comrobante.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            }
            else
            {
                ViewBag.mensaje = "Falta diario contable";
                cargar_combos(model.IdProveedor, model.IdOrden_giro_Tipo);
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
                cargar_combos(model.IdProveedor, model.IdOrden_giro_Tipo);
                cargar_combos_detalle();
                return View(model);
            }
            string mensaje = bus_orden_giro.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model.IdProveedor, model.IdOrden_giro_Tipo);
                cargar_combos_detalle();
                ViewBag.mensaje = mensaje;
                return View(model);
            }


            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            if (!bus_orden_giro.modificarDB(model))
            {
                cargar_combos(model.IdProveedor, model.IdOrden_giro_Tipo);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdTipoCbte_Ogiro=0, decimal IdCbteCble_Ogiro = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_orden_giro_Info model = bus_orden_giro.get_info(IdEmpresa, IdTipoCbte_Ogiro, IdCbteCble_Ogiro);
            if (model == null)
                return RedirectToAction("Index");
            if (model.info_comrobante.lst_ct_cbtecble_det == null)
                model.info_comrobante.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            Session["ct_cbtecble_det_Info"] = model.info_comrobante.lst_ct_cbtecble_det;
            if (model.info_cuota.lst_cuotas_det == null)
                model.info_cuota.lst_cuotas_det = new List<cp_cuotas_x_doc_det_Info>();
            Session["lst_cuotas"] = model.info_cuota.lst_cuotas_det;
            cargar_combos(model.IdProveedor, model.IdOrden_giro_Tipo);
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
            if (Session["lst_cuotas"] != null)
                model.info_cuota.lst_cuotas_det = Session["lst_cuotas"] as List<cp_cuotas_x_doc_det_Info>;
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
        public JsonResult calcular_cuotas(DateTime Fecha_inicio,int Num_cuotas=0, int Dias_plazo = 0, double Total_a_pagar=0)
        {

            lst_detalle_cuotas = bus_detalle_cuotas.calcular_cuotas(Fecha_inicio, Num_cuotas,Dias_plazo, Total_a_pagar);
            Session["lst_cuotas"]=lst_detalle_cuotas;

            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_list_tipo_doc(decimal IdProveedor = 0, string codigoSRI = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var list_tipo_doc = bus_tipo_documento.get_list(IdEmpresa, IdProveedor, codigoSRI);
            return Json(list_tipo_doc, JsonRequestBehavior.AllowGet);
        }

        public JsonResult armar_diario(decimal IdProveedor = 0, double co_subtotal_iva = 0, double co_subtotal_siniva = 0, double co_valoriva = 0, double co_total = 0, string observacion="")
        {
            int IdEmpresa=Convert.ToInt32( Session["IdEmpresa"]);
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


            comprobante_contable_fp.delete_detail_New_details(info_proveedor, info_parametro, co_subtotal_iva, co_subtotal_siniva, co_valoriva, co_total, observacion);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion

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
            return PartialView("_GridViewPartial_deudas_dc", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                comprobante_contable_fp.UpdateRow(info_det);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = comprobante_contable_fp.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_deudas_dc", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            comprobante_contable_fp.DeleteRow(secuencia);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = comprobante_contable_fp.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_deudas_dc", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult GridViewPartial_aprobacion_facturas_Update(Core.Erp.Info.CuentasPorPagar.cp_orden_giro_Info item)
        {
            
                try
                {
                item.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
                    bus_orden_giro.Generar_OP_x_orden_giro(item);
                return RedirectToAction("Index3");

                }
            catch (Exception e)
                {
                    return RedirectToAction("Index3");
                }
            
           
        }
       
    }


    public class ct_cbtecble_det_List_fp
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

        public void delete_detail_New_details(cp_proveedor_Info info_proveedor, cp_parametros_Info info_parametro , double co_subtotal_iva = 0, 
            double co_subtotal_siniva = 0, double co_valoriva = 0, double co_total = 0, string observacion="")
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
                cbtecble_det_total_Info.dc_Valor_haber = co_total;
                cbtecble_det_total_Info.dc_Valor = co_total * -1;
                cbtecble_det_total_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_total_Info);


                // cuenta iva
                ct_cbtecble_det_Info cbtecble_det_iva_Info = new ct_cbtecble_det_Info();
                cbtecble_det_iva_Info.secuencia = 2;
                cbtecble_det_iva_Info.IdEmpresa = 0;
                cbtecble_det_iva_Info.IdTipoCbte = 1;
                cbtecble_det_iva_Info.IdCtaCble = info_parametro.pa_ctacble_iva;
                cbtecble_det_iva_Info.dc_Valor_debe = co_valoriva;
                cbtecble_det_iva_Info.dc_Valor = co_valoriva;
                cbtecble_det_iva_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_iva_Info);

                // cuenta sbtotal
                ct_cbtecble_det_Info cbtecble_det_sub_Info = new ct_cbtecble_det_Info();
                cbtecble_det_sub_Info.secuencia = 1;
                cbtecble_det_sub_Info.IdEmpresa = 0;
                cbtecble_det_sub_Info.IdTipoCbte = 1;
                cbtecble_det_sub_Info.IdCtaCble = info_parametro.pa_ctacble_deudora;
                cbtecble_det_sub_Info.dc_Valor_debe = co_subtotal_iva + co_subtotal_siniva;              
                cbtecble_det_sub_Info.dc_Valor = co_subtotal_iva+co_subtotal_siniva;
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