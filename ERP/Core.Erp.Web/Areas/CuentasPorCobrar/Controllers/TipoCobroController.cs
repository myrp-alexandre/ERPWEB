using Core.Erp.Bus.CuentasPorCobrar;
using Core.Erp.Info.CuentasPorCobrar;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class TipoCobroController : Controller
    {
        cxc_cobro_tipo_Bus bus_tipocobro = new cxc_cobro_tipo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipocobro()
        {
            List<cxc_cobro_tipo_Info> model = new List<cxc_cobro_tipo_Info>();
            model = bus_tipocobro.get_list(true);
            return PartialView("_GridViewPartial_tipocobro", model);
        }

        private void cargar_combos()
        {
            cxc_cobro_tipo_motivo_Bus bus_motivocobro = new cxc_cobro_tipo_motivo_Bus();
            var lst_motivo_cobro = bus_motivocobro.get_list();
            ViewBag.lst_motivo_cobro = lst_motivo_cobro;

            cxc_CatalogoTipo_Bus bus_catalogotipo = new cxc_CatalogoTipo_Bus();
            var lst_catalogotipo = bus_catalogotipo.get_list();
            ViewBag.lst_catalogotipo = lst_catalogotipo;

            Dictionary<string, string> lst_cta = new Dictionary<string, string>();
            lst_cta.Add("CAJA", "CAJA");
            lst_cta.Add("TIPO_COBRO", "TIPO COBRO");
            ViewBag.lst_cta = lst_cta;
        }
        public ActionResult Nuevo()
        {
            cxc_cobro_tipo_Info model = new cxc_cobro_tipo_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cxc_cobro_tipo_Info model)
        {
            if (bus_tipocobro.validar_existe_IdCobro_tipo(model.IdCobro_tipo))
            {
                ViewBag.mensaje = "El codigo ya se encuentra registrado";
                cargar_combos();
                return View(model);
            }
            if (!bus_tipocobro.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(string IdCobro_tipo = "")
        {
            cxc_cobro_tipo_Info model = bus_tipocobro.get_info(IdCobro_tipo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(cxc_cobro_tipo_Info model)
        {
            if (!bus_tipocobro.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(string IdCobro_tipo = "")
        {
            cxc_cobro_tipo_Info model = bus_tipocobro.get_info(IdCobro_tipo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(cxc_cobro_tipo_Info model)
        {
            if (!bus_tipocobro.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}