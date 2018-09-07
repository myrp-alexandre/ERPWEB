using Core.Erp.Bus.RRHH;
using Core.Erp.Info.RRHH;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class ProyeccionDeGastosController : Controller
    {
        ro_empleado_x_Proyeccion_Gastos_Personales_Bus bus_division = new ro_empleado_x_Proyeccion_Gastos_Personales_Bus();
        // GET: RRHH/Division
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_division()
        {
            try
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                List<ro_empleado_x_Proyeccion_Gastos_Personales_Info> model = bus_division.get_list(IdEmpresa);
                return PartialView("_GridViewPartial_base_impuesto_renta", model);
            }
            catch (Exception)
            {

                throw;
            }
        }

        [HttpPost]
        public ActionResult Nuevo(ro_empleado_x_Proyeccion_Gastos_Personales_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                    if (!bus_division.guardarDB(info))
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
                ro_empleado_x_Proyeccion_Gastos_Personales_Info info = new ro_empleado_x_Proyeccion_Gastos_Personales_Info();
                return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }

        [HttpPost]
        public ActionResult Modificar(ro_empleado_x_Proyeccion_Gastos_Personales_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (!bus_division.anularDB(info))
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

                return View(bus_division.get_info(IdEmpresa, IdEmpleado, Anio));

            }
            catch (Exception)
            {

                throw;
            }
        }

        [HttpPost]
        public ActionResult Anular(ro_empleado_x_Proyeccion_Gastos_Personales_Info info)
        {
            try
            {

                if (!bus_division.anularDB(info))
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

                return View(bus_division.get_info(IdEmpresa,IdEmpleado, Anio));

            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}