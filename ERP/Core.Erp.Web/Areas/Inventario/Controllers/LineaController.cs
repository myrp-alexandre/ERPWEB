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
    public class LineaController : Controller
    {
        in_linea_Bus bus_linea = new in_linea_Bus();
        public ActionResult Index(string IdCategoria = "")
        {
            ViewBag.IdCategoria = IdCategoria;
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_linea(string IdCategoria = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.IdCategoria = IdCategoria;
            List<in_linea_Info> model = bus_linea.get_list(IdEmpresa, IdCategoria, true);
            return PartialView("_GridViewPartial_linea", model);
        }

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            in_categorias_Bus bus_categoria = new in_categorias_Bus();
            var lst_categoria = bus_categoria.get_list(IdEmpresa, false);
            ViewBag.lst_categorias = lst_categoria;
        }
        public ActionResult Nuevo(string IdCategoria = "")
        {
            in_linea_Info model = new in_linea_Info
            {
                IdCategoria = IdCategoria
            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_linea_Info model)
        {
            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_linea.guardarDB(model))
            {
                ViewBag.IdCategoria = model.IdCategoria;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdCategoria = model.IdCategoria });
        }
        public ActionResult Modificar(int IdLinea = 0, string IdCategoria = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_linea_Info model = bus_linea.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdCategoria, IdLinea);
            if (model == null)
            {
                ViewBag.IdCategoria = IdCategoria;
                return RedirectToAction("Index", IdCategoria = model.IdCategoria);
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(in_linea_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_linea.modificarDB(model))
            {
                ViewBag.IdCategoria = model.IdCategoria;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdCategoria = model.IdCategoria });
        }
        public ActionResult Anular(int IdLinea = 0, string IdCategoria = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_linea_Info model = bus_linea.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdCategoria, IdLinea);
            if (model == null)
            {
                ViewBag.IdCategoria = IdCategoria;
                return RedirectToAction("Index", IdCategoria = model.IdCategoria);
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(in_linea_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            if (!bus_linea.anularDB(model))
            {
                ViewBag.IdCategoria = model.IdCategoria;
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index", new { IdCategoria = model.IdCategoria });
        }
    }
}