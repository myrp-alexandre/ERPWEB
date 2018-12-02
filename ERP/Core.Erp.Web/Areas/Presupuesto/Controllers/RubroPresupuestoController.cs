using DevExpress.Web.Mvc;
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
    public class RubroPresupuestoController : Controller
    {
        #region Variables
        pre_rubro_Bus bus_Rubro = new pre_rubro_Bus();
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_Rubro()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
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

        //[ValidateInput(false)]
        //public ActionResult GridViewPartial()
        //{
        //    var model = new object[0];
        //    return PartialView("_GridViewPartial", model);
        //}

        //[HttpPost, ValidateInput(false)]
        //public ActionResult GridViewPartialAddNew(Core.Erp.Info.RRHH.ro_area_Info item)
        //{
        //    var model = new object[0];
        //    if (ModelState.IsValid)
        //    {
        //        try
        //        {
        //            // Insert here a code to insert the new item in your model
        //        }
        //        catch (Exception e)
        //        {
        //            ViewData["EditError"] = e.Message;
        //        }
        //    }
        //    else
        //        ViewData["EditError"] = "Please, correct all errors.";
        //    return PartialView("_GridViewPartial", model);
        //}
        //[HttpPost, ValidateInput(false)]
        //public ActionResult GridViewPartialUpdate(Core.Erp.Info.RRHH.ro_area_Info item)
        //{
        //    var model = new object[0];
        //    if (ModelState.IsValid)
        //    {
        //        try
        //        {
        //            // Insert here a code to update the item in your model
        //        }
        //        catch (Exception e)
        //        {
        //            ViewData["EditError"] = e.Message;
        //        }
        //    }
        //    else
        //        ViewData["EditError"] = "Please, correct all errors.";
        //    return PartialView("_GridViewPartial", model);
        //}
        //[HttpPost, ValidateInput(false)]
        //public ActionResult GridViewPartialDelete(System.Int32 IdArea)
        //{
        //    var model = new object[0];
        //    if (IdArea >= 0)
        //    {
        //        try
        //        {
        //            // Insert here a code to delete the item from your model
        //        }
        //        catch (Exception e)
        //        {
        //            ViewData["EditError"] = e.Message;
        //        }
        //    }
        //    return PartialView("_GridViewPartial", model);
        //}
    }
}