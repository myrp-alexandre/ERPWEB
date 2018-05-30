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
    public class DivisionController : Controller
    {
        ro_division_Bus bus_division = new ro_division_Bus();
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
                List<ro_division_Info> model = bus_division.get_list(GetIdEmpresa(), true);
                return PartialView("_GridViewPartial_division", model);
            }
            catch (Exception)
            {

                throw;
            }
        }

        [HttpPost]
        public ActionResult Nuevo(ro_division_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    info.IdEmpresa = GetIdEmpresa();
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
                ro_division_Info info = new ro_division_Info();
                return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }

        [HttpPost]
        public ActionResult Modificar(ro_division_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (!bus_division.modificarDB(info))
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
        public ActionResult Modificar(int IdDivision = 0)
        {
            try
            {

                return View(bus_division.get_info(GetIdEmpresa(), IdDivision));

            }
            catch (Exception)
            {

                throw;
            }
        }

        [HttpPost]
        public ActionResult Anular(ro_division_Info info)
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
        public ActionResult Anular(int IdDivision = 0)
        {
            try
            {

                return View(bus_division.get_info(GetIdEmpresa(), IdDivision));

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