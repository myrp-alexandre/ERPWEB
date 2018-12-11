using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    [SessionTimeout]
    public class PlanDeCuentasController : Controller
    {
        #region Index
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        public ActionResult Index()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_plancta()
        {
            int IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa);
            List<ct_plancta_Info> model = bus_plancta.get_list(IdEmpresa, true, false);
            return PartialView("_GridViewPartial_plancta", model);
        }
        private void cargar_combos(int IdEmpresa)
        {
            var lst_cuentas = bus_plancta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuentas = lst_cuentas;

            Dictionary<string, string> lst_naturaleza = new Dictionary<string, string>();
            lst_naturaleza.Add("D","Deudora");
            lst_naturaleza.Add("C", "Acreedora");
            ViewBag.lst_naturaleza = lst_naturaleza;

            ct_grupocble_Bus bus_grupo_contable = new ct_grupocble_Bus();
            var lst_grupo_contabe = bus_grupo_contable.get_list(false);
            ViewBag.lst_grupo_contabe = lst_grupo_contabe;
        }

        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            ct_plancta_Info model = new ct_plancta_Info
            {
                IdEmpresa = IdEmpresa
            };
            cargar_combos(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(ct_plancta_Info model)
        {
            if (bus_plancta.validar_existe_id(model.IdEmpresa,model.IdCtaCble))
            {
                ViewBag.mensaje = "El código de la cuenta ya se encuentra registrado";
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            if (!bus_plancta.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0, string IdCtaCble = "")
        {   
            ct_plancta_Info model = bus_plancta.get_info(IdEmpresa, IdCtaCble);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(ct_plancta_Info model)
        {
            if (!bus_plancta.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, string IdCtaCble = "")
        {
            ct_plancta_Info model = bus_plancta.get_info(IdEmpresa, IdCtaCble);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ct_plancta_Info model)
        {
            if (!bus_plancta.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion

        #region Importacion

        #endregion

        public JsonResult get_info_nuevo(int IdEmpresa = 0, string IdCtaCble_padre = "")
        {
            var resultado = bus_plancta.get_info_nuevo(IdEmpresa, IdCtaCble_padre);
            
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

    }
}