using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using Core.Erp.Bus.Contabilidad;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class BodegaController : Controller
    {
        tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
        public ActionResult Index(int IdSucursal = 0)
        {
            ViewBag.IdSucursal = IdSucursal;
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_bodega(int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.IdSucursal = IdSucursal;
            List<tb_bodega_Info> model = bus_bodega.get_list(IdEmpresa, IdSucursal, true);
            return PartialView("_GridViewPartial_bodega", model);
        }

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_cuentas = bus_plancta.get_list(IdEmpresa, false, true);
            ViewBag.lst_cuentas = lst_cuentas;

        }

        public ActionResult Nuevo(int IdSucursal = 0)
        {
            tb_bodega_Info model = new tb_bodega_Info { IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]), IdSucursal = IdSucursal };
            ViewBag.IdSucursal = IdSucursal;
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(tb_bodega_Info model)
        {            
            if (!bus_bodega.guardarDB(model))
            {
                ViewBag.IdSucursal = model.IdSucursal;
                cargar_combos();
                return View(model);
            }

            return RedirectToAction("Index",new { IdSucursal = model.IdSucursal});
        }

        public ActionResult Modificar(int IdSucursal = 0, int IdBodega = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_bodega_Info model = bus_bodega.get_info(IdEmpresa, IdSucursal, IdBodega);
            if (model == null)
                return RedirectToAction("Index", new { IdSucursal = IdSucursal });
            ViewBag.IdSucursal = IdSucursal;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(tb_bodega_Info model)
        {
            if (!bus_bodega.modificarDB(model))
            {
                ViewBag.IdSucursal = model.IdSucursal;
                cargar_combos();
                return View(model);
            }

            return RedirectToAction("Index", new { IdSucursal = model.IdSucursal });
        }

        public ActionResult Anular(int IdSucursal = 0, int IdBodega = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_bodega_Info model = bus_bodega.get_info(IdEmpresa, IdSucursal, IdBodega);
            if (model == null)
                return RedirectToAction("Index", new { IdSucursal = IdSucursal });
            ViewBag.IdSucursal = IdSucursal;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(tb_bodega_Info model)
        {
            if (!bus_bodega.anularDB(model))
            {
                ViewBag.IdSucursal = model.IdSucursal;
                cargar_combos();
                return View(model);
            }

            return RedirectToAction("Index", new { IdSucursal = model.IdSucursal });
        }
    }
}