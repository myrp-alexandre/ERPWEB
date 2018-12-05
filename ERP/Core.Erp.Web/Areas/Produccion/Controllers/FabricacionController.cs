using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Produccion;
using Core.Erp.Bus.Produccion;
using Core.Erp.Bus.General;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.Produccion.Controllers
{
    public class FabricacionController : Controller
    {
        #region VAriables
        pro_Fabricacion_Bus bus_fabricacion = new pro_Fabricacion_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        tb_bodega_Bus bus_bodega = new tb_bodega_Bus();

        #endregion
        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_fabricacion()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_fabricacion.GetList(IdEmpresa, true);
            return PartialView("_GridViewPartial_fabricacion", model);
        }
        #endregion
        #region Metodos
        private void cargar_combos(int IdEmpresa)
        {
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
            var lst_bodega = bus_bodega.get_list(IdEmpresa, false);
            ViewBag.lst_bodega = lst_bodega;

        }
        #endregion
        #region Acciones
        public ActionResult Nuevo()
        {
            pro_Fabricacion_Info model = new pro_Fabricacion_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                Fecha = DateTime.Now,
                FechaIni = DateTime.Now.Date.AddMonths(-1),
                FechaFin = DateTime.Now.Date
            };
            cargar_combos(model.IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(pro_Fabricacion_Info model)
        {
            model.IdUsuarioCreacion = Session["IdUsuario"].ToString();
            if (!bus_fabricacion.GuardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);

            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , decimal IdFabricacion = 0)
        {
            pro_Fabricacion_Info model = bus_fabricacion.GetInfo(IdEmpresa, IdFabricacion);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);

        }
        [HttpPost]
        public ActionResult Modificar(pro_Fabricacion_Info model)
        {
            model.IdUsuarioModificacion = Session["IdUsuario"].ToString();
            if (!bus_fabricacion.ModificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);

            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, decimal IdFabricacion = 0)
        {
            pro_Fabricacion_Info model = bus_fabricacion.GetInfo(IdEmpresa, IdFabricacion);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);

        }
        [HttpPost]
        public ActionResult Anular(pro_Fabricacion_Info model)
        {
            model.IdUsuarioAnulacion = Session["IdUsuario"].ToString();
            if (!bus_fabricacion.AnularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);

            }
            return RedirectToAction("Index");
        }
        #endregion
        #region Json
        public JsonResult CargarBodega(int IdEmpresa = 0, int IdSucursal = 0)
        {
            tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
            bus_bodega = new tb_bodega_Bus();
            var resultado = bus_bodega.get_list(IdEmpresa, IdSucursal, false);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion

    }
}