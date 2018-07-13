using Core.Erp.Bus.Banco;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Info.Banco;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Areas.Contabilidad.Controllers;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Banco.Controllers
{
    public class NotaDeCreditoBancoController : Controller
    {
        #region Variables
        ba_Cbte_Ban_Bus bus_cbteban = new ba_Cbte_Ban_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        ba_tipo_nota_Bus bus_tipo_nota = new ba_tipo_nota_Bus();
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        ba_Banco_Cuenta_Bus bus_banco_cuenta = new ba_Banco_Cuenta_Bus();
        ct_cbtecble_det_List List_ct = new ct_cbtecble_det_List();
        ct_cbtecble_det_Bus bus_det_ct = new ct_cbtecble_det_Bus();
        string mensaje = string.Empty;
        #endregion

        #region Index
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
        private void cargar_combos_consulta()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
        }
        public ActionResult GridViewPartial_CreditoBanco(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            ViewBag.IdSucursal = IdSucursal;
            var model = bus_cbteban.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin, IdSucursal, cl_enumeradores.eTipoCbteBancario.NCBA.ToString());
            return PartialView("_GridViewPartial_CreditoBanco", model);
        }
        #endregion

        #region Metodos
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_tipo_nota = bus_tipo_nota.get_list(IdEmpresa, cl_enumeradores.eTipoCbteBancario.NCBA.ToString(), false);
            ViewBag.lst_tipo_nota = lst_tipo_nota;

            var lst_banco_cuenta = bus_banco_cuenta.get_list(IdEmpresa, false);
            ViewBag.lst_banco_cuenta = lst_banco_cuenta;
        }
        private bool validar(ba_Cbte_Ban_Info i_validar, ref string msg)
        {
            i_validar.lst_det_ct = List_ct.get_list();

            if (i_validar.lst_det_ct.Count == 0)
            {
                msg = "El detalle del diario se encuentra vacío";
                return false;
            }

            foreach (var item in i_validar.lst_det_ct)
            {
                if (string.IsNullOrEmpty(item.IdCtaCble))
                {
                    mensaje = "Faltan cuentas contables, por favor verifique";
                    return false;
                }
            }

            if (Math.Round(i_validar.lst_det_ct.Sum(q => q.dc_Valor), 2, MidpointRounding.AwayFromZero) != 0)
            {
                mensaje = "La suma de los detalles debe ser 0, por favor verifique";
                return false;
            }
            if (i_validar.lst_det_ct.Where(q => q.dc_Valor == 0).Count() > 0)
            {
                mensaje = "Existen detalles con valor 0 en el debe o haber, por favor verifique";
                return false;
            }

            i_validar.IdPeriodo = Convert.ToInt32(i_validar.cb_Fecha.ToString("yyyyMM"));
            i_validar.IdUsuario = SessionFixed.IdUsuario;
            i_validar.IdUsuarioUltMod = SessionFixed.IdUsuario;
            i_validar.cb_Valor = Math.Round(i_validar.lst_det_ct.Sum(q => q.dc_Valor_debe), 2, MidpointRounding.AwayFromZero);
            return true;
        }
        #endregion
        
        public ActionResult Nuevo()
        {
            ba_Cbte_Ban_Info model = new ba_Cbte_Ban_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal),
                CodTipoCbteBan = cl_enumeradores.eTipoCbteBancario.NCBA.ToString(),
                cb_Fecha = DateTime.Now.Date,
                lst_det_ct = new List<ct_cbtecble_det_Info>()
            };
            SessionFixed.TipoPersona = model.IdTipo_Persona;
            List_ct.set_list(model.lst_det_ct);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ba_Cbte_Ban_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }
            if (!bus_cbteban.guardarDB(model, cl_enumeradores.eTipoCbteBancario.NCBA))
            {
                ViewBag.mensaje = "No se pudo guardar el registro";
                cargar_combos();
                return View(model);
            }

            return RedirectToAction("Index");
        }

        #region Json
        public JsonResult GetValorTotal()
        {
            var lst_ct = List_ct.get_list();
            return Json(Math.Round(lst_ct.Sum(q => q.dc_Valor_debe),2,MidpointRounding.AwayFromZero), JsonRequestBehavior.AllowGet);
        }
        public JsonResult armar_diario(int IdBanco = 0, int IdTipoNota = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var bco = bus_banco_cuenta.get_info(IdEmpresa, IdBanco);
            var tipo_nota = bus_tipo_nota.get_info(IdEmpresa, IdTipoNota);
            List<ct_cbtecble_det_Info> lst_ct = new List<ct_cbtecble_det_Info>();
            int secuencia = 1;

            //Debe
            lst_ct.Add(new ct_cbtecble_det_Info
            {
                IdCtaCble = bco.IdCtaCble,
                secuencia = secuencia++,
                dc_Valor = 0,
                dc_Valor_haber = 0,
                dc_para_conciliar = true
            });

            //Haber
            if (!string.IsNullOrEmpty(tipo_nota.IdCtaCble))
            {
                lst_ct.Add(new ct_cbtecble_det_Info
                {
                    IdCtaCble = tipo_nota.IdCtaCble,
                    secuencia = secuencia++,
                    dc_Valor = 0,
                    dc_Valor_haber = 0,
                    dc_para_conciliar = true
                });
            }
            else
            {                
                lst_ct.Add(new ct_cbtecble_det_Info
                {
                    IdCtaCble = null,
                    secuencia = secuencia++,
                    dc_Valor = 0,
                    dc_Valor_debe = 0
                });
            }

            
            List_ct.set_list(lst_ct);
            return Json(0, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}