using Core.Erp.Bus.Facturacion;
using Core.Erp.Info.Facturacion;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class VendedorController : Controller
    {
        fa_Vendedor_Bus bus_vendedor = new fa_Vendedor_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_vendedor()
        {

            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<fa_Vendedor_Info> model = bus_vendedor.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_vendedor", model);
        }

        public ActionResult Nuevo()
        {
            fa_Vendedor_Info model = new fa_Vendedor_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(fa_Vendedor_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_vendedor.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdVendedor = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_Vendedor_Info model = bus_vendedor.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdVendedor);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_Vendedor_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_vendedor.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdVendedor = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_Vendedor_Info model = bus_vendedor.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdVendedor);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_Vendedor_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            if (!bus_vendedor.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

    }
}