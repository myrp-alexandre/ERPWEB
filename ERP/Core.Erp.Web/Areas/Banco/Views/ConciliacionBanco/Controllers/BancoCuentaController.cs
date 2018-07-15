using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Banco;
using Core.Erp.Info.Banco;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;


namespace Core.Erp.Web.Areas.Banco.Controllers
{
    public class BancoCuentaController : Controller
    {
        ba_Banco_Cuenta_Bus bus_cuenta = new ba_Banco_Cuenta_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cuentas()
        {
            List<ba_Banco_Cuenta_Info> model = new List<ba_Banco_Cuenta_Info>();
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model = bus_cuenta.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_cuentas", model);
        }

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            Dictionary<string, string> lst_cta = new Dictionary<string, string>();
            lst_cta.Add("cuenta de ahorro", "Cuenta de ahorro");
            lst_cta.Add("cuenta corriente", "Cuenta corriente");
            ViewBag.lst_cta = lst_cta;

            Dictionary<bool, string> lst_impresion = new Dictionary<bool, string>();
            lst_impresion.Add(true , "solo cheque");
            lst_impresion.Add(false, "Cheque y comprobante");
            ViewBag.lst_impresion = lst_impresion;

            tb_banco_Bus bus_banco = new tb_banco_Bus();
            var lst_banco = bus_banco.get_list(false);
            ViewBag.lst_banco = lst_banco;

            ct_plancta_Bus bus_cuentacontable = new ct_plancta_Bus();
            var lst_cuenta = bus_cuentacontable.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuenta = lst_cuenta;
        }
        public ActionResult Nuevo()
        {
            ba_Banco_Cuenta_Info model = new ba_Banco_Cuenta_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ba_Banco_Cuenta_Info model)
        {
            if (!bus_cuenta.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdBanco = 0)

        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ba_Banco_Cuenta_Info model = bus_cuenta.get_info(IdEmpresa,IdBanco);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(ba_Banco_Cuenta_Info model)
        {
            if (!bus_cuenta.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdBanco = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ba_Banco_Cuenta_Info model = bus_cuenta.get_info(IdEmpresa, IdBanco);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ba_Banco_Cuenta_Info model)
        {
            if (!bus_cuenta.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}