using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.General;
using Core.Erp.Bus.General;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class ComprobantesSinAutorizacionController : Controller
    {
        tb_comprobantes_sin_autorizacion_Bus bus_comprobantes = new tb_comprobantes_sin_autorizacion_Bus();
        #region vistas 
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal)
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_deudas(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            if (IdSucursal == 0)
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            ViewBag.IdSucursal = IdSucursal;
            var model = bus_comprobantes.get_list(IdEmpresa,"", ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_deudas", model);
        }

        #endregion
    }
}