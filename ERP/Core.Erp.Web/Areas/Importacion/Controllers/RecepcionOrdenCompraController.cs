using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Importacion;
using Core.Erp.Bus.Importacion;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using Core.Erp.Info.CuentasPorPagar;
using DevExpress.Web;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Info.Inventario;
using Core.Erp.Bus.Inventario;
using DevExpress.Web.Mvc;

namespace Core.Erp.Web.Areas.Importacion.Controllers
{
    public class RecepcionOrdenCompraController : Controller
    {


        #region variables
        imp_orden_compra_ext_recepcion_Bus bus_recepcion = new imp_orden_compra_ext_recepcion_Bus();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        tb_pais_Bus bus_paises = new tb_pais_Bus();
        tb_ciudad_Bus bus_ciudad = new tb_ciudad_Bus();
        cp_pagos_sri_Bus bus_forma_pago = new cp_pagos_sri_Bus();
        imp_orden_compra_ext_recepcion_det_lst detalle = new imp_orden_compra_ext_recepcion_det_lst();
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        in_UnidadMedida_Bus bus_unidad_medida = new in_UnidadMedida_Bus();
        imp_orden_compra_ext_recepcion_det_Bus bus_detalle = new imp_orden_compra_ext_recepcion_det_Bus();
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


        public ActionResult GridViewPartial_recepcion_oc_ext(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            if (IdSucursal == 0)
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            ViewBag.IdSucursal = IdSucursal;

            List<imp_orden_compra_ext_recepcion_Info> model = new List<imp_orden_compra_ext_recepcion_Info>();
            model = bus_recepcion.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_recepcion_oc_ext", model);
        }
        public ActionResult GridViewPartial_recepcion_oc_ext_det()
        {
            List<imp_orden_compra_ext_recepcion_det_Info> model = new List<imp_orden_compra_ext_recepcion_det_Info>();
            model = Session["imp_orden_compra_ext_recepcion_det_Info"] as List<imp_orden_compra_ext_recepcion_det_Info>;
            if (model == null)
                model = new List<imp_orden_compra_ext_recepcion_det_Info>();
            return PartialView("_GridViewPartial_recepcion_oc_ext_det", model);
        }

        #endregion

        #region acciones
        public ActionResult Nuevo( decimal IdOrdenCompra_ext=0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            imp_orden_compra_ext_recepcion_Info model = new imp_orden_compra_ext_recepcion_Info();
            model=  bus_recepcion.get_rcepcion_mercancia(IdEmpresa, IdOrdenCompra_ext);
            if (model != null)
                Session["imp_orden_compra_ext_recepcion_det_Info"] = model.lst_detalle;
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(imp_orden_compra_ext_recepcion_Info model)
        {
            model.lst_detalle = Session["imp_orden_compra_ext_recepcion_det_Info"] as List<imp_orden_compra_ext_recepcion_det_Info>;
            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            if (!bus_recepcion.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            Session["imp_orden_compra_ext_recepcion_det_Info"] = null;
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(decimal IdRecepcion=0)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            imp_orden_compra_ext_recepcion_Info model = bus_recepcion.get_info(IdEmpresa, IdRecepcion);
            var lst_detalle = bus_detalle.get_list(IdEmpresa, IdRecepcion);
            Session["imp_orden_compra_ext_recepcion_det_Info"] = lst_detalle;
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            cargar_combos_detalle();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(imp_orden_compra_ext_recepcion_Info model)
        {
            model.lst_detalle = Session["imp_orden_compra_ext_recepcion_det_Info"] as List<imp_orden_compra_ext_recepcion_det_Info>;
            if (!bus_recepcion.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            Session["imp_orden_compra_ext_recepcion_det_Info"] = null;
            return RedirectToAction("Index");
        }
        public ActionResult Anular(decimal IdRecepcion=0)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            imp_orden_compra_ext_recepcion_Info model = bus_recepcion.get_info(IdEmpresa, IdRecepcion);
            var lst_detalle = bus_detalle.get_list(IdEmpresa, IdRecepcion);
            Session["imp_orden_compra_ext_recepcion_det_Info"] = lst_detalle;
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(imp_orden_compra_ext_recepcion_Info model)
        {
            if (!bus_recepcion.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            Session["imp_orden_compra_ext_recepcion_det_Info"] = null;
            return RedirectToAction("Index");
        }
        #endregion

        private void cargar_combos()
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            var lst_catalogos = bus_catalogo.get_list(1);
            ViewBag.lst_catalogos = lst_catalogos;

            in_movi_inven_tipo_Bus bus_tipo = new in_movi_inven_tipo_Bus();
            var lst_tipo = bus_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;

            in_Motivo_Inven_Bus bus_motivo = new in_Motivo_Inven_Bus();
            var lst_motivo = bus_motivo.get_list(IdEmpresa, false);
            ViewBag.lst_motivo = lst_motivo;

            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
            var lst_bodega = bus_bodega.get_list(IdEmpresa, false);
            ViewBag.lst_bodega = lst_bodega;


        }
        private void cargar_combos_detalle()
        {
            var lst_undades = bus_unidad_medida.get_list(false);
            ViewBag.lst_undades = lst_undades;
        }
        #region funciones del detalle
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] imp_orden_compra_ext_recepcion_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (info_det != null)
                if (info_det.IdProducto != 0)
                {
                    in_Producto_Info info_producto = bus_producto.get_info(IdEmpresa, info_det.IdProducto);
                    if (info_producto != null)
                    {
                        info_det.pr_descripcion = info_producto.pr_descripcion;
                        detalle.AddRow(info_det);

                    }
                }

            var model = detalle.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_orden_compra_ext_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] imp_orden_compra_ext_recepcion_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (info_det != null)
                if (info_det.IdProducto != 0)
                {
                    in_Producto_Info info_producto = bus_producto.get_info(IdEmpresa, info_det.IdProducto);
                    if (info_producto != null)
                    {
                        info_det.pr_descripcion = info_producto.pr_descripcion;

                    }
                }

            detalle.UpdateRow(info_det);
            var model = detalle.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_recepcion_oc_ext_det", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            detalle.DeleteRow(secuencia);
            var model = detalle.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_recepcion_oc_ext_det", model);
        }
        #endregion
    }


    public class imp_orden_compra_ext_recepcion_det_lst
    {
        public List<imp_orden_compra_ext_recepcion_det_Info> get_list()
        {
            if (HttpContext.Current.Session["imp_orden_compra_ext_recepcion_det_Info"] == null)
            {
                List<imp_orden_compra_ext_recepcion_det_Info> list = new List<imp_orden_compra_ext_recepcion_det_Info>();

                HttpContext.Current.Session["imp_orden_compra_ext_recepcion_det_Info"] = list;
            }
            return (List<imp_orden_compra_ext_recepcion_det_Info>)HttpContext.Current.Session["imp_orden_compra_ext_recepcion_det_Info"];
        }

        public void set_list(List<imp_orden_compra_ext_recepcion_det_Info> list)
        {
            HttpContext.Current.Session["imp_orden_compra_ext_recepcion_det_Info"] = list;
        }

        public void AddRow(imp_orden_compra_ext_recepcion_det_Info info_det)
        {
            List<imp_orden_compra_ext_recepcion_det_Info> list = get_list();
            info_det.secuencia = list.Count == 0 ? 1 : list.Max(q => q.secuencia) + 1;
            list.Add(info_det);
        }

        public void UpdateRow(imp_orden_compra_ext_recepcion_det_Info info_det)
        {
            imp_orden_compra_ext_recepcion_det_Info edited_info = get_list().Where(m => m.secuencia == info_det.secuencia).First();
            edited_info.cantidad = info_det.cantidad;

        }

        public void DeleteRow(int secuencia)
        {
            List<imp_orden_compra_ext_recepcion_det_Info> list = get_list();
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }
    }
}
