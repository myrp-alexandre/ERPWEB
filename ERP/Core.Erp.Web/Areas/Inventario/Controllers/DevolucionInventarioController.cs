using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class DevolucionInventarioController : Controller
    {
        #region Variables
        in_devolucion_inven_Bus bus_devolucion = new in_devolucion_inven_Bus();
        #endregion
        #region Index
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
        public ActionResult GridViewPartial_devolucion(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            var model = bus_devolucion.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_devolucion",model);
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo()
        {            
            return View();
        }
        public ActionResult Modificar(decimal IdDev_Inven = 0)
        {
            return View();
        }
        public ActionResult Anular(decimal IdDev_Inven = 0)
        {
            return View();
        }
        #endregion
    }
}