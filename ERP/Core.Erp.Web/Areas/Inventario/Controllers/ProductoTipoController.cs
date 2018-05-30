using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Inventario;
using Core.Erp.Bus.Inventario;


namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class ProductoTipoController : Controller
    {
        in_ProductoTipo_Bus bus_producto_tipo = new in_ProductoTipo_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipo_producto()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<in_ProductoTipo_Info> model = bus_producto_tipo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_tipo_producto", model);
        }

        public ActionResult Nuevo()
        {
            in_ProductoTipo_Info model = new in_ProductoTipo_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_ProductoTipo_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_producto_tipo.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdProductoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_ProductoTipo_Info model = bus_producto_tipo.get_info(IdEmpresa,IdProductoTipo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(in_ProductoTipo_Info model)
        {
            if (!bus_producto_tipo.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdProductoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_ProductoTipo_Info model = bus_producto_tipo.get_info(IdEmpresa, IdProductoTipo);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(in_ProductoTipo_Info model)
        {
            if (!bus_producto_tipo.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #region json
        public JsonResult get_info_producto_tipo(int IdProductoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_ProductoTipo_Bus bus_producto_tipo = new in_ProductoTipo_Bus();
            var resultado = bus_producto_tipo.get_info(IdEmpresa, IdProductoTipo);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}