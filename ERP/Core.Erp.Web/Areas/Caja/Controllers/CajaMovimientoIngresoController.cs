using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Caja;
using Core.Erp.Info.Caja;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Bus.CuentasPorCobrar;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Web.Areas.Contabilidad.Controllers;

namespace Core.Erp.Web.Areas.Caja.Controllers
{
    public class CajaMovimientoIngresoController : Controller
    {
        caj_Caja_Movimiento_Bus bus_caja_mov = new caj_Caja_Movimiento_Bus();
        caj_Caja_Movimiento_det_Bus bus_caja_mov_det = new caj_Caja_Movimiento_det_Bus();
        ct_cbtecble_det_Bus bus_comprobante_detalle = new ct_cbtecble_det_Bus();
        ct_cbtecble_det_List list_ct_cbtecble_det = new ct_cbtecble_det_List();
        caj_parametro_Bus bus_caj_param = new caj_parametro_Bus();
        caj_Caja_Bus bus_caja = new caj_Caja_Bus();
        caj_Caja_Movimiento_Tipo_Bus bus_tipo = new caj_Caja_Movimiento_Tipo_Bus();
        string mensaje = string.Empty;

        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info();
            return View(model);
        }

        private bool validar(caj_Caja_Movimiento_Info i_validar, ref string msg)
        {
            if (i_validar.lst_ct_cbtecble_det.Count == 0)
            {
                mensaje = "Debe ingresar registros en el detalle, por favor verifique";
                return false;
            }

            foreach (var item in i_validar.lst_ct_cbtecble_det)
            {
                if (string.IsNullOrEmpty(item.IdCtaCble))
                {
                    mensaje = "Faltan cuentas contables, por favor verifique";
                    return false;
                }
            }

            if (i_validar.lst_ct_cbtecble_det.Sum(q => q.dc_Valor) != 0)
            {
                mensaje = "La suma de los detalles debe ser 0, por favor verifique";
                return false;
            }
            if (i_validar.lst_ct_cbtecble_det.Where(q => q.dc_Valor == 0).Count() > 0)
            {
                mensaje = "Existen detalles con valor 0 en el debe o haber, por favor verifique";
                return false;
            }
            return true;
        }

        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            return View(model);
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_movimiento(DateTime? fecha_ini, DateTime? fecha_fin)
        {
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : fecha_ini;
            ViewBag.fecha_fin = fecha_fin == null ? DateTime.Now.Date : fecha_fin;
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<caj_Caja_Movimiento_Info> model = bus_caja_mov.get_list(IdEmpresa, "+", true, ViewBag.fecha_ini, ViewBag.fecha_fin);
            return PartialView("_GridViewPartial_movimiento", model);
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);            
            var lst_tipo = bus_tipo.get_list(IdEmpresa,"+", false);
            ViewBag.lst_tipo = lst_tipo;
            
            var lst_caja = bus_caja.get_list(IdEmpresa, false);
            ViewBag.lst_caja = lst_caja;
            
            tb_persona_Bus bus_persona = new tb_persona_Bus();
            var lst_personas = bus_persona.get_list(false);
            ViewBag.lst_personas = lst_personas;

            cxc_cobro_tipo_Bus bus_cobro = new cxc_cobro_tipo_Bus();
            var lst_cobro = bus_cobro.get_list(false);
            ViewBag.lst_cobro = lst_cobro;
            
        }

        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_plancta_Bus bus_cuenta = new ct_plancta_Bus();
            var lst_cuentas = bus_cuenta.get_list(IdEmpresa, false, true);
            ViewBag.lst_cuentas = lst_cuentas;
        }
        public ActionResult Nuevo()
        {
            caj_Caja_Movimiento_Info model = new caj_Caja_Movimiento_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                IdTipo_Persona = "PERSONA",
                info_caj_Caja_Movimiento_det = new caj_Caja_Movimiento_det_Info
                {
                    IdCobro_tipo = "EFEC"
                },
                cm_fecha = DateTime.Now
            };
            model.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            list_ct_cbtecble_det.set_list(model.lst_ct_cbtecble_det);
            cargar_combos_detalle();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(caj_Caja_Movimiento_Info model)
        {
            #region Validaciones
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list();
            if (!validar(model, ref mensaje))
            {
                cargar_combos();
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.IdUsuario = Session["IdUsuario"].ToString();
            caj_parametro_Info i_parametro = bus_caj_param.get_info(model.IdEmpresa);
            if (i_parametro == null)
            {
                cargar_combos();
                ViewBag.mensaje = "Debe ingresar los parámetros para usar el módulo";
                return View(model);
            }
            model.IdTipocbte = i_parametro.IdTipoCbteCble_MoviCaja_Ing;
            model.cm_Signo = "+";
            #endregion
            
            #region guardar
            if (!bus_caja_mov.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            #endregion

            return RedirectToAction("Index");
        }
        
        public ActionResult Modificar(int IdTipocbte = 0, decimal IdCbteCble = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            caj_Caja_Movimiento_Info model = bus_caja_mov.get_info(IdEmpresa, IdTipocbte, IdCbteCble);
            if (model == null)
                return RedirectToAction("Index");
            model.info_caj_Caja_Movimiento_det = bus_caja_mov_det.get_info(IdEmpresa, IdTipocbte, IdCbteCble);
            if (model.info_caj_Caja_Movimiento_det == null)
                return RedirectToAction("Index");

            model.lst_ct_cbtecble_det = bus_comprobante_detalle.get_list(IdEmpresa, IdTipocbte, IdCbteCble);
            list_ct_cbtecble_det.set_list(model.lst_ct_cbtecble_det);

            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(caj_Caja_Movimiento_Info model)
        {
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list();
            if (!validar(model, ref mensaje))
            {
                cargar_combos();
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_caja_mov.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdTipocbte = 0, decimal IdCbteCble = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            caj_Caja_Movimiento_Info model = bus_caja_mov.get_info(IdEmpresa, IdTipocbte, IdCbteCble);
            if (model == null)
                return RedirectToAction("Index");
            model.info_caj_Caja_Movimiento_det = bus_caja_mov_det.get_info(IdEmpresa, IdTipocbte, IdCbteCble);
            if (model.info_caj_Caja_Movimiento_det == null)
                return RedirectToAction("Index");

            model.lst_ct_cbtecble_det = bus_comprobante_detalle.get_list(IdEmpresa, IdTipocbte, IdCbteCble);
            list_ct_cbtecble_det.set_list(model.lst_ct_cbtecble_det);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(caj_Caja_Movimiento_Info model)
        {
            model.IdUsuario_Anu = Session["IdUsuario"].ToString();
            if (!bus_caja_mov.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }


        public ActionResult armar_diario(int IdCaja = 0, int IdTipoMovi = 0, double valor = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var i_caja = bus_caja.get_info(IdEmpresa, IdCaja);
            var i_tipo_movi = bus_tipo.get_info(IdEmpresa, IdTipoMovi);

            List<ct_cbtecble_det_Info>  lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>
            {
                //Debe
                new ct_cbtecble_det_Info
                {
                    IdCtaCble = i_caja == null ? "" : i_caja.IdCtaCble,
                    dc_Valor = Math.Abs(valor),
                    dc_Valor_debe = Math.Abs(valor),
                    secuencia = 1
                    
                },
                //Haber
                new ct_cbtecble_det_Info
                {
                    IdCtaCble = i_tipo_movi == null ? "" : i_tipo_movi.IdCtaCble,
                    dc_Valor = Math.Abs(valor)*-1,
                    dc_Valor_haber = Math.Abs(valor),
                    secuencia = 2
                }
            };
            list_ct_cbtecble_det.set_list(lst_ct_cbtecble_det);
            return Json("", JsonRequestBehavior.AllowGet);
        }
        
    }
}