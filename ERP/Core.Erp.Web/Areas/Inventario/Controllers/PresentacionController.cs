using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Inventario;
using Core.Erp.Web.Helps;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    [SessionTimeout]
    public class PresentacionController : Controller
    {
        #region Index / metodos
        in_presentacion_Bus bus_presentacion = new in_presentacion_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_presentacion()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_presentacion.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_presentacion", model);
        }

        #endregion
        #region Acciones

        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            in_presentacion_Info model = new in_presentacion_Info
            {
                IdEmpresa = IdEmpresa
            };
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
            if (!bus_presentacion.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , string IdPresentacion = "")
        {
            in_presentacion_Info model = bus_presentacion.get_info(IdEmpresa, IdPresentacion);
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
        public ActionResult Anular(int IdEmpresa = 0 , string IdPresentacion = "")
        {
            in_presentacion_Info model = bus_presentacion.get_info(IdEmpresa, IdPresentacion);
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
        #endregion
    }
}