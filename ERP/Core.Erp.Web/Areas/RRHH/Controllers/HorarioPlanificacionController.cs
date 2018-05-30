using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.RRHH;
using Core.Erp.Bus.RRHH;
using DevExpress.Web.Mvc;
using Core.Erp.Bus.General;
namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class HorarioPlanificacionController : Controller
    {
        #region variables
        ro_horario_planificacion_Bus bus_planificacion = new ro_horario_planificacion_Bus();
        ro_horario_planificacion_det_Bus bus_planificacion_det = new ro_horario_planificacion_det_Bus();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();
        ro_horario_Bus bus_horario = new ro_horario_Bus();
        ro_horario_planificacion_det_lst lst_planificacion_det = new ro_horario_planificacion_det_lst();
        List<ro_horario_planificacion_Info> lst_detalle = new List<ro_horario_planificacion_Info>();
        ro_nomina_tipo_Bus bus_nomina = new ro_nomina_tipo_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        ro_division_Bus bus_division = new ro_division_Bus();
        ro_area_Bus bus_area = new ro_area_Bus();
        ro_departamento_Bus bus_departamento = new ro_departamento_Bus();
        ro_cargo_Bus bus_cargo = new ro_cargo_Bus();
        ro_horario_planificacion_Info info = new ro_horario_planificacion_Info();
        int IdEmpresa = 0;
        #endregion
        public ActionResult Index()
        {
            return View();
        }
        [ValidateInput(false)]      
        public ActionResult Nuevo()
        {
            cargar_combos();
            ro_horario_planificacion_Info info = new ro_horario_planificacion_Info();
            info.FechaInicio = DateTime.Now;
            info.FechaFin = DateTime.Now.AddDays(30);
            info.lst_planificacion_det = new List<ro_horario_planificacion_det_Info>();
            return View(info);
        }
        [HttpPost]
        public ActionResult Nuevo(ro_horario_planificacion_Info model)
        {
            if (model == null)
                return View(model);
            model.IdEmpresa=Convert.ToInt32( Session["IdEmpresa"].ToString());
            model.lst_planificacion_det = lst_planificacion_det.get_list();
            if (bus_planificacion.guardarDB(model))
                return RedirectToAction("Index");
            else return View(model);
        }
        public ActionResult Modificar(int IdPlanificacion)
        {
            cargar_combos();
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            info = bus_planificacion.get_info(IdEmpresa, IdPlanificacion);
            lst_planificacion_det.set_list(info.lst_planificacion_det);
            return View(bus_planificacion.get_info(IdEmpresa, IdPlanificacion));
        }
        [HttpPost]
        public ActionResult Modificar(ro_horario_planificacion_Info model)
        {
            model.lst_planificacion_det = lst_planificacion_det.get_list();
            if (model.lst_planificacion_det == null || model.lst_planificacion_det.Count() == 0)
            {
                ViewBag.mensaje = "No existe detalle para la novedad";
                cargar_combos();
                return View(model);
            }
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_planificacion.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");

        }
        public ActionResult Anular(int IdPlanificacion)
        {
            cargar_combos();
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            info = bus_planificacion.get_info(IdEmpresa, IdPlanificacion);
            lst_planificacion_det.set_list(info.lst_planificacion_det);
            return View(bus_planificacion.get_info(IdEmpresa, IdPlanificacion));
        }
        [HttpPost]
        public ActionResult Anular(ro_horario_planificacion_Info model)
        {
            model.lst_planificacion_det = lst_planificacion_det.get_list();

            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_planificacion.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        [ValidateInput(false)]


        public ActionResult Consultar(DateTime fi, DateTime ff, int IdNomina=0, int IdSucursal=0, int IdDivision=0, int IdArea=0, int IdDepartamento=0, int IdCargo=0,int IdHorario=0)
        {

           
            IdEmpresa =Convert.ToInt32( Session["IdEmpresa"].ToString());
            info = bus_planificacion.get_list(IdEmpresa, IdNomina,IdSucursal,IdDivision,IdArea,IdDepartamento,IdCargo,fi,ff,IdHorario);
            lst_planificacion_det.set_list(info.lst_planificacion_det);
             return Json("", JsonRequestBehavior.AllowGet);
    }


    [ValidateInput(false)]
        public ActionResult GridViewPartial_horario_planificacion()
        {
            IdEmpresa =Convert.ToInt32( Session["IdEmpresa"]);
            lst_detalle = bus_planificacion.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_horario_planificacion", lst_detalle);
        }

        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ro_horario_planificacion_det_Info info_det)
        {
            if (ModelState.IsValid)
                lst_planificacion_det.AddRow(info_det);
            ro_horario_planificacion_Info model = new ro_horario_planificacion_Info();
            model.lst_planificacion_det = lst_planificacion_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_horario_planificacion_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ro_horario_planificacion_det_Info info_det)
        {
            if (ModelState.IsValid)
                lst_planificacion_det.UpdateRow(info_det);
            ro_horario_planificacion_Info model = new ro_horario_planificacion_Info();
            model.lst_planificacion_det = lst_planificacion_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_horario_planificacion_det", model);
        }

        public ActionResult EditingDelete([ModelBinder(typeof(DevExpressEditorsBinder))] ro_horario_planificacion_det_Info info_det)
        {
            lst_planificacion_det.DeleteRow(Convert.ToInt32( info_det.Secuencia));
            ro_horario_planificacion_Info model = new ro_horario_planificacion_Info();
            model.lst_planificacion_det = lst_planificacion_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_horario_planificacion_det", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_horario_planificacion_det()
        {
            cargar_combos_detalle();
            info = new ro_horario_planificacion_Info();
            info.IdEmpresa=Convert.ToInt32( Session["IdEmpresa"].ToString());
            info.lst_planificacion_det = Session["ro_horario_planificacion_det_Info"] as List<ro_horario_planificacion_det_Info>;
            return PartialView("_GridViewPartial_horario_planificacion_det", info);
        }

       
        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.lst_horario = bus_horario.get_list(IdEmpresa, false);
        }
        private void cargar_combos()
        {
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"].ToString());
            ViewBag.lst_nomina = bus_nomina.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_division = bus_division.get_list(IdEmpresa, false);
            ViewBag.lst_area = bus_area.get_list(IdEmpresa, false);
            ViewBag.lst_departamento = bus_departamento.get_list(IdEmpresa, false);
            ViewBag.lst_cargo = bus_cargo.get_list(IdEmpresa, false);
            ViewBag.lst_horario = bus_horario.get_list(IdEmpresa, false);

        }
    }

    public class ro_horario_planificacion_det_lst
    {
        public List<ro_horario_planificacion_det_Info> get_list()
        {
            if (HttpContext.Current.Session["ro_horario_planificacion_det_Info"] == null)
            {
                List<ro_horario_planificacion_det_Info> list = new List<ro_horario_planificacion_det_Info>();

                HttpContext.Current.Session["ro_horario_planificacion_det_Info"] = list;
            }
            return (List<ro_horario_planificacion_det_Info>)HttpContext.Current.Session["ro_horario_planificacion_det_Info"];
        }

        public void set_list(List<ro_horario_planificacion_det_Info> list)
        {
            HttpContext.Current.Session["ro_horario_planificacion_det_Info"] = list;
        }

        public void AddRow(ro_horario_planificacion_det_Info info_det)
        {
            List<ro_horario_planificacion_det_Info> list = get_list();
            list.Add(info_det);
        }

        public void UpdateRow(ro_horario_planificacion_det_Info info_det)
        {

            ro_horario_planificacion_det_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdHorario = info_det.IdHorario;
        }

        public void DeleteRow( int Secuencia)
        {
            List<ro_horario_planificacion_det_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }
}