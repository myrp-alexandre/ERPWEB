using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Bus.RRHH;
using Core.Erp.Info.Contabilidad;
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

        ro_rubro_tipo_Bus bus_rubro = new ro_rubro_tipo_Bus();
        public ActionResult CmbRubro_Emp()
        {
            ro_empleado_x_CuentaContable_Info model = new ro_empleado_x_CuentaContable_Info();
            return PartialView("_CmbRubro_Emp", model);
        }
        public List<ro_rubro_tipo_Info> get_list_bajo_demanda_rubro(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_rubro.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        public ro_rubro_tipo_Info get_info_bajo_demanda_rubro(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_rubro.get_info_bajo_demanda(Convert.ToInt32(SessionFixed.IdEmpresa), args);
        }


        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbEmpleado_CtaCon()
        {
            decimal model = new decimal();
            return PartialView("_CmbEmpleado_CtaCon", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda_empleado(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda_empleado(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        #endregion
        ro_empleado_x_CuentaContable_List List_Det = new ro_empleado_x_CuentaContable_List();
        ro_empleado_x_CuentaContable_Bus bus_emple = new ro_empleado_x_CuentaContable_Bus();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();
       public ActionResult Index(decimal IdEmpleado = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ro_empleado_x_CuentaContable_Info model = bus_emple.GetInfo(IdEmpresa, IdEmpleado);
            if (model == null)
                model = new ro_empleado_x_CuentaContable_Info { IdEmpresa = IdEmpresa};
           ro_empleado_Info mod = bus_empleado.get_info(IdEmpresa, IdEmpleado);
            model.IdEmpleado = mod.IdEmpleado;
            model.pe_nombre = mod.pe_nombre;
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual);
            List_Det.set_list(new List<ro_empleado_x_CuentaContable_Info>(), model.IdTransaccionSession);
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(ro_empleado_x_CuentaContable_Info model)
        {
            List_Det.get_list(model.IdTransaccionSession);
            if (!bus_emple.GuardarDB(model))
                ViewBag.mensaje = "No se pudieron actualizar los registros";
            return View(model);
        }

        #region Detalle de jornada
        private void carga_combo()
        {
            ro_rubro_tipo_Bus bus_rubro = new ro_rubro_tipo_Bus();
            var lst_rubro = bus_rubro.get_list(Convert.ToInt32(SessionFixed.IdEmpresa), false);
            ViewBag.lst_rubro = lst_rubro;
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_Emp_CtaCont(decimal IdEmpleado = 0)
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var mod = bus_emple.GetList(IdEmpresa, IdEmpleado);
            carga_combo();
            return PartialView("_GridViewPartial_Emp_CtaCont", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ro_empleado_x_CuentaContable_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            if (info_det != null)
                if (info_det.IdCuentacon != "")
                {
                    ct_plancta_Info info_cuenta = bus_plancta.get_info(IdEmpresa, info_det.IdCuentacon);
                    ro_rubro_tipo_Info info_rubro = bus_rubro.get_info(IdEmpresa, info_det.IdRubro);
                    if (info_cuenta != null)
                    {
                        info_det.pc_Cuenta = info_cuenta.pc_Cuenta;
                    }
                    if(info_rubro!= null)
                    {
                        info_det.ru_descripcion = info_rubro.ru_descripcion;
                    }
                }
            if (ModelState.IsValid)
                List_Det.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            carga_combo();
            return PartialView("_GridViewPartial_Emp_CtaCont", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ro_empleado_x_CuentaContable_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            if (info_det != null)
                if (info_det.IdCuentacon != "")
                {
                    ct_plancta_Info info_cuenta = bus_plancta.get_info(IdEmpresa, info_det.IdCuentacon);
                    ro_rubro_tipo_Info info_rubro = bus_rubro.get_info(IdEmpresa, info_det.IdRubro);
                    if (info_cuenta != null)
                    {
                        info_det.pc_Cuenta = info_cuenta.pc_Cuenta;
                    }
                    if (info_rubro != null)
                    {
                        info_det.ru_descripcion = info_rubro.ru_descripcion;
                    }
                }
            if (ModelState.IsValid)
                List_Det.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = List_Det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            carga_combo();
            return PartialView("_GridViewPartial_Emp_CtaCont", model);
        }
        public ActionResult EditingDelete(int Secuencia)
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