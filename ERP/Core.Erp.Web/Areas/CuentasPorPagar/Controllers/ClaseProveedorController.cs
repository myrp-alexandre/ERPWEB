using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Web.Helps;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    [SessionTimeout]
    public class ClaseProveedorController : Controller
    {
        #region Variable
        cp_proveedor_clase_Bus bus_clase_proveedor = new cp_proveedor_clase_Bus();
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();

        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_clase_proveedor()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_clase_proveedor.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_clase_proveedor", model);
        }
        private void cargar_combos()
        {
            var lst_ctacble = bus_plancta.get_list(Convert.ToInt32(Session["IdEmpresa"]), false, true);
            ViewBag.lst_cuentas = lst_ctacble;
        }

        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0, int IdClaseProveedor = 0)
        {
            cp_proveedor_clase_Info model = new cp_proveedor_clase_Info
            {
                IdEmpresa = IdEmpresa
            };
            model.cod_clase_proveedor = bus_clase_proveedor.get_id(IdEmpresa).ToString();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_proveedor_clase_Info model)
        {
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

        #endregion
    }
}