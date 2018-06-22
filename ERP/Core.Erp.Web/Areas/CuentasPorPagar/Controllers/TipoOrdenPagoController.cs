using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Bus.Contabilidad;
namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class TipoOrdenPagoController : Controller
    {


        cp_orden_pago_tipo_x_empresa_Bus bus_tipo_op = new cp_orden_pago_tipo_x_empresa_Bus();
        ct_plancta_Bus bus_pla_cuenta = new ct_plancta_Bus();
        ct_cbtecble_tipo_Bus bus_tipo_comprobante = new ct_cbtecble_tipo_Bus();
        cp_orden_pago_estado_aprob_Bus bus_estado_op = new cp_orden_pago_estado_aprob_Bus();
        int IdEmpresa = 0;
        public ActionResult Index()
        {
            return View();
        }

      
        public ActionResult Nuevo()
        {
            cargar_combos();
            cp_orden_pago_tipo_x_empresa_Info model = new cp_orden_pago_tipo_x_empresa_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_orden_pago_tipo_x_empresa_Info model)
        {
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdEmpresa = IdEmpresa;
            if (bus_tipo_op.si_existe(model))
            {
                cargar_combos();

                ViewBag.mensaje = "El código ya se encuentra registrado";
                return View(model);
            }

            if (!bus_tipo_op.guardarDB(model))
            {
                cargar_combos();

                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string IdTipo_op = "")
        {
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cargar_combos();
            cp_orden_pago_tipo_x_empresa_Info model = bus_tipo_op.get_info(IdEmpresa, IdTipo_op);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_orden_pago_tipo_x_empresa_Info model)
        {
            if (!bus_tipo_op.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(string IdTipo_op = "")
        {
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            cargar_combos();
            cp_orden_pago_tipo_x_empresa_Info model = bus_tipo_op.get_info(IdEmpresa, IdTipo_op);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(cp_orden_pago_tipo_x_empresa_Info model)
        {
            if (!bus_tipo_op.anularDB(model))
            {
                cargar_combos();

                return View(model);
            }
            return RedirectToAction("Index");
        }

        private void cargar_combos()
        {
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.lst_tipo_comprobante = bus_tipo_comprobante.get_list(IdEmpresa, false);
            ViewBag.lst_cuenta_contable = bus_pla_cuenta.get_list(IdEmpresa, false, true);
            ViewBag.lst_estado = bus_estado_op.get_list();
        }


        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipo_orden_pago()
        {
            bus_tipo_op = new cp_orden_pago_tipo_x_empresa_Bus();
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<cp_orden_pago_tipo_x_empresa_Info> model = new List<cp_orden_pago_tipo_x_empresa_Info>();
            model = bus_tipo_op.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_tipo_orden_pago", model);
        }
    }
}