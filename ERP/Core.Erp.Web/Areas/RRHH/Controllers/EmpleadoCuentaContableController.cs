using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
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
    public class EmpleadoCuentaContableController : Controller
    {
        #region Metodos ComboBox bajo demanda
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        public ActionResult CmbCuenta_Empleado()
        {
            ro_empleado_x_CuentaContable_Info model = new ro_empleado_x_CuentaContable_Info();
            return PartialView("_CmbCuenta_Empleado", model);
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
        ro_empleado_x_CuentaContable_List List_Det = new ro_empleado_x_CuentaContable_List();
        public ActionResult Index()
        {
            return View();
        }

        #region Detalle de jornada
        private void carga_combo()
        {
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_Emp_CtaCont()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            carga_combo();
            return PartialView("_GridViewPartial_Emp_CtaCont", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNewJornada([ModelBinder(typeof(DevExpressEditorsBinder))] ro_empleado_x_CuentaContable_Info info_det)
        {

            if (ModelState.IsValid)
                List_Det.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            carga_combo();
            return PartialView("_GridViewPartial_Emp_CtaCont", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdateJornada([ModelBinder(typeof(DevExpressEditorsBinder))] ro_empleado_x_CuentaContable_Info info_det)
        {

            if (ModelState.IsValid)
                List_Det.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            carga_combo();
            return PartialView("_GridViewPartial_Emp_CtaCont", model);
        }
        public ActionResult EditingDeleteJornada(int Secuencia)
        {
            List_Det.DeleteRow(Secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            carga_combo();
            return PartialView("_GridViewPartial_Emp_CtaCont", model);
        }
        #endregion

    }

    public class ro_empleado_x_CuentaContable_List
    {
        string Variable = "ro_empleado_x_CuentaContable_Info";
        public List<ro_empleado_x_CuentaContable_Info> get_list(decimal IdTransaccionSession)
        {

            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<ro_empleado_x_CuentaContable_Info> list = new List<ro_empleado_x_CuentaContable_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<ro_empleado_x_CuentaContable_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<ro_empleado_x_CuentaContable_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(ro_empleado_x_CuentaContable_Info info_det, decimal IdTransaccionSession)
        {
            List<ro_empleado_x_CuentaContable_Info> list = get_list(IdTransaccionSession);
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;


            list.Add(info_det);
        }

        public void UpdateRow(ro_empleado_x_CuentaContable_Info info_det, decimal IdTransaccionSession)
        {
            ro_empleado_x_CuentaContable_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdEmpleado = info_det.IdEmpleado;
            edited_info.Secuencia = info_det.Secuencia;


        }

        public void DeleteRow(int Secuencia, decimal IdTransaccionSession)
        {
            List<ro_empleado_x_CuentaContable_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }

}