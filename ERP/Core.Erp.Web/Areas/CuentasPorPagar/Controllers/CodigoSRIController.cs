using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Bus.Contabilidad;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class CodigoSRIController : Controller
    {
        cp_codigo_SRI_Bus bus_codigo_sri = new cp_codigo_SRI_Bus();
        cp_codigo_SRI_tipo_Bus bus_tipo_codigo = new cp_codigo_SRI_tipo_Bus();
        cp_codigo_SRI_x_CtaCble_Bus bus_codigo_ctacble = new cp_codigo_SRI_x_CtaCble_Bus();
        public ActionResult Index(string IdTipoSRI = "")
        {
            ViewBag.IdTipoSRI = IdTipoSRI;
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_codigo_sri(string IdTipoSRI = "")
        {
            List<cp_codigo_SRI_Info> model = new List<cp_codigo_SRI_Info>();
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model = bus_codigo_sri.get_list(IdTipoSRI, true);
            ViewBag.IdTipoSRI = IdTipoSRI;
            return PartialView("_GridViewPartial_codigo_sri", model);
        }

        private void cargar_combos()
        {
            var lst_codigo_tipo = bus_tipo_codigo.get_list(true);
            ViewBag.lst_tipo = lst_codigo_tipo;

            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_ctacble = bus_plancta.get_list(Convert.ToInt32(Session["IdEmpresa"]), false, false);
            ViewBag.lst_cuentas = lst_ctacble;

        }

        public ActionResult Nuevo(string IdTipoSRI = "")
        {
            cp_codigo_SRI_Info model = new cp_codigo_SRI_Info
            {
                co_f_valides_desde = DateTime.Now.AddYears(-100),
                co_f_valides_hasta = DateTime.Now.AddYears(100),
                info_codigo_ctacble = new cp_codigo_SRI_x_CtaCble_Info()

            };
            ViewBag.IdTipoSRI = IdTipoSRI;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_codigo_SRI_Info model)
        {
            if(!bus_codigo_sri.guardarDB(model))
            {
                if (!string.IsNullOrEmpty(model.info_codigo_ctacble.IdCtaCble))
                {
                    model.info_codigo_ctacble.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
                    model.info_codigo_ctacble.idCodigo_SRI = model.IdCodigo_SRI;
                    bus_codigo_ctacble.guardarDB(model.info_codigo_ctacble);
                }                
                return RedirectToAction("Index", new { IdTipoSRI = model.IdTipoSRI });
            }
            return RedirectToAction("Index", new { IdTipoSRI = model.IdTipoSRI });
        }

        public ActionResult Modificar(int IdCodigo_SRI = 0)
        {
            cp_codigo_SRI_Info model = bus_codigo_sri.get_info(IdCodigo_SRI);
            if (model == null)
            {
                return RedirectToAction("Index", new { IdTipoSRI = model.IdTipoSRI });
            }
            model.info_codigo_ctacble = bus_codigo_ctacble.get_info(IdCodigo_SRI, Convert.ToInt32(Session["IdEmpresa"]));
            if (model.info_codigo_ctacble == null)
                model.info_codigo_ctacble = new cp_codigo_SRI_x_CtaCble_Info
                {
                    IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                    idCodigo_SRI = model.IdCodigo_SRI
                };
            ViewBag.IdTipoSRI = model.IdTipoSRI;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_codigo_SRI_Info model)
        {
            if(!bus_codigo_sri.modificarDB(model))
            {
                cargar_combos();
                ViewBag.IdTipoSRI = model.IdTipoSRI;
                return View(model);
            }
            bus_codigo_ctacble.eliminarDB(model.IdCodigo_SRI, model.info_codigo_ctacble.IdEmpresa);
            if (!string.IsNullOrEmpty(model.info_codigo_ctacble.IdCtaCble))
                bus_codigo_ctacble.guardarDB(model.info_codigo_ctacble);
            return RedirectToAction("Index", new { IdTipoSRI = model.IdTipoSRI });
        }

        public ActionResult Anular(int IdCodigo_SRI = 0, string IdTipoSRI = "")
        {
            cp_codigo_SRI_Info model = bus_codigo_sri.get_info(IdCodigo_SRI);
            if(model == null)
            {
                return RedirectToAction("Index", new { IdTipoSRI = IdTipoSRI });
            }
            model.info_codigo_ctacble = bus_codigo_ctacble.get_info(IdCodigo_SRI, Convert.ToInt32(Session["IdEmpresa"]));
            if(model.info_codigo_ctacble == null)
                model.info_codigo_ctacble = new cp_codigo_SRI_x_CtaCble_Info
                {
                    IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                    idCodigo_SRI = model.IdCodigo_SRI
                };
            ViewBag.IdTipoSRI = IdTipoSRI;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(cp_codigo_SRI_Info model)
        {
            if (!bus_codigo_sri.anularDB(model))
            {
                cargar_combos();
                ViewBag.IdTipoSRI = model.IdTipoSRI;
                return View(model);
            }
            return RedirectToAction("Index", new { IdTipoSRI = model.IdTipoSRI });
        }
    }
}