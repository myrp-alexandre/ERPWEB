using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.RRHH;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class EmpleadoRubroAcumuladoController : Controller
    {
        ro_empleado_x_rubro_acumulado_Bus bus_rubro_acumulados = new ro_empleado_x_rubro_acumulado_Bus();
        ro_rubro_tipo_Bus bus_rubro = new ro_rubro_tipo_Bus();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();
        int IdEmpresa = 0;
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_rubros_acumulados(decimal IdEmpleado = 0)
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                ViewBag.IdEmpleado = IdEmpleado;
                bus_rubro_acumulados = new ro_empleado_x_rubro_acumulado_Bus();
                List<ro_empleado_x_rubro_acumulado_Info> model = bus_rubro_acumulados.get_list(IdEmpresa);
                return PartialView("_GridViewPartial_rubros_acumulados", model);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Nuevo(ro_empleado_x_rubro_acumulado_Info info)
        {
            try
            {

                ViewBag.IdEmpleado = info.IdEmpleado;
                IdEmpresa = GetIdEmpresa();
                info.IdEmpresa = IdEmpresa;
                info.UsuarioIngresa = Session["IdUsuario"].ToString();
                if (ModelState.IsValid)
                {
                    if (!bus_rubro_acumulados.guardarDB(info))
                    {
                        cargar_combos();
                        return View(info);
                    }
                    else
                        return RedirectToAction("Index", new { IdEmpleado = info.IdEmpleado });

                }
                else
                    return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult Nuevo(int IdEmpleado = 0)
        {
            try
            {
                ro_empleado_x_rubro_acumulado_Info model = new ro_empleado_x_rubro_acumulado_Info
                {
                    IdEmpleado = IdEmpleado
                };
                ViewBag.IdEmpleado = IdEmpleado;
                cargar_combos();
                return View(model);

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
     
        public ActionResult Anular(ro_empleado_x_rubro_acumulado_Info info)
        {
            try
            {
                info.IdEmpresa = GetIdEmpresa();
                if (!bus_rubro_acumulados.anularDB(info))
                {
                    cargar_combos();
                    return View(info);
                }
                else
                    return RedirectToAction("Index");


            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult Anular(decimal Idempleado = 0, string IdRubro = "")
        {
            try
            {
                cargar_combos();
                IdEmpresa = GetIdEmpresa();
                return View(bus_rubro_acumulados.get_info(IdEmpresa, Idempleado, IdRubro));

            }
            catch (Exception)
            {

                throw;
            }
        }

        private void cargar_combos()
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                ViewBag.lst_rubro = bus_rubro.get_list_rub_acumula(IdEmpresa);
                ViewBag.lst_empleado = bus_empleado.get_list_combo(IdEmpresa);
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

    }
}