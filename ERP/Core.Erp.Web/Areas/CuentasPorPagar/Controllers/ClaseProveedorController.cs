using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Bus.Contabilidad;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class ClaseProveedorController : Controller
    {
        cp_proveedor_clase_Bus bus_clase_proveedor = new cp_proveedor_clase_Bus();

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_clase_proveedor()
        {
            List<cp_proveedor_clase_Info> model = new List<cp_proveedor_clase_Info>();
           
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model = bus_clase_proveedor.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_clase_proveedor", model);
        }
        private void cargar_combos()
        {
            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_ctacble = bus_plancta.get_list(Convert.ToInt32(Session["IdEmpresa"]), false, false);
            ViewBag.lst_cuentas = lst_ctacble;
        }

        public ActionResult Nuevo(int IdClaseProveedor = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cargar_combos();
            cp_proveedor_clase_Info model = new cp_proveedor_clase_Info();
            model.cod_clase_proveedor = bus_clase_proveedor.get_id(IdEmpresa).ToString();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_proveedor_clase_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_clase_proveedor.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdClaseProveedor = 0)
        {
            cp_proveedor_clase_Info model = bus_clase_proveedor.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdClaseProveedor);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_proveedor_clase_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_clase_proveedor.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdClaseProveedor = 0)
        {
            cp_proveedor_clase_Info model = bus_clase_proveedor.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdClaseProveedor);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(cp_proveedor_clase_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_clase_proveedor.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}