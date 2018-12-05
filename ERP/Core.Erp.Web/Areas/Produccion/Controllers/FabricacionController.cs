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
        #region Detalle
        private void cargar_combos_detalle()
        {
            in_UnidadMedida_Bus bus_unidad = new in_UnidadMedida_Bus();
            var lst_unidad = bus_unidad.get_list(false);
            ViewBag.lst_unidad = lst_unidad;
        }


        public ActionResult GridViewPartial_fabricacion_det(decimal IdFabricacion = 0)
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cargar_combos_detalle();
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_fabricacion_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] pro_FabricacionDet_Info info_det)
        {

            if (ModelState.IsValid)
                List_det.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_fabricacion_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] pro_FabricacionDet_Info info_det)
        {

            if (ModelState.IsValid)
                List_det.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_fabricacion_det", model);
        }
        public ActionResult EditingDelete(int Secuencia)
        {
            List_det.DeleteRow(Secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            pro_Fabricacion_Info model = new pro_Fabricacion_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_fabricacion_det", model);
        }















        #endregion
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
            info_det.IdFabricacion = info_det.IdFabricacion;
            info_det.Cantidad = info_det.Cantidad;
            info_det.Costo = info_det.Costo;
            info_det.IdProducto = info_det.IdProducto;
            info_det.IdUnidadMedida = info_det.IdUnidadMedida;
            info_det.RealizaMovimiento = info_det.RealizaMovimiento;
            info_det.Signo = info_det.Signo;


            list.Add(info_det);
        }

        public void UpdateRow(pro_FabricacionDet_Info info_det, decimal IdTransaccionSession)
        {
            pro_FabricacionDet_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdFabricacion = info_det.IdFabricacion;
            edited_info.Cantidad = info_det.Cantidad;
            edited_info.Costo = info_det.Costo;
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.IdUnidadMedida = info_det.IdUnidadMedida;
            edited_info.RealizaMovimiento = info_det.RealizaMovimiento;
            edited_info.Signo = info_det.Signo;
        }

        public void DeleteRow(int Secuencia, decimal IdTransaccionSession)
        {
            List<pro_FabricacionDet_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }

}