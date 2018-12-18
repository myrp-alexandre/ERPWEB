using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.RRHH;
using Core.Erp.Bus.RRHH;
using DevExpress.Web.Mvc;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class HorasExtrasController : Controller
    {
        #region variables
        ro_nomina_x_horas_extras_Bus bus_horas_extras = new ro_nomina_x_horas_extras_Bus();
        ro_nomina_x_horas_extras_det_Bus bus_hora_extra_detalle = new ro_nomina_x_horas_extras_det_Bus();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();
        ro_horario_Bus bus_horario = new ro_horario_Bus();
        List<ro_nomina_x_horas_extras_Info> lst_horas_extras = new List<ro_nomina_x_horas_extras_Info>();
        ro_nomina_tipo_Bus bus_nomina = new ro_nomina_tipo_Bus();
        ro_Nomina_Tipoliquiliqui_Bus bus_nomina_tipo = new ro_Nomina_Tipoliquiliqui_Bus();
        ro_periodo_x_ro_Nomina_TipoLiqui_Bus bus_periodos = new ro_periodo_x_ro_Nomina_TipoLiqui_Bus();
        ro_nomina_x_horas_extras_Info info = new ro_nomina_x_horas_extras_Info();
        ro_nomina_x_horas_extras_det_Info_list ro_nomina_x_horas_extras_det_Info_list = new ro_nomina_x_horas_extras_det_Info_list();
        int IdEmpresa = 0;
        #endregion



        #region aprobacion horas extras
        public ActionResult Index2()
        {
            cl_filtros_Info model = new cl_filtros_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index2(cl_filtros_Info model)
        {
            return View(model);

        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_aprobacion_horas_extras(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            lst_horas_extras = bus_horas_extras.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_aprobacion_horas_extras", lst_horas_extras);
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_aprobacion_horas_extras_det()
        {
            cargar_combos_detalle();
            ro_nomina_x_horas_extras_Info model = new ro_nomina_x_horas_extras_Info();
            model.lst_nomina_horas_extras = ro_nomina_x_horas_extras_det_Info_list.get_list();

            return PartialView("_GridViewPartial_aprobacion_horas_extras_det", model);
        }

        public ActionResult Aprobar(int IdNomina_Tipo, int IdNomina_TipoLiqui, int IdPeriodo, int IdHorasExtras)
        {
            cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ro_nomina_x_horas_extras_Info model = new ro_nomina_x_horas_extras_Info();
            model = bus_horas_extras.get_info(IdEmpresa, IdHorasExtras);
            if (model != null)
                model.lst_nomina_horas_extras = bus_hora_extra_detalle.get_list(model.IdEmpresa, model.IdHorasExtras);
            ro_nomina_x_horas_extras_det_Info_list.set_list(model.lst_nomina_horas_extras);

            return View(model);
        }
        [HttpPost]
        public ActionResult Aprobar(ro_nomina_x_horas_extras_Info model)
        {

            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_horas_extras.aprobacionHE(model))
            {
                cargar_combos(info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
                cargar_combos(model.IdNomina_Tipo, model.IdNomina_TipoLiqui);
                return View(model);
            }
            return RedirectToAction("Index2");

        }
        #endregion
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
        public ActionResult GridViewPartial_horas_extras(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            lst_horas_extras = bus_horas_extras.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_horas_extras", lst_horas_extras);
        }

        [ValidateInput(false)]
        public ActionResult Nuevo()
        {
            cargar_combos(0, 0);
            ro_nomina_x_horas_extras_Info info = new ro_nomina_x_horas_extras_Info();
            info.lst_nomina_horas_extras = new List<ro_nomina_x_horas_extras_det_Info>();
            return View(info);
        }
        [HttpPost]
        public ActionResult Nuevo(ro_nomina_x_horas_extras_Info model)
        {
            if (model == null)
                return View(model);
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"].ToString());
            if (bus_horas_extras.guardarDB(model))
                return RedirectToAction("Index");
            else
            {
                cargar_combos(model.IdNomina_Tipo, model.IdNomina_TipoLiqui);
                return View(model);
            }
        }
        public ActionResult Modificar(int IdNomina_Tipo, int IdNomina_TipoLiqui, int IdPeriodo, int IdHorasExtras)
        {
            cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ro_nomina_x_horas_extras_Info model = new ro_nomina_x_horas_extras_Info();
            model = bus_horas_extras.get_info(IdEmpresa, IdHorasExtras);
            if (model != null)
                model.lst_nomina_horas_extras = bus_hora_extra_detalle.get_list(model.IdEmpresa, model.IdHorasExtras);
            ro_nomina_x_horas_extras_det_Info_list.set_list(model.lst_nomina_horas_extras);

            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(ro_nomina_x_horas_extras_Info model)
        {

            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_horas_extras.modificarDB(model))
            {
                cargar_combos(model.IdNomina_Tipo, model.IdNomina_TipoLiqui);
                return View(model);
            }
            return RedirectToAction("Index");

        }
        public ActionResult Anular(int IdNomina_Tipo, int IdNomina_TipoLiqui, int IdPeriodo, int IdHorasExtras)
        {
            cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ro_nomina_x_horas_extras_Info model = new ro_nomina_x_horas_extras_Info();
            model = bus_horas_extras.get_info(IdEmpresa, IdHorasExtras);
            if (model != null)
                model.lst_nomina_horas_extras = bus_hora_extra_detalle.get_list(model.IdEmpresa, model.IdHorasExtras);
            ro_nomina_x_horas_extras_det_Info_list.set_list(model.lst_nomina_horas_extras);

            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ro_nomina_x_horas_extras_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_horas_extras.anularDB(model))
            {
                cargar_combos(model.IdNomina_Tipo, model.IdNomina_TipoLiqui);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ro_nomina_x_horas_extras_det_Info info_det)
        {
            if (ModelState.IsValid)
                ro_nomina_x_horas_extras_det_Info_list.UpdateRow(info_det);
            ro_nomina_x_horas_extras_Info model = new ro_nomina_x_horas_extras_Info();
            model.lst_nomina_horas_extras = ro_nomina_x_horas_extras_det_Info_list.get_list();
            return PartialView("_GridViewPartial_horas_extras_det", model);

        }

        public ActionResult EditingDelete([ModelBinder(typeof(DevExpressEditorsBinder))] ro_nomina_x_horas_extras_det_Info info_det)
        {
            ro_nomina_x_horas_extras_det_Info_list.DeleteRow(Convert.ToInt32(info_det.Secuencia));
            ro_nomina_x_horas_extras_Info model = new ro_nomina_x_horas_extras_Info();
            model.lst_nomina_horas_extras = ro_nomina_x_horas_extras_det_Info_list.get_list();
            return PartialView("_GridViewPartial_horas_extras_det", model);

        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_horas_extras_det()
        {
            cargar_combos_detalle();
            ro_nomina_x_horas_extras_Info model = new ro_nomina_x_horas_extras_Info();
            model.lst_nomina_horas_extras = ro_nomina_x_horas_extras_det_Info_list.get_list();
            return PartialView("_GridViewPartial_horas_extras_det", model);
        }
        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.lst_horario = bus_horario.get_list(IdEmpresa, false);
        }
        private void cargar_combos(int IdNomina, int IdNominaTipo)
        {
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"].ToString());
            ViewBag.lst_nomina = bus_nomina.get_list(IdEmpresa, false);
            ViewBag.lst_nomina_tipo = bus_nomina_tipo.get_list(IdEmpresa, IdNomina);
            ViewBag.lst_periodo = bus_periodos.get_list(IdEmpresa, IdNomina, IdNominaTipo);

        }


    }

    public class ro_nomina_x_horas_extras_det_Info_list
    {
        string variable = "ro_nomina_x_horas_extras_det_Info";
        public List<ro_nomina_x_horas_extras_det_Info> get_list()
        {
            if (HttpContext.Current.Session[variable] == null)
            {
                List<ro_nomina_x_horas_extras_det_Info> list = new List<ro_nomina_x_horas_extras_det_Info>();

                HttpContext.Current.Session[variable] = list;
            }
            return (List<ro_nomina_x_horas_extras_det_Info>)HttpContext.Current.Session[variable];
        }

        public void set_list(List<ro_nomina_x_horas_extras_det_Info> list)
        {
            HttpContext.Current.Session[variable] = list;
        }

        public void AddRow(ro_nomina_x_horas_extras_det_Info info_det)
        {
            List<ro_nomina_x_horas_extras_det_Info> list = get_list();
            list.Add(info_det);
        }

        public void UpdateRow(ro_nomina_x_horas_extras_det_Info info_det)
        {

            ro_nomina_x_horas_extras_det_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.hora_extra100 = info_det.hora_extra100;
            edited_info.hora_extra50 = info_det.hora_extra50;
            edited_info.hora_extra25 = info_det.hora_extra25;

        }

        public void DeleteRow(int Secuencia)
        {
            List<ro_nomina_x_horas_extras_det_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }

    }
}
