using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using Core.Erp.Web.Helps;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.General.Controllers
{
    [SessionTimeout]
    public class ReporteController : Controller
    {
        #region Index / Metodo

        tb_sis_reporte_Bus bus_reporte = new tb_sis_reporte_Bus();
        public ActionResult Index()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_reporte()
        {
            List<tb_sis_reporte_Info> model = new List<tb_sis_reporte_Info>();
            model = bus_reporte.get_list();
            return PartialView("_GridViewPartial_reporte", model);
        }
        private void cargar_combos()
        {
            tb_modulo_Bus bus_modulo = new tb_modulo_Bus();
            var lst_modulo = bus_modulo.get_list();
            ViewBag.lst_modulo = lst_modulo;
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo()
        {
            tb_sis_reporte_Info model = new tb_sis_reporte_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(tb_sis_reporte_Info model)
        {

            if (bus_reporte.validar_existe_CodReporte(model.CodReporte))
            {
                ViewBag.mensaje = "El código ya se encuentra registrado";
                cargar_combos();
                return View(model);
            }

            if (!bus_reporte.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(string CodReporte = "")
        {
            tb_sis_reporte_Info model = bus_reporte.get_info(CodReporte);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(tb_sis_reporte_Info model)
        {
            if (!bus_reporte.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");

        }

        #endregion

        #region json

        public JsonResult get_id(string CodModulo)
        {
            var resultado = bus_reporte.get_id(CodModulo);
            return Json(resultado, JsonRequestBehavior.AllowGet);
            
        }

        #endregion

    }
}