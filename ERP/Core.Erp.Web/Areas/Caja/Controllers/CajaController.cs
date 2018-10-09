using Core.Erp.Bus.Caja;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Bus.SeguridadAcceso;
using Core.Erp.Info.Caja;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Caja.Controllers
{
    [SessionTimeout]
    public class CajaController : Controller
    {
        #region Variables
        caj_Caja_Bus bus_caja = new caj_Caja_Bus();
        seg_usuario_Bus bus_usuario = new seg_usuario_Bus();
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();

        #endregion
        #region Metodos ComboBox bajo demanda

        public ActionResult CmbCuenta_Caja()
        {
            caj_Caja_Info model = new caj_Caja_Info();
            return PartialView("_CmbCuenta_Caja", model);
        }
        public List<ct_plancta_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_plancta.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), false);
        }
        public ct_plancta_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_plancta.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_caja()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<caj_Caja_Info> model = bus_caja.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_caja", model);
        }

        #endregion

        #region Metodos
        private void cargar_combos(int IdEmpresa)
        {
            var lst_cuentas = bus_plancta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuentas = lst_cuentas;

            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_responsable = bus_usuario.get_list(false);
            ViewBag.lst_responsable = lst_responsable;
        }

        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            caj_Caja_Info model = new caj_Caja_Info
            {
                IdEmpresa = IdEmpresa
            };
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(caj_Caja_Info model)
        {
            if (!bus_caja.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0 ,int IdCaja = 0)
        {
            caj_Caja_Info model = bus_caja.get_info(IdEmpresa, IdCaja);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(caj_Caja_Info model)
        {
            if (!bus_caja.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0 , int IdCaja = 0)
        {
            caj_Caja_Info model = bus_caja.get_info(IdEmpresa, IdCaja);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(caj_Caja_Info model)
        {
            if (!bus_caja.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion
    }
}