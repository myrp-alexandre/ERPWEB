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
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Inventario;
using DevExpress.Web;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Areas.Produccion.Controllers
{
    public class FabricacionController : Controller
    {
        #region VAriables
        pro_Fabricacion_Bus bus_fabricacion = new pro_Fabricacion_Bus();
        pro_FabricacionDet_Bus bus_fabricacion_det = new pro_FabricacionDet_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
        pro_FabricacionDet_List List_det = new pro_FabricacionDet_List();
        pro_FabricacionDet_Info_List List = new pro_FabricacionDet_Info_List();

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
        private void cargar_combos_detalle()
        {
            in_UnidadMedida_Bus bus_unidad = new in_UnidadMedida_Bus();
            var lst_unidad = bus_unidad.get_list(false);
            ViewBag.lst_unidad = lst_unidad;
        }

        #endregion
        #region Acciones
        public ActionResult Nuevo()
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            pro_Fabricacion_Info model = new pro_Fabricacion_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                Fecha = DateTime.Now,
                FechaIni = DateTime.Now.Date.AddMonths(-1),
                FechaFin = DateTime.Now.Date,
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession)

            };
            model.LstDet = new List<pro_FabricacionDet_Info>();
            List_det.set_list(model.LstDet, model.IdTransaccionSession);
            cargar_combos(model.IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(pro_Fabricacion_Info model)
        {
            model.IdUsuarioCreacion = Session["IdUsuario"].ToString();
            model.LstDet = List_det.get_list(model.IdTransaccionSession);
            if (!bus_fabricacion.GuardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);

            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , decimal IdFabricacion = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            pro_Fabricacion_Info model = bus_fabricacion.GetInfo(IdEmpresa, IdFabricacion);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.LstDet = bus_fabricacion_det.GetList(IdEmpresa, IdFabricacion);
            List_det.set_list(model.LstDet, model.IdTransaccionSession);
            cargar_combos(IdEmpresa);
            return View(model);

        }
        [HttpPost]
        public ActionResult Modificar(pro_Fabricacion_Info model)
        {
            model.IdUsuarioModificacion = Session["IdUsuario"].ToString();
            model.LstDet = List_det.get_list(model.IdTransaccionSession);
            if (!bus_fabricacion.ModificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);

            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, decimal IdFabricacion = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            pro_Fabricacion_Info model = bus_fabricacion.GetInfo(IdEmpresa, IdFabricacion);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.LstDet = bus_fabricacion_det.GetList(IdEmpresa, IdFabricacion);
            List_det.set_list(model.LstDet, model.IdTransaccionSession);
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

        public JsonResult ArmarMateriaPrima(int IdEmpresa = 0 ,  decimal IdTransaccionSession = 0 )
        {
            in_Producto_Composicion_Bus bus_comp = new in_Producto_Composicion_Bus();
            //var resultado = bus_comp.get_list(IdEmpresa, IdProducto);
            //foreach (var item in resultado)
            //{
            //  //  item.Cantidad = item.Cantidad * 1;
            //    pro_FabricacionDet_Info info = new pro_FabricacionDet_Info
            //    {
            //        IdEmpresa = item.IdEmpresa,
            //        IdProducto = item.IdProductoHijo,
            //        Cantidad = item.Cantidad,
            //        IdUnidadMedida = item.IdUnidadMedida,
            //        Signo = "-",
            //        pr_descripcion = item.pr_descripcion,
            //        Secuencia = item.secuencia,
            //        IdProductoPadre = item.IdProductoPadre

            //    };
            //    var producto = List_det.get_list(IdTransaccionSession).Where(q => q.IdProducto == info.IdProducto).FirstOrDefault();
            //    double Cantidad = 0;
            //    if (producto == null)
            //    {
            //        List_det.AddRow(info, IdTransaccionSession);
            //        item.Cantidad = info.Cantidad * Cantidad;
            //    }
            //    else
            //    {
            //        producto.Cantidad = producto.Cantidad + info.Cantidad;
            //        List_det.UpdateRow(info, IdTransaccionSession);
            //    }
            //}

            var Lista = List_det.get_list(IdTransaccionSession).Where(q => q.Signo == "+").ToList();
            foreach (var item in Lista)
            {
                var composicion = bus_comp.get_list(IdEmpresa, item.IdProducto);
                foreach (var comp in composicion)
                {
                    pro_FabricacionDet_Info info = new pro_FabricacionDet_Info
                    {

                        IdProducto = comp.IdProductoHijo,
                        Signo = "-",
                        Cantidad = item.Cantidad * comp.Cantidad,
                        IdUnidadMedida = comp.IdUnidadMedida,
                        Costo = 0, 
                        pr_descripcion = comp.pr_descripcion
                    };
                    List_det.AddRow(info, IdTransaccionSession);
                }
            }
            return Json(List_det, JsonRequestBehavior.AllowGet);

        }

        public JsonResult GetProductoFacturadosPorFecha(DateTime FechaIni, DateTime FechaFin, int IdEmpresa = 0, int IdSucursal = 0, int IdBodega = 0 ,  decimal IdTransaccionSession = 0)
        {
            bool resultado = true;
            var Lista = bus_fabricacion_det.GetProductoFacturadosPorFecha(IdEmpresa, IdSucursal, IdBodega, FechaIni, FechaFin);
            if (Lista.Count()== 0)
                resultado = false;
            var det = List_det.get_list(IdTransaccionSession);
            det.AddRange(Lista);
            List_det.set_list(det, IdTransaccionSession);
            return Json(resultado, JsonRequestBehavior.AllowGet);

        }

        #endregion
        #region Metodos ComboBox bajo demanda
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        public ActionResult CmbProducto_Fabricacion()
        {
            decimal model = new decimal();
            return PartialView("_CmbProducto_Fabricacion", model);
        }
        public List<in_Producto_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_producto.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoBusquedaProducto.PORMODULO, cl_enumeradores.eModulo.INV, 0);
        }
        public in_Producto_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_producto.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion
        #region Detalle_ing


        public ActionResult GridViewPartial_fabricacion_det_ing(decimal IdFabricacion = 0)
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            cargar_combos_detalle();
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)).Where(q=> q.Signo == "+").ToList();
            return PartialView("_GridViewPartial_fabricacion_det_ing", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNewIngreso( [ModelBinder(typeof(DevExpressEditorsBinder))] pro_FabricacionDet_Info info_det )
        {
            var producto = bus_producto.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdProducto);
            if (producto != null)
                info_det.pr_descripcion = producto.pr_descripcion;
            info_det.Signo = "+";
            if (ModelState.IsValid)
                List_det.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)).Where(q => q.Signo == "+").ToList();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_fabricacion_det_ing", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdateIngreso([ModelBinder(typeof(DevExpressEditorsBinder))] pro_FabricacionDet_Info info_det)
        {
            var producto = bus_producto.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdProducto);
            if (producto != null)
                info_det.pr_descripcion = producto.pr_descripcion;
            info_det.Signo = "+";
            if (ModelState.IsValid)
                List_det.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)).Where(q => q.Signo == "+").ToList();
            foreach (var item in model.LstDet.Where(v=>v.IdProductoPadre==info_det.IdProducto))
            {
                item.Cantidad = item.Cantidad * info_det.Cantidad;
                List_det.UpdateRow(item, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));   
            }
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_fabricacion_det_ing", model);
        }
        public ActionResult EditingDeleteIngreso(int Secuencia)
        {
            List_det.DeleteRow(Secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_fabricacion_det_ing", model);
        }

        #endregion
        #region Detalle_egr
        public ActionResult GridViewPartial_fabricacion_det_egr(decimal IdFabricacion = 0)
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cargar_combos_detalle();
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)).Where(q => q.Signo == "-").ToList();
            return PartialView("_GridViewPartial_fabricacion_det_egr", model);
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNewEgreso([ModelBinder(typeof(DevExpressEditorsBinder))] pro_FabricacionDet_Info info_det)
        {
            var producto = bus_producto.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdProducto);
            if (producto != null)
                info_det.pr_descripcion = producto.pr_descripcion;
            info_det.Signo = "-";
            if (ModelState.IsValid)
                List_det.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)).Where(q => q.Signo == "-").ToList();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_fabricacion_det_egr", model);
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdateEgreso([ModelBinder(typeof(DevExpressEditorsBinder))] pro_FabricacionDet_Info info_det)
        {
            var producto = bus_producto.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdProducto);
            if (producto != null)
                info_det.pr_descripcion = producto.pr_descripcion;
            if (ModelState.IsValid)
                info_det.Signo = "-";
            List_det.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)).Where(q => q.Signo == "-").ToList();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_fabricacion_det_egr", model);
        }
        public ActionResult EditingDeleteEgreso(int Secuencia)
        {
            List_det.DeleteRow(Secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)).Where(q => q.Signo == "-").ToList();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_fabricacion_det_egr", model);
        }

        #endregion

        [ValidateInput(false)]
        public ActionResult GridViewPartial_fabricacion_det_fac()
        {
            var model = List.get_list();
            return PartialView("_GridViewPartial_fabricacion_det_fac", model);
        }

    }

    public class pro_FabricacionDet_List
    {
        string Variable = "pro_FabricacionDet_Info";
        public List<pro_FabricacionDet_Info> get_list(decimal IdTransaccionSession)
        {

            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<pro_FabricacionDet_Info> list = new List<pro_FabricacionDet_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<pro_FabricacionDet_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<pro_FabricacionDet_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(pro_FabricacionDet_Info info_det, decimal IdTransaccionSession)
        {
            List<pro_FabricacionDet_Info> list = get_list(IdTransaccionSession);
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            list.Add(info_det);
        }

        public void UpdateRow(pro_FabricacionDet_Info info_det, decimal IdTransaccionSession)
        {
            pro_FabricacionDet_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.Cantidad = info_det.Cantidad;
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.IdUnidadMedida = info_det.IdUnidadMedida;
            edited_info.RealizaMovimiento = info_det.RealizaMovimiento;
            edited_info.pr_descripcion = info_det.pr_descripcion;
            edited_info.IdProductoPadre = info_det.IdProductoPadre;
        }

        public void DeleteRow(int Secuencia, decimal IdTransaccionSession)
        {
            List<pro_FabricacionDet_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }


    public class pro_FabricacionDet_Info_List
    {
        string Variable = "pro_FabricacionDet_Info";
        public List<pro_FabricacionDet_Info> get_list()
        {

            if (HttpContext.Current.Session[Variable] == null)
            {
                List<pro_FabricacionDet_Info> list = new List<pro_FabricacionDet_Info>();

                HttpContext.Current.Session[Variable] = list;
            }
            return (List<pro_FabricacionDet_Info>)HttpContext.Current.Session[Variable];
        }

        public void set_list(List<pro_FabricacionDet_Info> list)
        {
            HttpContext.Current.Session[Variable] = list;
        }
    }


}