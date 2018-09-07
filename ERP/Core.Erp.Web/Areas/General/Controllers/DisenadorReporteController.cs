using Core.Erp.Info.General;
using Core.Erp.Web.Helps;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.General.Controllers
{
    [SessionTimeout]

    public class DisenadorReporteController : Controller
    {
        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_pais()
        {
           
            return PartialView();
        }

        #endregion
        #region Acciones
        public ActionResult Nuevo()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Nuevo(tb_sis_reporte_diseno_Info model)
        {
           
                return View();
        }

        public ActionResult Modificar(string IdReporte = "")
        {
           
            return View();
        }

        [HttpPost]
        public ActionResult Modificar(tb_sis_reporte_diseno_Info model)
        {
            return View();
        }

        public ActionResult Anular()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Anular(tb_sis_reporte_diseno_Info model)
        {
            return View();

        }

        #endregion
    }
}