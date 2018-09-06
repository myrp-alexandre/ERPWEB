using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Web.Helps;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    [SessionTimeout]
    public class PuntoCargoController : Controller
    {
        #region Index
        ct_punto_cargo_Bus bus_comprobante_tipo = new ct_punto_cargo_Bus();
        int IdEmpresa;

        public ActionResult Index()
        {
            return View();
        }

        #endregion
        #region Acciones
        public ActionResult Nuevo()
        {
            ct_punto_cargo_Info model = new ct_punto_cargo_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ct_punto_cargo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_comprobante_tipo.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdPuntoCargo = 0)
        {
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            ct_punto_cargo_Info model = bus_comprobante_tipo.get_info(IdEmpresa, IdPuntoCargo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(ct_punto_cargo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_comprobante_tipo.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdPuntoCargo = 0)
        {
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_punto_cargo_Info model = bus_comprobante_tipo.get_info(IdEmpresa, IdPuntoCargo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ct_punto_cargo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_comprobante_tipo.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion
    }
}