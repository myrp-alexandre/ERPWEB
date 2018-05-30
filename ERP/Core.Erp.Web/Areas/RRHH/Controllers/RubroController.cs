using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.RRHH;
using Core.Erp.Bus.RRHH;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.Contabilidad;
namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class RubroController : Controller
    {
        List<ro_catalogo_Info> lst_tipo_rubro = new List<ro_catalogo_Info>();
        List<ro_catalogo_Info> lst_tipo_campo = new List<ro_catalogo_Info>();
        List<ro_catalogo_Info> lst_grupo = new List<ro_catalogo_Info>();
        ro_catalogo_Bus bus_catalogo = new ro_catalogo_Bus();
        ro_rubro_tipo_Bus bus_rubro = new ro_rubro_tipo_Bus();
        List<ct_plancta_Info> lst_plancuenta = new List<ct_plancta_Info>();
        Bus.Contabilidad.ct_plancta_Bus bus_plancuenta = new Bus.Contabilidad.ct_plancta_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_rubro()
        {
            try
            {
                List<ro_rubro_tipo_Info> model = bus_rubro.get_list(GetIdEmpresa(), true);
                return PartialView("_GridViewPartial_rubro", model);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Nuevo(ro_rubro_tipo_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    info.IdEmpresa = GetIdEmpresa();
                    if (!bus_rubro.guardarDB(info))
                    {
                        cargar_combo();
                        return View(info);
                    }
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
                ro_rubro_tipo_Info info = new ro_rubro_tipo_Info();
                cargar_combo();
                return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Modificar(ro_rubro_tipo_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (!bus_rubro.modificarDB(info))
                    {
                        cargar_combo();
                        return View(info);
                    }
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

        public ActionResult Modificar(string IdRubro )
        {
            try
            {
                cargar_combo();
                return View(bus_rubro.get_info(GetIdEmpresa(), IdRubro));

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]

        public ActionResult Anular(ro_rubro_tipo_Info info)
        {
            try
            {
                    if (!bus_rubro.anularDB(info))
                    {
                        cargar_combo();
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
        public ActionResult Anular(string IdRubro )
        {
            try
            {
                cargar_combo();
                return View(bus_rubro.get_info(GetIdEmpresa(), IdRubro));

            }
            catch (Exception)
            {

                throw;
            }
        }

        private void cargar_combo()
        {
            try
            {
                lst_tipo_rubro = bus_catalogo.get_list_x_tipo(22);
                lst_tipo_campo = bus_catalogo.get_list_x_tipo(13);
                lst_grupo = bus_catalogo.get_list_x_tipo(14);
                lst_plancuenta = bus_plancuenta.get_list(GetIdEmpresa(), false, true);

                ViewBag.lst_tipo_rubro = lst_tipo_rubro;
                ViewBag.lst_tipo_campo = lst_tipo_campo;
                ViewBag.lst_grupo = lst_grupo;
                ViewBag.lst_plancuenta = lst_plancuenta;

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