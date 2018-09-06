using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.RRHH;
using Core.Erp.Info.RRHH;
using Core.Erp.Web.Helps;
using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using DevExpress.Web;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class EmpleadoRubroAcumuladoController : Controller
    {
        #region variables
        ro_empleado_x_rubro_acumulado_Bus bus_rubro_acumulados = new ro_empleado_x_rubro_acumulado_Bus();
        ro_rubro_tipo_Bus bus_rubro = new ro_rubro_tipo_Bus();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();
        #endregion

        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbEmpleado_rubros_acumulados()
        {
            ro_rubro_acumulados_Info model = new ro_rubro_acumulados_Info();
            return PartialView("_CmbEmpleado_rubros_acumulados", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        #endregion

        #region vistas
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_rubros_acumulados(decimal IdEmpleado = 0)
        {
            try
            {
                int  IdEmpresa= Convert.ToInt32(SessionFixed.IdEmpresa);
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
        #endregion

        #region acciones
        [HttpPost]
        public ActionResult Nuevo(ro_empleado_x_rubro_acumulado_Info info)
        {
            try
            {

                ViewBag.IdEmpleado = info.IdEmpleado;
                info.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
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
                info.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
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
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                return View(bus_rubro_acumulados.get_info(IdEmpresa, Idempleado, IdRubro));

            }
            catch (Exception)
            {

                throw;
            }
        }

        #endregion
        private void cargar_combos()
        {
            try
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                ViewBag.lst_rubro = bus_rubro.get_list_rub_acumula(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }
       
    }
}