using DevExpress.Web.Mvc;
using Core.Erp.Bus.Presupuesto;
using Core.Erp.Info.Presupuesto;
using Core.Erp.Web.Helps;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Presupuesto
{
    public class RubroController : Controller
    {
        // GET: Presupuesto/Rubro
        #region Variables
        pre_rubro_Bus bus_Rubro = new pre_rubro_Bus();
        #endregion

        #region Index
        public ActionResult Index(int IdEmpresa)
        {
            ViewBag.IdEmpresa = IdEmpresa;
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_Rubro(int IdEmpresa = 0)
        {
            ViewBag.IdEmpresa = IdEmpresa;
            List<pre_rubro_Info> model = bus_Rubro.GetList(IdEmpresa, true);
            return PartialView("_GridViewPartial_Rubro", model);
        }
        #endregion



        #region Acciones
        public ActionResult Nuevo()
        {
            pre_rubro_Info model = new pre_rubro_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(pre_rubro_Info model)
        {
            model.IdUsuario = SessionFixed.IdUsuario;
            if (!bus_Rubro.GuardarBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdRubro = 0)
        {
            pre_rubro_Info model = bus_Rubro.GetInfo(IdRubro);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(pre_rubro_Info model)
        {
            model.IdUsuarioModificacion = SessionFixed.IdUsuario;
            if (!bus_Rubro.ModificarBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdRubro = 0)
        {
            pre_rubro_Info model = bus_Rubro.GetInfo(IdRubro);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(pre_rubro_Info model)
        {
            model.IdUsuarioModificacion = SessionFixed.IdUsuario;
            if (!bus_Rubro.AnularBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion
    }
}