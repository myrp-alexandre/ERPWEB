using Core.Erp.Bus.Caja;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Caja;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Caja.Controllers
{
    public class TipoMovimientoCajaController : Controller
    {
        caj_Caja_Movimiento_Tipo_Bus bus_tipomovimiento = new caj_Caja_Movimiento_Tipo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipomovimientocaja()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<caj_Caja_Movimiento_Tipo_Info> model = bus_tipomovimiento.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_tipomovimientocaja", model);
        }

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_cuentas = bus_plancta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuentas = lst_cuentas;

            Dictionary<string, string> lst_signo = new Dictionary<string, string>();
            lst_signo.Add("+", "+");
            lst_signo.Add("-", "-");
            ViewBag.lst_signo = lst_signo;
        }

        public ActionResult Nuevo()
        {
            caj_Caja_Movimiento_Tipo_Info model = new caj_Caja_Movimiento_Tipo_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(caj_Caja_Movimiento_Tipo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_tipomovimiento.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdTipoMovi = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            caj_Caja_Movimiento_Tipo_Info model = bus_tipomovimiento.get_info(IdEmpresa, IdTipoMovi);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(caj_Caja_Movimiento_Tipo_Info model)
        {
            if (!bus_tipomovimiento.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdTipoMovi = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            caj_Caja_Movimiento_Tipo_Info model = bus_tipomovimiento.get_info(IdEmpresa, IdTipoMovi);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(caj_Caja_Movimiento_Tipo_Info model)
        {
            if (!bus_tipomovimiento.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}