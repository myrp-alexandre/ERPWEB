using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Inventario;
using Core.Erp.Bus.Contabilidad;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class CategoriaController : Controller
    {
        in_categorias_Bus bus_categoria = new in_categorias_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_categoria()
        {
            List<in_categorias_Info> model = new List<in_categorias_Info>();
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model = bus_categoria.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_categoria", model);
        }
        private void cargar_combos()
        {
            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_ctacble = bus_plancta.get_list(Convert.ToInt32(Session["IdEmpresa"]), false, false);
            ViewBag.lst_cuentas = lst_ctacble;
        }

        public ActionResult Nuevo()
        {
            in_categorias_Info model = new in_categorias_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_categorias_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (bus_categoria.validar_existe_IdCategoria(Convert.ToInt32(Session["IdEmpresa"]), model.IdCategoria))
            {
                ViewBag.mensaje = "El id ya se encuentra registrado";
                cargar_combos();
                return View(model);
            }
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_categoria.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
            }
        public ActionResult Modificar(string IdCategoria = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_categorias_Info model = bus_categoria.get_info(Convert.ToInt32(Session["IdEmpresa"]),IdCategoria);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(in_categorias_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_categoria.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(string IdCategoria = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_categorias_Info model = bus_categoria.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdCategoria);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(in_categorias_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            if (!bus_categoria.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}