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

using DevExpress.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class OrdenPagoController : Controller
    {

        #region MyRegion
        cp_orden_pago_Bus bus_orden_giro = new cp_orden_pago_Bus();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        cp_TipoDocumento_Bus bus_tipo_documento = new cp_TipoDocumento_Bus();
        cp_orden_pago_tipo_x_empresa_Info info_param_op = new cp_orden_pago_tipo_x_empresa_Info();
        cp_orden_pago_tipo_x_empresa_Bus bus_param_op = new cp_orden_pago_tipo_x_empresa_Bus();
        ct_cbtecble_det_List_op comprobante_contable_fp = new ct_cbtecble_det_List_op();
        tb_persona_tipo_Bus bus_persona_tipo = new tb_persona_tipo_Bus();
        cp_orden_pago_formapago_Bus bus_forma_pago = new cp_orden_pago_formapago_Bus();
        List<cp_orden_pago_det_Info> lst_detalle_op = new List<cp_orden_pago_det_Info>();
        List<cp_orden_pago_Info> lst_ordenes_pagos = new List<cp_orden_pago_Info>();
        #endregion
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GridViewPartial_ordenes_pagos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            lst_ordenes_pagos = bus_orden_giro.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_ordenes_pagos", lst_ordenes_pagos);
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_detalle_op()
        {
            try
            {
                lst_detalle_op = Session["lst_detalle"] as List<cp_orden_pago_det_Info>;
                return PartialView("_GridViewPartial_detalle_op", lst_detalle_op);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult GridViewPartial_orden_pago_dc()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_orden_pago_dc", model);
        }

        private void cargar_combos(string TipoPersona="")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var lst_proveedores = bus_proveedor.get_list(IdEmpresa, false);
            ViewBag.lst_proveedores = lst_proveedores;

            var lst_persona_tipo = bus_persona_tipo.get_list();
            ViewBag.lst_persona_tipo = lst_persona_tipo;

             var lst_forma_pago = bus_forma_pago.get_list();
            ViewBag.lst_forma_pago = lst_forma_pago;


        }

        public ActionResult Nuevo()
        {
           
            (Session["ct_cbtecble_det_Info"]) = null;
            cp_orden_pago_Info model = new cp_orden_pago_Info
            {
                Fecha_Pago = DateTime.Now.Date,
                Fecha=DateTime.Now.Date
            

            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_orden_pago_Info model)
        {
          
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdTipoCbte_Ogiro = 0, decimal IdCbteCble_Ogiro = 0)
        {

            cp_orden_pago_Info model = new cp_orden_pago_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_orden_pago_Info model)
        {


            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdTipoCbte_Ogiro = 0, decimal IdCbteCble_Ogiro = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_orden_pago_Info model = new cp_orden_pago_Info();
          
            cargar_combos_detalle();
            return View(model);
        }


        [HttpPost]
        public ActionResult Anular(cp_orden_pago_Info model)
        {
            
            return RedirectToAction("Index");
        }
        #region json
       
        public JsonResult armar_diario(string IdFormaPago="", decimal IdEntidad = 0, double Valor_a_pagar = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
           

            if (Session["info_parametro"] == null)
            {
                info_param_op = bus_param_op.get_info(IdEmpresa, IdFormaPago);
                Session["info_parametro"] = info_param_op;
            }
            else
                info_param_op = Session["info_parametro"] as cp_orden_pago_tipo_x_empresa_Info;

            info_param_op = bus_param_op.get_info(IdEmpresa, IdFormaPago);


            comprobante_contable_fp.delete_detail_New_details( IdFormaPago, IdEntidad, Valor_a_pagar);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion


        [ValidateInput(false)]
        public ActionResult GridViewPartial_deudas()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<cp_orden_pago_Info> model = new List<cp_orden_pago_Info>();
         
            return PartialView("_GridViewPartial_deudas", model);
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


    }


    public class ct_cbtecble_det_List_op
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

        public void delete_detail_New_details(string IdFormaPago="", decimal IdEntidad=0, double Valor_a_pagar=0)
        {
            try
            {
                
                HttpContext.Current.Session["ct_cbtecble_det_Info"] = null;

                // cuenta total
                ct_cbtecble_det_Info cbtecble_det_total_Info = new ct_cbtecble_det_Info();
                cbtecble_det_total_Info.secuencia = 3;
                cbtecble_det_total_Info.IdEmpresa = 0;
                cbtecble_det_total_Info.IdTipoCbte = 1;
                //cbtecble_det_total_Info.IdCtaCble = info_proveedor.IdCtaCble_CXP;
                cbtecble_det_total_Info.dc_Valor_haber = Valor_a_pagar;
                cbtecble_det_total_Info.dc_Valor = Valor_a_pagar * -1;
                cbtecble_det_total_Info.dc_Observacion="";
                AddRow(cbtecble_det_total_Info);


                // cuenta iva
                ct_cbtecble_det_Info cbtecble_det_iva_Info = new ct_cbtecble_det_Info();
                cbtecble_det_iva_Info.secuencia = 2;
                cbtecble_det_iva_Info.IdEmpresa = 0;
                cbtecble_det_iva_Info.IdTipoCbte = 1;
                //cbtecble_det_iva_Info.IdCtaCble = info_parametro.pa_ctacble_iva;
                //cbtecble_det_iva_Info.dc_Valor_debe = co_valoriva;
                //cbtecble_det_iva_Info.dc_Valor = co_valoriva;
                //cbtecble_det_iva_Info.dc_Observacion = observacion;
                AddRow(cbtecble_det_iva_Info);

                
            }
            catch (Exception)
            {

                throw;
            }
        }


    }
}