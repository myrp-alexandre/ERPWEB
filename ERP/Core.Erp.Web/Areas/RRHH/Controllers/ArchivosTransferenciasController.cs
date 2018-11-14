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
    public class ArchivosTransferenciasController : Controller
    {
        #region Variables
        ro_archivos_bancos_generacion_Bus bus_archivo = new ro_archivos_bancos_generacion_Bus();
        ro_nomina_tipo_Bus bus_nomina = new ro_nomina_tipo_Bus();
        ro_Nomina_Tipoliquiliqui_Bus bus_nomina_tipo = new ro_Nomina_Tipoliquiliqui_Bus();
        ro_archivos_bancos_generacion_x_empleado_Bus bus_archivo_detalle = new ro_archivos_bancos_generacion_x_empleado_Bus();
        ro_archivos_bancos_generacion_x_empleado_list_Info ro_archivos_bancos_generacion_x_empleado_list_Info = new ro_archivos_bancos_generacion_x_empleado_list_Info();
        ro_rubro_tipo_Bus bus_rubro = new ro_rubro_tipo_Bus();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();
      

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

            var model = bus_archivo.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin, true);
            return PartialView("_GridViewPartial_empleado_novedad", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_empleado_novedad_det(int IdEmpleado = 0, decimal IdArchivo = 0)
        {
            int IdEmpresa = Convert.ToInt32( SessionFixed.IdEmpresa);
            ro_archivos_bancos_generacion_Info model = new ro_archivos_bancos_generacion_Info();
            model.detalle = bus_archivo_detalle.get_list(IdEmpresa, IdArchivo);
            if (model.detalle.Count == 0)
                model.detalle = ro_archivos_bancos_generacion_x_empleado_list_Info.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            return PartialView("_GridViewPartial_empleado_novedad_det", model);
        }
        #endregion

        #region acciones
        public ActionResult Nuevo()
        {

            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            ro_archivos_bancos_generacion_Info model = new ro_archivos_bancos_generacion_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                 
            };
            ro_archivos_bancos_generacion_x_empleado_list_Info.set_list(new List<ro_archivos_bancos_generacion_x_empleado_Info>(),Convert.ToDecimal( SessionFixed.IdTransaccionSession));
            cargar_combos(0);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ro_archivos_bancos_generacion_Info model)
        {



            model.detalle = ro_archivos_bancos_generacion_x_empleado_list_Info.get_list(model.IdTransaccionSession);
            if (model.detalle == null || model.detalle.Count() == 0)
            {
                ViewBag.mensaje = "No existe detalle para la el archivo";
                cargar_combos(model.IdNomina);
                return View(model);
            }

         

            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.IdUsuario = SessionFixed.IdUsuario;
            if (!bus_archivo.guardarDB(model))
            {
                cargar_combos(model.IdNomina);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpleado, decimal IdArchivo)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ro_archivos_bancos_generacion_Info model = bus_archivo.get_info(IdEmpresa, IdArchivo);
            if (model == null)
                return RedirectToAction("Index");
            model.detalle = bus_archivo_detalle.get_list(IdEmpresa, IdArchivo);
            ro_archivos_bancos_generacion_x_empleado_list_Info.set_list(model.detalle, Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            cargar_combos(model.IdNomina);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(ro_archivos_bancos_generacion_Info model)
        {
            model.detalle = ro_archivos_bancos_generacion_x_empleado_list_Info.get_list(model.IdTransaccionSession);
            if (model.detalle == null || model.detalle.Count() == 0)
            {
                ViewBag.mensaje = "No existe detalle para la planificación";
                cargar_combos(model.IdNomina);
                return View(model);
            }
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_archivo.modificarDB(model))
            {
                cargar_combos(model.IdNomina);
                return View(model);
            }
            return RedirectToAction("Index");

        }

        public ActionResult Anular(int IdEmpleado, decimal IdArchivo)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ro_archivos_bancos_generacion_Info model = bus_archivo.get_info(IdEmpresa, IdArchivo);
            if (model == null)
                return RedirectToAction("Index");
            model.detalle = bus_archivo_detalle.get_list(IdEmpresa, IdArchivo);
            ro_archivos_bancos_generacion_x_empleado_list_Info.set_list(model.detalle, Convert.ToDecimal(SessionFixed.IdTransaccionSession));
            cargar_combos(model.IdNomina);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ro_archivos_bancos_generacion_Info model)
        {
            model.detalle = ro_archivos_bancos_generacion_x_empleado_list_Info.get_list(model.IdTransaccionSession);

            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            model.Fecha_UltAnu = DateTime.Now;
            if (!bus_archivo.anularDB(model))
            {
                cargar_combos(model.IdNomina);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion

        #region cargar combos

        private void cargar_combos(int IdNomina)
        {
            IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.lst_nomina = bus_nomina.get_list(IdEmpresa, false);
            ViewBag.lst_nomina_tipo = bus_nomina_tipo.get_list(IdEmpresa, IdNomina);
        }
        #endregion

        #region funciones del detalle
       
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ro_archivos_bancos_generacion_x_empleado_Info info_det)
        {
            if (ModelState.IsValid)
                ro_archivos_bancos_generacion_x_empleado_list_Info.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            ro_archivos_bancos_generacion_Info model = new ro_archivos_bancos_generacion_Info();
            model.detalle = ro_archivos_bancos_generacion_x_empleado_list_Info.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_empleado_novedad_det", model);
        }

        public ActionResult EditingDelete([ModelBinder(typeof(DevExpressEditorsBinder))] ro_archivos_bancos_generacion_x_empleado_Info info_det)
        {
            ro_archivos_bancos_generacion_x_empleado_list_Info.DeleteRow(info_det.IdEmpleado, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            ro_archivos_bancos_generacion_Info model = new ro_archivos_bancos_generacion_Info();
            model.detalle = ro_archivos_bancos_generacion_x_empleado_list_Info.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_empleado_novedad_det", model);
        }
        #endregion
       


    }


    public class ro_archivos_bancos_generacion_x_empleado_list_Info
    {
        string variable = "ro_archivos_bancos_generacion_x_empleado_Info";
        public List<ro_archivos_bancos_generacion_x_empleado_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[variable+IdTransaccionSession.ToString()] == null)
            {
                List<ro_empleado_novedad_det_Info> list = new List<ro_empleado_novedad_det_Info>();

                HttpContext.Current.Session[variable+IdTransaccionSession.ToString()] = list;
            }
            return (List<ro_archivos_bancos_generacion_x_empleado_Info>)HttpContext.Current.Session[variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<ro_archivos_bancos_generacion_x_empleado_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
        }

        public void UpdateRow(ro_archivos_bancos_generacion_x_empleado_Info info_det, decimal IdTransaccionSession)
        {
            ro_archivos_bancos_generacion_x_empleado_Info edited_info = get_list(IdTransaccionSession).Where(m => m.IdEmpleado == info_det.IdEmpleado).First();
            edited_info.Valor = info_det.Valor;
           

        }


        public void DeleteRow(decimal IdEmpleado, decimal IdTransaccionSession)
        {
            List<ro_archivos_bancos_generacion_x_empleado_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.IdEmpleado == IdEmpleado).First());
        }
    }
}