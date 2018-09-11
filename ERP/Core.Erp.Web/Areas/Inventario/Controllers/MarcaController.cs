using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Inventario;
using Core.Erp.Web.Helps;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    [SessionTimeout]
    public class MarcaController : Controller
    {
        #region Index
        in_Marca_Bus bus_marca = new in_Marca_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_marca()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_marca.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_marca", model);
        }

        #endregion
        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            in_Marca_Info model = new in_Marca_Info
            {
                IdEmpresa = IdEmpresa
            };
            return View();
        }

        [HttpPost]
        public ActionResult Nuevo(in_Marca_Info model)
        {
            if(!bus_marca.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , int IdMarca = 0)
        {
            in_Marca_Info model = bus_marca.get_info(IdEmpresa, IdMarca);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(in_Marca_Info model)
        {
            if (!bus_marca.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0 , int IdMarca = 0)
        {
            in_Marca_Info model = bus_marca.get_info(IdEmpresa, IdMarca);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(in_Marca_Info model)
        {
            if (bus_marca.si_esta_en_uso(model.IdEmpresa, model.IdMarca))
            {
                ViewBag.mensaje = "El registro " + model.Descripcion + ", esta en uso en productos";
                return View(model);
            }
            if (!bus_marca.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion
    }
}