using Core.Erp.Bus.General;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Info.Inventario;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class ConsignacionController : Controller
    {
        // GET: Inventario/Consignacion

        #region Variables
        in_Consignacion_Bus bus_in_Consignacion;
        in_Consignacion_det_Bus in_Consignacion_det_Bus;
        in_Consignacion_det_List in_Consignacion_det_List = new in_Consignacion_det_List();
        in_parametro_Bus bus_in_param = new in_parametro_Bus();
        string mensaje = string.Empty;
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        #endregion

        public ConsignacionController()
        {
            bus_in_Consignacion = new in_Consignacion_Bus();
        }

        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();

        public ActionResult CmbProveedor_Consignacion()
        {
            in_Consignacion_Info model = new in_Consignacion_Info();
            return PartialView("_CmbProveedor_Consignacion", model);
        }
        public ActionResult CmbSucursal_Consignacion()
        {
            in_Consignacion_Info model = new in_Consignacion_Info();
            return PartialView("_CmbSucursal_Consignacion", model);
        }

        public List<tb_persona_Info> get_list_bajo_demanda_proveedor(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.PROVEE.ToString());
        }

        public tb_persona_Info get_info_bajo_demanda_proveedor(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.PROVEE.ToString());
        }

        public List<tb_sucursal_Info> get_list_bajo_demanda_sucursal(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_sucursal.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }

        public tb_sucursal_Info get_info_bajo_demanda_sucursal(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_sucursal.get_info_bajo_demanda(Convert.ToInt32(SessionFixed.IdEmpresa), args);
        }
        #endregion

        public ActionResult Index()
        {
            return View();
        }

        #region Metodos
        private void cargar_combos_consulta()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            lst_sucursal.Add(new tb_sucursal_Info
            {
                IdEmpresa = IdEmpresa,
                IdSucursal = 0,
                Su_Descripcion = "Todos"
            });
            ViewBag.lst_sucursal = lst_sucursal;
        }
        private void cargar_combos(int IdEmpresa)
        {
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
        }
        #endregion

        public ActionResult GridViewPartial_consignacion(DateTime fecha_ini, DateTime fecha_fin, int IdSucursal = 0)
        {
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : fecha_ini;
            ViewBag.fecha_fin = fecha_fin == null ? DateTime.Now.Date : fecha_fin;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            List<in_Ing_Egr_Inven_Info> model = in_Consignacion_det_Bus.get_list(IdEmpresa, "+", true, ViewBag.fecha_ini, ViewBag.fecha_fin);
            return PartialView("_GridViewPartial_consignacion", model);
        }        

        #region Acciones
        public ActionResult Nuevo()
        {
            in_Consignacion_Info model = new in_Consignacion_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_Consignacion_Info model)
        {
            model.IdUsuario = SessionFixed.IdUsuario;
            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            if (!bus_in_Consignacion.GuardarBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion

        #region Funciones del detalle
        public ActionResult GridViewPartial_consignacion_det(int IdEmpresa = 0, decimal IdConsignacion = 0)
        {
            //int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = in_Consignacion_det_List.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_consignacion_det", model);
        }

        private void cargar_combos_detalle()
        {
            in_UnidadMedida_Bus bus_unidad = new in_UnidadMedida_Bus();
            var lst_unidad = bus_unidad.get_list(false);
            ViewBag.lst_unidad = lst_unidad;
        }

        #endregion
    }

    public class in_Consignacion_det_List
    {
        string Variable = "in_Consignacion_det_Info";
        public List<in_Consignacion_det_Info> get_list(decimal IdConsignacion)
        {
            if (HttpContext.Current.Session[Variable + IdConsignacion.ToString()] == null)
            {
                List<in_Consignacion_det_Info> list = new List<in_Consignacion_det_Info>();

                HttpContext.Current.Session[Variable + IdConsignacion.ToString()] = list;
            }
            return (List<in_Consignacion_det_Info>)HttpContext.Current.Session[Variable + IdConsignacion.ToString()];
        }

        public void set_list(List<in_Consignacion_det_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(in_Consignacion_det_Info info_det, decimal IdConsignacion)
        {
            List<in_Consignacion_det_Info> list = get_list(IdConsignacion);
            info_det.Secuencial = list.Count == 0 ? 1 : list.Max(q => q.Secuencial) + 1;
            info_det.IdProducto = info_det.IdProducto;
            info_det.IdUnidadMedida = info_det.IdUnidadMedida;

            list.Add(info_det);
        }

        public void UpdateRow(in_Consignacion_det_Info info_det, decimal IdConsignacion)
        {
            in_Consignacion_det_Info edited_info = get_list(IdConsignacion).Where(m => m.Secuencial == info_det.Secuencial).First();
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.IdUnidadMedida = info_det.IdUnidadMedida;
            //edited_info.pr_descripcion = info_det.pr_descripcion;
            edited_info.IdProducto = info_det.IdProducto;

        }

        public void DeleteRow(int Secuencial, decimal IdConsignacion)
        {
            List<in_Consignacion_det_Info> list = get_list(IdConsignacion);
            list.Remove(list.Where(m => m.Secuencial == Secuencial).First());
        }
    }
}