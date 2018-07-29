using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Info.Facturacion;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.General;
namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class GuiaRemisionController : Controller
    {
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        fa_guia_remision_Bus bus_guia = new fa_guia_remision_Bus();
        fa_guia_remision_det_Bus bus_detalle = new fa_guia_remision_det_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        fa_PuntoVta_Bus bus_punto_venta = new fa_PuntoVta_Bus();
        #region Metodos ComboBox bajo demanda cliente
        public ActionResult CmbCliente_Guia()
        {
            fa_guia_remision_Info model = new fa_guia_remision_Info();
            return PartialView("_CmbCliente_Guia", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.CLIENTE.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.CLIENTE.ToString());
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


        public ActionResult GridViewPartial_guias_remision(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            if (IdSucursal == 0)
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            ViewBag.IdSucursal = IdSucursal;

            List<fa_guia_remision_Info> model = new List<fa_guia_remision_Info>();
            model = bus_guia.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_guias_remision", model);
        }
        public ActionResult GridViewPartial_guias_remision_det()
        {
            List<fa_guia_remision_det_Info> model = new List<fa_guia_remision_det_Info>();
            model = Session["fa_guia_remision_det_Info"] as List<fa_guia_remision_det_Info>;
            if (model == null)
                model = new List<fa_guia_remision_det_Info>();
            return PartialView("_GridViewPartial_guias_remision_det", model);
        }

        public ActionResult GridViewPartial_FacturasSinGuia()
        {
            List<fa_factura_Info> model = new List<fa_factura_Info>();
            model = Session["fa_factura_Info"] as List<fa_factura_Info>;
            if (model == null)
                model = new List<fa_factura_Info>();
            return PartialView("_GridViewPartial_FacturasSinGuia", model);
        }

        #endregion

        #region acciones
        public ActionResult Nuevo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            fa_guia_remision_Info model = new fa_guia_remision_Info
            {
                gi_fecha = DateTime.Now,

            };
            cargar_combos(model);
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(fa_guia_remision_Info model)
        {
            model.lst_detalle = Session["fa_guia_remision_det_Info"] as List<fa_guia_remision_det_Info>;
            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            string mensaje = bus_guia.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            if (!bus_guia.guardarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            Session["fa_guia_remision_det_Info"] = null;
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(decimal IdOrdenCompra_ext)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            fa_guia_remision_Info model = bus_guia.get_info(IdEmpresa, IdOrdenCompra_ext);
            var lst_detalle = bus_detalle.get_list(IdEmpresa, IdOrdenCompra_ext);
            Session["fa_guia_remision_det_Info"] = lst_detalle;
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(fa_guia_remision_Info model)
        {
            model.lst_detalle = Session["fa_guia_remision_det_Info"] as List<fa_guia_remision_det_Info>;
            string mensaje = bus_guia.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            if (!bus_guia.modificarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            Session["fa_guia_remision_det_Info"] = null;
            return RedirectToAction("Index");
        }
        public ActionResult Anular(decimal IdOrdenCompra_ext)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            fa_guia_remision_Info model = bus_guia.get_info(IdEmpresa, IdOrdenCompra_ext);
            var lst_detalle = bus_detalle.get_list(IdEmpresa, IdOrdenCompra_ext);
            Session["fa_guia_remision_det_Info"] = lst_detalle;
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_guia_remision_Info model)
        {
            if (!bus_guia.anularDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            Session["fa_guia_remision_det_Info"] = null;
            return RedirectToAction("Index");
        }
        #endregion

        private void cargar_combos(fa_guia_remision_Info model)
        {
            var lst_sucursal = bus_sucursal.get_list(model.IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_punto_venta = bus_punto_venta.get_list(model.IdEmpresa, model.IdSucursal, false);
            ViewBag.lst_punto_venta = lst_punto_venta;
        }
       
    }
}