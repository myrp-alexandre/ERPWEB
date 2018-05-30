using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.RRHH;
using Core.Erp.Bus.RRHH;
namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class VacacionesController : Controller
    {
        ro_historico_vacaciones_x_empleado_Bus bus_vacaciones = new ro_historico_vacaciones_x_empleado_Bus();
        List<ro_historico_vacaciones_x_empleado_Info> lst_vacaciones = new List<ro_historico_vacaciones_x_empleado_Info>();
        ro_Solicitud_Vacaciones_x_empleado_Bus bus_cargo = new ro_Solicitud_Vacaciones_x_empleado_Bus();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();

        int IdEmpresa = 0;
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_solicitud_vacaciones()
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                List<ro_Solicitud_Vacaciones_x_empleado_Info> model = bus_cargo.get_list(IdEmpresa, true);
                return PartialView("_GridViewPartial_solicitud_vacaciones", model);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Nuevo(ro_Solicitud_Vacaciones_x_empleado_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    info.IdEmpresa = GetIdEmpresa();
                    if (!bus_cargo.guardarDB(info))
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
                ro_Solicitud_Vacaciones_x_empleado_Info info = new ro_Solicitud_Vacaciones_x_empleado_Info
                {
                    Fecha_Desde = DateTime.Now,
                    Fecha_Hasta = DateTime.Now
                };
                cargar_combo();
                return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Modificar(ro_Solicitud_Vacaciones_x_empleado_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (!bus_cargo.modificarDB(info))
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

        public ActionResult Modificar(int IdSolicitud = 0)
        {
            try
            {
                return View(bus_cargo.get_info(GetIdEmpresa(), IdSolicitud));

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]

        public ActionResult Anular(ro_Solicitud_Vacaciones_x_empleado_Info info)
        {
            try
            {

                if (!bus_cargo.anularDB(info))
                    return View(info);
                else
                    return RedirectToAction("Index");


            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult Anular(int IdSolicitud = 0)
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                return View(bus_cargo.get_info(IdEmpresa, IdSolicitud));

            }
            catch (Exception)
            {

                throw;
            }
        }
        private int GetIdEmpresa()
        {
            try
            {
                if (Session["IdEmpresa"] != null)
                    return Convert.ToInt32(Session["IdEmpresa"]);
                else
                    return 0;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void cargar_combo()
        {
            IdEmpresa = GetIdEmpresa();
            ViewBag.lst_empleado = bus_empleado.get_list_combo(IdEmpresa);
            ViewBag.lst_vacaciones = lst_vacaciones;
        }
        public ActionResult get_list_vacaciones(decimal IdEmpleado)
        {
            IdEmpresa = GetIdEmpresa();
            lst_vacaciones = bus_vacaciones.get_lst_vaciones_x_empleado(IdEmpresa, IdEmpleado);
            Session["lst_vacaciones"]=lst_vacaciones;
            return Json("", JsonRequestBehavior.AllowGet);
        }


        [ValidateInput(false)]
        public ActionResult GridLookupPartial_vacaciones()
        {
            lst_vacaciones = Session["lst_vacaciones"] as List<ro_historico_vacaciones_x_empleado_Info>;
            return ViewBag.lst_vacaciones;
        // return  ViewBag. lst_vacaciones;
        }

    }
}