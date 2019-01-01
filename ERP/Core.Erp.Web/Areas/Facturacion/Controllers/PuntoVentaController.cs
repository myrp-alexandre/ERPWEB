using Core.Erp.Info.Facturacion;
using Core.Erp.Bus.Facturacion;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.General;
using Core.Erp.Web.Helps;
using Core.Erp.Bus.Caja;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    [SessionTimeout]
    public class PuntoVentaController : Controller
    {
        #region Index

        fa_PuntoVta_Bus bus_punto = new fa_PuntoVta_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_puntoventa()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<fa_PuntoVta_Info> model = bus_punto.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_puntoventa", model);
        }
        private void cargar_combos( fa_PuntoVta_Info model)
        {
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(model.IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
            var lst_bodega = bus_bodega.get_list(model.IdEmpresa, model.IdSucursal, false);
            ViewBag.lst_bodega = lst_bodega;

            Dictionary<string, string> lst_signos = new Dictionary<string, string>();
            lst_signos.Add("-", "-");
            lst_signos.Add("+", "+");
            ViewBag.lst_signos = lst_signos;

            caj_Caja_Bus bus_caja = new caj_Caja_Bus();
            var lst_caja = bus_caja.get_list(model.IdEmpresa, false);
            ViewBag.lst_caja = lst_caja;
        }
        #endregion
        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            fa_PuntoVta_Info model = new fa_PuntoVta_Info
            {
                IdEmpresa = IdEmpresa
            };
            cargar_combos(model);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(fa_PuntoVta_Info model)
        {
            if (!bus_punto.guardarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0 , int IdSucursal = 0, int IdPuntoVta = 0)
        {
            fa_PuntoVta_Info model = bus_punto.get_info(IdEmpresa,IdSucursal, IdPuntoVta);
            if (model == null)
            return RedirectToAction("Index");
                cargar_combos(model);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_PuntoVta_Info model)
        {
            if (!bus_punto.modificarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0 , int IdSucursal = 0, int IdPuntoVta = 0)
        {
            fa_PuntoVta_Info model = bus_punto.get_info(IdEmpresa, IdSucursal, IdPuntoVta);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
                cargar_combos(model);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_PuntoVta_Info model)
        {
            if (!bus_punto.anularDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
        #region Json
        public JsonResult cargar_bodega(int IdEmpresa = 0 , int IdSucursal = 0)
        {
            tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
            var resultado = bus_bodega.get_list(IdEmpresa, IdSucursal, false);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}