using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.RRHH;
using Core.Erp.Bus.RRHH;
using DevExpress.Web.Mvc;

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
        int IdEmpresa = 0;
        #endregion



        #region aprobacion horas extras
        public ActionResult Index2()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_aprobacion_horas_extras()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"].ToString());
            lst_horas_extras = bus_horas_extras.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_aprobacion_horas_extras", lst_horas_extras);
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_aprobacion_horas_extras_det(int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0, int IdHorasExtras = 0)
        {
            cargar_combos_detalle();
            info = new ro_nomina_x_horas_extras_Info();
            info.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"].ToString());
            info.IdHorasExtras = IdHorasExtras;
            info.lst_nomina_horas_extras = bus_hora_extra_detalle.get_list_x_extado_aprobacion(info.IdEmpresa, info.IdHorasExtras, false);
            if (info.lst_nomina_horas_extras.Count() > 0)
                Session["ro_nomina_x_horas_extras_det_Info"] = info.lst_nomina_horas_extras;
            else
            {
                info.lst_nomina_horas_extras = Session["ro_nomina_x_horas_extras_det_Info"] as List<ro_nomina_x_horas_extras_det_Info>;
                if (info.lst_nomina_horas_extras == null)
                    info.lst_nomina_horas_extras = new List<ro_nomina_x_horas_extras_det_Info>();
            }

            return PartialView("_GridViewPartial_aprobacion_horas_extras_det", info);
        }

        public ActionResult Aprobar(int IdNomina_Tipo, int IdNomina_TipoLiqui, int IdPeriodo, int IdHorasExtras)
        {
            cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            return View(bus_horas_extras.get_info(IdEmpresa, IdHorasExtras));
        }
        [HttpPost]
        public ActionResult Aprobar(ro_nomina_x_horas_extras_Info model)
        {

            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_horas_extras.aprobacionHE(model))
            {
                cargar_combos(info.IdNomina_Tipo,info.IdNomina_TipoLiqui);
                cargar_combos(model.IdNomina_Tipo, model.IdNomina_TipoLiqui);
                return View(model);
            }
            return RedirectToAction("Index2");

        }
        #endregion
        public ActionResult Index()
        {
            return View();
        }
      
        [ValidateInput(false)]
        public ActionResult GridViewPartial_horas_extras()
        {
            int IdEmpresa=Convert.ToInt32( Session["IdEmpresa"].ToString());
            lst_horas_extras = bus_horas_extras.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_horas_extras", lst_horas_extras);
        }
     
        [ValidateInput(false)]
        public ActionResult Nuevo()
        {
            cargar_combos(0,0);
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
        public ActionResult Modificar(int IdNomina_Tipo,int IdNomina_TipoLiqui, int IdPeriodo, int IdHorasExtras)
        {
            cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            return View(bus_horas_extras.get_info(IdEmpresa, IdHorasExtras));
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
            return View(bus_horas_extras.get_info(IdEmpresa, IdHorasExtras));
        }
        [HttpPost]
        public ActionResult Anular(ro_nomina_x_horas_extras_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_horas_extras.anularDB(model))
            {
                cargar_combos(model.IdNomina_Tipo,model.IdNomina_TipoLiqui);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        [ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ro_nomina_x_horas_extras_det_Info info_det)
        {
            return PartialView("_GridViewPartial_horas_extras_det", info);

        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ro_nomina_x_horas_extras_det_Info info_det)
        {
            return PartialView("_GridViewPartial_horas_extras_det", info);

        }

        public ActionResult EditingDelete([ModelBinder(typeof(DevExpressEditorsBinder))] ro_nomina_x_horas_extras_det_Info info_det)
        {
            return PartialView("_GridViewPartial_horas_extras_det", info);

        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_horas_extras_det(int IdNomina_Tipo=0,int IdNomina_TipoLiqui = 0, int IdPeriodo = 0, int IdHorasExtras = 0)
        {
            cargar_combos_detalle();
            info = new ro_nomina_x_horas_extras_Info();
            info.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"].ToString());
            info.IdHorasExtras = IdHorasExtras;
            info.lst_nomina_horas_extras = bus_hora_extra_detalle.get_list(info.IdEmpresa, info.IdHorasExtras);
            if ( info.lst_nomina_horas_extras.Count() > 0)
                Session["ro_nomina_x_horas_extras_det_Info"] = info.lst_nomina_horas_extras;
            else
            {
                info.lst_nomina_horas_extras = Session["ro_nomina_x_horas_extras_det_Info"] as List<ro_nomina_x_horas_extras_det_Info>;
                if (info.lst_nomina_horas_extras == null)
                    info.lst_nomina_horas_extras = new List<ro_nomina_x_horas_extras_det_Info>();
            }
           
            return PartialView("_GridViewPartial_horas_extras_det", info);
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

}
