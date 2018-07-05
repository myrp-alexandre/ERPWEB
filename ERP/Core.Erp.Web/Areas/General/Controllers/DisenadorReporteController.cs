using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.General;
namespace Core.Erp.Web.Areas.General.Controllers
{
    public class DisenadorReporteController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_pais()
        {
           
            return PartialView();
        }

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
    }
}