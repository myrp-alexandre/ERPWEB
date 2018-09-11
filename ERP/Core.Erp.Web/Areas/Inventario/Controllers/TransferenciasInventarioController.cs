using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Inventario;
using Core.Erp.Bus.Inventario;
using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using DevExpress.Web.Mvc;
using DevExpress.Web;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    [SessionTimeout]
    public class TransferenciasInventarioController : Controller
    {
        #region variables
        in_transferencia_Bus bus_trnferencia = new in_transferencia_Bus();
        in_transferencia_det_Bus bus_tras_detalle = new in_transferencia_det_Bus();
        in_transferencia_det_List List_in_transferencia_det = new in_transferencia_det_List();
        in_parametro_Bus bus_in_param = new in_parametro_Bus();
        string mensaje = string.Empty;
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        #endregion

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbProducto_TransferenciaInventario()
        {
            decimal model = new decimal();
            return PartialView("_CmbProducto_TransferenciaInventario", model);
        }
        public List<in_Producto_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_producto.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa),cl_enumeradores.eTipoBusquedaProducto.PORMODULO,cl_enumeradores.eModulo.INV,0);
        }
        public in_Producto_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_producto.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
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

        [ValidateInput(false)]
        public ActionResult GridViewPartial_transferencias(DateTime? fecha_ini, DateTime? fecha_fin)
        {
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : fecha_ini;
            ViewBag.fecha_fin = fecha_fin == null ? DateTime.Now.Date : fecha_fin;
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<in_transferencia_Info> model = bus_trnferencia.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_transferencias", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_transferencias_det(int IdSucursalOrigen = 0, int IdBodegaOrigen = 0, decimal IdTransferencia = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_transferencia_Info model = new in_transferencia_Info();
            model.list_detalle = bus_tras_detalle.get_list(IdEmpresa, IdSucursalOrigen, IdBodegaOrigen, IdTransferencia);
            if (model.list_detalle.Count == 0)
                model.list_detalle = List_in_transferencia_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_transferencias_det", model.list_detalle);
        }

        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            Session["in_transferencia_det_Info"] = null;
            in_parametro_Info i_param = bus_in_param.get_info(IdEmpresa);
            if (i_param == null)
                return RedirectToAction("Index");
            in_transferencia_Info model = new in_transferencia_Info
            {
                IdEmpresa = IdEmpresa,
                tr_fecha = DateTime.Now,
                IdMovi_inven_tipo_SucuOrig = i_param.P_IdMovi_inven_tipo_default_egr,
                IdMovi_inven_tipo_SucuDest = i_param.P_IdMovi_inven_tipo_default_ing

            };
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_transferencia_Info model)
        {
            model.list_detalle = List_in_transferencia_det.get_list();
            string mensaje = bus_trnferencia.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model.IdEmpresa);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_trnferencia.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            Session["in_transferencia_det_Info"] = null;
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdSucursalOrigen = 0, int IdBodegaOrigen = 0, decimal IdTransferencia = 0)
        {
            in_transferencia_Info model = bus_trnferencia.get_info(IdEmpresa, IdSucursalOrigen, IdBodegaOrigen, IdTransferencia);
            Session["in_transferencia_det_Info"] = model.list_detalle;
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(in_transferencia_Info model)
        {
            model.list_detalle = List_in_transferencia_det.get_list();
            string mensaje = bus_trnferencia.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model.IdEmpresa);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_trnferencia.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            Session["in_transferencia_det_Info"] = null;
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, int IdSucursalOrigen = 0, int IdBodegaOrigen = 0, decimal IdTransferencia = 0)
        {
            in_transferencia_Info model = bus_trnferencia.get_info(IdEmpresa, IdSucursalOrigen, IdBodegaOrigen, IdTransferencia);
            Session["in_transferencia_det_Info"] = model.list_detalle;
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(in_transferencia_Info model)
        {
            model.list_detalle = List_in_transferencia_det.get_list();
            string mensaje = bus_trnferencia.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model.IdEmpresa);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.tr_userAnulo = Session["IdUsuario"].ToString();
            if (!bus_trnferencia.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion

        #region Funciones del detalle
       
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] in_transferencia_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (info_det != null)
                if (info_det.IdProducto != 0)
                {
                    in_Producto_Info info_producto = bus_producto.get_info(IdEmpresa, info_det.IdProducto);
                    if (info_producto != null)
                    {
                        info_det.pr_descripcion = info_producto.pr_descripcion_combo;
                        info_det.IdUnidadMedida = info_producto.IdUnidadMedida;
                    }
                }


            List_in_transferencia_det.AddRow(info_det);
            in_transferencia_Info model = new in_transferencia_Info();
            model.list_detalle = List_in_transferencia_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_transferencias_det", model.list_detalle);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] in_transferencia_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (info_det != null)
                if (info_det.IdProducto != 0)
                {
                    in_Producto_Info info_producto = bus_producto.get_info(IdEmpresa, info_det.IdProducto);
                    if (info_producto != null)
                    {
                        info_det.pr_descripcion = info_producto.pr_descripcion_combo;
                        info_det.IdUnidadMedida = info_producto.IdUnidadMedida;
                    }
                }

            List_in_transferencia_det.UpdateRow(info_det);
            in_transferencia_Info model = new in_transferencia_Info();
            model.list_detalle = List_in_transferencia_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_transferencias_det", model.list_detalle);
        }

        public ActionResult EditingDelete(int Secuencia)
        {
            List_in_transferencia_det.DeleteRow(Secuencia);
            in_transferencia_Info model = new in_transferencia_Info();
            model.list_detalle = List_in_transferencia_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_transferencias_det", model.list_detalle);
        }
        #endregion

        private void cargar_combos_detalle()
        {
           

            in_UnidadMedida_Bus bus_unidad = new in_UnidadMedida_Bus();
            var lst_unidad = bus_unidad.get_list(false);
            ViewBag.lst_unidad = lst_unidad;
        }
        private void cargar_combos(int IdEmpresa)
        {
            in_movi_inven_tipo_Bus bus_tipo = new in_movi_inven_tipo_Bus();
            var lst_tipo = bus_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;

            in_Motivo_Inven_Bus bus_motivo = new in_Motivo_Inven_Bus();
            var lst_motivo = bus_motivo.get_list(IdEmpresa, cl_enumeradores.eTipoIngEgr.ING.ToString(), false);
            ViewBag.lst_motivo = lst_motivo;

            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
            var lst_bodega = bus_bodega.get_list(IdEmpresa, false);
            ViewBag.lst_bodega = lst_bodega;
        }

    }

    public class in_transferencia_det_List
    {
        public List<in_transferencia_det_Info> get_list()
        {
            if (HttpContext.Current.Session["in_transferencia_det_Info"] == null)
            {
                List<in_transferencia_det_Info> list = new List<in_transferencia_det_Info>();

                HttpContext.Current.Session["in_transferencia_det_Info"] = list;
            }
            return (List<in_transferencia_det_Info>)HttpContext.Current.Session["in_transferencia_det_Info"];
        }

        public void set_list(List<in_transferencia_det_Info> list)
        {
            HttpContext.Current.Session["in_transferencia_det_Info"] = list;
        }

        public void AddRow(in_transferencia_det_Info info_det)
        {
            List<in_transferencia_det_Info> list = get_list();
            info_det.dt_secuencia = list.Count == 0 ? 1 : list.Max(q => q.dt_secuencia) + 1;
            info_det.IdProducto = info_det.IdProducto;
            info_det.IdUnidadMedida = info_det.IdUnidadMedida;
            info_det.dt_cantidad = info_det.dt_cantidad;
            list.Add(info_det);
        }

        public void UpdateRow(in_transferencia_det_Info info_det)
        {
            in_transferencia_det_Info edited_info = get_list().Where(m => m.dt_secuencia == info_det.dt_secuencia).First();
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.IdUnidadMedida = info_det.IdUnidadMedida;
            edited_info.dt_cantidad = info_det.dt_cantidad;

        }

        public void DeleteRow(int dt_secuencia)
        {
            List<in_transferencia_det_Info> list = get_list();
            list.Remove(list.Where(m => m.dt_secuencia == dt_secuencia).First());
        }

    }
}