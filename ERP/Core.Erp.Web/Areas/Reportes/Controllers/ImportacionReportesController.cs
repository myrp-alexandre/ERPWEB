using Core.Erp.Web.Reportes.Importacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class ImportacionReportesController : Controller
    {
        public ActionResult IMP_001(int IdOrdenCompra_ext = 0)
        {
            IMP_001_Rpt model = new IMP_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdOrdenCompra_ext.Value = IdOrdenCompra_ext;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
                model.RequestParameters = false;
            return View(model);
        }
    }
}