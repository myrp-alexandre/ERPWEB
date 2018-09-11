using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Helps;
using Core.Erp.Info.Inventario;
using Core.Erp.Web.Helps;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    [SessionTimeout]
    public class MotivoInventarioController : Controller
    {
        #region Index /  Metodos

        in_Motivo_Inven_Bus bus_motivo = new Bus.Inventario.in_Motivo_Inven_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_motivoinven()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_motivo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_motivoinven", model);
        }

        private void cargar_combos()
        {
            in_Catalogo_Bus bus_catalogo = new in_Catalogo_Bus();
            var lst_tipo = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoInventario.ING_EGR), false);
            ViewBag.lst_tipos = lst_tipo;
        }
        #endregion
        #region Acciones

        public ActionResult Nuevo(int IdEmpresa = 0 )
        {
            in_Motivo_Inven_Info model = new in_Motivo_Inven_Info
            {
                IdEmpresa = IdEmpresa
            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_Motivo_Inven_Info model)
        {
            if (!bus_motivo.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0 , int IdMotivo_Inv = 0)
        {
            in_Motivo_Inven_Info model = bus_motivo.get_info(IdEmpresa, IdMotivo_Inv);
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
            model.IdUsuarioUltMod = SessionFixed.IdUsuario.ToString();
            if (!bus_motivo.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0 , int IdMotivo_Inv = 0)
        {
            in_Motivo_Inven_Info model = bus_motivo.get_info(IdEmpresa, IdMotivo_Inv);
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
            model.IdUsuarioUltAnu = SessionFixed.IdUsuario.ToString();
            if (!bus_motivo.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
    }
}