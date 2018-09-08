using Core.Erp.Bus.RRHH;
using Core.Erp.Info.RRHH;
using Core.Erp.Web.Helps;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class ProyeccionDeGastosController : Controller
    {
        #region variable
        ro_empleado_proyeccion_gastos_Bus bus_proyeccion = new ro_empleado_proyeccion_gastos_Bus();
        ro_empleado_proyeccion_gastos_det_Bus bus_det = new ro_empleado_proyeccion_gastos_det_Bus();
        ro_empleado_proyeccion_gastos_det_Info_lis ro_empleado_proyeccion_gastos_det_Info_lis = new ro_empleado_proyeccion_gastos_det_Info_lis();
        #endregion

        #region vistas
        public ActionResult Index()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_proyeccion_gastos()
        {
            try
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                List<ro_empleado_proyeccion_gastos_Info> model = bus_proyeccion.get_list(IdEmpresa);
                return PartialView("_GridViewPartial_proyeccion_gastos", model);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_proyeccion_gastos_det(int IdEmpresa, decimal IdTransaccion)
        {
            try
            {
                cargar_combo();
                ro_empleado_proyeccion_gastos_Info model = new ro_empleado_proyeccion_gastos_Info();
                List<ro_empleado_proyeccion_gastos_det_Info> lst_det = bus_det.get_list(IdEmpresa, IdTransaccion);
                model.list_proyeciones = lst_det;
                return PartialView("_GridViewPartial_proyeccion_gastos_det", model);
            }
            catch (Exception)
            {

                throw;
            }
        }

        #endregion

        #region acciones
        [HttpPost]
        public ActionResult Nuevo(ro_empleado_proyeccion_gastos_Info info)
        {
            try
            {

                if (ModelState.IsValid)
                {
                    int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                    if (!bus_proyeccion.guardarDB(info))

                        return View(info);
                    else
                        return RedirectToAction("Index");
                }
                else
                    return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult Nuevo()
        {
            try
            {
                ro_empleado_proyeccion_gastos_Info info = new ro_empleado_proyeccion_gastos_Info();
                cargar_combo();
                return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }

        [HttpPost]
        public ActionResult Modificar(ro_empleado_proyeccion_gastos_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (!bus_proyeccion.anularDB(info))
                        return View(info);
                    else
                        return RedirectToAction("Index");
                }
                else
                    return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult Modificar(decimal IdEmpleado, int Anio = 0)
        {
            try
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

                return View(bus_proyeccion.get_info(IdEmpresa, IdEmpleado, Anio));

            }
            catch (Exception)
            {

                throw;
            }
        }

        [HttpPost]
        public ActionResult Anular(ro_empleado_proyeccion_gastos_Info info)
        {
            try
            {

                if (!bus_proyeccion.anularDB(info))
                    return View(info);
                else
                    return RedirectToAction("Index");
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult Anular(decimal IdEmpleado, int Anio = 0)
        {
            try
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

                return View(bus_proyeccion.get_info(IdEmpresa, IdEmpleado, Anio));

            }
            catch (Exception)
            {

                throw;
            }
        }
        #endregion

        #region cargar_combos
        private void cargar_combo()
        {
            try
            {
                ro_tipo_gastos_personales_Bus bus_tipo_gasto = new ro_tipo_gastos_personales_Bus();
                var list_tipo_gasto = bus_tipo_gasto.get_list();
                ViewBag.list_tipo_gasto = list_tipo_gasto;
            }
            catch (Exception)
            {

                throw;
            }
        }
        #endregion


        #region funciones del detalle
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ro_empleado_proyeccion_gastos_det_Info info_det)
        {
            if (ModelState.IsValid)
                ro_empleado_proyeccion_gastos_det_Info_lis.AddRow(info_det);
            ro_empleado_proyeccion_gastos_Info model = new ro_empleado_proyeccion_gastos_Info();
            model.list_proyeciones = ro_empleado_proyeccion_gastos_det_Info_lis.get_list();
            cargar_combo();
            return PartialView("_GridViewPartial_empleado_novedad_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ro_empleado_proyeccion_gastos_det_Info info_det)
        {
            if (ModelState.IsValid)
                ro_empleado_proyeccion_gastos_det_Info_lis.UpdateRow(info_det);
            ro_empleado_proyeccion_gastos_Info model = new ro_empleado_proyeccion_gastos_Info();
            model.list_proyeciones = ro_empleado_proyeccion_gastos_det_Info_lis.get_list();
            cargar_combo();
            return PartialView("_GridViewPartial_empleado_novedad_det", model);
        }

        public ActionResult EditingDelete([ModelBinder(typeof(DevExpressEditorsBinder))] ro_empleado_proyeccion_gastos_det_Info info_det)
        {
            ro_empleado_proyeccion_gastos_det_Info_lis.DeleteRow(info_det.Secuencia);
            ro_empleado_proyeccion_gastos_Info model = new ro_empleado_proyeccion_gastos_Info();
            model.list_proyeciones = ro_empleado_proyeccion_gastos_det_Info_lis.get_list();
            cargar_combo();
            return PartialView("_GridViewPartial_empleado_novedad_det", model);
        }
        #endregion
    }


    public class ro_empleado_proyeccion_gastos_det_Info_lis
    {
        public List<ro_empleado_proyeccion_gastos_det_Info> get_list()
        {
            if (HttpContext.Current.Session["ro_novedad_detalle_info"] == null)
            {
                List<ro_empleado_proyeccion_gastos_det_Info> list = new List<ro_empleado_proyeccion_gastos_det_Info>();

                HttpContext.Current.Session["ro_novedad_detalle_info"] = list;
            }
            return (List<ro_empleado_proyeccion_gastos_det_Info>)HttpContext.Current.Session["ro_novedad_detalle_info"];
        }

        public void set_list(List<ro_empleado_proyeccion_gastos_det_Info> list)
        {
            HttpContext.Current.Session["ro_novedad_detalle_info"] = list;
        }

        public void AddRow(ro_empleado_proyeccion_gastos_det_Info info_det)
        {
            List<ro_empleado_proyeccion_gastos_det_Info> list = get_list();
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            list.Add(info_det);
        }

        public void UpdateRow(ro_empleado_proyeccion_gastos_det_Info info_det)
        {
            ro_empleado_proyeccion_gastos_det_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.Valor = info_det.Valor;
            edited_info.IdTipoGasto = info_det.IdTipoGasto;
        }

        public void DeleteRow(int Secuencia)
        {
            List<ro_empleado_proyeccion_gastos_det_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }
}