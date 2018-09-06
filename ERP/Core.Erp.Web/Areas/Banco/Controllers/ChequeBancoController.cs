using Core.Erp.Bus.Banco;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Bus.General;
using Core.Erp.Info.Banco;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Areas.Contabilidad.Controllers;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Banco.Controllers
{
    [SessionTimeout]
    public class ChequeBancoController : Controller
    {
        #region Variables
        ba_Cbte_Ban_Bus bus_cbteban = new ba_Cbte_Ban_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        ba_tipo_nota_Bus bus_tipo_nota = new ba_tipo_nota_Bus();
        tb_ciudad_Bus bus_ciudad = new tb_ciudad_Bus();
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        cp_orden_pago_cancelaciones_Bus bus_cancelaciones = new cp_orden_pago_cancelaciones_Bus();
        ba_Banco_Cuenta_Bus bus_banco_cuenta = new ba_Banco_Cuenta_Bus();
        cp_orden_pago_cancelaciones_List List_op = new cp_orden_pago_cancelaciones_List();
        ct_cbtecble_det_List List_ct = new ct_cbtecble_det_List();
        ba_Talonario_cheques_x_banco_Bus bus_talonario = new ba_Talonario_cheques_x_banco_Bus();
        ct_cbtecble_det_Bus bus_det_ct = new ct_cbtecble_det_Bus();
        cl_funciones funciones = new cl_funciones();
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
            lst_sucursal.Add(new tb_sucursal_Info
            {
                IdEmpresa = IdEmpresa,
                IdSucursal = 0,
                Su_Descripcion = "Todos"
            });
            ViewBag.lst_sucursal = lst_sucursal;
        }
        public ActionResult GridViewPartial_cheque(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            ViewBag.IdSucursal = IdSucursal;
            var model = bus_cbteban.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin, IdSucursal, cl_enumeradores.eTipoCbteBancario.CHEQ.ToString(), true);
            return PartialView("_GridViewPartial_cheque", model);
        }
        #endregion

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbPersona_ChequeBanco()
        {
            SessionFixed.TipoPersona = Request.Params["IdTipo_Persona"] != null ? Request.Params["IdTipo_Persona"].ToString() : SessionFixed.TipoPersona;
            decimal model = new decimal();
            return PartialView("_CmbPersona_ChequeBanco", model);
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

        #region Metodos
        private void cargar_combos(int IdEmpresa)
        {
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_ciudad = bus_ciudad.get_list("", false);
            ViewBag.lst_ciudad = lst_ciudad;

            Dictionary<string, string> lst_tipo_personas = new Dictionary<string, string>();
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.PERSONA.ToString(), "Persona");
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.PROVEE.ToString(), "Proveedor");
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.EMPLEA.ToString(), "Empleado");
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.CLIENTE.ToString(), "Cliente");
            ViewBag.lst_tipo_personas = lst_tipo_personas;

            var lst_banco_cuenta = bus_banco_cuenta.get_list(IdEmpresa, false);
            ViewBag.lst_banco_cuenta = lst_banco_cuenta;
        }
        private bool validar(ba_Cbte_Ban_Info i_validar, ref string msg)
        {
            i_validar.lst_det_canc_op = List_op.get_list();
            i_validar.lst_det_ct = List_ct.get_list(i_validar.IdTransaccionSession);

            if (i_validar.IdEntidad == 0)
            {
                msg = "Seleccione el beneficiario";
                return false;
            }
            if (i_validar.lst_det_canc_op.Count == 0)
            {
                msg = "Seleccione las órdenes de pago a ser canceladas";
                return false;
            }
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

            if (Math.Round(i_validar.lst_det_ct.Sum(q => q.dc_Valor),2,MidpointRounding.AwayFromZero) != 0)
            {
                mensaje = "La suma de los detalles debe ser 0, por favor verifique";
                return false;
            }
            if (i_validar.lst_det_ct.Where(q => q.dc_Valor == 0).Count() > 0)
            {
                mensaje = "Existen detalles con valor 0 en el debe o haber, por favor verifique";
                return false;
            }

            var persona = bus_persona.get_info(i_validar.IdEmpresa, i_validar.IdTipo_Persona, Convert.ToDecimal(i_validar.IdEntidad));
            if (persona == null)
            {
                msg = "La persona seleccionada no corresponde al tipo asignado";
                return false;
            }
            i_validar.IdPersona = persona.IdPersona;
            i_validar.IdPersona_Girado_a = persona.IdPersona;

            if (Math.Round(i_validar.lst_det_canc_op.Sum(q=>q.MontoAplicado), 2, MidpointRounding.AwayFromZero) != Math.Round(i_validar.lst_det_ct.Sum(q => q.dc_Valor_debe), 2, MidpointRounding.AwayFromZero))
            {
                msg = "Los valores ingresados no concuerdan con el valor del diario";
                return false;
            }
            if (i_validar.IdCbteCble == 0)
            {
                i_validar.cb_Observacion += " Canc./ ";
                foreach (var item in i_validar.lst_det_canc_op)
                {
                    i_validar.cb_Observacion += item.Referencia + "/";
                }
            }            
            i_validar.IdPeriodo = Convert.ToInt32(i_validar.cb_Fecha.ToString("yyyyMM"));
            i_validar.IdUsuario = SessionFixed.IdUsuario;
            i_validar.IdUsuarioUltMod = SessionFixed.IdUsuario;
            i_validar.IdUsuario_Anu = SessionFixed.IdUsuario;
            i_validar.cb_Valor = Math.Round(i_validar.lst_det_ct.Sum(q => q.dc_Valor_debe), 2, MidpointRounding.AwayFromZero);
            i_validar.ValorEnLetras = funciones.NumeroALetras(i_validar.cb_Valor.ToString());
            return true;
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
            #endregion
            ba_Cbte_Ban_Info model = new ba_Cbte_Ban_Info
            {
                IdEmpresa = IdEmpresa,
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal),
                CodTipoCbteBan = cl_enumeradores.eTipoCbteBancario.CHEQ.ToString(),
                cb_ciudadChq = "09",
                IdTipo_Persona = cl_enumeradores.eTipoPersona.PROVEE.ToString(),
                cb_Fecha = DateTime.Now.Date,
                IdEntidad = 0,
                lst_det_canc_op = new List<cp_orden_pago_cancelaciones_Info>(),
                lst_det_ct = new List<ct_cbtecble_det_Info>(),
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)
            };
            SessionFixed.TipoPersona = model.IdTipo_Persona;
            List_ct.set_list(model.lst_det_ct,model.IdTransaccionSession);
            List_op.set_list(model.lst_det_canc_op);
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ba_Cbte_Ban_Info model)
        {
            if (!validar(model,ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            if (!bus_cbteban.guardarDB(model, cl_enumeradores.eTipoCbteBancario.CHEQ))
            {
                ViewBag.mensaje = "No se pudo guardar el registro";
                cargar_combos(model.IdEmpresa);
                return View(model);
            }

            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult Modificar(ba_Cbte_Ban_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            if (!bus_cbteban.modificarDB(model, cl_enumeradores.eTipoCbteBancario.CHEQ))
            {
                ViewBag.mensaje = "No se pudo modificar el registro";
                cargar_combos(model.IdEmpresa);
                return View(model);
            }

            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , int IdTipocbte = 0, decimal IdCbteCble = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            ba_Cbte_Ban_Info model = bus_cbteban.get_info(IdEmpresa, IdTipocbte, IdCbteCble);
            if(model == null)
                return RedirectToAction("Index");
            model.lst_det_ct = bus_det_ct.get_list(model.IdEmpresa, model.IdTipocbte, model.IdCbteCble);
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual);
            List_ct.set_list(model.lst_det_ct,model.IdTransaccionSession);
            model.lst_det_canc_op = bus_cancelaciones.get_list_x_pago(model.IdEmpresa, model.IdTipocbte, model.IdCbteCble, SessionFixed.IdUsuario);
            List_op.set_list(model.lst_det_canc_op);
            cargar_combos(IdEmpresa);
            SessionFixed.TipoPersona = model.IdTipo_Persona;
            return View(model);
        }

        public ActionResult Anular(int IdEmpresa = 0 , int IdTipocbte = 0, decimal IdCbteCble = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            ba_Cbte_Ban_Info model = bus_cbteban.get_info(IdEmpresa, IdTipocbte, IdCbteCble);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_det_ct = bus_det_ct.get_list(model.IdEmpresa, model.IdTipocbte, model.IdCbteCble);
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual);
            List_ct.set_list(model.lst_det_ct, model.IdTransaccionSession);
            model.lst_det_canc_op = bus_cancelaciones.get_list_x_pago(model.IdEmpresa, model.IdTipocbte, model.IdCbteCble, SessionFixed.IdUsuario);
            List_op.set_list(model.lst_det_canc_op);
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(ba_Cbte_Ban_Info model)
        {
            model.IdUsuario_Anu = SessionFixed.IdUsuario;
            if (!bus_cbteban.anularDB(model))
            {
                ViewBag.mensaje = "No se pudo anular el registro";
                cargar_combos(model.IdEmpresa);
                return View(model);
            }

            return RedirectToAction("Index");
        }

        #endregion

        #region Detalle

        public ActionResult GridViewPartial_cheque_op_x_cruzar()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            SessionFixed.TipoPersona = Request.Params["IdTipo_Persona"] != null ? Request.Params["IdTipo_Persona"].ToString() : SessionFixed.TipoPersona;
            SessionFixed.IdEntidad = !string.IsNullOrEmpty(Request.Params["Entidad"]) ? Request.Params["Entidad"].ToString() : "0";
            decimal IdEntidad = Convert.ToInt32(SessionFixed.IdEntidad);
            List<cp_orden_pago_cancelaciones_Info> model;
            if (IdEntidad == 0)
                model = new List<cp_orden_pago_cancelaciones_Info>();
            else
                model = bus_cancelaciones.get_list_con_saldo(IdEmpresa, 0,SessionFixed.TipoPersona, IdEntidad, "APRO", SessionFixed.IdUsuario, false);
            return PartialView("_GridViewPartial_cheque_op_x_cruzar",model);
        }

        public ActionResult GridViewPartial_cheque_op()
        {
            var model = List_op.get_list();
            return PartialView("_GridViewPartial_cheque_op", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew(string IDs = "")
        {
            if (IDs != "")
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                decimal IdEntidad = Convert.ToDecimal(SessionFixed.IdEntidad);
                List<cp_orden_pago_cancelaciones_Info> lst_x_cruzar;
                if (IdEntidad == 0)
                    lst_x_cruzar = new List<cp_orden_pago_cancelaciones_Info>();
                else
                    lst_x_cruzar = bus_cancelaciones.get_list_con_saldo(IdEmpresa, 0, SessionFixed.TipoPersona, IdEntidad, "APRO", SessionFixed.IdUsuario, false);
                string[] array = IDs.Split(',');
                foreach (var item in array)
                {
                    var info_det = lst_x_cruzar.Where(q => q.IdOrdenPago_op == Convert.ToInt32(item)).FirstOrDefault();
                    if (info_det != null)
                        List_op.AddRow(info_det);
                }
            }
            var model = List_op.get_list();
            return PartialView("_GridViewPartial_cheque_op", model);
        }

        public ActionResult EditingDeleteFactura(decimal IdOrdenPago_op)
        {
            List_op.DeleteRow(IdOrdenPago_op);            
            var model = List_op.get_list();
            return PartialView("_GridViewPartial_cheque_op", model);
        }
        #endregion

        #region Json
        public JsonResult armar_diario(int IdEmpresa = 0, int IdBanco = 0, decimal IdTransaccionSession = 0)
        {
            var bco = bus_banco_cuenta.get_info(IdEmpresa, IdBanco);
            var lst_op = List_op.get_list();

            List<ct_cbtecble_det_Info> lst_ct = new List<ct_cbtecble_det_Info>();
            int secuencia = 1;
            foreach (var item in lst_op)
            {
                //Debe
                lst_ct.Add(new ct_cbtecble_det_Info
                {
                    IdCtaCble = item.IdCtaCble,
                    secuencia = secuencia++,
                    dc_Valor = Math.Round(item.MontoAplicado, 2, MidpointRounding.AwayFromZero),
                    dc_Valor_debe = Math.Round(item.MontoAplicado, 2, MidpointRounding.AwayFromZero)
                });
            }
            lst_ct.Add(new ct_cbtecble_det_Info
            {
                IdCtaCble = bco.IdCtaCble,
                secuencia = secuencia++,
                dc_Valor = Math.Round(lst_op.Sum(q => q.MontoAplicado), 2, MidpointRounding.AwayFromZero) * -1,
                dc_Valor_haber = Math.Round(lst_op.Sum(q => q.MontoAplicado), 2, MidpointRounding.AwayFromZero),
                dc_para_conciliar = true
            });
            List_ct.set_list(lst_ct,IdTransaccionSession);
            return Json(Math.Round(lst_op.Sum(q => q.MontoAplicado), 2, MidpointRounding.AwayFromZero), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetNumCheque(int IdEmpresa = 0, int IdBanco = 0)
        {            
            var resultado = bus_talonario.get_ult_NumCheque_no_usado(IdEmpresa, IdBanco);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public void vaciar_detalle(decimal IdTransaccionSession = 0)
        {
            List_op.set_list(new List<cp_orden_pago_cancelaciones_Info>());
            List_ct.set_list(new List<ct_cbtecble_det_Info>(),IdTransaccionSession);
        }
        #endregion
    }

    public class cp_orden_pago_cancelaciones_List
    {
        public List<cp_orden_pago_cancelaciones_Info> get_list()
        {
            if (HttpContext.Current.Session["cp_orden_pago_cancelaciones_Info"] == null)
            {
                List<cp_orden_pago_cancelaciones_Info> list = new List<cp_orden_pago_cancelaciones_Info>();

                HttpContext.Current.Session["cp_orden_pago_cancelaciones_Info"] = list;
            }
            return (List<cp_orden_pago_cancelaciones_Info>)HttpContext.Current.Session["cp_orden_pago_cancelaciones_Info"];
        }

        public void set_list(List<cp_orden_pago_cancelaciones_Info> list)
        {
            HttpContext.Current.Session["cp_orden_pago_cancelaciones_Info"] = list;
        }

        public void AddRow(cp_orden_pago_cancelaciones_Info info_det)
        {
            List<cp_orden_pago_cancelaciones_Info> list = get_list();
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            if (list.Where(q => q.IdOrdenPago_op == info_det.IdOrdenPago_op).Count() == 0)
                list.Add(info_det);
        }

        public void DeleteRow(decimal IdOrdenPago_op)
        {
            List<cp_orden_pago_cancelaciones_Info> list = get_list();
            list.Remove(list.Where(m => m.IdOrdenPago_op == IdOrdenPago_op).First());
        }
    }
}