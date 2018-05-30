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
    public class RubrosCalculadosController : Controller
    {
        ro_rubros_calculados_Bus bus_cargo = new ro_rubros_calculados_Bus();
        int IdEmpresa = 0;
        ro_rubro_tipo_Bus bus_rubro = new ro_rubro_tipo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_rubros_calculados()
        {
            try
            {
                cargar_combos();
                IdEmpresa = GetIdEmpresa();
                List<ro_rubros_calculados_Info> model = bus_cargo.get_list(IdEmpresa, true);
                return PartialView("_GridViewPartial_rubros_calculados", model);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Nuevo(ro_rubros_calculados_Info info)
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
                cargar_combos();
                ro_rubros_calculados_Info info = new ro_rubros_calculados_Info();
                return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Modificar(ro_rubros_calculados_Info info)
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

        public ActionResult Modificar(int IdArea = 0)
        {
            try
            {
                cargar_combos();
                IdEmpresa = GetIdEmpresa();
                return View(bus_cargo.get_info(IdEmpresa));

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

        private void cargar_combos()
        {
            try
            {
                ViewBag.lst_rubro = bus_rubro.get_list(GetIdEmpresa(), false);
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}