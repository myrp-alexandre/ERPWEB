using Core.Erp.Bus.Banco;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Info.Banco;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Banco.Controllers
{
    [SessionTimeout]
    public class BancoCuentaController : Controller
    {
        #region Variables
        ba_Banco_Cuenta_Bus bus_cuenta = new ba_Banco_Cuenta_Bus();
        tb_banco_Bus bus_banco = new tb_banco_Bus();
        ct_plancta_Bus bus_cuentacontable = new ct_plancta_Bus();
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cuentas()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_cuenta.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_cuentas", model);
        }
        #endregion

        #region Metodos
        private void cargar_combos(int IdEmpresa)
        {

            Dictionary<string, string> lst_cta = new Dictionary<string, string>();
            lst_cta.Add("cuenta de ahorro", "Cuenta de ahorro");
            lst_cta.Add("cuenta corriente", "Cuenta corriente");
            ViewBag.lst_cta = lst_cta;

            Dictionary<bool, string> lst_impresion = new Dictionary<bool, string>();
            lst_impresion.Add(true, "solo cheque");
            lst_impresion.Add(false, "Cheque y comprobante");
            ViewBag.lst_impresion = lst_impresion;

            var lst_banco = bus_banco.get_list(false);
            ViewBag.lst_banco = lst_banco;

            var lst_cuenta = bus_cuentacontable.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuenta = lst_cuenta;
        }

        #endregion

        #region Acciones

        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            ba_Banco_Cuenta_Info model = new ba_Banco_Cuenta_Info
            {
                IdEmpresa = IdEmpresa
            };
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ba_Banco_Cuenta_Info model)
        {
            if (!bus_cuenta.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0, int IdBanco = 0)

        {
            ba_Banco_Cuenta_Info model = bus_cuenta.get_info(IdEmpresa,IdBanco);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(ba_Banco_Cuenta_Info model)
        {
            if (!bus_cuenta.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, int IdBanco = 0)
        {
            ba_Banco_Cuenta_Info model = bus_cuenta.get_info(IdEmpresa, IdBanco);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ba_Banco_Cuenta_Info model)
        {
            if (!bus_cuenta.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
    }
}