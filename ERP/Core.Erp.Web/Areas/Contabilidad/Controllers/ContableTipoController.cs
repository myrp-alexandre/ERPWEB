using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;

namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    public class ContableTipoController : Controller
    {
        ct_cbtecble_tipo_Bus bus_contable_tipo = new ct_cbtecble_tipo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_contable_tipo()
        {
            List<ct_cbtecble_tipo_Info> model = new List<ct_cbtecble_tipo_Info>();
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model = bus_contable_tipo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_contable_tipo", model);
        }

        public ActionResult Nuevo()
        {
            ct_cbtecble_tipo_Info model = new ct_cbtecble_tipo_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ct_cbtecble_tipo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_contable_tipo.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdTipoCbte = 0)
        {
            ct_cbtecble_tipo_Info model = bus_contable_tipo.get_info(IdTipoCbte);
            if (model == null)
                return RedirectToAction("Index");
                return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(ct_cbtecble_tipo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_contable_tipo.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdTipoCbte = 0)
        {
            ct_cbtecble_tipo_Info model = bus_contable_tipo.get_info(IdTipoCbte);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ct_cbtecble_tipo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_contable_tipo.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}