using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.General;
using Core.Erp.Bus.General;
using Core.Erp.Web.Helps;

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
    }
}