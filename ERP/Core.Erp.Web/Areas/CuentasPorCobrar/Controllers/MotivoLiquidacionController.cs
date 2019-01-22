using Core.Erp.Bus.CuentasPorCobrar;
using Core.Erp.Info.CuentasPorCobrar;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class MotivoLiquidacionController : Controller
    {
        cxc_MotivoLiquidacionTarjeta_Bus bus_motivo = new cxc_MotivoLiquidacionTarjeta_Bus();
        public ActionResult Index()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_catalogotipocxc()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_motivo.GetList(IdEmpresa, true);
            return PartialView("_GridViewPartial_catalogotipocxc", model);
        }
        public ActionResult Nuevo()
        {
            cxc_MotivoLiquidacionTarjeta_Info model = new cxc_MotivoLiquidacionTarjeta_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa)
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(cxc_MotivoLiquidacionTarjeta_Info model)
        {
            if (!bus_motivo.GuardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0 , decimal IdMotivo = 0)
        {
            cxc_MotivoLiquidacionTarjeta_Info model = bus_motivo.GEtInfo(IdEmpresa, IdMotivo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(cxc_MotivoLiquidacionTarjeta_Info model)
        {
            if (!bus_motivo.ModificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, decimal IdMotivo = 0)
        {
            cxc_MotivoLiquidacionTarjeta_Info model = bus_motivo.GEtInfo(IdEmpresa, IdMotivo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(cxc_MotivoLiquidacionTarjeta_Info model)
        {
            if (!bus_motivo.AnularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}