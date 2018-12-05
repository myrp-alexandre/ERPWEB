using DevExpress.Web.Mvc;
using Core.Erp.Bus.Presupuesto;
using Core.Erp.Info.Presupuesto;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
using DevExpress.Web;

namespace Core.Erp.Web.Areas.Presupuesto.Controllers
{
    public class RubroPresupuestoController : Controller
    {
        #region Variables
        pre_rubro_Bus bus_Rubro = new pre_rubro_Bus();
        pre_RubroTipo_Bus bus_RubroTipo = new pre_RubroTipo_Bus();
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_Rubro()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<pre_rubro_Info> model = bus_Rubro.GetList(IdEmpresa, true);
            return PartialView("_GridViewPartial_Rubro", model);
        }

        private void cargar_combos(int IdEmpresa)
        {
            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_ctacble = bus_plancta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuentas = lst_ctacble;
        }
        #endregion

        #region Metodos
        private void cargar_RubroTipo(int IdEmpresa)
        {
            try
            {
                var lst_RubroTipo = bus_RubroTipo.GetList(IdEmpresa, false);
                ViewBag.lst_RubroTipo = lst_RubroTipo;
            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion

        #region Metodos ComboBox bajo demanda
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        public ActionResult CmbCuentaContable()
        {
            string model = "";
            return PartialView("_CmbCuentaContable", model);
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

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            cargar_combos(IdEmpresa);
            pre_rubro_Info model = new pre_rubro_Info();
            return View(model);
            
        }

        [HttpPost]
        public ActionResult Nuevo(pre_rubro_Info model)
        {            
            model.IdUsuario = SessionFixed.IdUsuario;
            if (!bus_Rubro.GuardarBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdRubro = 0)
        {
            pre_rubro_Info model = bus_Rubro.GetInfo(IdEmpresa, IdRubro);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(pre_rubro_Info model)
        {
            model.IdUsuarioModificacion = SessionFixed.IdUsuario;
            if (!bus_Rubro.ModificarBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0, int IdRubro = 0)
        {
            pre_rubro_Info model = bus_Rubro.GetInfo(IdEmpresa, IdRubro);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(pre_rubro_Info model)
        {
            model.IdUsuarioAnulacion = SessionFixed.IdUsuario;
            if (!bus_Rubro.AnularBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion
    }
}