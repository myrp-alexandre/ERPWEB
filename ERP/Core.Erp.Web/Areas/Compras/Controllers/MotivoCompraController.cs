using Core.Erp.Bus.Compras;
using Core.Erp.Info.Compras;
using Core.Erp.Web.Helps;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Compras.Controllers
{
    [SessionTimeout]

    public class MotivoCompraController : Controller
    {
        #region Index
        com_Motivo_Orden_Compra_Bus bus_motivo = new com_Motivo_Orden_Compra_Bus();
        public ActionResult Index()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_motivocompra()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_motivo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_motivocompra", model);
        }

        #endregion

        #region Acciones

        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            com_Motivo_Orden_Compra_Info model = new com_Motivo_Orden_Compra_Info
            {
                IdEmpresa = IdEmpresa
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(com_Motivo_Orden_Compra_Info model)
        {
            if (!bus_motivo.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0, int IdMotivo = 0)
        {
            com_Motivo_Orden_Compra_Info model = bus_motivo.get_info(IdEmpresa, IdMotivo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(com_Motivo_Orden_Compra_Info model)
        {
            model.IdUsuarioUltMod = SessionFixed.IdUsuario;

            if (!bus_motivo.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, int IdMotivo = 0)
        {
            com_Motivo_Orden_Compra_Info model = bus_motivo.get_info(IdEmpresa, IdMotivo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(com_Motivo_Orden_Compra_Info model)
        {
            model.IdUsuarioUltAnu = SessionFixed.IdUsuario;
            if (!bus_motivo.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
    }
}