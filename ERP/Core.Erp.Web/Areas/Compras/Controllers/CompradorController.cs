using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Compras;
using Core.Erp.Web.Helps;
using Core.Erp.Bus.SeguridadAcceso;
using Core.Erp.Info.Compras;

namespace Core.Erp.Web.Areas.Compras.Controllers
{
    public class CompradorController : Controller
    {
        com_comprador_Bus bus_comprador = new com_comprador_Bus();
        seg_usuario_Bus bus_usuario = new seg_usuario_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_comprador()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_comprador.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_comprador", model);
        }

        private void cargar_combos()
        {
            var lst_usuario = bus_usuario.get_list(false);
            ViewBag.lst_usuario = lst_usuario;
        }

        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            com_comprador_Info model = new com_comprador_Info
            {
                IdEmpresa = IdEmpresa
            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(com_comprador_Info model)
        {
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_comprador.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0, decimal IdComprador = 0)
        {
            com_comprador_Info model = bus_comprador.get_info(IdEmpresa, IdComprador);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(com_comprador_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();

            if (!bus_comprador.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, decimal IdComprador = 0)
        {
            com_comprador_Info model = bus_comprador.get_info(IdEmpresa, IdComprador);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(com_comprador_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();

            if (!bus_comprador.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}