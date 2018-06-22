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

        #region variables
        cp_orden_pago_Bus bus_orden_pago = new cp_orden_pago_Bus();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        cp_orden_pago_tipo_x_empresa_Info info_param_op = new cp_orden_pago_tipo_x_empresa_Info();
        cp_orden_pago_tipo_x_empresa_Bus bus_orden_pago_tipo = new cp_orden_pago_tipo_x_empresa_Bus();
        ct_cbtecble_det_List_op comprobante_contable_fp = new ct_cbtecble_det_List_op();
        tb_persona_tipo_Bus bus_persona_tipo = new tb_persona_tipo_Bus();
        cp_orden_pago_formapago_Bus bus_forma_pago = new cp_orden_pago_formapago_Bus();
        List<cp_orden_pago_det_Info> lst_detalle_op = new List<cp_orden_pago_det_Info>();
        List<cp_orden_pago_Info> lst_ordenes_pagos = new List<cp_orden_pago_Info>();

        List<cp_orden_pago_tipo_x_empresa_Info> lst_tipo_orden_pago = new List<cp_orden_pago_tipo_x_empresa_Info>();
        int IdEmpresa = 0;
        #endregion
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GridViewPartial_ordenes_pagos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            lst_ordenes_pagos = bus_orden_pago.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_ordenes_pagos", lst_ordenes_pagos);
        }

        public ActionResult GridViewPartial_ordenes_pagos_con_saldo()
        {
            lst_detalle_op = Session["lst_detalle_op"] as List<cp_orden_pago_det_Info>;
            return PartialView("_GridViewPartial_ordenes_pagos_con_saldo", lst_detalle_op);
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

            var lst_tipo_orden_pago = bus_orden_pago_tipo.get_list(IdEmpresa);
            ViewBag.lst_tipo_orden_pago = lst_tipo_orden_pago;


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
            model.detalle = Session["lst_detalle"] as List<cp_orden_pago_det_Info>;
            model.info_comprobante.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            info_param_op = Session["info_param_op"] as cp_orden_pago_tipo_x_empresa_Info;
            model.IdEmpresa =Convert.ToInt32( Session["IdEmpresa"]);
            model.info_comprobante.IdTipoCbte =(int) info_param_op.IdTipoCbte_OP;
            model.IdEstadoAprobacion = info_param_op.IdEstadoAprobacion;
            string mensaje = bus_orden_pago.validar(model);
            if (mensaje != "")
            {
                cargar_combos();
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
                    cargar_combos();
                    cargar_combos_detalle();
                    return View(model);
                }
            }
        }

        public ActionResult Modificar(int IdOrdenPago = 0)
        {
            cargar_combos();
            cargar_combos_detalle();
            IdEmpresa =Convert.ToInt32( Session["IdEmpresa"]);
            cp_orden_pago_Info model = new cp_orden_pago_Info();
            model = bus_orden_pago.get_info(IdEmpresa, IdOrdenPago);
            Session["ct_cbtecble_Info"] = model.info_comprobante;
            Session["lst_detalle"] = model.detalle;
            Session["ct_cbtecble_det_Info"] = model.info_comprobante.lst_ct_cbtecble_det;


            if (Session["info_param_op"] == null)
            {
                info_param_op = bus_orden_pago_tipo.get_info(IdEmpresa, model.IdTipo_op);
                Session["info_param_op"] = info_param_op;
            }
            else
            {
                info_param_op = Session["info_param_op"] as cp_orden_pago_tipo_x_empresa_Info;
            }

            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_orden_pago_Info model)
        {




            model.detalle = Session["lst_detalle"] as List<cp_orden_pago_det_Info>;
            model.info_comprobante = Session["ct_cbtecble_Info"] as ct_cbtecble_Info;
            model.info_comprobante.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            info_param_op = Session["info_param_op"] as cp_orden_pago_tipo_x_empresa_Info;
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.info_comprobante.IdTipoCbte = (int)info_param_op.IdTipoCbte_OP;
            model.IdEstadoAprobacion = info_param_op.IdEstadoAprobacion;
            string mensaje = bus_orden_pago.validar(model);
            if (mensaje != "")
            {
                cargar_combos();
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
                    cargar_combos();
                    cargar_combos_detalle();
                    return View(model);
                }
            }
        }
        public ActionResult Anular(int IdOrdenPago =0)
        {
            cargar_combos();
            cargar_combos_detalle();
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_orden_pago_Info model = new cp_orden_pago_Info();
            model = bus_orden_pago.get_info(IdEmpresa, IdOrdenPago);
            Session["ct_cbtecble_Info"] = model.info_comprobante;
            Session["lst_detalle"] = model.detalle;
            Session["ct_cbtecble_det_Info"] = model.info_comprobante.lst_ct_cbtecble_det;
            return View(model);
        }


        [HttpPost]
        public ActionResult Anular(cp_orden_pago_Info model)
        {


            model.detalle = Session["lst_detalle"] as List<cp_orden_pago_det_Info>;
            model.info_comprobante = Session["ct_cbtecble_Info"] as ct_cbtecble_Info;
            model.info_comprobante.lst_ct_cbtecble_det = Session["ct_cbtecble_det_Info"] as List<ct_cbtecble_det_Info>;
            info_param_op = Session["info_param_op"] as cp_orden_pago_tipo_x_empresa_Info;
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.info_comprobante.IdTipoCbte = (int)info_param_op.IdTipoCbte_OP;
            model.IdEstadoAprobacion = info_param_op.IdEstadoAprobacion;
            string mensaje = bus_orden_pago.validar(model);
            if (mensaje != "")
            {
                cargar_combos();
                ViewBag.mensaje = mensaje;
                cargar_combos_detalle();
                return View(model);
            }
            else
            {
                if (bus_orden_pago.anularDB(model))
                    return RedirectToAction("Index");
                else
                {
                    ViewBag.mensaje = mensaje;
                    cargar_combos();
                    cargar_combos_detalle();
                    return View(model);
                }
            }
        }
        #region json
       
        public JsonResult armar_diario(string IdTipo_op = "", decimal IdEntidad = 0, double Valor_a_pagar = 0, string observacion="")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            if (Session["info_param_op"] == null)
            {
                info_param_op = bus_orden_pago_tipo.get_info(IdEmpresa, IdTipo_op);
                Session["info_param_op"] = info_param_op;
            }
            else
            {
                info_param_op = Session["info_param_op"] as cp_orden_pago_tipo_x_empresa_Info;
            }
            comprobante_contable_fp.delete_detail_New_details(info_param_op, IdEntidad, Valor_a_pagar, observacion);
            // añadir detalle 
            Session["lst_detalle"] = null;
            cp_orden_pago_det_Info info_detalle = new cp_orden_pago_det_Info();
            info_detalle.Valor_a_pagar = Valor_a_pagar;
            info_detalle.Referencia = observacion;
            info_detalle.IdEstadoAprobacion = info_param_op.IdEstadoAprobacion;
            lst_detalle_op.Add(info_detalle);
            Session["lst_detalle"] = lst_detalle_op;

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

        public JsonResult Buscar_op(decimal IdProveedor)
        {
            try
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
                string IdUsuario = Convert.ToString(Session["IdUsuario"]);

                lst_detalle_op =  bus_orden_pago.Get_List_orden_pago_con_saldo(IdEmpresa, "FACT_PROVEE", IdProveedor, "APRO", IdUsuario);
                Session["lst_detalle_op"] = lst_detalle_op as List<cp_orden_pago_det_Info>;
                return Json("", JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ActionResult EditingCheckUncheck([ModelBinder(typeof(DevExpressEditorsBinder))] cp_orden_pago_det_Info info_det)
        {
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
          cp_orden_pago_Info op_info= bus_orden_pago.get_info(IdEmpresa, info_det.IdOrdenPago);
           
            if (ModelState.IsValid)
            {
                try
                {
                    lst_detalle_op = Session["lst_detalle_op"] as List<cp_orden_pago_det_Info>;
                    lst_detalle_op.ForEach(item =>
                    {
                        if (item.IdOrdenPago == info_det.IdOrdenPago)
                        {
                            item.check = info_det.check;
                            item.Total_cancelado_OP = info_det.Total_cancelado_OP;
                            item.Fecha_Pago = info_det.Fecha_Pago;
                        }
                    });
                    Session["lst_detalle_op"] = lst_detalle_op;
                    return PartialView("_GridViewPartial_ordenes_pagos_con_saldo", lst_detalle_op);

                }
                catch (Exception ex)
                {

                    ViewData["EditError"] = ex.Message;
                }
            }
            else
            {
                ViewData["EditError"] = ModelState.FirstOrDefault().Value.Errors.ToString();

                lst_ordenes_pagos = Session["lst_detalle_op"] as List<cp_orden_pago_Info>;
            }

            cargar_combos_detalle();
            return PartialView("_GridViewPartial_ordenes_pagos_con_saldo", lst_detalle_op);
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

        public void delete_detail_New_details(cp_orden_pago_tipo_x_empresa_Info info_param_op , decimal IdEntidad=0, double Valor_a_pagar=0, string observacion="")
        {
            try
            {
                
                HttpContext.Current.Session["ct_cbtecble_det_Info"] = null;

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
}