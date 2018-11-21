using Core.Erp.Bus.General;
using Core.Erp.Bus.RRHH;
using Core.Erp.Info.Helps;
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
    public class ImportacionNovedadesController : Controller
    {
        #region Variables
        ro_EmpleadoNovedadCargaMasiva_Bus bus_novedad = new ro_EmpleadoNovedadCargaMasiva_Bus();
        ro_nomina_tipo_Bus bus_nomina = new ro_nomina_tipo_Bus();
        ro_Nomina_Tipoliquiliqui_Bus bus_nomina_tipo = new ro_Nomina_Tipoliquiliqui_Bus();
        ro_EmpleadoNovedadCargaMasiva_det_Bus bus_novedad_detalle_bus = new ro_EmpleadoNovedadCargaMasiva_det_Bus();
        ro_EmpleadoNovedadCargaMasiva_detLis_Info detalle = new ro_EmpleadoNovedadCargaMasiva_detLis_Info();
        ro_rubro_tipo_Bus bus_rubro = new ro_rubro_tipo_Bus();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();
        ro_contrato_Bus bus_contrato = new ro_contrato_Bus();
        List<ro_rubro_tipo_Info> lst_rubros = new List<ro_rubro_tipo_Info>();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();

        int IdEmpresa = 0;
        #endregion

    
        #region Vistas
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
        public ActionResult GridViewPartial_empleado_novedad(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);

            var model = bus_novedad.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin, false);
            return PartialView("_GridViewPartial_empleado_novedad", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_empleado_novedad_det(int IdEmpleado = 0, decimal ro_IdCarga = 0)
        {
            ro_EmpleadoNovedadCargaMasiva_Info model = new ro_EmpleadoNovedadCargaMasiva_Info();
                model.detalle = detalle.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_empleado_novedad_det", model);
        }
        #endregion

        #region acciones
        public ActionResult Nuevo()
        {
            ro_EmpleadoNovedadCargaMasiva_Info model = new ro_EmpleadoNovedadCargaMasiva_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                FechaCarga = DateTime.Now,
            };
            model.detalle = new List<ro_EmpleadoNovedadCargaMasiva_det_Info>();
            detalle.set_list(model.detalle);
            cargar_combos(0);
            cargar_combos_detalle();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ro_EmpleadoNovedadCargaMasiva_Info model)
        {



            model.detalle = detalle.get_list();
            if (model.detalle == null || model.detalle.Count() == 0)
            {
                ViewBag.mensaje = "No existe detalle para la novedad";
                cargar_combos();
                return View(model);
            }

          

            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_novedad.GuardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpleado, decimal IdCarga)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ro_EmpleadoNovedadCargaMasiva_Info model = bus_novedad.get_info(IdEmpresa,  IdCarga);
            if (model == null)
                return RedirectToAction("Index");
            model.detalle = bus_novedad_detalle_bus.get_list(IdEmpresa,  IdCarga);
            detalle.set_list(model.detalle);
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ro_EmpleadoNovedadCargaMasiva_Info model)
        {
            model.detalle = detalle.get_list();

            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            model.Fecha_UltAnu = DateTime.Now;
            if (!bus_novedad.AnularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion

        #region cargar combos

        private void cargar_combos(int IdNomina=0)
        {
            IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.lst_nomina = bus_nomina.get_list(IdEmpresa, false);
            ViewBag.lst_nomina_tipo = bus_nomina_tipo.get_list(IdEmpresa, IdNomina);
        }
        #endregion

        #region funciones del detalle
      
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ro_EmpleadoNovedadCargaMasiva_det_Info info_det)
        {
            if (ModelState.IsValid)
                detalle.UpdateRow(info_det);
            ro_EmpleadoNovedadCargaMasiva_Info model = new ro_EmpleadoNovedadCargaMasiva_Info();
            model.detalle = detalle.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_empleado_novedad_det", model);
        }

        public ActionResult EditingDelete([ModelBinder(typeof(DevExpressEditorsBinder))] ro_EmpleadoNovedadCargaMasiva_det_Info info_det)
        {
            detalle.DeleteRow(info_det.Secualcial);
            ro_EmpleadoNovedadCargaMasiva_Info model = new ro_EmpleadoNovedadCargaMasiva_Info();
            model.detalle = detalle.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_empleado_novedad_det", model);
        }
        #endregion
        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            lst_rubros = bus_rubro.get_list_rub_concepto(IdEmpresa);
            ViewBag.lst_rubro = lst_rubros;
            Session["rubros"] = lst_rubros;
        }

    }


    public class ro_EmpleadoNovedadCargaMasiva_detLis_Info
    {
        public List<ro_EmpleadoNovedadCargaMasiva_det_Info> get_list()
        {
            if (HttpContext.Current.Session["ro_EmpleadoNovedadCargaMasiva_det_Info"] == null)
            {
                List<ro_EmpleadoNovedadCargaMasiva_det_Info> list = new List<ro_EmpleadoNovedadCargaMasiva_det_Info>();

                HttpContext.Current.Session["ro_EmpleadoNovedadCargaMasiva_det_Info"] = list;
            }
            return (List<ro_EmpleadoNovedadCargaMasiva_det_Info>)HttpContext.Current.Session["ro_EmpleadoNovedadCargaMasiva_det_Info"];
        }

        public void set_list(List<ro_EmpleadoNovedadCargaMasiva_det_Info> list)
        {
            HttpContext.Current.Session["ro_EmpleadoNovedadCargaMasiva_det_Info"] = list;
        }

      
        public void UpdateRow(ro_EmpleadoNovedadCargaMasiva_det_Info info_det)
        {
            ro_EmpleadoNovedadCargaMasiva_det_Info edited_info = get_list().Where(m => m.Secualcial == info_det.Secualcial).First();
            edited_info.Valor = info_det.Valor;
            edited_info.Valor = info_det.Valor;
        }

        public void DeleteRow(int Secuencia)
        {
            List<ro_EmpleadoNovedadCargaMasiva_det_Info> list = get_list();
            list.Remove(list.Where(m => m.Secualcial == Secuencia).First());
        }
    }
}