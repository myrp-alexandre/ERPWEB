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
    public class ProcesarRolController : Controller
    {
        #region variables
        List<ro_nomina_tipo_Info> lista_nomina = new List<ro_nomina_tipo_Info>();
        ro_nomina_tipo_Bus bus_nomina = new ro_nomina_tipo_Bus();
        ro_Nomina_Tipoliquiliqui_Bus bus_nomina_tipo = new ro_Nomina_Tipoliquiliqui_Bus();
        List<ro_Nomina_Tipoliqui_Info> lst_nomina_tipo = new List<ro_Nomina_Tipoliqui_Info>();
        ro_periodo_x_ro_Nomina_TipoLiqui_Bus bus_periodos_x_nomina = new ro_periodo_x_ro_Nomina_TipoLiqui_Bus();
        List<ro_periodo_x_ro_Nomina_TipoLiqui_Info> lst_periodos = new List<ro_periodo_x_ro_Nomina_TipoLiqui_Info>();
        ro_rol_Bus bus_rol = new ro_rol_Bus();
        int IdEmpresa = 0;
        #endregion


        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_ro_rol()
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                List< ro_rol_Info> model = bus_rol.get_list(IdEmpresa);
                return PartialView("_GridViewPartial_ro_rol", model);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Nuevo( ro_rol_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    info.UsuarioIngresa = Session["IdUsuario"].ToString();
                    info.IdEmpresa = GetIdEmpresa();
                    if (!bus_rol.procesar(info))
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
                cargar_combos(0, 0);
                 ro_rol_Info info = new  ro_rol_Info();
                return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Modificar(ro_rol_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    info.IdEmpresa = GetIdEmpresa();
                    if (!bus_rol.procesar(info))
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
        public ActionResult Modificar( int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo=0)
        {
            try
            { 
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                IdEmpresa = GetIdEmpresa();
                return View(bus_rol.get_info(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo));

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

        private void cargar_combos(int IdNomina_Tipo, int IdNomina_Tipo_Liqui)
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                lista_nomina = bus_nomina.get_list(IdEmpresa, false);
                lst_nomina_tipo = bus_nomina_tipo.get_list(IdEmpresa, IdNomina_Tipo);
                lst_periodos = bus_periodos_x_nomina.get_list(IdEmpresa, IdNomina_Tipo, IdNomina_Tipo_Liqui);
                ViewBag.lst_nomina = lista_nomina;
                ViewBag.lst_nomina_tipo = lst_nomina_tipo;
                ViewBag.lst_periodos = lst_periodos;

            }
            catch (Exception)
            {

                throw;
            }
        }



       
    }
}