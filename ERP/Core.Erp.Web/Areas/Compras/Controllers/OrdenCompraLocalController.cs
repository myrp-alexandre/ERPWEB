using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Compras;
using Core.Erp.Info.Compras;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.Compras.Controllers
{
    public class OrdenCompraLocalController : Controller
    {
        com_ordencompra_local_Bus bus_ordencompra = new com_ordencompra_local_Bus();

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_ordencompralocal()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_ordencompra.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_ordencompralocal", model);
        }

        private void cargar_combos()
        {

        }

        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            com_ordencompra_local_Info model = new com_ordencompra_local_Info
            {
                IdEmpresa = IdEmpresa
            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(com_ordencompra_local_Info model)
        {
            model.IdUsuario = SessionFixed.IdUsuario;
            if (!bus_ordencompra.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0, int IdSucursal = 0 ,  decimal IdOrdenCompra = 0)
        {
            com_ordencompra_local_Info model = bus_ordencompra.get_info(IdEmpresa, IdSucursal, IdOrdenCompra);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(com_ordencompra_local_Info model)
        {
            model.IdUsuarioUltMod = SessionFixed.IdUsuario;

            if (!bus_ordencompra.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, int IdSucursal = 0, decimal IdOrdenCompra = 0)
        {
            com_ordencompra_local_Info model = bus_ordencompra.get_info(IdEmpresa, IdSucursal, IdOrdenCompra);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(com_ordencompra_local_Info model)
        {
            model.IdUsuarioUltAnu = SessionFixed.IdUsuario;

            if (!bus_ordencompra.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}