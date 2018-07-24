using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Importacion;
using Core.Erp.Bus.Importacion;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.Importacion.Controllers
{
    
    public class OrdenCompraExteriorController : Controller
    {
        imp_ordencompra_ext_Bus bus_orden = new imp_ordencompra_ext_Bus();
        // GET: Importacion/OrdenCompraExterior
        public ActionResult Index()
        {
            return View();
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