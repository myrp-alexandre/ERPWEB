using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Facturacion;
using Core.Erp.Info.Facturacion;
using Core.Erp.Bus.Contabilidad;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class ClienteTipoController : Controller
    {
        fa_cliente_tipo_Bus bus_clientetipo = new fa_cliente_tipo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_clientetipo()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<fa_cliente_tipo_Info> model = bus_clientetipo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_clientetipo", model);
        }
        private void cargar_combos()
        {
            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_ctacble = bus_plancta.get_list(Convert.ToInt32(Session["IdEmpresa"]), false, false);
            ViewBag.lst_cuentas = lst_ctacble;
        }
        public ActionResult Nuevo()
        {
            fa_cliente_tipo_Info model = new fa_cliente_tipo_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(fa_cliente_tipo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_clientetipo.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int Idtipo_cliente = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_cliente_tipo_Info model = bus_clientetipo.get_info(Convert.ToInt32(Session["IdEmpresa"]), Idtipo_cliente);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_cliente_tipo_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_clientetipo.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int Idtipo_cliente = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_cliente_tipo_Info model = bus_clientetipo.get_info(Convert.ToInt32(Session["IdEmpresa"]), Idtipo_cliente);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_cliente_tipo_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            if (!bus_clientetipo.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}