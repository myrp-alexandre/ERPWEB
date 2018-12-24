using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Web.Helps;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.General;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class SolicitudPagoController : Controller
    {
        #region Variables
        cp_SolicitudPago_Bus bus_solicitud = new cp_SolicitudPago_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        #endregion
        #region Index

        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal)
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
        private void cargar_combos(int IdEmpresa)
        {
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_solicitud_pago(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            ViewBag.IdSucursal = IdSucursal;
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            var model = bus_solicitud.GetList(IdEmpresa, IdSucursal, ViewBag.Fecha_ini, ViewBag.Fecha_fin, true);
            return PartialView("_GridViewPartial_solicitud_pago", model);
        }
        #endregion
        #region Acciones
        public ActionResult Nuevo()
        {
            cp_SolicitudPago_Info model = new cp_SolicitudPago_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                Solicitante = Convert.ToString(SessionFixed.IdUsuario)
            };
            return View();
        }

        [HttpPost]
        public ActionResult Nuevo(cp_SolicitudPago_Info model)
        {
            if (!bus_solicitud.GuardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , decimal IdSolicitud = 0)
        {
            cp_SolicitudPago_Info model = bus_solicitud.GetInfo(IdEmpresa, IdSolicitud);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_SolicitudPago_Info model)
        {
            if (!bus_solicitud.ModificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0, decimal IdSolicitud = 0)
        {
            cp_SolicitudPago_Info model = bus_solicitud.GetInfo(IdEmpresa, IdSolicitud);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(cp_SolicitudPago_Info model)
        {
            if (!bus_solicitud.AnularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion
    }
}