using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.General;
using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.General;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    [SessionTimeout]
    public class ActivoFijoController : Controller
    {
        #region Variables
        Af_Activo_fijo_Bus bus_activo = new Af_Activo_fijo_Bus();
        Af_Activo_fijo_CtaCble_Bus bus_cta_cble = new Af_Activo_fijo_CtaCble_Bus();
        Af_Activo_fijo_tipo_Bus bus_tipo = new Af_Activo_fijo_tipo_Bus();
        Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
        Af_Catalogo_Bus bus_catalogo = new Af_Catalogo_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        Af_Activo_fijo_CtaCble_List List_det = new Af_Activo_fijo_CtaCble_List();
        #endregion

        #region Index

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_activo_fijo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_activo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_activo_fijo", model);
        }
        #endregion
        #region Metodos ComboBox bajo demanda
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        public ActionResult CmbCuenta_AF()
        {
            string model = "";
            return PartialView("_CmbCuenta_AF", model);
        }

        public List<ct_plancta_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_plancta.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), false);
        }
        public ct_plancta_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_plancta.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion
        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbEmpleado_Enc_AF()
        {
            decimal model = new decimal();
            return PartialView("_CmbEmpleado_Enc_AF", model);
        }
        public ActionResult CmbEmpleado_Cus_AF()
        {
            decimal model = new decimal();
            return PartialView("_CmbEmpleado_Cus_AF", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda_emp(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda_emp(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        #endregion

        #region Metodos
        private void cargar_combos(int IdEmpresa, int IdActivoFijoTipo = 0)
        {
            var lst_tipo = bus_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;

            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_categoria = bus_categoria.get_list(IdEmpresa, IdActivoFijoTipo, false);
            ViewBag.lst_categoria = lst_categoria;

            var lst_color = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_COLOR), false);
            ViewBag.lst_color = lst_color;

            var lst_modelo = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_MODELO), false);
            ViewBag.lst_modelo = lst_modelo;

            var lst_estado = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_ESTADO_AF), false);
            ViewBag.lst_estado = lst_estado;

            var lst_marca = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_MARCA), false);
            ViewBag.lst_marca = lst_marca;

            var lst_ubicacion = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_UBICACION), false);
            ViewBag.lst_ubicacion = lst_ubicacion;
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
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info
            {
                IdEmpresa = IdEmpresa,
                Af_fecha_compra = DateTime.Now,
                Af_fecha_fin_depre = DateTime.Now,
                Af_fecha_ini_depre = DateTime.Now,
                Estado_Proceso = "TIP_ESTADO_AF_ACTIVO",
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession)
            };
            model.LstDet = new List<Af_Activo_fijo_CtaCble_Info>();
            List_det.set_list(model.LstDet, model.IdTransaccionSession);
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Activo_fijo_Info model)
        {
            model.LstDet = List_det.get_list(model.IdTransaccionSession);
            if (!bus_activo.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdActivoFijo = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            Af_Activo_fijo_Info model = bus_activo.get_info(IdEmpresa, IdActivoFijo);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.LstDet = bus_cta_cble.GetList(IdEmpresa, IdActivoFijo);
            List_det.set_list(model.LstDet, model.IdTransaccionSession);
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(Af_Activo_fijo_Info model)
        {
            model.LstDet = List_det.get_list(model.IdTransaccionSession);
            if (!bus_activo.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0, int IdActivoFijo = 0)
        {
            Af_Activo_fijo_Info model = bus_activo.get_info(IdEmpresa, IdActivoFijo);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.LstDet = bus_cta_cble.GetList(IdEmpresa, IdActivoFijo);
            List_det.set_list(model.LstDet, model.IdTransaccionSession);
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(Af_Activo_fijo_Info model)
        {
            model.LstDet = List_det.get_list(model.IdTransaccionSession);
            if (!bus_activo.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion

        #region Json
        public JsonResult cargar_categoria( int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
            var resultado = bus_categoria.get_list(IdEmpresa, IdActivoFijoTipo, false);
            
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult get_info_tipo( int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            Af_Activo_fijo_tipo_Bus bus_tipo  = new Af_Activo_fijo_tipo_Bus();
            var resultado = bus_tipo.get_info(IdEmpresa, IdActivoFijoTipo);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Detalle
        private void cargar_combos_Detalle()
        {
            var lst_catalogo = bus_catalogo.get_list(cl_enumeradores.eTipoCatalogoAF.TIP_CTACBLE.ToString(), false);
            ViewBag.lst_catalogo = lst_catalogo;
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_activo_fijo_ctacble(int IdActivoFijo = 0)
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cargar_combos_Detalle();
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_activo_fijo_ctacble", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] Af_Activo_fijo_CtaCble_Info info_det)
        {
            var cuenta = bus_plancta.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdCtaCble);
            if (cuenta != null)
                info_det.pc_Cuenta = cuenta.pc_Cuenta;
            if (ModelState.IsValid)
                List_det.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info();
           model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_Detalle();
            return PartialView("_GridViewPartial_activo_fijo_ctacble", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] Af_Activo_fijo_CtaCble_Info info_det)
        {
            var cuenta = bus_plancta.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdCtaCble);
            if (cuenta != null)
                info_det.pc_Cuenta = cuenta.pc_Cuenta;

            if (ModelState.IsValid)
                List_det.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_Detalle();
            return PartialView("_GridViewPartial_activo_fijo_ctacble", model);
        }
        public ActionResult EditingDelete(int Secuencia)
        {
            List_det.DeleteRow(Secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_Detalle();
            return PartialView("_GridViewPartial_activo_fijo_ctacble", model);
        }
        #endregion
    }
    public class Af_Activo_fijo_CtaCble_List
    {
        string Variable = "Af_Activo_fijo_CtaCble_Info";
        public List<Af_Activo_fijo_CtaCble_Info> get_list(decimal IdTransaccionSession)
        {

            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<Af_Activo_fijo_CtaCble_Info> list = new List<Af_Activo_fijo_CtaCble_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<Af_Activo_fijo_CtaCble_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<Af_Activo_fijo_CtaCble_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(Af_Activo_fijo_CtaCble_Info info_det, decimal IdTransaccionSession)
        {
            List<Af_Activo_fijo_CtaCble_Info> list = get_list(IdTransaccionSession);
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            info_det.IdCatalogo = info_det.IdCatalogo;
            info_det.IdCtaCble = info_det.IdCtaCble;
            info_det.Porcentaje = info_det.Porcentaje;
            info_det.pc_Cuenta = info_det.pc_Cuenta;


            list.Add(info_det);
        }

        public void UpdateRow(Af_Activo_fijo_CtaCble_Info info_det, decimal IdTransaccionSession)
        {
            Af_Activo_fijo_CtaCble_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdActivoFijo = info_det.IdActivoFijo;
            edited_info.IdCtaCble = info_det.IdCtaCble;
            edited_info.IdCatalogo = info_det.IdCatalogo;
            edited_info.Porcentaje = info_det.Porcentaje;
            edited_info.pc_Cuenta = info_det.pc_Cuenta;
        }

        public void DeleteRow(int Secuencia, decimal IdTransaccionSession)
        {
            List<Af_Activo_fijo_CtaCble_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }

}