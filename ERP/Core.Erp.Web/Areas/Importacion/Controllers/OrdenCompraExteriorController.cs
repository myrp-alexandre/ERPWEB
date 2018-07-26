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
    
    public class OrdenCompraExteriorController : Controller
    {
        #region variables
        imp_ordencompra_ext_Bus bus_orden = new imp_ordencompra_ext_Bus();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        tb_pais_Bus bus_paises = new tb_pais_Bus();
        tb_ciudad_Bus bus_ciudad = new tb_ciudad_Bus();
        cp_pagos_sri_Bus bus_forma_pago = new cp_pagos_sri_Bus();
        imp_ordencompra_ext_det_Info_lst detalle = new imp_ordencompra_ext_det_Info_lst();
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        in_UnidadMedida_Bus bus_unidad_medida = new in_UnidadMedida_Bus();
        #endregion

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbProveedor_exterior()
        {
            cp_proveedor_Info model = new cp_proveedor_Info();
            return PartialView("_CmbProveedor_exterior", model);
        }
        public List<cp_proveedor_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_proveedor.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        public cp_proveedor_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_proveedor.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }


        public ActionResult CmbCuenta_cta_contable()
        {
            imp_ordencompra_ext_Info model = new imp_ordencompra_ext_Info();
           
            return PartialView("_CmbCuenta_contable", model);
        }
        public List<ct_plancta_Info> get_list_bajo_demanda_cta(ListEditItemsRequestedByFilterConditionEventArgs args)
       {
            return bus_plancta.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), false);
        }
        public ct_plancta_Info get_info_bajo_demanda_cta(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_plancta.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion

        #region vistas

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GridViewPartial_orden_compra_ext()
        {
            List<imp_ordencompra_ext_Info> model = new List<imp_ordencompra_ext_Info>();
            return PartialView("_GridViewPartial_orden_compra_ext", model);
        }
        public ActionResult GridViewPartial_orden_compra_ext_det()
        {
            List<imp_ordencompra_ext_det_Info> model = new List<imp_ordencompra_ext_det_Info>();
            return PartialView("_GridViewPartial_orden_compra_ext_det", model);
        }

        #endregion

        #region acciones
        public ActionResult Nuevo()
        {
            imp_ordencompra_ext_Info model = new imp_ordencompra_ext_Info
            {
                fecha_creacion = DateTime.Now,
                oe_fecha = DateTime.Now,
                oe_fecha_llegada = DateTime.Now,
                oe_fecha_embarque = DateTime.Now

            };

            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(imp_ordencompra_ext_Info model)
        {
            if (!bus_orden.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(decimal IdOrdenCompra_ext)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            imp_ordencompra_ext_Info model = bus_orden.get_info(IdEmpresa, IdOrdenCompra_ext);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(imp_ordencompra_ext_Info model)
        {
            if (!bus_orden.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(decimal IdOrdenCompra_ext)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            imp_ordencompra_ext_Info model = bus_orden.get_info(IdEmpresa, IdOrdenCompra_ext);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(imp_ordencompra_ext_Info model)
        {
            if (!bus_orden.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion

        private void cargar_combos()
        {
            var lst_paises = bus_paises.get_list(false);
            ViewBag.lst_paises = lst_paises;

            var lst_ciudades = bus_ciudad.get_list("1", false);
            ViewBag.lst_ciudades = lst_ciudades;

            var lst_forma_pago = bus_forma_pago.get_list();
            ViewBag.lst_forma_pago = lst_forma_pago;


        }
        private void cargar_combos_detalle()
        {
            var lst_undades = bus_unidad_medida.get_list(false);
            ViewBag.lst_undades = lst_undades;
        }
        #region funciones del detalle
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] imp_ordencompra_ext_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (info_det != null)
                if (info_det.IdProducto != 0)
                {
                    in_Producto_Info info_producto = bus_producto.get_info(IdEmpresa, info_det.IdProducto);
                    if (info_producto != null)
                    {
                        info_det.pr_descripcion = info_producto.pr_descripcion;
                        info_det.IdUnidadMedida = info_producto.IdUnidadMedida;
                    }
                }

            detalle.AddRow(info_det);
            var model = detalle.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_egr_inv_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] imp_ordencompra_ext_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (info_det != null)
                if (info_det.IdProducto != 0)
                {
                    in_Producto_Info info_producto = bus_producto.get_info(IdEmpresa, info_det.IdProducto);
                    if (info_producto != null)
                    {
                        info_det.pr_descripcion = info_producto.pr_descripcion;
                        info_det.IdUnidadMedida = info_producto.IdUnidadMedida;
                    }
                }

            detalle.UpdateRow(info_det);
            var model = detalle.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_egr_inv_det", model);
        }

        public ActionResult EditingDelete(int Secuencia)
        {
            detalle.DeleteRow(Secuencia);
            var model = detalle.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_egr_inv_det", model);
        }
        #endregion
    }


    public class imp_ordencompra_ext_det_Info_lst
    {
        public List<imp_ordencompra_ext_det_Info> get_list()
        {
            if (HttpContext.Current.Session["imp_ordencompra_ext_det_Info"] == null)
            {
                List<imp_ordencompra_ext_det_Info> list = new List<imp_ordencompra_ext_det_Info>();

                HttpContext.Current.Session["imp_ordencompra_ext_det_Info"] = list;
            }
            return (List<imp_ordencompra_ext_det_Info>)HttpContext.Current.Session["imp_ordencompra_ext_det_Info"];
        }

        public void set_list(List<imp_ordencompra_ext_det_Info> list)
        {
            HttpContext.Current.Session["imp_ordencompra_ext_det_Info"] = list;
        }

        public void AddRow(imp_ordencompra_ext_det_Info info_det)
        {
            List<imp_ordencompra_ext_det_Info> list = get_list();
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            info_det.IdProducto = info_det.IdProducto;
            info_det.IdUnidadMedida = info_det.IdUnidadMedida;
            info_det.od_costo = info_det.od_costo;
            info_det.od_cantidad = info_det.od_cantidad;

            list.Add(info_det);
        }

        public void UpdateRow(imp_ordencompra_ext_det_Info info_det)
        {
            imp_ordencompra_ext_det_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.IdUnidadMedida = info_det.IdUnidadMedida;
            edited_info.od_costo = info_det.od_costo;
            edited_info.od_cantidad = info_det.od_cantidad;

        }

        public void DeleteRow(int Secuencia)
        {
            List<imp_ordencompra_ext_det_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }
}