using Core.Erp.Bus.Banco;
using Core.Erp.Bus.Caja;
using Core.Erp.Bus.CuentasPorCobrar;
using Core.Erp.Bus.General;
using Core.Erp.Info.CuentasPorCobrar;
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

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class CobranzaController : Controller
    {
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        cxc_cobro_Bus bus_cobro = new cxc_cobro_Bus();
        caj_Caja_Bus bus_caja = new caj_Caja_Bus();
        caj_parametro_Bus bus_param_caja = new caj_parametro_Bus();
        cxc_cobro_tipo_Bus bus_cobro_tipo = new cxc_cobro_tipo_Bus();
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        tb_banco_Bus bus_banco = new tb_banco_Bus();
        ba_Banco_Cuenta_Bus bus_banco_cuenta = new ba_Banco_Cuenta_Bus();
        cxc_cobro_det_Bus bus_det = new cxc_cobro_det_Bus();
        cxc_cobro_det_List list_det = new cxc_cobro_det_List();
        string mensaje = string.Empty;

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbCliente_Cobranza()
        {
            cxc_cobro_Info model = new cxc_cobro_Info();
            return PartialView("_CmbCliente_Cobranza", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.CLIENTE.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.CLIENTE.ToString());
        }
        #endregion

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

        #region Metodos
        private void cargar_combos_consulta()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_caja = bus_caja.get_list(IdEmpresa, false);
            ViewBag.lst_caja = lst_caja;

            var lst_cobro_tipo = bus_cobro_tipo.get_list(false);
            ViewBag.lst_cobro_tipo = lst_cobro_tipo;

            var lst_banco = bus_banco.get_list(false);
            ViewBag.lst_banco = lst_banco;

            var lst_banco_cuenta = bus_banco_cuenta.get_list(IdEmpresa, false);
            ViewBag.lst_banco_cuenta = lst_banco_cuenta;
        }

        private bool validar(cxc_cobro_Info i_validar, ref string msg)
        {
            i_validar.IdEntidad = i_validar.IdCliente;
            if (i_validar.cr_TotalCobro == 0)
            {
                msg = "No ha seleccionado documentos para realizar la cobranza";
                return false;
            }
            if (Math.Round(i_validar.cr_saldo,2,MidpointRounding.AwayFromZero) < 0)
            {
                msg = "El valor aplicado a los documentos es mayor al total a cobrar";
                return false;
            }
            i_validar.lst_det = list_det.get_list();
            if (i_validar.lst_det.Count == 0)
            {
                msg = "No ha seleccionado documentos para realizar la cobranza";
                return false;
            }
            if (i_validar.lst_det.Where(q=>q.dc_ValorPago == 0).Count() > 0)
            {
                msg = "Existen documentos con valor aplicado 0";
                return false;
            }
            if (i_validar.IdCobro > 0 && i_validar.lst_det.Where(q => q.dc_ValorPago > q.Saldo).Count() > 0)
            {
                msg = "Existen documentos cuyo valor aplicado es mayor al saldo de la factura";
                return false;
            }
            string observacion = "Canc./ ";
            foreach (var item in i_validar.lst_det)
            {
                observacion += item.vt_NumDocumento+ "/";
            }
            i_validar.cr_observacion = observacion;
            i_validar.cr_fechaCobro = i_validar.cr_fecha;
            i_validar.cr_fechaDocu = i_validar.cr_fecha;

            if (!string.IsNullOrEmpty(i_validar.IdCobro_tipo))
                i_validar.lst_det.ForEach(q => q.IdCobro_tipo_det = i_validar.IdCobro_tipo);

            
            
            switch (i_validar.IdCobro_tipo)
            {
                case "DEPO":
                    if (i_validar.IdBanco == null)
                    {
                        msg = "El campo cuenta bancaria es obligatorio para depositos";
                        return false;
                    }
                    break;
                case "CHQF":
                    if (string.IsNullOrEmpty(i_validar.cr_Banco))
                    {
                        msg = "El campo banco es obligatorio para cheques";
                        return false;
                    }
                    if (string.IsNullOrEmpty(i_validar.cr_cuenta))
                    {
                        msg = "El campo cuenta es obligatorio para cheques";
                        return false;
                    }
                    if (string.IsNullOrEmpty(i_validar.cr_NumDocumento))
                    {
                        msg = "El campo # cheque es obligatorio para cheques";
                        return false;
                    }
                    i_validar.IdBanco = null;
                    break;

                case "CHQV":
                    if (string.IsNullOrEmpty(i_validar.cr_Banco))
                    {
                        msg = "El campo banco es obligatorio para cheques";
                        return false;
                    }
                    if (string.IsNullOrEmpty(i_validar.cr_cuenta))
                    {
                        msg = "El campo cuenta es obligatorio para cheques";
                        return false;
                    }
                    if (string.IsNullOrEmpty(i_validar.cr_NumDocumento))
                    {
                        msg = "El campo # cheque es obligatorio para cheques";
                        return false;
                    }
                    i_validar.IdBanco = null;
                    break;
                default:
                    i_validar.IdBanco = null;
                    i_validar.cr_Banco = null;
                    break;
            }
            return true;
        }
        #endregion
        public ActionResult Nuevo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            int IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            var param_caja = bus_param_caja.get_info(IdEmpresa);
            cxc_cobro_Info model = new cxc_cobro_Info
            {
                IdEmpresa = IdEmpresa,
                IdSucursal = IdSucursal,
                cr_fecha = DateTime.Now.Date,
                IdCobro_tipo = "EFEC",
                IdCaja = 1,
                lst_det = new List<cxc_cobro_det_Info>(),
            };
            list_det.set_list(model.lst_det);
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(cxc_cobro_Info model)
        {
            if (!validar(model,ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }
            model.IdUsuario = SessionFixed.IdUsuario;
            if (!bus_cobro.guardarDB(model))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }

            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdSucursal = 0, decimal IdCobro = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cxc_cobro_Info model = bus_cobro.get_info(IdEmpresa, IdSucursal, IdCobro);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_det = bus_det.get_list(IdEmpresa, IdSucursal, IdCobro);
            list_det.set_list(model.lst_det);
            model.IdEntidad = model.IdCliente;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cxc_cobro_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }
            model.IdUsuarioUltMod = SessionFixed.IdUsuario;
            if (!bus_cobro.modificarDB(model))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }

            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdSucursal = 0, decimal IdCobro = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cxc_cobro_Info model = bus_cobro.get_info(IdEmpresa, IdSucursal, IdCobro);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_det = bus_det.get_list(IdEmpresa, IdSucursal, IdCobro);
            list_det.set_list(model.lst_det);
            model.IdEntidad = model.IdCliente;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(cxc_cobro_Info model)
        {
            model.IdUsuarioUltAnu = SessionFixed.IdUsuario;
            if (!bus_cobro.anularDB(model))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }

            return RedirectToAction("Index");
        }

        #region Grids
        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            ViewBag.IdSucursal = IdSucursal;
            var model = bus_cobro.get_list(IdEmpresa, IdSucursal, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_cobranza", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza_det()
        {
            var model = list_det.get_list();
            return PartialView("_GridViewPartial_cobranza_det", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza_facturas_x_cruzar()
        {
            Session["IdSucursalCobranza"] = (Request.Params["IdSucursalCobranza"] != null ? Convert.ToInt32(Request.Params["IdSucursalCobranza"]) : 0);
            Session["IdClienteCobranza"] = Request.Params["IdClienteCobranza"] != null ? Convert.ToDecimal(Request.Params["IdClienteCobranza"]) : 0;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            int IdSucursal = Convert.ToInt32(Session["IdSucursalCobranza"]);
            decimal IdCliente = Convert.ToDecimal(Session["IdClienteCobranza"]);
            var model = bus_det.get_list_cartera(IdEmpresa, IdSucursal, IdCliente);
            return PartialView("_GridViewPartial_cobranza_facturas_x_cruzar", model);
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdateFactura([ModelBinder(typeof(DevExpressEditorsBinder))] cxc_cobro_det_Info info_det)
        {
            if (ModelState.IsValid)
                list_det.UpdateRow(info_det);
            var model = list_det.get_list();
            return PartialView("_GridViewPartial_cobranza_det", model);
        }

        public ActionResult EditingDeleteFactura(string secuencia)
        {
            list_det.DeleteRow(secuencia);
            var model = list_det.get_list();
            return PartialView("_GridViewPartial_cobranza_det", model);
        }
        #endregion

        #region Json
        [HttpPost, ValidateInput(false)]
        public JsonResult EditingAddNewFactura(string IDs = "", double TotalACobrar = 0)
        {
            double saldo = TotalACobrar;
            if (IDs != "")
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                var lst_x_cruzar = bus_det.get_list_cartera(IdEmpresa, Convert.ToInt32(Session["IdSucursalCobranza"]), Convert.ToDecimal(Session["IdClienteCobranza"]));
                string[] array = IDs.Split(',');
                foreach (var item in array)
                {
                    var info_det = lst_x_cruzar.Where(q => q.secuencia == item).FirstOrDefault();
                    if (info_det != null)
                        list_det.AddRow(info_det);
                }
            }
            var lst = list_det.get_list();
            foreach (var item in lst)
            {
                if (saldo > 0)
                {
                    item.dc_ValorPago = saldo >= Convert.ToDouble(item.Saldo) ? Convert.ToDouble(item.Saldo) : saldo;
                    saldo = saldo - item.dc_ValorPago;
                }
                else
                    item.dc_ValorPago = 0;
            }
            list_det.set_list(lst);
            var resultado = saldo;
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CalcularSaldo(double TotalACobrar = 0)
        {
            double saldo = TotalACobrar;

            var lst = list_det.get_list();
            foreach (var item in lst)
            {
                saldo -= item.dc_ValorPago;
            }
            list_det.set_list(lst);
            var resultado = saldo;
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public void VaciarLista()
        {
            list_det.set_list(new List<cxc_cobro_det_Info>());
        }
        #endregion
    }

    public class cxc_cobro_det_List
    {
        public List<cxc_cobro_det_Info> get_list()
        {
            if (HttpContext.Current.Session["cxc_cobro_det_Info"] == null)
            {
                List<cxc_cobro_det_Info> list = new List<cxc_cobro_det_Info>();

                HttpContext.Current.Session["cxc_cobro_det_Info"] = list;
            }
            return (List<cxc_cobro_det_Info>)HttpContext.Current.Session["cxc_cobro_det_Info"];            
        }

        public void set_list(List<cxc_cobro_det_Info> list)
        {
            HttpContext.Current.Session["cxc_cobro_det_Info"] = list;
        }

        public void AddRow(cxc_cobro_det_Info info_det)
        {
            List<cxc_cobro_det_Info> list = get_list();
            if(list.Where(q=>q.secuencia == info_det.secuencia).FirstOrDefault() == null)
                list.Add(info_det);
        }

        public void UpdateRow(cxc_cobro_det_Info info_det)
        {
            cxc_cobro_det_Info edited_info = get_list().Where(m => m.secuencia == info_det.secuencia).First();
            edited_info.dc_ValorPago = info_det.dc_ValorPago;
        }

        public void DeleteRow(string secuencia)
        {
            List<cxc_cobro_det_Info> list = get_list();
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }
    }
}