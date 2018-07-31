using Core.Erp.Bus.Importacion;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Helps;
using Core.Erp.Info.Importacion;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Importacion.Controllers
{
    public class AsignacionDeGastosController : Controller
    {
        #region variables
        imp_liquidacion_det_x_imp_orden_compra_ext_Bus bus_liquidacion_oc = new imp_liquidacion_det_x_imp_orden_compra_ext_Bus();
        imp_orden_compra_ext_recepcion_det_lst detalle = new imp_orden_compra_ext_recepcion_det_lst();
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        in_UnidadMedida_Bus bus_unidad_medida = new in_UnidadMedida_Bus();
        imp_ordencompra_ext_det_Bus bus_detalle = new imp_ordencompra_ext_det_Bus();
        imp_catalogo_Bus bus_catalogo = new imp_catalogo_Bus();
        #endregion

        #region vistas

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


        public ActionResult GridViewPartial_liquidacion_importacion(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            if (IdSucursal == 0)
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            ViewBag.IdSucursal = IdSucursal;

            List<imp_liquidacion_det_x_imp_orden_compra_ext_Info> model = new List<imp_liquidacion_det_x_imp_orden_compra_ext_Info>();
            model = bus_liquidacion_oc.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_liquidacion_importacion", model);
        }
        public ActionResult GridViewPartial_liquidacion_importacion_det()
        {
            List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info> model = new List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>();
            model = Session["lst_detalle_oc"] as List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>;
            if (model == null)
                model = new List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>();
            return PartialView("_GridViewPartial_liquidacion_importacion_det", model);
        }

        public ActionResult GridViewPartial_gastos_asignados()
        {
            List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info> model = new List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>();
            model = Session["lst_gastos_asignados"] as List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>;
            if (model == null)
                model = new List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>();
            return PartialView("_GridViewPartial_gastos_asignados", model);
        }
        public ActionResult GridViewPartial_gastos_por_asignar()
        {
            List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info> model = new List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>();
            model = Session["lst_gastos_por_asignar"] as List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>;
            if (model == null)
                model = new List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>();
            return PartialView("_GridViewPartial_gastos_por_asignar", model);
        }
        #endregion

        #region acciones
        public ActionResult Nuevo(decimal IdOrdenCompra_ext = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            imp_liquidacion_det_x_imp_orden_compra_ext_Info model = new imp_liquidacion_det_x_imp_orden_compra_ext_Info();
            //model = bus_liquidacion_oc.get_rcepcion_mercancia(IdEmpresa, IdOrdenCompra_ext);
            if (model != null)
                Session["imp_orden_compra_ext_ct_cbteble_det_gastos_Info"] = model.lst_gastos_asignados;
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(imp_liquidacion_det_x_imp_orden_compra_ext_Info model)
        {
            model.lst_gastos_asignados = Session["imp_orden_compra_ext_ct_cbteble_det_gastos_Info"] as List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>;
            if (model.lst_detalle_oc == null)
            {
                ViewBag.mensaje = "no existe detalle";
                cargar_combos();
                return View(model);
            }
            else
            {
                if (model.lst_gastos_asignados.Count() == 0)
                {
                    ViewBag.mensaje = "no existe detalle";
                    cargar_combos();
                    return View(model);
                }

            }
            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            if (!bus_liquidacion_oc.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            Session["imp_orden_compra_ext_ct_cbteble_det_gastos_Info"] = null;
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(decimal IdRecepcion = 0)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            imp_liquidacion_det_x_imp_orden_compra_ext_Info model = bus_liquidacion_oc.get_info(IdEmpresa, IdRecepcion);
            var lst_detalle = bus_detalle.get_list(IdEmpresa, IdRecepcion);
            Session["imp_orden_compra_ext_ct_cbteble_det_gastos_Info"] = lst_detalle;
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            cargar_combos_detalle();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(imp_liquidacion_det_x_imp_orden_compra_ext_Info model)
        {
            model.lst_gastos_asignados = Session["imp_orden_compra_ext_ct_cbteble_det_gastos_Info"] as List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>;

            if (model.lst_gastos_asignados == null)
            {
                ViewBag.mensaje = "no existe detalle";
                cargar_combos();
                return View(model);
            }
            else
            {
                if (model.lst_gastos_asignados.Count() == 0)
                {
                    ViewBag.mensaje = "no existe detalle";
                    cargar_combos();
                    return View(model);
                }

            }
            if (!bus_liquidacion_oc.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            Session["imp_orden_compra_ext_ct_cbteble_det_gastos_Info"] = null;
            return RedirectToAction("Index");
        }
        public ActionResult Anular(decimal IdRecepcion = 0)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            imp_liquidacion_det_x_imp_orden_compra_ext_Info model = bus_liquidacion_oc.get_info(IdEmpresa, IdRecepcion);
            var lst_detalle = bus_detalle.get_list(IdEmpresa, IdRecepcion);
            Session["imp_orden_compra_ext_ct_cbteble_det_gastos_Info"] = lst_detalle;
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(imp_liquidacion_det_x_imp_orden_compra_ext_Info model)
        {
            model.lst_gastos_asignados = Session["imp_orden_compra_ext_ct_cbteble_det_gastos_Info"] as List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>;
            if (!bus_liquidacion_oc.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            Session["imp_orden_compra_ext_ct_cbteble_det_gastos_Info"] = null;
            return RedirectToAction("Index");
        }
        #endregion

        private void cargar_combos()
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            var lst_catalogos = bus_catalogo.get_list(1);
            ViewBag.lst_catalogos = lst_catalogos;

            


        }
        private void cargar_combos_detalle()
        {
            var lst_undades = bus_unidad_medida.get_list(false);
            ViewBag.lst_undades = lst_undades;
        }
    }
}