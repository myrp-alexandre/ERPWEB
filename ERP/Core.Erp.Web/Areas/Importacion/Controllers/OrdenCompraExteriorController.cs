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
namespace Core.Erp.Web.Areas.Importacion.Controllers
{
    
    public class OrdenCompraExteriorController : Controller
    {
        imp_ordencompra_ext_Bus bus_orden = new imp_ordencompra_ext_Bus();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
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
        #endregion


        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GridViewPartial_orden_compra_ext()
        {
            List<imp_ordencompra_ext_Info> model = new List<imp_ordencompra_ext_Info>();
            return PartialView("_GridViewPartial_orden_compra_ext", model);
        }

        
        public ActionResult Nuevo()
        {
            imp_ordencompra_ext_Info model = new imp_ordencompra_ext_Info
            {
                fecha_creacion = DateTime.Now,
                oe_fecha = DateTime.Now,
                oe_fecha_llegada=DateTime.Now,
                oe_fecha_embarque=DateTime.Now
               
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

        private void cargar_combos()
        {
           
        }

    }
}