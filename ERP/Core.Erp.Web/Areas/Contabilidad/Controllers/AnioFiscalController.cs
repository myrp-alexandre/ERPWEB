using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;

namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    public class AnioFiscalController : Controller
    {
        ct_anio_fiscal_Bus bus_anio_fiscal = new ct_anio_fiscal_Bus();
        ct_anio_fiscal_x_cuenta_utilidad_Bus bus_aniocta = new ct_anio_fiscal_x_cuenta_utilidad_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_anio_fiscal()
        {
            List<ct_anio_fiscal_Info> model = new List<ct_anio_fiscal_Info>();
            model = bus_anio_fiscal.get_list(true);
            return PartialView("_GridViewPartial_anio_fiscal", model);
        }
        private void cargar_combos()
        {
            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_ctacble = bus_plancta.get_list(Convert.ToInt32(Session["IdEmpresa"]), false, false);
            ViewBag.lst_cuentas = lst_ctacble;
        }
        public ActionResult Nuevo(int IdanioFiscal = 0)
        {
            ct_anio_fiscal_Info model = new ct_anio_fiscal_Info
            {
                info_anio_ctautil = new ct_anio_fiscal_x_cuenta_utilidad_Info()
            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ct_anio_fiscal_Info model)
        {
            if(bus_anio_fiscal.validar_existe_Idanio(model.IdanioFiscal))
            {
                ViewBag.mensaje = "El año ya se encuentra registrado";
                cargar_combos();
                return View(model);
            }

            if(!bus_anio_fiscal.guardarDB(model))
            {
                model.info_anio_ctautil.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
                model.info_anio_ctautil.IdanioFiscal = model.IdanioFiscal;
                bus_aniocta.guardarDB(model.info_anio_ctautil);
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdanioFiscal = 0)
        {
            ct_anio_fiscal_Info model = bus_anio_fiscal.get_info(IdanioFiscal);
            if(model == null)
                return RedirectToAction("Index");
            model.info_anio_ctautil = bus_aniocta.get_info(IdanioFiscal, Convert.ToInt32(Session["IdEmpresa"]));
            if (model.info_anio_ctautil == null)
                model.info_anio_ctautil = new ct_anio_fiscal_x_cuenta_utilidad_Info
                {
                    IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                    IdanioFiscal = model.IdanioFiscal
                };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(ct_anio_fiscal_Info model)
        {
            if(!bus_anio_fiscal.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdanioFiscal = 0)
        {
            ct_anio_fiscal_Info model = bus_anio_fiscal.get_info(IdanioFiscal);
            if(model == null)
                            return RedirectToAction("Index");
                model.info_anio_ctautil = bus_aniocta.get_info(IdanioFiscal, Convert.ToInt32(Session["IdEmpresa"]));
            if(model.info_anio_ctautil == null)
                model.info_anio_ctautil = new ct_anio_fiscal_x_cuenta_utilidad_Info();
            cargar_combos();
            return View(model);
            }

        [HttpPost]
        public ActionResult Anular(ct_anio_fiscal_Info model)
        {
            if(!bus_anio_fiscal.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}