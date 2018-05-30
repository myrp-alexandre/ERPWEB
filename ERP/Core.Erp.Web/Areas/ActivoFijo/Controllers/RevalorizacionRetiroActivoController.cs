using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.ActivoFijo;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    public class RevalorizacionRetiroActivoController : Controller
    {
        Af_Retiro_Activo_Bus bus_retiro = new Af_Retiro_Activo_Bus();

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_retiro_activo()
        {

            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<Af_Retiro_Activo_Info> model = new List<Af_Retiro_Activo_Info>();
            model = bus_retiro.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_retiro_activo", model);
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_Bus bus_fijo = new Af_Activo_fijo_Bus();
            var lst_fijo = bus_fijo.get_list(IdEmpresa, false);
            ViewBag.lst_fijo = lst_fijo;

            ct_cbtecble_Bus bus_cbte = new ct_cbtecble_Bus();
            var lst_cbte = bus_cbte.get_list(IdEmpresa, false);
            ViewBag.lst_cbte = lst_cbte;

            ct_cbtecble_tipo_Bus bus_tipo = new ct_cbtecble_tipo_Bus();
            var lst_tipo = bus_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;

        }
        public ActionResult Nuevo()
        {
            Af_Retiro_Activo_Info model = new Af_Retiro_Activo_Info
            {

                Fecha_Retiro = DateTime.Now
            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Retiro_Activo_Info model)
        {
            model.IdUsuario = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_retiro.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(decimal IdRetiroActivo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Retiro_Activo_Info model = bus_retiro.get_info(IdEmpresa, IdRetiroActivo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(Af_Retiro_Activo_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_retiro.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(decimal IdRetiroActivo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Retiro_Activo_Info model = bus_retiro.get_info(IdEmpresa, IdRetiroActivo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(Af_Retiro_Activo_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            if (!bus_retiro.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}