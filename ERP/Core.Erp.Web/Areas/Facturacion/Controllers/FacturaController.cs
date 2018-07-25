using Core.Erp.Bus.Facturacion;
using Core.Erp.Info.Facturacion;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class FacturaController : Controller
    {
        #region Variables
        fa_factura_Bus bus_factura = new fa_factura_Bus();
        fa_PuntoVta_Bus bus_punto_venta = new fa_PuntoVta_Bus();
        #endregion

        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_factura(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);            
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            var model = bus_factura.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_factura", model);
        }

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.lst_punto_venta = bus_punto_venta.get_list(IdEmpresa, false);
        }
    }
}