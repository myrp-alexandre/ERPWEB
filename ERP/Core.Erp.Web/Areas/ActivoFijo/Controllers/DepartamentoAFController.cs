using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.ActivoFijo;
using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    public class DepartamentoAFController : Controller
    {
        Af_Departamento_Bus bus_dep = new Af_Departamento_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_departamento_af()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_dep.GetList(IdEmpresa, true);
            return PartialView("_GridViewPartial_departamento_af", model);
        }

        #region Acciones
        public ActionResult Nuevo()
        {
            Af_Departamento_Info model = new Af_Departamento_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(Af_Departamento_Info model)
        {
            if (!bus_dep.GuardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 ,decimal IdDepartamento = 0)
        {
            Af_Departamento_Info model = bus_dep.GetInfo(IdEmpresa, IdDepartamento);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(Af_Departamento_Info model)
        {
            if (!bus_dep.ModificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, decimal IdDepartamento = 0)
        {
            Af_Departamento_Info model = bus_dep.GetInfo(IdEmpresa, IdDepartamento);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(Af_Departamento_Info model)
        {
            if (!bus_dep.AnularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion

    }
}