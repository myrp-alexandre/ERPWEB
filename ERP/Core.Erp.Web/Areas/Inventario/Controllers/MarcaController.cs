using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Inventario;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class MarcaController : Controller
    {
        in_Marca_Bus bus_marca = new in_Marca_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_marca()
        {
            List<in_Marca_Info> model = new List<in_Marca_Info>();
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model = bus_marca.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_marca", model);
        }

        public ActionResult Nuevo()
        {
            in_Marca_Info model = new in_Marca_Info();
            return View();
        }

        [HttpPost]
        public ActionResult Nuevo(in_Marca_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if(!bus_marca.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdMarca = 0)
        {
            in_Marca_Info model = bus_marca.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdMarca);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(in_Marca_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

         
            if (!bus_marca.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdMarca = 0)
        {
            in_Marca_Info model = bus_marca.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdMarca);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(in_Marca_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
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
    }
}