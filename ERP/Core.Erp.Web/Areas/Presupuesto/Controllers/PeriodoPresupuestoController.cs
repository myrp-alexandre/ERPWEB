using Core.Erp.Bus.Presupuesto;
using Core.Erp.Info.Presupuesto;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Presupuesto.Controllers
{
    public class PeriodoPresupuestoController : Controller
    {
        // GET: Presupuesto/PeriodoPresupuesto
        #region Variables
        pre_Periodo_Bus bus_Periodo = new pre_Periodo_Bus();
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_Periodo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<pre_Periodo_Info> model = bus_Periodo.GetList(IdEmpresa, true);
            return PartialView("_GridViewPartial_Periodo", model);
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            pre_Periodo_Info model = new pre_Periodo_Info();
            return View(model);

        }

        [HttpPost]
        public ActionResult Nuevo(pre_Periodo_Info model)
        {
            model.IdUsuarioCreacion = SessionFixed.IdUsuario;
            if (!bus_Periodo.GuardarBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdRubroTipo = 0)
        {
            pre_Periodo_Info model = bus_Periodo.GetInfo(IdEmpresa, IdRubroTipo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(pre_Periodo_Info model)
        {
            model.IdUsuarioModificacion = SessionFixed.IdUsuario;
            if (!bus_Periodo.ModificarBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0, int IdRubroTipo = 0)
        {
            pre_Periodo_Info model = bus_Periodo.GetInfo(IdEmpresa, IdRubroTipo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(pre_Periodo_Info model)
        {
            model.IdUsuarioAnulacion = SessionFixed.IdUsuario;
            if (!bus_Periodo.AnularBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
    }
}