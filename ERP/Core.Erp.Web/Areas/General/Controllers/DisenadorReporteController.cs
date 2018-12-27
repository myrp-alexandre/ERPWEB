using Core.Erp.Info.General;
using Core.Erp.Web.Helps;
using Core.Erp.Web.Reportes.Facturacion;
using DevExpress.Web.Mvc;
using System.IO;
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
            tb_sis_reporte_diseno_Info model = new tb_sis_reporte_diseno_Info();
            FAC_003_Rpt rpt = new FAC_003_Rpt();
            MemoryStream ms = new MemoryStream();
            rpt.SaveLayoutToXml(ms);
            ms.Position = 0;
            model.File_Disenio_Reporte = ms.ToArray();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(tb_sis_reporte_diseno_Info model)
        {
            byte[] reportLayout = ReportDesignerExtension.GetReportXml("ReportDesigner");
            model.File_Disenio_Reporte = reportLayout;
            return View(model);
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