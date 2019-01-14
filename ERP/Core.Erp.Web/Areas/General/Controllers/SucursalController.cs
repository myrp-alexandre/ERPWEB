using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.General;
using Core.Erp.Bus.General;
using Core.Erp.Web.Helps;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
using DevExpress.Web;

namespace Core.Erp.Web.Areas.General.Controllers
{
    [SessionTimeout]
    public class SucursalController : Controller
    {
        #region Index / Metodo

        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_sucursal()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_sucursal.get_list(IdEmpresa,true);
            return PartialView("_GridViewPartial_sucursal", model);
        }
        #endregion
        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0 )
        {
            tb_sucursal_Info model = new tb_sucursal_Info
            {
                IdEmpresa = IdEmpresa
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(tb_sucursal_Info model)
        {
            if (!bus_sucursal.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , int IdSucursal = 0)
        {
            tb_sucursal_Info model = bus_sucursal.get_info(IdEmpresa, IdSucursal);
            if(model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(tb_sucursal_Info model)
        {
            if (!bus_sucursal.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0 , int IdSucursal = 0)
        {
            tb_sucursal_Info model = bus_sucursal.get_info(IdEmpresa, IdSucursal);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(tb_sucursal_Info model)
        {
            if (!bus_sucursal.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion
        #region Metodos ComboBox bajo demanda
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        
        #region CmbCuenta_Sucursal
        public ActionResult CmbCuenta_Sucursal()
        {
            tb_sucursal_Info model = new tb_sucursal_Info();
            return PartialView("_CmbCuenta_Sucursal", model);
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

        #region CmbCuenta_Sucursal_IVA
        public ActionResult CmbCuenta_Sucursal_IVA()
        {
            tb_sucursal_Info model = new tb_sucursal_Info();
            return PartialView("_CmbCuenta_Sucursal_IVA", model);
        }

        public List<ct_plancta_Info> get_list_bajo_demanda_ctacble_iva(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_plancta.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), false);
        }
        public ct_plancta_Info get_info_bajo_demanda_ctacble_iva(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_plancta.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion

        #region CmbCuenta_Sucursal_IVA0
        public ActionResult CmbCuenta_Sucursal_IVA0()
        {
            tb_sucursal_Info model = new tb_sucursal_Info();
            return PartialView("_CmbCuenta_Sucursal_IVA0", model);
        }

        public List<ct_plancta_Info> get_list_bajo_demanda_ctacble_iva0(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_plancta.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), false);
        }
        public ct_plancta_Info get_info_bajo_demanda_ctacble_iva0(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_plancta.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion

        #endregion

    }
    public class tb_sucursal_List
    {
        string Variable = "tb_sucursal_Info";
        public List<tb_sucursal_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<tb_sucursal_Info> list = new List<tb_sucursal_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<tb_sucursal_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<tb_sucursal_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }
    }

}