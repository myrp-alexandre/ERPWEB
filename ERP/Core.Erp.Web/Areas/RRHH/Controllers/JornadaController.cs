using Core.Erp.Bus.General;
using Core.Erp.Bus.RRHH;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Info.RRHH;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class JornadaController : Controller
    {
        #region Variables
        ro_jornada_Bus bus_jornada = new ro_jornada_Bus();
        ro_empleado_x_jornada_Bus bus_jornada_det = new ro_empleado_x_jornada_Bus();
        ro_Empleado_x_Jornada_List List_Det = new ro_Empleado_x_Jornada_List();
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_Jornada()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<ro_jornada_Info> model = bus_jornada.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_Jornada", model);
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
            ro_jornada_Info model = new ro_jornada_Info
            {
                IdEmpresa = IdEmpresa,
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession),
                Lst_det = new List<ro_empleado_x_jornada_Info>()
            };
            List_Det.set_list(model.Lst_det, model.IdTransaccionSession);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ro_jornada_Info model)
        {
            model.Lst_det = List_Det.get_list(model.IdTransaccionSession);
            model.IdUsuario = SessionFixed.IdUsuario;
            if (!bus_jornada.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdJornada = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            ro_jornada_Info model = bus_jornada.get_info(IdEmpresa, IdJornada);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.Lst_det = bus_jornada_det.GetList(IdEmpresa, IdJornada);
            List_Det.set_list(model.Lst_det, model.IdTransaccionSession);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(ro_jornada_Info model)
        {
            model.Lst_det = List_Det.get_list(model.IdTransaccionSession);
            model.IdUsuarioUltMod = SessionFixed.IdUsuario;
            if (!bus_jornada.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0, int IdJornada = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            ro_jornada_Info model = bus_jornada.get_info(IdEmpresa, IdJornada);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.Lst_det = bus_jornada_det.GetList(IdEmpresa, IdJornada);
            List_Det.set_list(model.Lst_det, model.IdTransaccionSession);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(ro_jornada_Info model)
        {
            model.IdUsuarioUltMod = SessionFixed.IdUsuario;
            if (!bus_jornada.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion

        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbEmpleado_Jornada()
        {
            ro_empleado_x_jornada_Info model = new ro_empleado_x_jornada_Info();
            return PartialView("_CmbEmpleado_Jornada", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }


        #endregion

        #region Detalle

        [ValidateInput(false)]
        public ActionResult GridViewPartial_empleado_x_jornada()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_empleado_x_jornada", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ro_empleado_x_jornada_Info info_det)
        {
            if (ModelState.IsValid)
                List_Det.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_empleado_x_jornada", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ro_empleado_x_jornada_Info info_det)
        {

            if (ModelState.IsValid)
                List_Det.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_empleado_x_jornada", model);
        }
        public ActionResult EditingDelete(int Secuencia)
        {
            List_Det.DeleteRow(Secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_empleado_x_jornada", model);
        }
        #endregion

    }
    public class ro_Empleado_x_Jornada_List
    {
        string Variable = "ro_empleado_x_jornada_Info";
        public List<ro_empleado_x_jornada_Info> get_list(decimal IdTransaccionSession)
        {

            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<ro_empleado_x_jornada_Info> list = new List<ro_empleado_x_jornada_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<ro_empleado_x_jornada_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<ro_empleado_x_jornada_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(ro_empleado_x_jornada_Info info_det, decimal IdTransaccionSession)
        {
            List<ro_empleado_x_jornada_Info> list = get_list(IdTransaccionSession);
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;


            list.Add(info_det);
        }

        public void UpdateRow(ro_empleado_x_jornada_Info info_det, decimal IdTransaccionSession)
        {
            ro_empleado_x_jornada_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdEmpleado = info_det.IdEmpleado;
            edited_info.ValorHora = info_det.ValorHora;
            edited_info.Secuencia = info_det.Secuencia;
            edited_info.MaxNumHoras = info_det.MaxNumHoras;

        }

        public void DeleteRow(int Secuencia, decimal IdTransaccionSession)
        {
            List<ro_empleado_x_jornada_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }

}