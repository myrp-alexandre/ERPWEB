using Core.Erp.Bus.Compras;
using Core.Erp.Bus.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Compras.Controllers
{
    public class AprobacionOCController : Controller
    {
        com_ordencompra_local_Bus bus_ordencompra = new com_ordencompra_local_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();

        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa),
                IdSucursal = string.IsNullOrEmpty(SessionFixed.IdSucursal) ? 0 : Convert.ToInt32(SessionFixed.IdSucursal)
            };
            cargar_combos(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            cargar_combos(model.IdEmpresa);
            return View(model);
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_aprobacion_oc(int IdSucursal, DateTime? fecha_ini, DateTime? fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(fecha_ini);
            ViewBag.fecha_fin = fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(fecha_fin);
            ViewBag.IdSucursal = IdSucursal == 0 ? 0 : Convert.ToInt32(IdSucursal);
            var model = bus_ordencompra.GetListPorAprobar(IdEmpresa, IdSucursal, ViewBag.fecha_ini, ViewBag.fecha_fin);
            return PartialView("_GridViewPartial_aprobacion_oc", model);
        }

        private void cargar_combos(int IdEmpresa)
        {
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
            
        }

    }
}