using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class CambioProductoController : Controller
    {
        #region Variables
        tb_sucursal_Bus bus_sucursal;
        fa_CambioProducto_Bus bus_CambioProducto;
        #endregion

        #region Constructor
        public CambioProductoController()
        {
            bus_sucursal = new tb_sucursal_Bus();
            bus_CambioProducto = new fa_CambioProducto_Bus();
        }
        #endregion

        #region Index
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa),
                IdSucursal = string.IsNullOrEmpty(SessionFixed.IdSucursal) ? 0 : Convert.ToInt32(SessionFixed.IdSucursal)
            };
            CargarCombos(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            CargarCombos(model.IdEmpresa);
            return View(model);
        }

        private void CargarCombos(int IdEmpresa)
        {
            try
            {
                var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
                ViewBag.lst_sucursal = lst_sucursal;
            }
            catch (Exception)
            {
                throw;
            }
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_CambioProducto(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            ViewBag.IdSucursal = IdSucursal;
            var model = bus_CambioProducto.GetList(IdEmpresa, IdSucursal, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_CambioProducto", model);
        }
        #endregion


    }
}