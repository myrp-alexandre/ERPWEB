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
    public class GrupoController : Controller
    {
        in_grupo_Bus bus_grupo = new in_grupo_Bus();
        public ActionResult Index(string IdCategoria = "",int IdLinea = 0)
        {
            ViewBag.IdCategoria = IdCategoria;
            ViewBag.IdLinea = IdLinea;
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_grupo(string IdCategoria = "", int IdLinea = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.IdCategoria = IdCategoria;
            ViewBag.IdLinea = IdLinea;
            List<in_grupo_Info> model = bus_grupo.get_list(IdEmpresa,IdCategoria, IdLinea, true);
            return PartialView("_GridViewPartial_grupo", model);
        }
        private void cargar_combos(string IdCategoria)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            in_categorias_Bus bus_categoria = new in_categorias_Bus();
            var lst_categoria = bus_categoria.get_list(IdEmpresa, false);
            ViewBag.lst_categorias = lst_categoria;


            in_linea_Bus bus_linea = new in_linea_Bus();
            var lst_linea = bus_linea.get_list(IdEmpresa, IdCategoria, false);
            ViewBag.lst_lineas = lst_linea;


        }
        
        public ActionResult Nuevo(string IdCategoria ="", int IdLinea = 0)
        {
            in_grupo_Info model = new in_grupo_Info
            {
                IdCategoria = IdCategoria,
                IdLinea = IdLinea
            };
            cargar_combos(IdCategoria);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_grupo_Info model)
        {
            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_grupo.guardarDB(model))
            {
                ViewBag.IdCategoria = model.IdCategoria;
                ViewBag.IdLinea = model.IdLinea;
                cargar_combos(model.IdCategoria);
                return View(model);
            }
            return RedirectToAction("Index", new { IdCategoria = model.IdCategoria, IdLinea = model.IdLinea });
        }
        public ActionResult Modificar(string IdCategoria="", int IdLinea = 0, int IdGrupo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_grupo_Info model = bus_grupo.get_info(IdEmpresa, IdCategoria, IdLinea, IdGrupo);
            if (model == null)
            {
                ViewBag.IdCategoria = IdCategoria;
                ViewBag.IdLinea = IdLinea;
                return RedirectToAction("Index", new { IdCategoria = model.IdCategoria, IdLinea = model.IdLinea });
            }
            cargar_combos(IdCategoria);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(in_grupo_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_grupo.modificarDB(model))
            {
                ViewBag.IdCategoria = model.IdCategoria;
                ViewBag.IdLinea = model.IdLinea;
                cargar_combos(model.IdCategoria);
                return View(model);
            }
            return RedirectToAction("Index", new { IdCategoria = model.IdCategoria, IdLinea = model.IdLinea });
        }
        public ActionResult Anular(string IdCategoria = "", int IdLinea = 0, int IdGrupo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_grupo_Info model = bus_grupo.get_info(IdEmpresa, IdCategoria, IdLinea, IdGrupo);
            if (model == null)
            {
                ViewBag.IdCategoria = IdCategoria;
                ViewBag.IdLinea = IdLinea;
                return RedirectToAction("Index", new { IdCategoria = model.IdCategoria, IdLinea = model.IdLinea });
            }
            cargar_combos(IdCategoria);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(in_grupo_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_grupo.anularDB(model))
            {
                ViewBag.IdCategoria = model.IdCategoria;
                ViewBag.IdLinea = model.IdLinea;
                cargar_combos(model.IdCategoria);
                return View(model);
            }
            return RedirectToAction("Index", new { IdCategoria = model.IdCategoria, IdLinea = model.IdLinea });
        }
    }
}