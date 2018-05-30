
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
    public class SubgrupoController : Controller
    {
        in_subgrupo_Bus bus_subgrupo = new in_subgrupo_Bus();
        public ActionResult Index(string IdCategoria = "", int IdLinea = 0, int IdGrupo = 0)
        {
            ViewBag.IdCategoria = IdCategoria;
            ViewBag.IdLinea = IdLinea;
            ViewBag.IdGrupo = IdGrupo;
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_subgrupo(string IdCategoria = "", int IdLinea = 0, int IdGrupo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.IdCategoria = IdCategoria;
            ViewBag.IdLinea = IdLinea;
            ViewBag.IdGrupo = IdGrupo;
            List<in_subgrupo_Info> model = bus_subgrupo.get_list(IdEmpresa, IdCategoria, IdLinea, IdGrupo, true);
            return PartialView("_GridViewPartial_subgrupo", model);
        }
        private void cargar_combos(string IdCategoria, int IdLinea)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_categorias_Bus bus_categoria = new in_categorias_Bus();
            var lst_categoria = bus_categoria.get_list(IdEmpresa, true);
            ViewBag.lst_categorias = lst_categoria;


            in_linea_Bus bus_linea = new in_linea_Bus();
            var lst_linea = bus_linea.get_list(IdEmpresa, IdCategoria, true);
            ViewBag.lst_lineas = lst_linea;

            in_grupo_Bus bus_grupo = new in_grupo_Bus();
            var lst_grupo = bus_grupo.get_list(IdEmpresa, IdCategoria, IdLinea, true);
            ViewBag.lst_grupos = lst_grupo;
        }

        public ActionResult Nuevo(string IdCategoria = "", int IdLinea = 0, int IdGrupo = 0)
        {
            in_subgrupo_Info model = new in_subgrupo_Info
            {
                IdCategoria = IdCategoria,
                IdLinea = IdLinea,
                IdGrupo = IdGrupo
            };
            cargar_combos(IdCategoria, IdLinea);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_subgrupo_Info model)
        {
            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if(!bus_subgrupo.guardarDB(model))
            {
                ViewBag.IdCategoria = model.IdCategoria;
                ViewBag.IdLinea = model.IdLinea;
                ViewBag.IdGrupo = model.IdGrupo;
                cargar_combos(model.IdCategoria, model.IdLinea);
                return View(model);
            }
            return RedirectToAction("Index", new { IdCategoria = model.IdCategoria, IdLinea = model.IdLinea, IdGrupo = model.IdGrupo });
        }

        public ActionResult Modificar(string IdCategoria = "", int IdLinea = 0, int IdGrupo = 0, int IdSubgrupo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_subgrupo_Info model = bus_subgrupo.get_info(IdEmpresa, IdCategoria, IdLinea, IdGrupo, IdSubgrupo);
            if(model==null)
            {
                ViewBag.IdCategoria = IdCategoria;
                ViewBag.IdLinea = IdLinea;
                ViewBag.IdGrupo = IdGrupo;
                return RedirectToAction("Index", new { IdCategoria = model.IdCategoria, IdLinea = model.IdLinea,IdGrupo = model.IdGrupo});
            }
            cargar_combos(IdCategoria, IdLinea);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(in_subgrupo_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_subgrupo.modificarDB(model))
            {
                ViewBag.IdCategoria = model.IdCategoria;
                ViewBag.IdLinea = model.IdLinea;
                ViewBag.IdGrupo = model.IdGrupo;
                cargar_combos(model.IdCategoria, model.IdLinea);
                return View(model);
            }
            return RedirectToAction("Index", new { IdCategoria = model.IdCategoria, IdLinea = model.IdLinea, IdGrupo = model.IdGrupo });
        }

        public ActionResult Anular(string IdCategoria = "", int IdLinea = 0, int IdGrupo = 0, int IdSubgrupo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_subgrupo_Info model = bus_subgrupo.get_info(IdEmpresa, IdCategoria, IdLinea, IdGrupo, IdSubgrupo);
            if (model == null)
            {
                ViewBag.IdCategoria = IdCategoria;
                ViewBag.IdLinea = IdLinea;
                ViewBag.IdGrupo = IdGrupo;
                return RedirectToAction("Index", new { IdCategoria = model.IdCategoria, IdLinea = model.IdLinea, IdGrupo = model.IdGrupo });
            }
            cargar_combos(IdCategoria, IdLinea);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(in_subgrupo_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_subgrupo.anularDB(model))
            {
                ViewBag.IdCategoria = model.IdCategoria;
                ViewBag.IdLinea = model.IdLinea;
                ViewBag.IdGrupo = model.IdGrupo;
                cargar_combos(model.IdCategoria, model.IdLinea);
                return View(model);
            }
            return RedirectToAction("Index", new { IdCategoria = model.IdCategoria, IdLinea = model.IdLinea, IdGrupo = model.IdGrupo });
        }
    }
}