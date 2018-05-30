using Core.Erp.Bus.Caja;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Info.Caja;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Caja.Controllers
{
    public class CajaController : Controller
    {
        caj_Caja_Bus bus_caja = new caj_Caja_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_caja()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<caj_Caja_Info> model = bus_caja.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_caja", model);
        }

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_cuentas = bus_plancta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuentas = lst_cuentas;

            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_responsable = bus_caja.get_list(IdEmpresa, false);
            ViewBag.lst_responsable = lst_responsable;
        }

        public ActionResult Nuevo()
        {
            caj_Caja_Info model = new caj_Caja_Info();
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(caj_Caja_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_caja.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdCaja = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            caj_Caja_Info model = bus_caja.get_info(IdEmpresa, IdCaja);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(caj_Caja_Info model)
        {
            if (!bus_caja.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdCaja = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            caj_Caja_Info model = bus_caja.get_info(IdEmpresa, IdCaja);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(caj_Caja_Info model)
        {
            if (!bus_caja.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}