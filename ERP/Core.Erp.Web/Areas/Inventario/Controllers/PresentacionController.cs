using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Inventario;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class PresentacionController : Controller
    {
        in_presentacion_Bus bus_presentacion = new in_presentacion_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_presentacion()
        {
            List<in_presentacion_Info> model = new List<in_presentacion_Info>();
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model = bus_presentacion.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_presentacion", model);
        }

        public ActionResult Nuevo()
        {
            in_presentacion_Info model = new in_presentacion_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_presentacion_Info model)
        {
            if (bus_presentacion.validar_existe_IdPresentacion(model.IdPresentacion))
            {
                ViewBag.mensaje = "El código ya se encuentra registrado";
                return View(model);
            }
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_presentacion.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string IdPresentacion = "")
        {
            in_presentacion_Info model = bus_presentacion.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdPresentacion);
            if(model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(in_presentacion_Info model)
        {
            if(!bus_presentacion.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(string IdPresentacion = "")
        {
            in_presentacion_Info model = bus_presentacion.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdPresentacion);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(in_presentacion_Info model)
        {
            if (!bus_presentacion.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}