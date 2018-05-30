using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Inventario;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class MotivoInventarioController : Controller
    {
        in_Motivo_Inven_Bus bus_motivo = new Bus.Inventario.in_Motivo_Inven_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_motivoinven()
        {

            List<in_Motivo_Inven_Info> model = new List<in_Motivo_Inven_Info>();
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model = bus_motivo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_motivoinven", model);
        }

        private void cargar_combos()
        {
            in_Catalogo_Bus bus_catalogo = new in_Catalogo_Bus();
            var lst_tipo = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoInventario.ING_EGR), false);
            ViewBag.lst_tipos = lst_tipo;
        }
        public ActionResult Nuevo()
        {
            in_Motivo_Inven_Info model = new in_Motivo_Inven_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_Motivo_Inven_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_motivo.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdMotivo_Inv = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_Motivo_Inven_Info model = bus_motivo.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdMotivo_Inv);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(in_Motivo_Inven_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_motivo.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdMotivo_Inv = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_Motivo_Inven_Info model = bus_motivo.get_info(Convert.ToInt32(Session["IdEmpresa"]), IdMotivo_Inv);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(in_Motivo_Inven_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            if (!bus_motivo.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}