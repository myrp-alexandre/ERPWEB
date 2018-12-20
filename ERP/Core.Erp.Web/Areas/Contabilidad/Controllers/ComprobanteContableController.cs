using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.Presupuesto;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    [SessionTimeout]
    public class ComprobanteContableController : Controller
    {
        #region Variables
        ct_cbtecble_Bus bus_comprobante = new ct_cbtecble_Bus();
        ct_cbtecble_det_Bus bus_comprobante_detalle = new ct_cbtecble_det_Bus();
        ct_cbtecble_det_List list_ct_cbtecble_det = new ct_cbtecble_det_List();
        string mensaje = string.Empty;
        ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
        pre_Grupo_Bus bus_grupo = new pre_Grupo_Bus();
        #endregion

        #region Index
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_comprobante_contable(DateTime? fecha_ini, DateTime? fecha_fin)
        {
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : fecha_ini;
            ViewBag.fecha_fin = fecha_fin == null ? DateTime.Now.Date : fecha_fin;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<ct_cbtecble_Info> model = bus_comprobante.get_list(IdEmpresa, true, ViewBag.fecha_ini, ViewBag.fecha_fin);
            return PartialView("_GridViewPartial_comprobante_contable", model);
        }

        #endregion

        #region Metodos
        private bool validar(ct_cbtecble_Info i_validar, ref string msg)
        {
            if (!bus_periodo.ValidarFechaTransaccion(i_validar.IdEmpresa, i_validar.cb_Fecha, cl_enumeradores.eModulo.CONTA, ref msg))
            {
                return false;
            }

            if (i_validar.lst_ct_cbtecble_det.Count == 0)
            {
                mensaje = "Debe ingresar registros en el detalle";
                return false;
            }

            if(i_validar.lst_ct_cbtecble_det.Sum(q => q.dc_Valor) != 0)
            {
                mensaje = "La suma de los detalles debe ser 0";
                return false;
            }

            if (i_validar.lst_ct_cbtecble_det.Where(q=>q.dc_Valor == 0).Count() > 0)
            {
                mensaje = "Existen detalles con valor 0 en el debe o haber";
                return false;
            }

            return true;
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_cbtecble_tipo_Bus bus_tipo_comprobante = new ct_cbtecble_tipo_Bus();
            var lst_tipo_comprobante = bus_tipo_comprobante.get_list(IdEmpresa, false);
            ViewBag.lst_tipo_comprobante = lst_tipo_comprobante;

        }

        public ActionResult CargarGrupo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            int IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            DateTime cb_Fecha = DateTime.Now;
                string fecha = Request.Params["cb_Fecha"] != null && !string.IsNullOrEmpty(Request.Params["cb_Fecha"].ToString()) ? Request.Params["cb_Fecha"].ToString() : "";
            string IdCtaCble = Request.Params["IdCtaCble"] != null ? Request.Params["IdCtaCble"].ToString() : "";
            return GridViewExtension.GetComboBoxCallbackResult(p =>
            {
                p.TextField = "Descripcion";
                p.ValueField = "IdGrupo";
                p.ValueType = typeof(int);
                p.BindList(bus_grupo.get_list_x_CtaCble(IdEmpresa, IdSucursal, IdCtaCble, cb_Fecha));
            });
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            ct_cbtecble_Info model = new ct_cbtecble_Info
            {
                IdEmpresa = IdEmpresa,
                cb_Fecha = DateTime.Now,
                IdTipoCbte = 1,
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)
            };
            model.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            list_ct_cbtecble_det.set_list(model.lst_ct_cbtecble_det, model.IdTransaccionSession);
            cargar_combos();
            cargar_combos_detalle();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ct_cbtecble_Info model)
        {
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list(model.IdTransaccionSession);
            if (!validar(model,ref mensaje))
            {
                cargar_combos();
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.IdUsuario = SessionFixed.IdUsuario;
            if (!bus_comprobante.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            
            ct_cbtecble_Info model = bus_comprobante.get_info(IdEmpresa, IdTipoCbte, IdCbteCble);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual);
            model.lst_ct_cbtecble_det = bus_comprobante_detalle.get_list(IdEmpresa, IdTipoCbte, IdCbteCble);
            list_ct_cbtecble_det.set_list(model.lst_ct_cbtecble_det,model.IdTransaccionSession);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(ct_cbtecble_Info model)
        {
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list(model.IdTransaccionSession);
            if (!validar(model, ref mensaje))
            {
                cargar_combos();
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.IdUsuarioUltModi = Session["IdUsuario"].ToString();            
            if (!bus_comprobante.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");

        }

        public ActionResult Anular(int IdEmpresa = 0, int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion

            ct_cbtecble_Info model = bus_comprobante.get_info(IdEmpresa, IdTipoCbte, IdCbteCble);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual);
            model.lst_ct_cbtecble_det = bus_comprobante_detalle.get_list(IdEmpresa, IdTipoCbte, IdCbteCble);
            list_ct_cbtecble_det.set_list(model.lst_ct_cbtecble_det, model.IdTransaccionSession);
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ct_cbtecble_Info model)
        {
            model.IdUsuarioAnu = SessionFixed.IdUsuario;
            if (!bus_comprobante.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");

        }

        #endregion

        #region GRids

        [ValidateInput(false)]
        public ActionResult GridViewPartial_comprobante_detalle()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;

            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_comprobante_detalle", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_comprobante_detalle_readonly()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_comprobante_detalle_readonly", model);
        }

        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_plancta_Bus bus_cuenta = new ct_plancta_Bus();
            var lst_cuentas = bus_cuenta.get_list(IdEmpresa, false , true);
            ViewBag.lst_cuentas = lst_cuentas;

            var lst_grupos = bus_grupo.GetList(IdEmpresa, false);
            ViewBag.lst_grupos = lst_grupos;
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                list_ct_cbtecble_det.AddRow(info_det,Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_comprobante_detalle", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                list_ct_cbtecble_det.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_comprobante_detalle", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            list_ct_cbtecble_det.DeleteRow(secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_comprobante_detalle", model);
        }
        #endregion
    }
    
public class ct_cbtecble_det_List
    {
        string variable = "ct_cbtecble_det_Info";
        public List<ct_cbtecble_det_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] == null)
            {
                List<ct_cbtecble_det_Info> list = new List<ct_cbtecble_det_Info>();

                HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<ct_cbtecble_det_Info>)HttpContext.Current.Session[variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<ct_cbtecble_det_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(ct_cbtecble_det_Info info_det, decimal IdTransaccionSession)
        {
            List<ct_cbtecble_det_Info> list = get_list(IdTransaccionSession);
            info_det.secuencia = list.Count == 0 ? 1 : list.Max(q => q.secuencia) + 1;
            info_det.dc_Valor = info_det.dc_Valor_debe > 0 ? info_det.dc_Valor_debe : info_det.dc_Valor_haber * -1;
            info_det.IdGrupoPresupuesto = info_det.IdGrupoPresupuesto;
            info_det.Descripcion = info_det.Descripcion;
            list.Add(info_det);
        }

        public void UpdateRow(ct_cbtecble_det_Info info_det, decimal IdTransaccionSession)
        {
            ct_cbtecble_det_Info edited_info = get_list(IdTransaccionSession).Where(m => m.secuencia == info_det.secuencia).First();
            edited_info.IdCtaCble = info_det.IdCtaCble;
            edited_info.dc_para_conciliar = info_det.dc_para_conciliar;
            edited_info.dc_Valor = info_det.dc_Valor_debe > 0 ? info_det.dc_Valor_debe : info_det.dc_Valor_haber * - 1;
            edited_info.dc_Valor_debe = info_det.dc_Valor_debe;
            edited_info.dc_Valor_haber = info_det.dc_Valor_haber;

            edited_info.IdGrupoPresupuesto = info_det.IdGrupoPresupuesto;
            edited_info.Descripcion = info_det.Descripcion;
        }

        public void DeleteRow(int secuencia, decimal IdTransaccionSession)
        {
            List<ct_cbtecble_det_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }
    }
}