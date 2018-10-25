using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Banco;
using Core.Erp.Info.Banco;
using Core.Erp.Web.Helps;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Areas.Banco.Controllers
{
    public class TipoFlujoBancoController : Controller
    {
        ba_TipoFlujo_Bus bus_flujo = new ba_TipoFlujo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipo_flujo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_flujo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_tipo_flujo", model);
        }

        private void cargar_combo(int IdEmpresa)
        {
            var lst_tipo = bus_flujo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;

            Dictionary<string, string> lst_tip = new Dictionary<string, string>();
            lst_tip.Add(cl_enumeradores.eTipoIngEgr.ING.ToString(), "Ingreso");
            lst_tip.Add(cl_enumeradores.eTipoIngEgr.EGR.ToString(), "Egreso");
            ViewBag.lst_tip = lst_tip;
        }
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            ba_TipoFlujo_Info model = new ba_TipoFlujo_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa)
            };
            cargar_combo(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(ba_TipoFlujo_Info model)
        {
            if(!bus_flujo.guardarDB(model))
            {
                cargar_combo(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, decimal IdTipoFlujo = 0)
        {
            ba_TipoFlujo_Info model = bus_flujo.get_info(IdEmpresa, IdTipoFlujo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combo(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(ba_TipoFlujo_Info model)
        {
            if (!bus_flujo.modificarDB(model))
            {
                cargar_combo(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, decimal IdTipoFlujo = 0)
        {
            ba_TipoFlujo_Info model = bus_flujo.get_info(IdEmpresa, IdTipoFlujo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combo(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ba_TipoFlujo_Info model)
        {
            if (!bus_flujo.anularDB(model))
            {
                cargar_combo(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }


    }
}